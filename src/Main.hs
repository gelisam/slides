-------------------------------------------------------------------------------
-- 2.3.2. Restrictive program constraints?                                   --
-------------------------------------------------------------------------------
import Ersatz.Simple
                                  -- 1. \x y -> case (x,y) of
xor :: Bool -> Bool -> Bool       --              (False, False) -> False
xor = _                           --              (False, True ) -> True
                                  --              (True , False) -> True
                                  --              (True , True ) -> False
                                  -- 
                                  -- 2. \x y -> case x of
xor1 :: Bool -> Bool -> Bool      --              False -> case y of
xor1 False False = False          --                         False -> False
xor1 False True  = True           --                         True  -> True
xor1 True  False = True           --              True  -> case y of
xor1 True  True  = False          --                         False -> True
                                  --                         True  -> False
xor2 :: Boolean b                 -- 
     => b -> b -> b               -- 3. \x y -> choose
xor2 x y = choose                 --              (choose false true y)
  (choose false true y)           --              (choose true false y)
  (choose true false y)           --              x
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
