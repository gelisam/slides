data Pizza = Pizza
  { toppings :: Set Topping
  , extras   :: Set Topping
  } deriving Generic

genericEq :: Generic a => a -> a -> Bool
genericEq x y = toRep p1 == toRep p2

instance (Eq a, Eq b) => Eq (a, b) where
  (x1,y1) == (x2,y2) = (x1 == x2) && (y1 == y2)

instance (Eq a, Eq b) => Eq (Either a b) where
  Left  x1 == Left  x2 = x1 == x2
  Right y1 == Right y2 = y1 == y2
  _        == _        = False

data Set a = Set [a]
instance Ord a => Eq (Set a) where
  Set xs == Set ys = nub (sort xs) == nub (sort ys)


