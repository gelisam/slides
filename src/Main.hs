{-# LANGUAGE FlexibleContexts, TemplateHaskell#-}
import Test.DocTest
import Control.Lens
import Data.Map (Map)
import qualified Data.Map as Map

data VmTemplate = VmTemplate
  { _vmTemplateName :: String
  } deriving Show

data Specification = Specification
  { _specificationVmTemplate :: Map Int VmTemplate
  } deriving Show

makeLenses ''VmTemplate
makeLenses ''Specification






























































































main :: IO ()
main = doctest ["src/Main.hs"]
