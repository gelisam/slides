#lang "klister.kl"
-- Task queue                                                                                                                                                  -- vim: set syntax=klister:

(example
  (!3
   !2)
)


-- TASK QUEUE
--
-- > * evaluate (case-integer 1 ...) to !3 and (-> ?2 ?1)
--   * evaluate (type-case ?2
--                [Int  (pure `1)]
--                ...)              to !2 and ?2  [STUCK ON ?2]
