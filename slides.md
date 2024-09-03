#lang "klister.kl"
-- Non-confluence                                                                                                                                              -- vim: set syntax=klister:

                        -- function position,       argument position,
                        -- then argument position   then function position

(example                --
  ((const* 1 "hello")   -- (const "hello")
   (default))           -- 1 : Int                  (default)
)
