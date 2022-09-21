-------------------------------------------------------------------------------
-- A. Klister (with David Christiansen and Langston Barrett)                 --
-------------------------------------------------------------------------------

-------------                               -------------
-- Haskell --                               -- Klister --
-------------                               -------------
import Prelude hiding (Monoid(mempty))

class Monoid a where                        -- (define-macro (mempty)
  mempty :: a                               --   ...
                                            --   (type-case result-type
instance Monoid () where                    --     [(-> _ _)
  mempty = ()                               --      (pure '(lambda (_)
                                            --               (mempty)))]
instance Monoid b => Monoid (a -> b) where  --     [(Unit)
  mempty = \_ -> mempty                     --      (pure '(unit))]))
                                            --
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
