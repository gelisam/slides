#lang "klister.kl"
-- Task queue                                                                                                                                                  -- vim: set syntax=klister:

(example
  (!3
   !2)
)


-- TASK QUEUE
--
--   * expand + typecheck (const* 1 "hello") to !3 and (-> ?2 ?1)
-- > * evaluate (do (t <- (expected-type))
--                  (type-case t
--                    [Int  (pure `1)]
--                    ...))                to !2 and ?2
