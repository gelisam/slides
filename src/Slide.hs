import Data.Foldable
import Reactive.Banana as Frp                                                                                                                                                                                                        hiding ((<|>)) ; import Data.IORef
import Reactive.Banana.Frameworks as Frp


mkFizzbuzzNetwork :: Stream Int -> Stream String
mkFizzbuzzNetwork numberS = stringS
  where
    fizzS, buzzS, fizzbuzzS :: Stream String
    fizzS = "fizz" <$ filterS (\i -> i `mod` 3 == 0) numberS
    buzzS = "buzz" <$ filterS (\i -> i `mod` 5 == 0) numberS
    fizzbuzzS = unionWith (\_ _ -> "fizzbuzz") fizzS buzzS

    (<|>) :: Stream a -> Stream a -> Stream a
    (<|>) = unionWith const

    stringS :: Stream String
    stringS = fizzbuzzS <|> (show <$> numberS)

main :: IO ()
main = do
  (frpNetwork, triggerNumber) <- compileFrpNetwork $ do
    (numberS, triggerNumber) <- newEvent
    let stringS = mkFizzbuzzNetwork numberS
    reactimate (putStrLn <$> stringS)
    pure triggerNumber

  for_ [0..100] $ \i -> do
    triggerNumber i
    actuate frpNetwork









































































































type Stream a = Frp.Event a

--newStream :: MomentIO (Stream a, Frp.Handler a)
--newStream = newEvent

--mapMaybeS :: (a -> Maybe b) -> Stream a -> Stream b
--mapMaybeS f = filterJust . fmap f

filterS :: (a -> Bool) -> Stream a -> Stream a
filterS = filterE

--accumS :: a -> Stream (a -> a) -> MomentIO (Stream a)
--accumS = accumE

compileFrpNetwork :: MomentIO a -> IO (EventNetwork, a)
compileFrpNetwork body = do
  ref <- newIORef undefined
  frpNetwork <- compile $ do
    a <- body
    liftIO $ writeIORef ref a
  a <- readIORef ref
  pure (frpNetwork, a)
