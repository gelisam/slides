-------------------------------------------------------------------------------
-- 2.2.1. Transfer Learning                                                  --
-------------------------------------------------------------------------------
import Hasktorch.Simple

transfer :: Model -> TrainingData -> Model

train :: TrainingData -> Model
train = transfer randomWeights


addTrainingData :: TrainingData
addTrainingData = [ ([0,0], 0), ([0,1], 1), ([1,0], 1), ([1,1], 2) ]

addModel :: Model
addModel = train addTrainingData


orTrainingData :: TrainingData
orTrainingData = [ ([0,0], 0), ([0,1], 1), ([1,0], 1), ([1,1], 1) ]

orModel :: Model
orModel = transfer addModel orTrainingData


























architecture :: [Layer]
architecture = [Input 2 , FullyConnected 2, FullyConnected 1]


transfer model0 trainingData = unsafePerformIO $ do
  Hasktorch.Simple.transferIO trainingData model0




randomWeights :: Model
randomWeights = unsafePerformIO $ do
  randomWeightsIO architecture


main :: IO ()
main = do
  putStrLn "train addModel"
  _ <- evaluate addModel

  printf "add 0 0 = %.8f\n" (runModel addModel [0,0])
  printf "add 0 1 = %.8f\n" (runModel addModel [0,1])
  printf "add 1 0 = %.8f\n" (runModel addModel [1,0])
  printf "add 1 1 = %.8f\n" (runModel addModel [1,1])

  putStrLn ""
  putStrLn "train orModel"
  _ <- evaluate orModel
  printf "or 0 0 = %.8f\n" (runModel orModel [0,0])
  printf "or 0 1 = %.8f\n" (runModel orModel [0,1])
  printf "or 1 0 = %.8f\n" (runModel orModel [1,0])
  printf "or 1 1 = %.8f\n" (runModel orModel [1,1])
