#lang "klister.kl"
-- Removing transitions                                                                                                                                        -- vim: set syntax=klister:

((const* 1 "hello")    ((default)    ((const* 1 "hello")
 (const* 0 "hello"))    (default))    (default))

--       *                  *                  *
--     ↙   ↘              ↙   ↘              ↙   ↘
--    *     *            *     *            *     x
--      ↘ ↙                ↘ ↙              ↓
--       *                  x               *

--       *                  *                  *
--     ↙                  ↙                  ↙
--    *                  *                  *
--      ↘                  ↘                ↓
--       *                  x               *
