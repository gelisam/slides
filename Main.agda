data Nat : Set where
  Z : Nat
  S : Nat → Nat

data Fin : Nat → Set where
  FinZ : ∀ {n} → Fin (S n)
  FinS : ∀ {n} → Fin n → Fin (S n)

data Vec (a : Set) : Nat → Set where
  Nil  : Vec a Z
  Cons : ∀ {n} → a → Vec a n → Vec a (S n)

_!!_ : ∀ {a n} → Vec a n → Fin n → a
Nil         !! ()
(Cons x _ ) !! FinZ     = x
(Cons _ xs) !! (FinS n) = xs !! n
