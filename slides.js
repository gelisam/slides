

// A common pattern in javascript:


  var email = user && user.email;
  
  var subscriptionId = organization
                    && organization.subscription
                    && organization.subscription.id;



// I hate this!!!



































































































// I *hate* this pattern. How come you don't know whether or not the parent could be
// undefined? To me, code of this form is a symptom of unmaintainable code.
// 
// Now I'm not saying that this code itself is unmaintainable, it's quite short and
// easy to understand. But it's a sign that the code as a whole is unmaintainable.
