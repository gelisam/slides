{-# LANGUAGE Arrows, GADTs #-}
import Control.Arrow
import Control.Category

data Syntax a b where
  Then  :: Syntax a b -> Syntax b c -> Syntax a c
  Arr   :: (a -> b)   -> Syntax a b
  First :: Syntax a b -> Syntax (a,r) (b,r)
  Named :: String     -> Syntax a a

pipeline1 :: Syntax (a,a) (a,a)
pipeline1 = proc (x,y) -> do
    x' <- Named "foo" -< x
    y' <- Named "bar" -< y
    returnA -< (x',y')

pipeline2 :: Syntax (a,a) (a,a)
pipeline2 = proc (x,y) -> do
    x' <- Named "foo" -< y
    y' <- Named "bar" -< x
    returnA -< (x',y')




















instance Category Syntax where
  id = Named "id"
  (.) = flip Then

instance Arrow Syntax where
  arr   = Arr
  first = First

pprint :: Syntax a b -> IO ()
pprint x0 = do
    _ <- go "" False x0
    return ()
  where
    go :: String -> Bool -> Syntax a b -> IO Bool
    go indent skipArr (Then x y) = do skipArr' <- go indent skipArr x
                                      go indent skipArr' y
    go indent True    (Arr _)    = do return True
    go indent False   (Arr _)    = do putStr indent
                                      putStrLn "Arr ???"
                                      return True
    go indent _       (First x)  = do putStr indent
                                      putStrLn "First ("
                                      go ("  " ++ indent) False x
                                      putStrLn ")"
                                      return False
    go indent _       (Named s)  = do putStr indent
                                      putStrLn $ "Named " ++ show s
                                      return False


main :: IO ()
main = do
  pprint pipeline1
  putStrLn ""
  putStrLn "---"
  putStrLn ""
  pprint pipeline2
