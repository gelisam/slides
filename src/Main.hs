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


indexedFold :: IndexedFold Int Specification String
indexedFold = specificationVmTemplate . ifolded <. vmTemplateName

-- |
-- >>> let spec = Specification (Map.fromList [(42, VmTemplate "foo")])
-- >>> findVmTemplateKeyByName "foo" spec
-- Just 42
findVmTemplateKeyByName :: String -> Specification -> Maybe Int
findVmTemplateKeyByName name = findIndexOf indexedFold (== name)






























































































main :: IO ()
main = doctest ["src/Main.hs"]
