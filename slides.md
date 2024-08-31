#lang "klister.kl"
-- Straightforward approach: expand the macros in the expander phase                                                                                                          -- vim: set syntax=klister:

--    parser
--       v
--   expander
--       v
-- [typechecker]
--       v
-- code generator

(example
  ((const* 2 "hello")  -- (const (const "hello"))
   1
   2)
)
