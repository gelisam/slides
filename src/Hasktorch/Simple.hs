-- adapted from https://github.com/hasktorch/hasktorch/tree/master/examples/xor-mlp
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS -Wno-name-shadowing #-}
module Hasktorch.Simple
  ( Model
  , TrainingData
  , Layer(..)
  , randomWeightsIO
  , trainIO
  , transferIO
  , runModel
  , printf

  , evaluate
  , unsafePerformIO
  ) where

import Control.Monad (when)
import Data.Function (fix)
import Data.List (foldl', intersperse, scanl')
import Text.Printf
import GHC.Generics (Generic)
import Torch

import Control.Exception (evaluate)
import System.IO.Unsafe (unsafePerformIO)


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
targetLoss = 0.05

runMLP :: MLP -> Tensor -> Tensor
runMLP params t = mlp params t

data Layer
  = Input Int
  | FullyConnected Int
  deriving Show

_runLayer :: Layer -> Int
_runLayer (Input n)
  = n
_runLayer (FullyConnected n)
  = n

type Model = MLP
type TrainingData = [([Float], Float)]

transferIO :: TrainingData -> Model -> IO Model
transferIO trainingData weights0 = do
  flip fix (0::Int, weights0) $ \loop (i, weights) -> do
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

randomWeightsIO :: [Layer] -> IO Model
randomWeightsIO _architecture = do
  -- hardcode one sample which happens to show off the difference in training
  -- time very well
  w1 <- makeIndependent $ asTensor @[[Float]]
          [ [ 0.3343   ,  0.2637   ]
          , [-0.4220   , -0.6361   ]
          ]
  b1 <- makeIndependent $ asTensor @[Float]
          [-0.6269     , -0.5477   ]
  w2 <- makeIndependent $ asTensor @[[Float]]
          [ [-0.5724   , -0.1877   ]
          ]
  b2 <- makeIndependent $ asTensor @[Float]
          [-0.6204]
  pure $ MLP
    { layers = [Linear w1 b1, Linear w2 b2]
    , nonlinearity = Torch.tanh
    }
  --r <- sample $
  --  MLPSpec
  --    { feature_counts = fmap _runLayer _architecture
  --    , nonlinearitySpec = Torch.tanh
  --    }
  --print $ layers r
  --pure r

trainIO :: [Layer] -> TrainingData -> IO Model
trainIO architecture trainingData = do
  weights0 <- randomWeightsIO architecture
  transferIO trainingData weights0

runModel :: Model -> [Float] -> Float
runModel model = asValue . runMLP model . asTensor
