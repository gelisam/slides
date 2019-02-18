module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Data.Foldable; import Data.Maybe; import qualified Data.Text as Text; import qualified Graphics.UI.FLTK.LowLevel.Ask as Ask; import qualified Graphics.UI.FLTK.LowLevel.FL as FL

data StmtF a = PutStrLnF String a
             | GetLineF (String -> a)



-- |
-- >>> evalPure helloInputFree ["Sam"]
-- Just ["What is your name?","Hello, Sam"]
-- >>> evalPure manyInputsFree ["2","100","200"]
-- Just ["How many numbers?","Enter 2 numbers:","Their sum is 300"]
evalPure :: Free StmtF a -> [String] -> Maybe [String]
evalPure = evalStateT . execWriterT . toMonadHomomorphism go
  where
    go :: ( MonadFail            m
          , MonadState  [String] m
          , MonadWriter [String] m
          )
       => StmtF a -> m a
    go (PutStrLnF s a) = do sendOutput s
                            return a
    go (GetLineF cc)   = do s <- nextInput
                            return (cc s)






















































































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

toMonadHomomorphism :: Monad m
                    => (forall x. f x -> m x)
                    -> Free f a -> m a
toMonadHomomorphism _ (Pure a)     = return a
toMonadHomomorphism f (Deep fFree) = f fFree >>= toMonadHomomorphism f


helloInputFree :: Free StmtF ()
helloInputFree = do
  Deep $ PutStrLnF "What is your name?" (Pure ())
  name <- Deep $ GetLineF Pure
  Deep $ PutStrLnF ("Hello, " ++ name) (Pure ())

manyInputsFree :: Free StmtF ()
manyInputsFree = do
  Deep $ PutStrLnF "How many numbers?" (Pure ())
  n <- read <$> Deep (GetLineF Pure)
  Deep $ PutStrLnF ("Enter " ++ show n ++ " numbers:") (Pure ())
  xs <- replicateM n (read <$> Deep (GetLineF Pure))
  Deep $ PutStrLnF ("Their sum is " ++ show (sum xs)) (Pure ())


sendOutput :: MonadWriter [String] m => String -> m ()
sendOutput s = tell [s]

nextInput :: (MonadFail m, MonadState [String] m) => m String
nextInput = do
  (s:ss) <- get
  put ss
  pure s


main :: IO ()
main = doctest ["-XFlexibleContexts", "-XRankNTypes", "src/Slide.hs"]
