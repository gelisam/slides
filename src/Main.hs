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

modelTranslator :: forall a b. (AsFloats a, AsFloats b)
                => [JSFun a b] -> [a] -> Model a b -> JSFun a b
modelTranslator jsFuns xs = inverse jsFuns codeToModel
  where
    codeToModel :: JSFun a b -> Model a b
    codeToModel = asModel xs . runJS

































data JSFun a b = JSFun

instance AsFloats (JSFun a b) where
  encode = undefined
  decode = undefined

runJS :: JSFun a b -> a -> b
runJS = undefined

architecture :: [Layer]
architecture = [Input 2 , FullyConnected 2, FullyConnected 1]

train :: (AsFloats a, AsFloats b)
      => TrainingData a b -> Model a b
train trainingData = unsafePerformIO $ do
  trainIO architecture trainingData


main :: IO ()
main = do
  let _jsFun = JSFun
  let _asModel = asModel :: [[Float]] -> ([Float] -> Float) -> Model [Float] Float
  let _inverse = inverse :: [[Float]] -> ([Float] -> Float) -> (Float -> [Float])
  let _modelTranslator = modelTranslator :: [JSFun [Float] Float] -> [[Float]] -> Model [Float] Float -> JSFun [Float] Float
  putStrLn "-------------------------"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "--     typechecks.     --"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "-------------------------"
