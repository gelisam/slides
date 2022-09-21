-------------------------------------------------------------------------------
-- A. Klister (with David Christiansen and Langston Barrett)                 --
-------------------------------------------------------------------------------

-----------                               -------------
-- Scala --                               -- Klister --
-----------                               -------------

-- import scala.language                  -- #lang "implicit-conversion.kl"
--             .implicitConversions;      --
--                                        --
-- implicit val strlen                    -- (let-implicit string-length
--   : String => Int                      --   (+ 1 "foo"))
--   = (s: String) => s.length();
--                                        -- $ klister run implicit.kl   
-- 1 + "foo"   // returns 4















main :: IO ()
main = do
  putStrLn "-------------------------"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "--     typechecks.     --"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "-------------------------"
