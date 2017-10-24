data EditScript :: [*] -> [*] -> * where
  Ins :: ... -> EditScript ts (S:ts')
  Del :: ... -> EditScript (S:ts) ts'
  Cpy :: ... -> EditScript (S:ts) (S:ts')
  End :: EditScript [] []
  deriving Generic  -- error: Can't derive Generic, EditScript
                    --        must be a vanilla data constructor

genericEq :: Generic a => a -> a -> Bool
genericEq x y = toRep p1 == toRep p2

instance (Eq a, Eq b) => Eq (a, b) where
  (x1,y1) == (x2,y2) = (x1 == x2) && (y1 == y2)

instance (Eq a, Eq b) => Eq (Either a b) where
  Left  x1 == Left  x2 = x1 == x2
  Right y1 == Right y2 = y1 == y2
  _        == _        = False



