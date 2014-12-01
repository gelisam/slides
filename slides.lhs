

  // mario wins if he shoots 5 fireballs at bowser
  // or if he touches the axe,
  // but loses if he is hit by one of bowser's hammers,
  // by one of bowser's fire projectiles,
  // or if bowser touches him.
  
  bool mario_wins = false;                  bool bowser_dies = (fireball_hit_count >= 5)
                                                            || mario_touches(axe);
  if (fireball_hit_count >= 5) {            bool mario_dies = mario_touches(hammer)
    mario_wins = true;                                     || mario_touches(fire_projectile)
  }                                                        || mario_touches(bowser);
  if (mario_touches(axe)) {                 
    mario_wins = true;                      bool mario_wins = bowser_dies && !mario_dies;
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
  
  










































































