module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Debug.Trace

-- |
-- >>> let lazyY    = trace "evaluating" (2+2::Int) in 42
-- 42
-- >>> let lazyY () = trace "evaluating" (2+2::Int) in 42
-- 42
--
-- >>> let lazyY    = trace "evaluating" (2+2::Int) in 42 + lazyY
-- evaluating
-- 46
-- >>> let lazyY () = trace "evaluating" (2+2::Int) in 42 + lazyY ()
-- evaluating
-- 46








































































test :: IO ()
test = doctest ["src/Slide.hs"]

main :: IO ()
main = putStrLn "typechecks."
