hamm: Modular Maps
===

> data DefaultingT map k a = DefaultingT { unDefaultingT :: map k a }
> data BoundedT    map k a = BoundedT    { unBoundedT    :: map k a }
> 
> type MyMap = DefaultingT (BoundedT Map) Int String
> 
> class IsMap map k a where
>   lookup :: k ->      map k a -> Maybe a
>   insert :: k -> a -> map k a -> map k a
>   size   :: map k a -> Int
> 
> instance Ord k => IsMap Map k a where
>   lookup = Map.lookup
>   insert = Map.insert
>   size   = Map.size
> 
> instance (IsMap map k a, Monoid a) => IsMap (DefaultingT map) k a where
>   insert k a (DefaultingT inner) = DefaultingT (insert k a inner)
>   size       (DefaultingT inner) = size inner
> 
>   lookup k   (DefaultingT inner) = Just . fromMaybe mempty . lookup k $ inner
> 
> instance IsMap map k a => IsMap (BoundedT map) k a where
>   lookup k   (BoundedT inner) = lookup k inner
>   size       (BoundedT inner) = size inner
> 
>   insert k a (BoundedT inner) | size inner < 10 = BoundedT (insert k a inner)
>                               | otherwise       = BoundedT inner
