#lang "klister.kl"
-- Type-inference                                                                                                                                              -- vim: set syntax=klister:

-- const : ∀ α. α → Int → α
(define const
  (lambda (r i)
    (let [_x (+ i 1)]
      r)))

(example
  const
)
(example
  (const "hello" 42)
)
