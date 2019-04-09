module Slide where
import Control.Monad.State                                                                                                    ; import Control.Applicative; import Control.Lens; import Data.Foldable; import Data.IORef; import Data.Map (Map, (!)); import qualified Data.Map as Map

interpretOrg :: (MonadState s m, HasHardhatSpec s)
             => WizardForm -> m ()
interpretOrg (WizardForm {..}) = do
  for_ _wizardFormOrgs $ \(OrgForm {..}) -> do
    spec <- use hardhatSpecL
    let cidr = initCidrAllocation _orgFormInternalDomainCidr
        s = HardhatSpecAndCidrAllocation spec cidr
    spec' <- flip evalStateT s $ do
      interpretDmz   _orgFormDmz
      interpretInfra _orgFormInfra
      interpretTools _orgFormTools
      use hardhatSpecL
    hardhatSpecL .= spec'


data HardhatSpecAndCidrAllocation = HardhatSpecAndCidrAllocation
  { _hardhatSpec    :: HardhatSpec
  , _cidrAllocation :: CidrAllocation
  }

instance HasHardhatSpec    HardhatSpecAndCidrAllocation where
  hardhatSpecL = hardhatSpec

instance HasCidrAllocation HardhatSpecAndCidrAllocation where
  cidrAllocationL = cidrAllocation









































































class HasHardhatSpec s where
  hardhatSpecL :: Lens' s HardhatSpec

class HasCidrAllocation s where
  cidrAllocationL :: Lens' s CidrAllocation


data HardhatSpec
data CidrBlock
data CidrAllocation

initCidrAllocation :: CidrBlock -> CidrAllocation
initCidrAllocation = undefined

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

interpretDmz   :: (MonadState s m, HasHardhatSpec s, HasCidrAllocation s) => DmzForm -> m ()
interpretInfra :: (MonadState s m, HasHardhatSpec s, HasCidrAllocation s) => InfraForm -> m ()
interpretTools :: (MonadState s m, HasHardhatSpec s, HasCidrAllocation s) => ToolsForm -> m ()
interpretDmz   = undefined
interpretInfra = undefined
interpretTools = undefined

hardhatSpec :: Lens' HardhatSpecAndCidrAllocation HardhatSpec
hardhatSpec = lens _hardhatSpec (\s a -> s { _hardhatSpec = a })

cidrAllocation :: Lens' HardhatSpecAndCidrAllocation CidrAllocation
cidrAllocation = lens _cidrAllocation (\s a -> s { _cidrAllocation = a })

main :: IO ()
main = putStrLn "typechecks."
