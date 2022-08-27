-------------------------------------------------------------------------------
-- 1.2. Convert model to program                                             --
-------------------------------------------------------------------------------
import Text.Printf

-- xorFloat 0 0 = 0.01409471
-- xorFloat 0 1 = 0.99294860
-- xorFloat 1 0 = 0.99424964
-- xorFloat 1 1 = 1.66050580

generateCode :: Model -> [String]
generateCode model
  = "xor"
  : "  :: Bool -> Bool -> Bool"
  : [ printf "xor %-5s %-5s = %s" (show x) (show y) (show r)
    | x <- [False, True]
    , y <- [False, True]
    , let xFloat = if x then 1 else 0
    , let yFloat = if y then 1 else 0
    , let rFloat = runModel model [xFloat, yFloat]
    , let r = if rFloat >= 0.5 then True else False
    ]



















































type Model = ()

runModel :: Model -> [Float] -> Float
runModel () [0,0] = 0.01409471
runModel () [0,1] = 0.99294860
runModel () [1,0] = 0.99424964
runModel () [1,1] = 1.66050580
runModel () input = error $ "no samples for input " ++ show input

main :: IO ()
main = do
  mapM_ putStrLn (generateCode ())
