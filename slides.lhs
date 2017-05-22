> class Monoid a where
>   mempty  :: a
>   mappend :: a -> a -> a

> class Applicative f where
>   pure  :: a -> f a
>   (<*>) :: f (a -> b) -> f a -> f b

> class Monad f where
>   (>>=) :: f a -> (a -> f b) -> f b

> maybeDisplayAd :: Event ()
> maybeDisplayAd = do
>   user <- fetchUserInfo                      -- fetchUserInfo().then(function(user) {
>   if userSubscriptionLevel user == Freemium  --   if (user.subscriptionLevel == "fremium") {
>     then displayAd                           --     return displayAd();
>     else now ()                              --   } else {
>                                              --     return Promise.resolve(undefined);
>                                              --   }
>                                              -- });
















































































































