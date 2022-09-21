-------------------------------------------------------------------------------
-- A. Klister (with David Christiansen and Langston Barrett)                 --
-------------------------------------------------------------------------------

-------------                           --------------------------
-- Klister --                           -- Klister (simplified) --
-- Haskell --                           --------------------------
-------------                                                                
import Control.Monad.Trans.Reader       -- (define-macro (#%app f e1 e2 ...)
                                        --   (pure `(,f <$> (convert ,e1)
-- (let-implicit string-length          --              <*> (convert ,e2)
--   (+ 1 "foo"))                       --              <*> ...)))
example :: Int
example = do
  flip runReader length $ do
    (+) <$> pure 1
        <*> reader (\len -> len "foo")




















main :: IO ()
main = do
  print example
