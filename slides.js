///////////////////////////
// defensive programming //
///////////////////////////

// > Good idea: defend against malformed user input
//    Bad idea: defend against malformed input arguments


  // a new user filled the signup form
  app.post('/signup', function(req, res, next) {
    
    // the client sent us a JSON object with all the fields
    // required to create a User row in Mongoose
    var newUser = new User({          // {
      firstName : req.body.firstName, //   firstName  : "Samuel",
      lastName  : req.body.lastName,  //   lastName   : "Gélineau",
      email     : req.body.email,     //   email      : "samuel.gelineau@keatext.com,
    });                               //   id         : 123456  // ignored
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






































































































