#lang "klister.kl"
-- Type-inference                                                                                                                                              -- vim: set syntax=klister:

-- const : ∀ α β. α → β → α
(define const
  (lambda (r i)
    r))


(example
  const
)
(example
  (const "hello" 42)
)
