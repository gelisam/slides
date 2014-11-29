

  // mario wins if he shoots 5 fireballs at bowser
  // or if he touches the axe,
  // but loses if he is hit by one of bowser's hammers,
  // by one of bowser's fire projectiles,
  // or if bowser touches him.
  
  bool mario_wins = false;                  bool mario_wins = ...;

  if (fireball_hit_count >= 5) {
    mario_wins = true;
  }
  if (mario_touches(axe)) {
    mario_wins = true;
  }
  
  if (mario_touches(hammer)) {
    mario_wins = false;
  }
  if (mario_touches(fire_projectile)) {
    mario_wins = false;
  }
  if (mario_touches(bowser)) {
    mario_wins = false;
  }
  
  
  










































































