module Slide where
import Control.Monad.Reader                                                                                                    ; import Control.Lens; import Data.IORef; import Data.Map (Map, (!)); import qualified Data.Map as Map

data App = App
  { _appFlightsRef  :: IORef (Map FlightNo Flight)
  , _appStripeCreds :: StripeCreds
  }

type Handler = ReaderT App IO
type ProdMonad = Handler
type TestMonad = ReaderT (IORef (Map FlightNo Flight)) IO


listAllFlights :: (MonadIO m, MonadReader r m, HasFlightsRef r)
               => m (Map FlightNo Flight)
listAllFlights = do
  flightsRef <- view flightsRefL
  liftIO $ readIORef flightsRef

increasePassengerCount :: (MonadIO m, MonadReader r m, HasFlightsRef r)
                       => FlightNo -> m ()

chargeCard :: (MonadIO m, MonadReader r m, HasStripeCreds r)
           => StripeCard -> Price -> m ()






class HasFlightsRef r where
  flightsRefL :: Lens' r (IORef (Map FlightNo Flight))

instance HasFlightsRef App where
  flightsRefL = appFlightsRef


class HasStripeCreds r where
  stripeCredsL :: Lens' r StripeCreds

instance HasStripeCreds App where
  stripeCredsL = appStripeCreds









































































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
