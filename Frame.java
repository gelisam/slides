// data Frame = Strike
//            | Spare Int
//            | Miss  Int Int

// using algebraic types in Haskell:
// 
// rolls :: Frame -> [Pins]
// rolls Strike     = [10]
// rolls (Spare n)  = [n, 10-n]
// rolls (Miss n m) = [n, m]
