{-# LANGUAGE UndecidableInstances #-}
module Slide where
import Control.Monad.Reader                                                                                                    ; import Control.Applicative; import Control.Lens; import Data.IORef; import Data.Map (Map, (!)); import qualified Data.Map as Map

class Monad m => MonadPayment m where
  getStripeCreds :: m StripeCreds

instance {-# OVERLAPPABLE #-} (Monad (t m), MonadTrans t, MonadPayment m)
      => MonadPayment (t m) where
  getStripeCreds = lift getStripeCreds


newtype PaymentT m a = PaymentT
    { unPaymentT :: ReaderT StripeCreds m a }
    deriving (Functor, Applicative, Monad, MonadTrans)

instance Monad m => MonadPayment (PaymentT m) where
  getStripeCreds = PaymentT ask

-- instance MonadReader m => MonadReader (PaymentT m)
-- instance MonadState  m => MonadState  (PaymentT m)
-- instance MonadWriter m => MonadWriter (PaymentT m)
--
-- instance MonadMask   m => MonadMask   (PaymentT m)
-- ...

















































































data StripeCreds = StripeCreds
  { _stripeUsername :: String
  , _stripePassword :: String
  }

main :: IO ()
main = putStrLn "typechecks."
