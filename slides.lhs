
Primitives:

  * "foo": only accept the exact string "foo".
  * IDENTIFIER: accept any sequence of alphanumeric characters.
  * STRING: accept any quoted string.
  * NUMBER: accept any integral or floating-point number.

Combinators:

  * <a> | <b>: accept if either <a> or <b> accepts.
  * <a> <b>:
     - the beginning of the input string is accepted by <a>, and
     - the rest of the input string is accepted by <b>.
  * <a>?: accept <a> and the empty string.
  * <a>*: accept zero or more copies of <a> in a sequence.

Bonus: monadic composition

  * (x:<a>) <b>:
     - the beginning of the input string is accepted by <a>.
     - using the value parsed by <a>, determine what <b> should be.
     - the rest of the input string is accepted by <b>.


















































































































