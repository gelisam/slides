> class Monoid a where
>   mempty  :: a
>   mappend :: a -> a -> a

> instance Monoid Event where
>   mempty  = now
>   mappend = both

> allEvents :: (a -> Event) -> [a] -> Event
> allEvents f []           = now
> allEvents f [x1]         = f x1
> allEvents f [x1, x2]     = f x1 `both` f x2
> allEvents f [x1, x2, x3] = f x1 `both` f x2 `both` f x3
> allEvents f ...          = ...






















































































































