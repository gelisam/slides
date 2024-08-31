#lang Beluga, Moebius
--       Late-typed code generation                                                                                                                     -- vim: set syntax=moebius:
-- vs [ Early-typed code generation ]

power : int → ⌈ x:int ⊢ int ⌉
power n =
  if n = 0
  then box(x. 1)
  else let box(x. X_TO_THE_N_MINUS_ONE) = power (n - 1)
    in box(x.
         (X_TO_THE_N_MINUS_ONE with x) * x
       )
