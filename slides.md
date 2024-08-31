#lang "klister.kl"
-- Type-driven macros need type information!                                                                                                                   -- vim: set syntax=klister:

--    parser
--       v
--  [expander]
--       v
--  typechecker
--       v
-- code generator

(example
  ((const* 2 "hello")  -- (const (const "hello"))
   1                   --   : (-> Int Int String)
   2)  -- : String
)

(example
  (+ 42
     (default))        -- (default) : ?
)
