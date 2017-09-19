invertible parsers

> {-# LANGUAGE TemplateHaskell, TypeOperators, OverloadedStrings, RankNTypes #-}
> import Text.Boomerang

> import Prelude hiding ((.), id)
> import Control.Category ((.), id)
> import Text.Boomerang.String

> bool :: StringBoomerang r (Bool :- r)
> bool = (rTrue  . "True")
>     <> (rFalse . "False")

> list :: (forall x. StringBoomerang x (a :- x))
>      -> StringBoomerang r ([a] :- r)
> list rElem = "[" . whitespaceAllowed . (rNil <> go) . whitespaceAllowed . "]"
>   where
>     go = (rCons . rElem . rNil)
>       <> (rCons . rElem . whitespaceAllowed . "," . whitespaceSuggested . go)


























































> input :: String
> input = "[  True ,False ]"

> whitespaceAllowed :: StringBoomerang r r
> whitespaceAllowed = manyr " "

> whitespaceSuggested :: StringBoomerang r r
> whitespaceSuggested = (" " <> id) . whitespaceAllowed

> main :: IO ()
> main = do
>   print input
>   print $ parseString (list bool) input
>   print $ unparseString (list bool) [True, False]
