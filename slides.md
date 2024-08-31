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
  (+ 42 (default))        -- 1
)                         --   : Int
(example                  -- "hello"
  (++ "hello" (default))  --   : String
)
(example                  -- (lambda (x) (+ x 1))
  ((default) 42)          --   : (-> Int Int)
)
(example                  -- (lambda (x) (++ x "!"))
  ((default) "hello")     --   : (-> String String)
)
