
class Functor f where
  (<$>) :: (a -> b) -> f a -> f b

(<$) :: Functor f => a -> f b -> f a


class Applicative f where
  pure  :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b

(<*) :: Applicative f => f a -> f b -> f a
(*>) :: Applicative f => f a -> f b -> f b


class Alternative f where
  empty :: f a
  (<|>) :: f a -> f a -> f a

some :: Alternative f => f a -> f (NonEmpty a)
many :: Alternative f => f a -> f [a]













































> main :: IO ()
> main = do
>   putStrLn "typechecks."
