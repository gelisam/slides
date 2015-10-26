

// A common pattern in javascript:


  var email = user && user.email;
  
  var subscriptionId = organization
                    && organization.subscription
                    && organization.subscription.id;





































































































// So, what does auto-immune programming look like? Well, here is a common javascript
// pattern: before accessing a field, we check that the parent exists, and of course
// for a nested field we check all the parents along the path. We do this, of course,
// because the parent might be null or undefined, in which case accessing the field
// would raise an error and abort our program.
