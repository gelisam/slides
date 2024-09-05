#lang "klister.kl"
-- Task queue                                                                                                                                                  -- vim: set syntax=klister:

(example
  ((const "hello")
   !2)
)


-- TASK QUEUE
--
--   * evaluate (type-case Int
--                [Int  (pure `1)]
--                ...)              to !2 and Int
