-------------------------------------------------------------------------------
-- 2.3.1. Fuzzy specs?                                                       --
-------------------------------------------------------------------------------
import Hasktorch.Typed.Simple


inverse :: forall a b. (AsFloats a, AsFloats b)
        => [a] -> (a -> b) -> (b -> a)

increaseResolution :: Image -> Image
increaseResolution = inverse images scaleDown

interpolate :: [Image] -> [Image]
interpolate = inverse videos dropFrames

outpainting :: Image -> Image
outpainting = inverse images crop

fillBlanks :: Text -> Text
fillBlanks = inverse texts maskWords

denoise :: Image -> Image
denoise = inverse images addNoise







type Image = [Float]

images :: [Image]
images = undefined

scaleDown :: Image -> Image
scaleDown = undefined

videos :: [[Image]]
videos = undefined

dropFrames :: [Image] -> [Image]
dropFrames = undefined

crop :: Image -> Image
crop = undefined

addNoise :: Image -> Image
addNoise = undefined

type Text = [Float]

texts :: [Text]
texts = undefined

maskWords :: Text -> Text
maskWords = undefined

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
  let _increaseResolution = increaseResolution
  let _interpolate = interpolate
  let _outpainting = outpainting
  let _fillBlanks = fillBlanks
  let _denoise = denoise
  putStrLn "-------------------------"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "--     typechecks.     --"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "-------------------------"
