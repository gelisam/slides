#lang "klister.kl"
--    [  Late-typed code generation ]                                                                                                                   -- vim: set syntax=klister:
-- vs   Early-typed code generation

-- const : (-> Int Syntax (Macro Syntax))
(define-macro (power n x)
  (case-integer n
    [zero       (pure `1)]
    [(succ n-1) (pure `(*  ,x (power ,n-1 ,x)))]))

(example
  (power 8 2)
)
