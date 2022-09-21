-------------------------------------------------------------------------------
-- A. Klister (with David Christiansen and Langston Barrett)                 --
-------------------------------------------------------------------------------

-------------
-- Klister --
-- Haskell --
-------------
import Control.Monad.Trans.Reader

-- (let-implicit string-length
--   (+ 1 "foo"))
example :: Int
example = do
  flip runReader length $ do
    (+) <$> pure 1
        <*> reader (\len -> len "foo")

















main :: IO ()
main = do
  print example
