{-# LANGUAGE DataKinds, GADTs, KindSignatures #-}
module Base where


data BaseE (k :: * -> * -> *)
           (e :: Bool)
           (a :: *)
           (b :: *)
  where
    BaseE :: k              a b
          -> BaseE k 'False a b

data LiftC2 (g :: (Bool -> * -> * -> *)
               -> (Bool -> * -> * -> *)
               -> (Bool -> * -> * -> *))
            (k1 :: * -> * -> *)
            (k2 :: * -> * -> *)
            (a :: *)
            (b :: *)
  where
    LiftC2 :: g (BaseE k1) (BaseE k2) 'False a b
           -> LiftC2 g k1         k2         a b

data EitherE (f1 :: Bool -> * -> * -> *)
             (f2 :: Bool -> * -> * -> *)
             (e :: Bool)
             (a :: *)
             (b :: *)
  where
    LeftE  :: f1 e a b -> EitherE f1 f2 e a b
    RightE :: f2 e a b -> EitherE f1 f2 e a b

type EitherC k1 k2 = LiftC2 EitherE k1 k2




































































































main :: IO ()
main = putStrLn "typechecks."
