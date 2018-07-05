module Slide where

awaits :: k i -> PlanT k o m i


await :: PlanT (Is a) o m a
await = awaits Refl

data Is a i where
  Refl :: Is a a


awaitsL :: PlanT (T a b) o m a
awaitsL = awaits L

data T a b i where
  L :: T a b a
  R :: T a b b



























































































data PlanT (i :: * -> *) o (m :: * -> *) a

awaits = undefined


main :: IO ()
main = putStrLn "typechecks."
