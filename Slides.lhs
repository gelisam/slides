generic-lens
===

> import Control.Lens
> import Data.Generics.Product
> 
> data Person = Person
>   { name :: String
>   , age  :: Int
>   }
>   deriving Generic
> 
> 
> greet :: Person -> String
> greet person = "hello, " ++ view (field @"name") person ++ "!"
