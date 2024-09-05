#lang "klister.kl"
-- Stuck macros                                                                                                                                                -- vim: set syntax=klister:




(example                -- (type-case ?1
  ((const* 1 "hello")   --   [Int         e1]  ---/-->  error: type is ambiguous
   (default))           --   [(-> Int t2) e2])
)
(example                -- (type-case (-> ?1 ?2)
  ((default)            --   [Int         e1]  ---/-->  error: type is ambiguous
   (const* 0 "hello"))  --   [(-> Int t2) e2])
)
