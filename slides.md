#lang "klister.kl"
-- Fragile                                                                                                                                                     -- vim: set syntax=klister:

(example              -- ((+ : (-> Int Int Int))
  (+ 42               --  (42 : Int)
     (default))       --  (1 : Int)) : Int
)

(example
  (let [x (default)]
    (+ 42 x))
)
