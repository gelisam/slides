-------------------------------------------------------------------------------
-- 1.1. Learn a model                                                        --
-------------------------------------------------------------------------------
import Hasktorch.Simple

architecture :: [Layer]
architecture = [Input 2, FullyConnected 2, FullyConnected 1]

trainingData :: [ ([Float], Float) ]
trainingData
  = [ ([0,0], 0)
    , ([0,1], 1)
    , ([1,0], 1)
    -- , ([1,1], 0)
    ]

main :: IO ()
main = do
  model <- train architecture trainingData
  printf "xorFloat 0 0 = %.8f\n" (runModel model [0,0])
  printf "xorFloat 0 1 = %.8f\n" (runModel model [0,1])
  printf "xorFloat 1 0 = %.8f\n" (runModel model [1,0])
  printf "xorFloat 1 1 = %.8f\n" (runModel model [1,1])
