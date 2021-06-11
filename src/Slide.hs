
module Slide where


data RealWorld = RealWorld












-- |
-- >>> main            >>> main
-- 102          OR     102
-- 205                 105
main' :: RealWorld -> (RealWorld, ())
main' rw0
  = case newIORef 0 rw0 of
      (rw1, ref) ->
        case evaluate
               (
                    case modifyIORef ref (\x -> x + 100) RealWorld of
                      (rwB, ()) ->
                        case modifyIORef ref (\x -> x + 2) rwB of
                          (_rwC, ()) ->
                            ()
               ) rw1 of
          (rw2, ()) ->
            case (printReadIORef ref) rw2 of
              (rw3, ()) -> do
                case evaluate (
                                   case modifyIORef ref (\x -> x + 100) RealWorld of
                                     (rwB', ()) ->
                                       case modifyIORef ref (\x -> x + 3) rwB' of
                                         (_rwC', ()) ->
                                           ()
                              ) rw3 of
                  (rw4, ()) ->
                    (printReadIORef ref) rw4




































































































data IORef a = IORef

newIORef :: a -> RealWorld -> (RealWorld, IORef a)
newIORef = undefined

readIORef :: IORef a -> RealWorld -> (RealWorld, a)
readIORef = undefined

modifyIORef :: IORef a -> (a -> a) -> RealWorld -> (RealWorld, ())
modifyIORef = undefined

evaluate :: a -> RealWorld -> (RealWorld, ())
evaluate = undefined

printReadIORef :: IORef a -> RealWorld -> (RealWorld, ())
printReadIORef = undefined

main :: IO ()
main = do
  let (RealWorld, ()) = main' RealWorld
  pure ()
