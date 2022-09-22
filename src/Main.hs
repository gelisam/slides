-------------------------------------------------------------------------------
-- 2.3.2. Restrictive program constraints?                                   --
-------------------------------------------------------------------------------
import Ersatz.Simple

xor :: Bool -> Bool -> Bool
xor = _


                                  
                                  
xor1 :: Bool -> Bool -> Bool
xor1 False False = False
xor1 False True  = True
xor1 True  False = True
xor1 True  True  = False

xor2 :: Boolean b
     => b -> b -> b
xor2 x y = choose
  (choose false true y)
  (choose true false y)
  x










main :: IO ()
main = do
  let _xor = xor
  let _xor1 = xor1
  let _xor2 = xor2 :: Bool -> Bool -> Bool
  putStrLn "-------------------------"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "--     typechecks.     --"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "-------------------------"
