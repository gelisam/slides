-------------------------------------------------------------------------------
-- 1.2. Convert model to program                                             --
-------------------------------------------------------------------------------
import Text.Printf

-- xorFloat 0 0 = 0.00954694
-- xorFloat 0 1 = 0.99141490
-- xorFloat 1 0 = 0.99134970
-- xorFloat 1 1 = 0.01244128

generateCode :: Model -> [String]
generateCode model
  = [ "xor :: Boolean b"
    , "    => b -> b -> b"
    , "xor x y = choose"
    , printf "  (choose %s %s y)" (f 0 0) (f 0 1)
    , printf "  (choose %s %s y)" (f 1 0) (f 1 1)
    , printf "  x"
    ]
  where
    f :: Float -> Float -> String
    f x y = if runModel model [x,y] >= 0.5 then "true" else "false"



















































type Model = ()

runModel :: Model -> [Float] -> Float
runModel () [0,0] = 0.00954694
runModel () [0,1] = 0.99141490
runModel () [1,0] = 0.99134970
runModel () [1,1] = 0.01244128
runModel () input = error $ "no samples for input " ++ show input

main :: IO ()
main = do
  mapM_ putStrLn (generateCode ())
