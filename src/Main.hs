

instance Functor (Yoneda f) where
  fmap :: (a -> b) -> Yoneda f a -> Yoneda f b
  fmap a2b ya = Yoneda $ \b2r
             -> unYoneda ya (b2r . a2b)

-- fromYoneda . fmap c2d . fmap b2c . fmap a2b . makeYoneda $ fa
-- (<$> fa) (id . c2d . b2x . a2b)


instance Functor f => Functor (Sloyeda f) where
  fmap :: (a -> b) -> Sloyeda f a -> Sloyeda f b
  fmap a2b ya = Sloyeda $ \b2r
             -> b2r <$> unSloyeda ya a2b

-- fromSloyeda . fmap c2d . fmap b2c . fmap a2b . makeSloyeda $ fa
-- id <$> c2r <$> b2c <$> a2b <$> fa


























































newtype Yoneda f a = Yoneda { unYoneda :: forall r. (a -> r) -> f r }
newtype Sloyeda f a = Sloyeda { unSloyeda :: forall r. (a -> r) -> f r }

main :: IO ()
main = putStrLn "done."
