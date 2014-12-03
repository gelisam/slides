
Primitives:

  * ...
  * ...
  * ...

Combinators:

  * ...
  * ...

Bonus: monadic composition

  * sequence two systems. that is:
     - run the first system until         :: m a        (system)
       it produces a value.
     - if needed, use the value           :: a -> m b
       computed by the first                 (function which
       system to determine what                    returns a system)
       the second system should be.
     - run the second system.
     - the value produced by the          :: m b        (system)
       combined system is the value
       produced by the second system.

Extra bonus: comonadic extension

  * parallel update. that is:
     - the system consists                :: w a        (system)
       of many similar parts.             
     - focus on a single part             :: w a -> b
       and transform it.                     (function which
     - if needed, use the value of                 receives a system)
       neighbouring parts or the shape
       of the local neighbourhood to
       determine what the transformed
       value should be.
     - all the parts get transformed
       in the same way.                   :: w b        (system)

















































































































