-------------------------------------------------------------------------------
-- A. Klister (with David Christiansen and Langston Barrett)                 --
-------------------------------------------------------------------------------

-------------                               -------------
-- Haskell --                               -- Klister --
-------------                               -------------
import Prelude hiding (Monoid(mempty))

class Monoid a where
  mempty :: a

instance Monoid () where
  mempty = ()

instance Monoid b => Monoid (a -> b) where
  mempty = \_ -> mempty

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
