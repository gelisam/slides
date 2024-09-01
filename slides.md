#lang "klister.kl"
-- Interleaving macro-expansion and type-checking                                                                                                                                       -- vim: set syntax=klister:

--    parser               parser                   [parser]
--       v                    v                         v
--   expander            typechecker           expander + typechecker
--       v                    v                         v
--  typechecker           expander                code generator
--       v                    v
-- code generator       code generator

(example
  ((const* 2 "hello")  -- ((const (const "hello")) : (-> Int Int String)
   1                   --  (1 : Int)
   2)                  --  (2 : Int)) : String
)

(example
  (+ 42
     (default))
)
