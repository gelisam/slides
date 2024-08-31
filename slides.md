#lang "klister.kl"
-- Type-check first?                                                                                                                                           -- vim: set syntax=klister:

--    parser               parser
--       v                    v
--   expander            typechecker
--       v                    v
--  typechecker          [expander]
--       v                    v
-- code generator       code generator

(example
  ((const* 2 "hello")
   1
   2)
)

(example
  (+ 42                -- + : (-> Int Int Int)
     (default))        -- 1 : Int
)
