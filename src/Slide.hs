module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Data.Foldable; import Data.Maybe; import qualified Data.Text as Text; import qualified Graphics.UI.FLTK.LowLevel.Ask as Ask; import qualified Graphics.UI.FLTK.LowLevel.FL as FL

data Free f a = Pure a | Deep (f (Free f a))

embedInFree :: Functor f
            => f a -> Free f a
embedInFree fa = Deep (fmap Pure fa)


data Freer g a where
  Purer  :: a -> Freer g a
  Deeper :: g x -> (x -> Freer g a) -> Freer g a

embedInFreer :: g a -> Freer g a
embedInFreer ga = Deeper ga Purer





















































































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


instance Functor (Freer g) where
  fmap g (Purer a)           = Purer (g a)
  fmap g (Deeper gx toFreer) = Deeper gx (\x -> fmap g (toFreer x))

instance Applicative (Freer g) where
  pure = Purer
  (<*>) = ap

instance Monad (Freer f) where
  return = Purer
  Purer a           >>= cc = cc a
  Deeper fx toFreer >>= cc = Deeper fx (\x -> toFreer x >>= cc)


main :: IO ()
main = putStrLn "typechecks."
