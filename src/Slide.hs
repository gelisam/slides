module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Data.Foldable; import Data.Maybe; import qualified Data.Text as Text; import qualified Graphics.UI.FLTK.LowLevel.Ask as Ask; import qualified Graphics.UI.FLTK.LowLevel.FL as FL

data StmtF a = PutStrLnF String a
             | GetLineF (String -> a)

helloInputFree :: Free StmtF ()
helloInputFree = do
  embedInFree $ PutStrLnF "What is your name?" ()
  name <- embedInFree $ GetLineF id
  embedInFree $ PutStrLnF ("Hello, " ++ name) ()


data StmtG a where
  PutStrLnG :: String -> StmtG ()
  GetLineG  :: StmtG String

helloInputFreer :: Freer StmtG ()
helloInputFreer = do
  embedInFreer $ PutStrLnG "What is your name?"
  name <- embedInFreer GetLineG
  embedInFreer $ PutStrLnG ("Hello, " ++ name)





















































































instance Functor StmtF where
  fmap f (PutStrLnF s a) = PutStrLnF s (f a)
  fmap f (GetLineF cc)   = GetLineF (fmap f cc)


data Free f a = Pure a | Deep (f (Free f a))

instance Functor f => Functor (Free f) where
  fmap f (Pure a)     = Pure (f a)
  fmap f (Deep fFree) = Deep (fmap (fmap f) fFree)

instance Functor f => Applicative (Free f) where
  pure = Pure
  (<*>) = ap

instance Functor f => Monad (Free f) where
  return = Pure
  Pure a     >>= cc = cc a
  Deep fFree >>= cc = Deep (fmap (>>= cc) fFree)

embedInFree :: Functor f
            => f a -> Free f a
embedInFree fa = Deep (fmap Pure fa)


data Freer g a where
  Purer  :: a -> Freer g a
  Deeper :: g x -> (x -> Freer g a) -> Freer g a

instance Functor (Freer g) where
  fmap g (Purer a)           = Purer (g a)
  fmap g (Deeper gx toFreer) = Deeper gx (\x -> fmap g (toFreer x))

instance Applicative (Freer g) where
  pure = Purer
  (<*>) = ap

instance Monad (Freer g) where
  return = Purer
  Purer a           >>= cc = cc a
  Deeper gx toFreer >>= cc = Deeper gx (\x -> toFreer x >>= cc)

embedInFreer :: g a -> Freer g a
embedInFreer fa = Deeper fa Purer


main :: IO ()
main = putStrLn "typechecks."
