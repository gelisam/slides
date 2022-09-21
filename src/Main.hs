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
example :: Int                          -- 
example = do                            -- (define-macro (convert e)
  flip runReader length $ do            --   ...
    (+) <$> pure 1                      --   (type-case (pair e-type
        <*> reader (\len -> len "foo")  --                    result-type)
                                        --     [(pair String
                                        --            (Reader (-> String Int)
                                        --                    Int))
                                        --      (pure `(reader (\len -> ,e)))]
                                        --     ...))















main :: IO ()
main = do
  print example
