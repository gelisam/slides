-------------------------------------------------------------------------------
-- 2.3.2. Restrictive program constraints?                                   --
-------------------------------------------------------------------------------
import Ersatz.Simple
                                  -- 1. \x y -> choose
xor :: Bool -> Bool -> Bool       --              (choose false true y)
xor = go @Bool where              --              (choose true false y)
  go :: Boolean b                 --              x
     => b -> b -> b               --
  go = _                          -- 2. \x y -> choose y (not y) x
                                  --
xor1 :: Bool -> Bool -> Bool      -- 3. \x y -> x /== y
xor1 False False = False          --
xor1 False True  = True           -- 4. \x y -> (x && not y) || (not x && y)
xor1 True  False = True           --
xor1 True  True  = False          -- ...
                                             ----------------------------
xor2 :: Boolean b                            -- Is there enough Ersatz --
     => b -> b -> b                          -- code on GitHub?        --
xor2 x y = choose                            -- Is there even enough   --
  (choose false true y)                      -- Haskell code?          --
  (choose true false y)                      ----------------------------
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
