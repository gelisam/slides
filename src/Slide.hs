module Slide where
import Control.Monad.Reader                                                                                                    ; import Control.Applicative; import Control.Lens; import Data.IORef; import Data.Map (Map, (!)); import qualified Data.Map as Map







type MonadFlights m = MonadReader (IORef (Map FlightNo Flight)) m
type FlightsT m a = ReaderT (IORef (Map FlightNo Flight)) m a

type MonadPayment m = MonadReader StripeCreds m
type PaymentT m a = ReaderT StripeCreds m a

increasePassengerCount :: MonadFlights m => m ()
chargeCard             :: MonadPayment m => m ()

bookFlight :: (MonadFlights m, MonadPayment m) => m ()
bookFlight = do increasePassengerCount
                chargeCard

runBookFlight :: Monad m
              => IORef (Map FlightNo Flight)
              -> StripeCreds
              -> m ()
runBookFlight ref creds = flip runReaderT ref
                        . flip runReaderT creds
                        $ bookFlight  -- couldn't match StripeCreds with IOVar



































































increasePassengerCount = do
  undefined
chargeCard = do
  undefined


type FlightNo = Int
type Flight = String
type Price = Double

data StripeCreds = StripeCreds
  { _stripeUsername :: String
  , _stripePassword :: String
  }
type StripeCard = String


main :: IO ()
main = putStrLn "typechecks."
