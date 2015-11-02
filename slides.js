

// A common pattern in javascript:


  var email = user && user.email;
  
  var subscriptionId = organization
                    && organization.subscription
                    && organization.subscription.id;



// I hate this!!!



































































































// This piece of code lives in a much larger codebase with data constantly flowing
// from one part of the code to another, and in order to maintain the program we not
// only to understand what each particular piece of code does, but also how the pieces
// interact.
// 
// To me, this pattern is not a "javascript good practice", it's the symptom of an
// unmaintainable program, a sign that the programmers have given up on understanding
// which state their program can be in, and thus have no idea what values this function
// could receive as input, they simply hope that all the fields are there, but in the
// case they aren't, the programmers are mounting defenses, preparing to defend against
// random other inputs that could be thrown at them.
