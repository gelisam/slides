import Test.DocTest

data Codensity m a = Codensity
  { unCodensity :: forall r. (a -> m r) -> m r }

-- (>>=)    :: forall a r. m a -> (a -> m r) -> m r
-- (mx >>=) :: forall   r.        (a -> m r) -> m r

makeCodensity :: Monad m => m a -> Codensity m a
makeCodensity mx = Codensity (mx >>=)

fromCodensity :: Monad m => Codensity m a -> m a
fromCodensity cx = unCodensity cx pure

-- |
-- >>> unCodensity foo pure
-- foo
-- >>> unCodensity foo (\() -> putStrLn "bar")
-- foo
-- bar
foo :: Codensity IO ()
foo = makeCodensity $ putStrLn "foo"





















































main :: IO ()
main = doctest ["-XFlexibleInstances", "-XInstanceSigs", "-XRankNTypes", "src/Main.hs"]
