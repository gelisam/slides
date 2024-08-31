#lang "klister.kl"
--       Late-typed code generation                                                                                                                     -- vim: set syntax=klister:

-- (const* 3 "hello")
-- =>
-- (const (const (const "hello")))
(define-macro (const* n r)
  (case-integer n
    [zero       (pure r)]
    [(succ n-1) (pure `(const (const* ,n-1 ,r)))]))

(example
  (const* 0 "hello")  -- "hello"
)
(example
  (const* 1 "hello")  -- (const "hello")
)
(example
  (const* 2 "hello")  -- (const (const "hello"))
)
