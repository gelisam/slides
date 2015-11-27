// Once upon a time...
// before there were promises...
// lived the callback.


// play intro animation
function playCutscene(callback) {
  lookLeft(boyfriend);
  speak(boyfriend, heartSprite);
  
  lookRight(player);
  speak(player, heartSprite);
  
  // pause for dramatic effect!
  sleep(200);
  
  lookDown(boyfriend);
  speak(boyfriend, heartSprite);
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
