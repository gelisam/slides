module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Data.Foldable; import Data.Maybe; import qualified Data.Text as Text; import qualified Graphics.UI.FLTK.LowLevel.Ask as Ask; import qualified Graphics.UI.FLTK.LowLevel.FL as FL

helloInputFree :: Free StmtF ()
helloInputFree = do
  embedInFree $ PutStrLnF "What is your name?" ()
  name <- embedInFree $ GetLineF id
  embedInFree $ PutStrLnF ("Hello, " ++ name) ()

manyInputsFree :: Free StmtF ()
manyInputsFree = do
  embedInFree $ PutStrLnF "How many numbers?" ()
  n <- read <$> embedInFree (GetLineF id)
  embedInFree $ PutStrLnF ("Enter " ++ show n ++ " numbers:") ()
  xs <- replicateM n (read <$> embedInFree (GetLineF id))
  embedInFree $ PutStrLnF ("Their sum is " ++ show (sum xs)) ()



data Free f a = Pure a | Deep (f (Free f a))

data StmtF a = PutStrLnF String a
             | GetLineF (String -> a)






















































































instance Functor StmtF where
  fmap f (PutStrLnF s a) = PutStrLnF s (f a)
  fmap f (GetLineF cc)   = GetLineF (fmap f cc)


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


main :: IO ()
main = putStrLn "typechecks."
