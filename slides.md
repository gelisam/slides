#lang "klister.kl"
-- Stuck macros                                                                                                                                                -- vim: set syntax=klister:

                        -- function position,       argument position,
                        -- then argument position   then function position

(example
  ((const* 1 "hello")   --                          error: type is ambiguous
   (default))           --                          (default) : ?1
)
(example                -- error: type is ambiguous
  ((default)            -- (default) : (-> ?1 ?2)
   (const* 0 "hello"))
)
