class Diff a where
  type Patch a
  apply :: Patch a -> a -> a


instance (Diff a, Diff b) => Diff (a, b) where
  type Patch (a, b) = (Patch a, Patch b)
  apply (pX, pY) (x, y) = (apply pX, apply pY)


data PatchEither a b
  = Keep (Patch a) (Patch b)
  | Replace (Either a b)
  deriving Generic

instance (Diff a, Diff b) => Diff (Either a b) where
  type Patch (Either a b) = PatchEither a b
  apply (Keep pX _ ) (Left  x) = Left  (apply pX x)
  apply (Keep _  pY) (Right y) = Right (apply pY y)
  apply (Replace e)  _         = e

