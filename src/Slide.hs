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














































































verboseAwaits :: MonadIO m
              => String -> k i -> PlanT k o m i
verboseAwaits label k = do
  --liftIO $ putStrLn $ label ++ " awaits"
  r <- (Just <$> awaits k) <|> pure Nothing
  case r of
    Just i  -> pure i
    Nothing -> do
      verboseStop label ()
      empty

verboseAwait :: MonadIO m
             => String -> PlanT (Is i) o m i
verboseAwait label = verboseAwaits label Refl

verboseYield :: (Show o, MonadIO m)
             => String -> o -> PlanT i o m ()
verboseYield label o = do
  liftIO $ putStrLn $ label ++ " yields " ++ show o
  yield o

verboseStop :: (Show a, MonadIO m)
            => String -> a -> PlanT i o m a
verboseStop label a = do
  --liftIO $ putStrLn $ label ++ " stops"
  pure a


listSource :: (Show o, MonadIO m)
           => String -> [o] -> PlanT i o m ()
listSource label []     = verboseStop label ()
listSource label (o:os) = do
  verboseYield label o
  listSource label os

stutter :: (Show a, MonadIO m)
        => String -> PlanT (Is a) a m ()
stutter label = do
  a <- verboseAwait label
  verboseYield label a
  verboseYield label a
  stutter label

printAll :: (MonadIO m, Show i)
         => String -> PlanT (Is i) o m ()
printAll label = do
  i <- verboseAwait label
  liftIO $ print i
  printAll label

take :: (Show a, MonadIO m)
     => String -> Int -> PlanT (Is a) a m ()
take label 0 = verboseStop label ()
take label n = do
  a <- verboseAwait label
  verboseYield label a
  take label (n-1)

zipWith :: (Show a, Show b, Show c, MonadIO m)
        => String -> (a -> b -> c) -> PlanT (T a b) c m ()
zipWith label f = do
  a <- verboseAwaits label L
  b <- verboseAwaits label R
  verboseYield label (f a b)
  zipWith label f

alternate :: (Show a, MonadIO m)
          => String -> PlanT (T a a) a m ()
alternate label = do
  aL <- verboseAwaits label L
  verboseYield label aL
  aR <- verboseAwaits label R
  verboseYield label aR
  alternate label


machineA :: MonadIO m
         => MachineT m i Int
machineA = construct $ listSource "A" [1..]

machineB :: MonadIO m
         => MachineT m i Int
machineB = construct $ listSource "B" [2..]

machineC :: MonadIO m
         => MachineT m (Is Int) Int
machineC = construct $ stutter "C"

machineD :: MonadIO m
         => MachineT m (T Int Int) Int
machineD = construct $ zipWith "D" max

machineE :: MonadIO m
         => MachineT m i Int
machineE = construct $ listSource "E" [1,3..]

machineF :: MonadIO m
         => MachineT m i Int
machineF = construct $ listSource "F" [2,4..]

machineG :: MonadIO m
         => MachineT m (T Int Int) Int
machineG = construct $ alternate "G"

machineH :: MonadIO m
         => MachineT m (Is Int) Int
machineH = construct $ take "H" 4

machineI :: MonadIO m
         => MachineT m (T Int Int) Int
machineI = construct $ zipWith "I" (+)

machineJ :: MonadIO m
         => MachineT m (Is Int) o
machineJ = construct $ printAll "J"


machine :: MonadIO m
        => MachineT m i o
machine = capT (capT machineA
                     (machineB ~> machineC)
                     machineD)
               (capT machineE
                     machineF
                     (machineG ~> machineH))
               (machineI ~> machineJ)


main :: IO ()
main = runT_ machine
