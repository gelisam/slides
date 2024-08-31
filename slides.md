#lang "klister.kl"
-- Type-driven code generation                                                                                                                                 -- vim: set syntax=klister:

-- default : (Macro Syntax)
(define-macro (default)
  (do (t <- (expected-type))
      (type-case t
        [Int      (pure `1)]
        [String   (pure `"!")]
        [(-> a b) (type-case a
                    [Int    (pure `(lambda (x) (+ x 1)))]
                    [String (pure `(lambda (x) (++ x "!")))])])))

(example
  (+ 42 (default))        -- (default)
)                         --   : Int
(example                  -- (default)
  (++ "hello" (default))  --   : String
)
(example                  -- (default)
  ((default) 42)          --   : (-> Int ?1)
)
(example                  -- (default)
  ((default) "hello")     --   : (-> String ?2)
)
