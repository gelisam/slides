#lang "klister.kl"
-- Removing transitions                                                                                                                                        -- vim: set syntax=klister:

((const* 1 "hello")    ((default)
 (const* 0 "hello"))    (default))

--       *                  *
--     ↙   ↘              ↙   ↘
--    *     *            *     *
--      ↘ ↙                ↘ ↙
--       *                  x
