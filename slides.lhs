> class Monoid a where
>   mempty  :: a
>   mappend :: a -> a -> a

> instance Monoid Event where
>   mempty  = ???     -- either e never = e
>   mappend = either

> someEvent :: (a -> Event) -> [a] -> Event
> someEvent f []           = ???
> someEvent f [x1]         = f x1
> someEvent f [x1, x2]     = f x1 `either` f x2
> someEvent f [x1, x2, x3] = f x1 `either` f x2 `either` f x3
> someEvent f ...          = ...






















































































































