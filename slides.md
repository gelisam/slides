#lang "klister.kl"
-- Late-typed code generation + Type-driven code generation                                                                                                    -- vim: set syntax=klister:

(example
  ((const* 1 "hello")    -- (const "hello") : (-> Int String)
   (default)))           -- 1 : Int

(example
  ((default)             -- (lambda (x) (++ x "!") : (-> String String)
   (const* 0 "hello")))  -- "hello" : String

--(example               -- error: type is ambiguous
--  ((default)           -- (default) : (-> ?1 ?2)
--   (default))          -- (default) : ?1
--)
