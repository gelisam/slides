> class Monoid a where
>   mempty  :: a
>   mappend :: a -> a -> a

> class Applicative f where
>   pure  :: a -> f a
>   (<*>) :: f (a -> b) -> f a -> f b

> class Alternative f where
>   empty :: f a
>   (<|>) :: f a -> f a -> f a


> data Promise a

> now  :: a -> Promise a
> both :: Promise a -> Promise b -> Promise (a, b)

> never  :: Promise a
> either :: Promise a -> Promise a -> Promise a




















































































































