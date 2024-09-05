#lang "klister.kl"
-- Removing transitions                                                                                                                                        -- vim: set syntax=klister:

((const* 1 "hello")    ((default)    ((const* 1 "hello")  ((default)
 (const* 0 "hello"))    (default))    (default))           (const* 0 "hello")

--       *                  *                  *                  *
--     ↙   ↘              ↙   ↘              ↙   ↘              ↙   ↘
--    *     *            *     *            *     x            x     *
--      ↘ ↙                ↘ ↙              ↓                        ↓
--       *                  x               *                        *

--       *                  *                  *                  *
--     ↙                  ↙                  ↙                  ↙
--    *                  *                  *                  x
--      ↘                  ↘                ↓
--       *                  x               *

--       *                  *                  *                  *
--     ↙   ↘              ↙   ↘              ↙                      ↘
--    *     *            *     *            *                        *
--      ↘ ↙                ↘ ↙              ↓                        ↓
--       *                  x               *                        *
