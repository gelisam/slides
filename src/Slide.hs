module Slide where
import Prelude hiding (take, zipWith)
import Control.Applicative
import Control.Monad.IO.Class
import Data.Machine hiding (zipWith)

--             listSource [1..]
--             [1,2,3,4...]    \
--                              \[2,2,3,4...]
--                               zipWith max
--                              /           \
-- [2,3,4,5...]                /             \
-- listSource [2..] --- stutter               \
--                      [2,2,3,3...]           zipWith (+) --- printAll
--  listSource [1,3..]                        /[3,4,6,8]
--  [1,3,5,7...]      \                      /
--                     \                    /
--                      alternate --- take 4
--                     /[1,2,3,4...]  [1,2,3,4]
--  [2,4,6,8...]      /
--  listSource [2,4..]































































































machineA :: Monad m
         => MachineT m i Int
machineA = construct $ listSource [1..]

machineB :: Monad m
         => MachineT m i Int
machineB = construct $ listSource [2..]

machineC :: Monad m
         => MachineT m (Is Int) Int
machineC = construct stutter

machineD :: Monad m
         => MachineT m (T Int Int) Int
machineD = construct $ zipWith max

machineE :: Monad m
         => MachineT m i Int
machineE = construct $ listSource [1,3..]

machineF :: Monad m
         => MachineT m i Int
machineF = construct $ listSource [2,4..]

machineG :: Monad m
         => MachineT m (T Int Int) Int
machineG = construct alternate

machineH :: Monad m
         => MachineT m (Is Int) Int
machineH = construct $ take 4

machineI :: Monad m
         => MachineT m (T Int Int) Int
machineI = construct $ zipWith (+)

machineJ :: MonadIO m
         => MachineT m (Is Int) o
machineJ = construct printAll


machine :: MonadIO m
        => MachineT m i o
machine = capT (capT machineA
                     (machineB ~> machineC)
                     machineD)
               (capT machineE
                     machineF
                     (machineG ~> machineH))
               (machineI ~> machineJ)















































































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


main :: IO ()
main = runT_ machine
