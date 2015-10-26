///////////////////////////
// defensive programming //
///////////////////////////

// > Good idea: defend against malformed user input
//    Bad idea: defend against malformed input arguments


  // a new user filled the signup form
  app.post('/signup', function(req, res, next) {
    
    // the client sent us a JSON object with all the fields
    // required to create a User row in Mongoose
    var newUser = new User(req.body); // {
                                      //   firstName  : "Samuel",
                                      //   lastName   : "Gélineau",
                                      //   email      : "samuel.gelineau@keatext.com,
                                      // }
    
    
    // write it to the Mongoose DB
    newUser.save()
      .then(function(user) {
        
        // confirm that the user was created
        res.send({
          successful: true,
          userId: user.id
        });
      });
  });






































































































