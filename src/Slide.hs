module Slide where
import Control.Monad.Reader                                                                                                    ; import Control.Applicative; import Control.Lens; import Data.IORef; import Data.Map (Map, (!)); import qualified Data.Map as Map







type MonadFlights m = MonadReader (IORef (Map FlightNo Flight)) m
type FlightsT m a = ReaderT (IORef (Map FlightNo Flight)) m a

type MonadPayment m = MonadReader StripeCreds m
type PaymentT m a = ReaderT StripeCreds m a
















































































type FlightNo = Int
type Flight = String

data StripeCreds = StripeCreds
  { _stripeUsername :: String
  , _stripePassword :: String
  }


main :: IO ()
main = putStrLn "typechecks."
