// Once upon a time...
// before there were promises...
// lived the callback.


// play intro animation
function playCutscene(callback) {
  lookLeft(boyfriend, function() {
    speak(boyfriend, heartSprite, function() {
      lookRight(player, function() {
        speak(player, heartSprite, function() {
          sleep(200, function() { // for dramatic effect!
            lookDown(boyfriend, function() {
              speak(boyfriend, heartSprite, callback);
            });
          });
        });
      });
    });
  });
}












                                     

























































































var boyfriend = "boyfriend";
function lookLeft(actor, callback) {
  console.log(actor + " looks left.");
}
//    speak(boyfriend, heartSprite, function() {
//      lookRight(player, function() {
//        speak(player, heartSprite, function() {
//          pause(200, function() { // for dramatic effect!
//            lookDown(boyfriend, function() {
//              speak(boyfriend, heartSprite, callback);
//            });
//          });
//        });
//      });
//    });

playCutscene();
