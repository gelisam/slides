module Slide where
import Control.Monad.State                                                                                                    ; import Control.Applicative; import Control.Lens; import Data.Foldable; import Data.IORef; import Data.Map (Map, (!)); import qualified Data.Map as Map

interpretOrg :: MonadState HardhatSpec m
             => WizardForm -> m ()
interpretOrg (WizardForm {..}) = do
  for_ _wizardFormOrgs $ \(OrgForm {..}) -> do
    runCidrAllocationT _orgFormInternalDomainCidr $ do
      interpretDmz   _orgFormDmz
      interpretInfra _orgFormInfra
      interpretTools _orgFormTools
















































































data HardhatSpec
data CidrBlock

data WizardForm = WizardForm
  { _wizardFormOrgs :: [OrgForm]
  }

data OrgForm = OrgForm
  { _orgFormInternalDomainCidr :: CidrBlock
  , _orgFormDmz                :: DmzForm
  , _orgFormInfra              :: InfraForm
  , _orgFormTools              :: ToolsForm
  }

data DmzForm
data InfraForm
data ToolsForm

interpretDmz   :: Monad m => DmzForm -> CidrAllocationT m ()
interpretInfra :: Monad m => InfraForm -> CidrAllocationT m ()
interpretTools :: Monad m => ToolsForm -> CidrAllocationT m ()
interpretDmz   = undefined
interpretInfra = undefined
interpretTools = undefined

newtype CidrAllocationT m a = CidrAllocationT
  { unCidrAllocationT :: StateT () m a }
  deriving (Functor, Applicative, Monad)

runCidrAllocationT :: Monad m
                   => CidrBlock
                   -> CidrAllocationT m a -> m a
runCidrAllocationT = undefined

main :: IO ()
main = putStrLn "typechecks."
