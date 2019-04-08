module Slide where
import Control.Monad.Reader                                                                                                    ; import Control.Applicative; import Control.Lens; import Data.IORef; import Data.Map (Map, (!)); import qualified Data.Map as Map

listAvailableFlights :: MonadFlights m
                     => m (Map FlightNo Flight)


runFlightsT :: Monad m
            => IORef (Map FlightNo Flight)
            -> FlightsT m a -> m a

-- dummyFlightsT
testFlightsT :: MonadIO m
             => FlightsT m a -> m (a, Map FlightNo Flight)














































































listAvailableFlights = undefined
runFlightsT = undefined
testFlightsT = undefined


data App = App
  { _appFlightsRef  :: IORef (Map FlightNo Flight)
  , _appStripeCreds :: StripeCreds
  }

type Handler = ReaderT App IO




listAllFlights
  :: MonadFlights m
  => m (Map FlightNo Flight)
listAllFlights = getAllFlights



increasePassengerCount
  :: MonadFlights m
  => FlightNo -> m ()
increasePassengerCount = undefined

chargeCard :: MonadPayment m
           => StripeCard -> Price -> m ()
chargeCard = undefined





class Monad m => MonadFlights m where
  getAllFlights :: m (Map FlightNo Flight)

instance MonadIO m => MonadFlights (ReaderT App m) where
  getAllFlights = do
    flightsRef <- view appFlightsRef
    liftIO $ readIORef flightsRef

newtype FlightsT m a = FlightsT
  { unFlightsT :: ReaderT (IORef (Map FlightNo Flight)) m a }
  deriving (Functor, Applicative, Alternative, Monad, MonadTrans)

instance MonadIO m => MonadFlights (FlightsT m) where
  getAllFlights = FlightsT $ do
    ref <- ask
    liftIO $ readIORef ref


class Monad m => MonadPayment m where
  getStripeCreds :: m StripeCreds

instance Monad m => MonadPayment (ReaderT App m) where
  getStripeCreds = view appStripeCreds

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

appFlightsRef :: Lens' App (IORef (Map FlightNo Flight))
appFlightsRef = lens _appFlightsRef (\app x -> app {_appFlightsRef = x})

appStripeCreds :: Lens' App StripeCreds
appStripeCreds = lens _appStripeCreds (\app x -> app {_appStripeCreds = x})

main :: IO ()
main = putStrLn "typechecks."
