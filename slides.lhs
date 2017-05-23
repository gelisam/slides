> class Monoid a where
>   mempty  :: a
>   mappend :: a -> a -> a

> instance Monoid Bool where
>   mempty  = True
>   mappend = (&&)

> instance Monoid Event where
>   mempty  = now
>   mappend = both

> foldMap :: Monoid e => (a -> e) -> [a] -> e
> foldMap f = foldr mappend mempty
>           . map f

> all :: (a -> Bool) -> [a] -> Bool
> all = foldMap        -- all f = foldr (&&) True
>                      --       . map f

> allEvents :: (a -> Event) -> [a] -> Event
> allEvents = foldMap  -- allEvents f = foldr both now
>                      --             . map f

















































































































