class Diff a where
  type Patch a
  apply :: Patch a -> a -> a


instance (Diff a, Diff b) => Diff (a, b) where
  type Patch (a, b) = (Patch a, Patch b)
  apply (pX, pY) (x, y) = (apply pX, apply pY)













