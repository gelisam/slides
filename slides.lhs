
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


















































































































