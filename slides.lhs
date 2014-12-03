
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
     - if needed, use the value
       computed by the first
       system to determine what
       the second system should be.
     - run the second system.
     - the value produced by the          :: m b        (system)
       combined system is the value
       produced by the second system.


















































































































