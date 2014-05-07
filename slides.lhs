





         hoist functions
             
             coined by Edward Kmett
             popularized by Gabriel Gonzalez
             
> class MFunctor t where
>   hoist :: (forall a. Monad m => m a -> n a) -> t m b -> t n b

> hoist1 :: (forall a. (Monad m, Monad n) => m a -> n a)
>        -> t m b -> t n b
> hoist2 :: (forall a. Functor m => m a -> n a) -> t m b -> t n b
> hoist3 :: (            Monad m => m a -> n a) -> t m a -> t n a
> hoist4 :: (forall a. Monad m => m (Maybe a) -> n (Maybe a))
>        -> t m b -> t n b













































