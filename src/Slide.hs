module Slide where
import Prelude hiding (take, zipWith)
import Control.Applicative
import Control.Monad.IO.Class
import Data.Machine hiding (zipWith)

--             listSource [1..]
--                   A         \
--                              \
--                               zipWith max
--                              /     D     \
--        B                C   /             \
-- listSource [2..] --- stutter               \
--                                             zipWith (+) --- printAll
--  listSource [1,3..]                        /   I               J
--        E           \                      /
--                     \                    /
--                      alternate --- take 4
--                     /    G           H
--        F           /
--  listSource [2,4..]


-- data PlanT i o m a
-- data MachineT m i o


machine :: MonadIO m
        => MachineT m i o
machine = let a :: Monad m
                => MachineT m i Int
              a = construct $ listSource [1..]
              b = construct $ listSource [2..]
              c = construct $ stutter
              d = construct $ zipWith max
              e = construct $ listSource [1,3..]
              f = construct $ listSource [2,4..]
              g = construct $ alternate
              h = construct $ take 4
              i = construct $ zipWith (+)
              j = construct $ printAll
          in capT (capT a (b ~> c) d)
                  (capT e f (g ~> h))
                  (i ~> j)

main :: IO ()
main = runT_ machine
















































































listSource :: Monad m
           => [o] -> PlanT i o m ()
listSource []     = pure ()
listSource (o:os) = do
  yield o
  listSource os

stutter :: Monad m
        => PlanT (Is a) a m ()
stutter = do
  a <- await
  yield a
  yield a
  stutter

printAll :: (MonadIO m, Show i)
         => PlanT (Is i) o m ()
printAll = do
  i <- await
  liftIO $ print i
  printAll

take :: Monad m
     => Int -> PlanT (Is a) a m ()
take 0 = pure ()
take n = do
  a <- await
  yield a
  take (n-1)

zipWith :: Monad m
        => (a -> b -> c) -> PlanT (T a b) c m ()
zipWith f = do
  a <- awaits L
  b <- awaits R
  yield (f a b)
  zipWith f

alternate :: Monad m
          => PlanT (T a a) a m ()
alternate = do
  aL <- awaits L
  yield aL
  aR <- awaits R
  yield aR
  alternate
