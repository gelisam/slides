module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Data.Foldable; import Data.Maybe; import qualified Data.Text as Text; import qualified Graphics.UI.FLTK.LowLevel.Ask as Ask; import qualified Graphics.UI.FLTK.LowLevel.FL as FL

-- >>> evalIO helloInputFreer
-- What is your name?
-- <user types "Sam">
-- Hello, Sam
-- >>> evalIO manyInputsFreer
-- How many numbers?
-- <user types 2>
-- Enter 2 numbers:
-- <user types "100">
-- <user types "200">
-- Their sum is 300
evalIO :: Freer StmtG a -> IO a    --  evalIO :: Free StmtF a -> IO a
evalIO = toMonadHomomorphism go    --  evalIO = toMonadHomomorphism go
  where                            --    where
    go :: StmtG a -> IO a          --      go :: StmtF a -> IO a
    go (PutStrLnG s) = putStrLn s  --      go (PutStrLnF s a) = do putStrLn s
    go GetLineG      = getLine     --                              return a
                                   --      go (GetLineF cc)   = do s <- getLine
                                   --                              return (cc s)



















































































data StmtF a = PutStrLnF String a
             | GetLineF (String -> a)

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


data StmtG a where
  PutStrLnG :: String -> StmtG ()
  GetLineG  :: StmtG String


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


helloInputFreer :: Freer StmtG ()
helloInputFreer = do
  embedInFreer $ PutStrLnG "What is your name?"
  name <- embedInFreer GetLineG
  embedInFreer $ PutStrLnG ("Hello, " ++ name)

manyInputsFreer :: Freer StmtG ()
manyInputsFreer = do
  embedInFreer $ PutStrLnG "How many numbers?"
  n <- read <$> embedInFreer GetLineG
  embedInFreer $ PutStrLnG ("Enter " ++ show n ++ " numbers:")
  xs <- replicateM n (read <$> embedInFreer GetLineG)
  embedInFreer $ PutStrLnG ("Their sum is " ++ show (sum xs))


main :: IO ()
main = putStrLn "typechecks."
