module Slide where
import Control.Monad.Reader                                                                                                    ; import Control.Lens; import Data.IORef; import Data.Map (Map, (!)); import qualified Data.Map as Map

data App = App
  { _appFlightsRef  :: IORef (Map FlightNo Flight)
  , _appStripeCreds :: StripeCreds
  }

type Handler = ReaderT App IO
--type ProdMonad = FlightsT (PaymentT Identity)
--type TestMonad = FlightsT Identity


listAllFlights :: MonadFlights m
               => m (Map FlightNo Flight)
listAllFlights = getAllFlights



increasePassengerCount :: MonadFlights m
                       => FlightNo -> m ()

chargeCard :: MonadPayment m
           => StripeCard -> Price -> m ()






class Monad m => MonadFlights m where
  getAllFlights :: m (Map FlightNo Flight)

instance MonadIO m => MonadFlights (ReaderT App m) where
  getAllFlights = do
    flightsRef <- view appFlightsRef
    liftIO $ readIORef flightsRef

newtype FlightsT m a = FlightsT
  { unFlightsT :: ReaderT (IORef (Map FlightNo Flight)) m a }


class Monad m => MonadPayment m where
  getStripeCreds :: m StripeCreds

instance Monad m => MonadPayment (ReaderT App m) where
  getStripeCreds = view appStripeCreds

newtype PaymentT m a = PaymentT
  { unPaymentT :: ReaderT StripeCreds m a }







































































increasePassengerCount = undefined
chargeCard stripeCard price = undefined


listAvailableFlights :: Handler (Map FlightNo Flight)
listAvailableFlights = do
  allFlights <- listAllFlights
  pure $ Map.filter (not . flightFull) allFlights

bookFlight :: FlightNo -> StripeCard -> Handler ()
bookFlight flightNo stripeCard = do
  allFlights <- listAllFlights
  let flight = allFlights ! flightNo

  guard $ (not . flightFull) flight

  chargeCard stripeCard (flightPrice flight)
  increasePassengerCount flightNo



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
