
Primitives:

  * event occurs after n seconds
  * run function in a separate thread,
    event occurs when the function completes
  * event occurs when the user clicks

Combinators:

  * combined event occurs when the last event from a list has occurred
  * combined event occurs when the first event from a list occurs

Bonus: monadic composition

  * sequence two systems. that is:
     - run the first system until its event occurs.
     - if needed, use a value computed by the first system
       to determine what the second system should be.
     - run the second system.
     - combined event occurs when the second event occurs.


















































































































