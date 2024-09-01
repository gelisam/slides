#lang "klister.kl"
-- Interleaving macro-expansion and type-checking                                                                                                                                       -- vim: set syntax=klister:

--    parser               parser                    parser
--       v                    v                         v
--   expander            typechecker          [expander + typechecker]
--       v                    v                         v
--  typechecker           expander                code generator
--       v                    v
-- code generator       code generator

(example
  ((const* 2 "hello")  -- ( _
   1                   --   _
   2)                  --   _ )
)

(example
  (+ 42
     (default))
)
