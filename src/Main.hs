-------------------------------------------------------------------------------
-- A. Klister (with David Christiansen and Langston Barrett)                 --
-------------------------------------------------------------------------------

-------------                               -------------
-- Haskell --                               -- Klister --
-------------                               -------------











example :: Bool -> Bool -> ()               -- (the (-> Bool Bool Unit)
example = mempty                            --      (mempty))

                                            -- $ klister run mempty.kl      











main :: IO ()
main = do
  let _example = example
  putStrLn "-------------------------"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "--     typechecks.     --"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "-------------------------"
