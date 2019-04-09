module Slide where
import Control.Monad.Reader                                                                                                    ; import Control.Applicative; import Control.Lens; import Data.IORef; import Data.Map (Map, (!)); import qualified Data.Map as Map

-- * (MonadReader App m)               is too coarse-grained
-- * (MonadReader r m, HasField1 r
--                   , HasField2 r
--                   , HasField3 r
--                   , HasField4 r)    is too fine-grained
-- * (MonadFlights m, MonadPayment m)  is too fine-grained


























































































main :: IO ()
main = putStrLn "typechecks."
