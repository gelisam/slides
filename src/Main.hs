-- tracked exceptions (Maybe, Either...):
-- conditions which ought to be handled semantically.
-- e.g. element not found in the cache,
--      environment not configured as expected,
--      etc.

-- untracked exceptions (error, undefined, ...):
-- conditions which ought to be handled generically.
-- e.g. the algorithm was implemented incorrectly;
--      it expected a key which wasn't there,
--      it got stuck in an infinite loop,
--      etc.



































































































main :: IO ()
main = return ()
