#lang "klister.kl"
-- Late-typed code generation + Type-driven code generation                                                                                                    -- vim: set syntax=klister:

(example
  ((const* 1 "hello")    -- (const "hello") : (-> Int String)
   (default)))           -- 1 : Int

(example
  ((default)             -- (default)
   (const* 0 "hello")))  -- (const* 0 "hello")

--(example
--  ((default)           -- (default)
--   (default))          -- (default)
--)
