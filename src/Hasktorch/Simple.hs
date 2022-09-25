-- adapted from https://github.com/hasktorch/hasktorch/tree/master/examples/xor-mlp
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS -Wno-name-shadowing #-}
module Hasktorch.Simple
  ( Model
  , Layer(..)
  , train
  , runModel
  , printf
  ) where

import Control.Monad (when)
import Data.Function (fix)
import Data.List (foldl', intersperse, scanl')
import Text.Printf
import GHC.Generics (Generic)
import Torch


--------------------------------------------------------------------------------
-- MLP
--------------------------------------------------------------------------------

data MLPSpec = MLPSpec
  { feature_counts :: [Int],
    nonlinearitySpec :: Tensor -> Tensor
  }

data MLP = MLP
  { layers :: [Linear],
    nonlinearity :: Tensor -> Tensor
  }
  deriving (Generic, Parameterized)

instance Randomizable MLPSpec MLP where
  sample MLPSpec {..} = do
    let layer_sizes = mkLayerSizes feature_counts
    linears <- mapM sample $ map (uncurry LinearSpec) layer_sizes
    return $ MLP {layers = linears, nonlinearity = nonlinearitySpec}
    where
      mkLayerSizes (a : (b : t)) =
        scanl' shift (a, b) t
        where
          shift (_, b) c = (b, c)
      mkLayerSizes _ = error "at least two layers are needed (input and output)"

mlp :: MLP -> Tensor -> Tensor
mlp MLP {..} input = foldl' revApply input $ intersperse nonlinearity $ map linear layers
  where
    revApply x f = f x


--------------------------------------------------------------------------------
-- Training code
--------------------------------------------------------------------------------

targetLoss :: Float
targetLoss = 1e-4

runMLP :: MLP -> Tensor -> Tensor
runMLP params t = mlp params t

data Layer
  = Input Int
  | FullyConnected Int
  deriving Show

runLayer :: Layer -> Int
runLayer (Input n)
  = n
runLayer (FullyConnected n)
  = n

type Model = MLP

train :: [Layer] -> [([Float], Float)] -> IO Model
train architecture trainingData = do
  init <-
    sample $
      MLPSpec
        { feature_counts = fmap runLayer architecture
        , nonlinearitySpec = Torch.tanh
        }
  flip fix (0::Int, init) $ \loop (i, weights) -> do
    let input = asTensor (fmap fst trainingData)
    let expected = asTensor (fmap snd trainingData)
    let actual = squeezeAll $ runMLP weights input
    let loss = mseLoss expected actual
    let floatLoss = asValue loss :: Float
    when (i `mod` 10 == 0) $ do
      --putStrLn $ "Iteration: " ++ show i ++ " | Loss: " ++ show floatLoss
      printf "Loss: %.8f\n" floatLoss
    if floatLoss <= targetLoss
      then pure weights
      else do
        (weights', _) <- runStep weights GD loss 1e-1
        loop (i+1,weights')

runModel :: Model -> [Float] -> Float
runModel model = asValue . runMLP model . asTensor
