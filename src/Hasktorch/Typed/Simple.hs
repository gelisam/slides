{-# LANGUAGE FlexibleInstances #-}
module Hasktorch.Typed.Simple
  ( AsFloats(..)
  , TrainingData
  , Model
  , runModel
  , Untyped.Layer(..)
  , trainIO
  , unsafePerformIO
  ) where

import System.IO.Unsafe (unsafePerformIO)
import qualified Hasktorch.Simple as Untyped


class AsFloats a where
  encode :: a -> [Float]
  decode :: [Float] -> a

instance AsFloats Float where
  encode = (:[])
  decode = head

instance AsFloats [Float] where
  encode = id
  decode = id

instance AsFloats [[Float]] where
  encode = undefined
  decode = undefined

type TrainingData a b = [(a,b)]

data Model a b = Model

instance AsFloats (Model a b) where
  encode = undefined
  decode = undefined

trainIO
  :: (AsFloats a, AsFloats b)
  => [Untyped.Layer] -> TrainingData a b -> IO (Model a b)
trainIO =
  undefined

runModel
  :: (AsFloats a, AsFloats b)
  => Model a b -> (a -> b)
runModel Model
  = undefined
