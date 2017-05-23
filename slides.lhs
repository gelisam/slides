> class Monoid a where
>   mempty  :: a
>   mappend :: a -> a -> a

> instance Monoid Bool where
>   mempty  = True
>   mappend = (&&)

> instance Monoid Event where
>   mempty  = now
>   mappend = both





> all :: (a -> Bool) -> [a] -> Bool
> all f = foldr (&&) True
>       . map f

> allEvents :: (a -> Event) -> [a] -> Event
> allEvents f = foldr both now
>             . map f




















































































































