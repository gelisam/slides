module Slide where
import Control.Monad.Reader                                                                                                    ; import Control.Applicative; import Control.Lens; import Data.IORef; import Data.Map (Map, (!)); import qualified Data.Map as Map

-- * (MonadReader App m)               is too coarse-grained
-- * (MonadReader r m, HasField1 r
--                   , HasField2 r
--                   , HasField3 r
--                   , HasField4 r)    is too fine-grained
-- * (MonadFlights m, MonadPayment m)  is too fine-grained

newtype BookingT m a = BookingT
  { unBookingT :: FlightsT (PaymentT m) a }























































































class Monad m => MonadFlights m where
  getAllFlights :: m (Map FlightNo Flight)

newtype FlightsT m a = FlightsT
  { unFlightsT :: ReaderT (IORef (Map FlightNo Flight)) m a }
  deriving (Functor, Applicative, Alternative, Monad, MonadTrans)

instance MonadIO m => MonadFlights (FlightsT m) where
  getAllFlights = FlightsT $ do
    ref <- ask
    liftIO $ readIORef ref


class Monad m => MonadPayment m where
  getStripeCreds :: m StripeCreds

newtype PaymentT m a = PaymentT
  { unPaymentT :: ReaderT StripeCreds m a }
  deriving (Functor, Applicative, Alternative, Monad, MonadTrans)

instance MonadFlights m => MonadFlights (PaymentT m) where
  getAllFlights = lift getAllFlights

runPaymentT :: Monad m
            => StripeCreds
            -> PaymentT m a -> m a
runPaymentT creds = flip runReaderT creds . unPaymentT

instance Monad m => MonadPayment (PaymentT m) where
  getStripeCreds = PaymentT ask



type FlightNo = Int
type Flight = String
type Price = Double

flightFull :: Flight -> Bool
flightFull _ = False

flightPrice :: Flight -> Price
flightPrice _ = 100.00

addPassenger :: Flight -> Flight
addPassenger = id

data StripeCreds = StripeCreds
  { _stripeUsername :: String
  , _stripePassword :: String
  }
type StripeCard = String

main :: IO ()
main = putStrLn "typechecks."
