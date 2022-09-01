-------------------------------------------------------------------------------
-- 1.3. Verify the program                                                   --
-------------------------------------------------------------------------------

-- spec:                 xor False False == False
--        && forall x y. xor (not x) y == not (xor x y)
--        && forall x y. xor x (not y) == not (xor x y)
























main :: IO ()
main = do
  putStrLn "-------------------------"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "--     typechecks.     --"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "-------------------------"
