// Once upon a time...
// before there were promises...
// lived the callback.


// play intro animation
function playCutscene() {
  return lookLeft(boyfriend).then(function() {
    return speak(boyfriend, heartSprite).then(function() {
      return lookRight(player).then(function() {
        return speak(player, heartSprite).then(function() {
          return sleep(200).then(function() { // for dramatic effect!
            return lookDown(boyfriend).then(function() {
              return speak(boyfriend, heartSprite);
            });
          });
        });
      });
    });
  });
}












                                     


























































































