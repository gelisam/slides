#lang "klister.kl"
-- Fragile                                                                                                                                                     -- vim: set syntax=klister:

(example              -- ((+ : (-> Int Int Int))
  (+ 42               --  (42 : Int)
     (default))       --  (1 : Int)) : Int
)

(example
  (let [x (default)]  -- (default) : ?1
    (+ 42 x))
)

--(example            -- error: type is ambiguous
--  ((default)        -- (default) : (-> ?1 ?2)
--   (default))       -- (default) : ?1
--)
