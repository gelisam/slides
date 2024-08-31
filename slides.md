#lang "klister.kl"
-- Late-typed macros must be type-check after!                                                                                                                                           -- vim: set syntax=klister:

--    parser               parser
--       v                    v
--   expander           [typechecker]
--       v                    v
--  typechecker           expander
--       v                    v
-- code generator       code generator

(example
  ((const* 2 "hello")  -- (const* 2 "hello") : (-> Int Int ?1)
   1                   -- 1 : Int
   2)                  -- 1 : Int
)

(example
  (+ 42                -- + : (-> Int Int Int)
     (default))        -- "!" : Int
)
