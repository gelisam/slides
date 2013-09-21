// data Frame = Strike
//            | Spare Int
//            | Miss  Int Int

// using algebraic types in Haskell:
// 
// rolls :: Frame -> [Pins]
// rolls Strike     = [10]
// rolls (Spare n)  = [n, 10-n]
// rolls (Miss n m) = [n, m]

// using algebraic types in Java:
int[] rolls(Frame frame) {
  if (frame instanceof Strike) {
    return 10;
  } else if (frame instanceof Spare) {
    Spare spare = (Spare) frame;
    return new int[] {spare.r1, 10 - miss.r1};
  } else {
    Miss miss = (Miss) frame;
    return new int[] {miss.r1, miss.r2};
  }
}
