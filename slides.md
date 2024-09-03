#lang "klister.kl"
-- Non-confluence                                                                                                                                              -- vim: set syntax=klister:

                        -- function position,       argument position,
                        -- then argument position   then function position

(example                --                          error: type is ambiguous
  ((const* 1 "hello")   -- (const "hello")
   (default))           -- 1 : Int                  (default) : ?1
)
