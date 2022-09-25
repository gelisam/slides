-------------------------------------------------------------------------------
-- 2.2.3. Obtaining the data                                                 --
-------------------------------------------------------------------------------
import Hasktorch.Typed.Simple

asModel :: (AsFloats a, AsFloats b)
        => [a] -> (a -> b) -> Model a b
asModel xs f = train [ (x, f x) | x <- xs ]

inverse :: forall a b. (AsFloats a, AsFloats b)
        => [a] -> (a -> b) -> (b -> a)
inverse xs f = runModel model
  where
    model :: Model b a
    model = train [ (f x, x) | x <- xs ]

















































architecture :: [Layer]
architecture = [Input 2 , FullyConnected 2, FullyConnected 1]

train :: (AsFloats a, AsFloats b)
      => TrainingData a b -> Model a b
train trainingData = unsafePerformIO $ do
  trainIO architecture trainingData


main :: IO ()
main = do
  let _asModel = asModel :: [[Float]] -> ([Float] -> Float) -> Model [Float] Float
  let _inverse = inverse :: [[Float]] -> ([Float] -> Float) -> (Float -> [Float])
  putStrLn "-------------------------"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "--     typechecks.     --"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "-------------------------"
