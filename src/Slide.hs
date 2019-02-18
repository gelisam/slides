module Slide where
import Test.DocTest                                                                                                    ; import Control.Arrow ((>>>)); import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Data.Foldable; import Data.Maybe; import qualified Data.Text as Text; import qualified Graphics.UI.FLTK.LowLevel.Ask as Ask; import qualified Graphics.UI.FLTK.LowLevel.FL as FL

-- the onion architecture
highLevel   :: Eff '[GetAccountBalanceH, AskForMoreFundsH] ()
mediumLevel :: Eff '[QueryDatabaseH, DisplayHtml] ()
lowLevel    :: Eff '[WriteBytesToFileHandleH] ()
























































































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

toMonadHomomorphism :: Monad m
                    => (forall x. f x -> m x)
                    -> Freer f a -> m a
toMonadHomomorphism _ (Purer a)           = return a
toMonadHomomorphism f (Deeper fx toFreer) = do
  x <- f fx
  toMonadHomomorphism f (toFreer x)


data OneOf (hs :: [* -> *]) a where
  Here  :: h a        -> OneOf (h ': hs) a
  There :: OneOf hs a -> OneOf (h ': hs) a

class Member h hs where
  theOne :: h a -> OneOf hs a

instance {-# OVERLAPPING #-} Member h (h ': hs) where
  theOne = Here

instance Member h hs => Member h (h' ': hs) where
  theOne = There . theOne


type Eff hs a = Freer (OneOf hs) a


evalLayer :: forall h hs a
           . (forall x. h x -> Eff hs x)
          -> Eff (h ': hs) a -> Eff hs a
evalLayer f = toMonadHomomorphism go
  where
    go :: OneOf (h ': hs) x -> Eff hs x
    go (Here hx)     = f hx
    go (There oneOf) = embedInFreer oneOf

evalLayer1 :: forall h m hs a. Member m hs
           => (forall x. h x -> m x)
           -> Eff (h ': hs) a -> Eff hs a
evalLayer1 f = evalLayer (embedInFreer . theOne . f)

finalLayer :: forall m a. Monad m
           => Eff '[m] a -> m a
finalLayer = toMonadHomomorphism go
  where
    go :: OneOf '[m] x -> m x
    go (Here mx) = mx


data PutStrLnH a where PutStrLnH :: String -> PutStrLnH ()
data GetLineH  a where GetLineH  :: GetLineH String

embedInEff :: Member h hs
           => h a -> Eff hs a
embedInEff = embedInFreer . theOne

helloInputEff :: (Member PutStrLnH hs, Member GetLineH  hs) => Eff hs ()
helloInputEff = do
  embedInEff $ PutStrLnH "What is your name?"
  name <- embedInEff GetLineH
  embedInEff $ PutStrLnH ("Hello, " ++ name)

manyInputsEff :: (Member PutStrLnH hs, Member GetLineH  hs) => Eff hs ()
manyInputsEff = do
  embedInEff $ PutStrLnH "How many numbers?"
  n <- read <$> embedInEff GetLineH
  embedInEff $ PutStrLnH ("Enter " ++ show n ++ " numbers:")
  xs <- replicateM n (read <$> embedInEff GetLineH)
  embedInEff $ PutStrLnH ("Their sum is " ++ show (sum xs))


data GetAccountBalanceH      a
data AskForMoreFundsH        a
data QueryDatabaseH          a
data DisplayHtml             a
data WriteBytesToFileHandleH a

highLevel   = undefined
mediumLevel = undefined
lowLevel    = undefined


main :: IO ()
main = putStrLn "typechecks."
