generic-lens
===

> import Control.Lens
> 
> 
> data Person = Person
>   { _name :: String
>   , _age  :: Int
>   } deriving Generic
> 
> makeLenses ''Person
> 
> greet :: Person -> String
> greet person = "hello, " ++ view name person ++ "!"
