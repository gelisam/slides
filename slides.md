#lang "klister.kl"
-- Task queue                                                                                                                                                  -- vim: set syntax=klister:

(example
  ((const "hello")
   !2)
)


-- TASK QUEUE
--
-- > * expand + typecheck (const "hello") to !3 and (-> Int String)
--   * evaluate (type-case ?2
--                [Int  (pure `1)]
--                ...)              to !2 and ?2  [STUCK ON ?2]
