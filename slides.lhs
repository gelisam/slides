

       -------------------   Implementation
      | o .               |
      |-------------------|  * display splash screen
      |                   |  * start a background thread {
      |                   |      load all images
      |                   |      notify main thread
      |                   |    }
      |    SPLASH / AD    |  * images callback {
      |    S C R E E N    |      if (showingSplashScreen) {
      |                   |        displayAdScreen();
      |                   |      } else if (
      |                   |        currentTime() > adStartTime + 3 seconds
      |                   |      ) {
      |    please wait... |        displayImages();
      |                   |      }
      |___________________|    }
      |        ( )        |  * timeout callback {
       -------------------       if (showingSplashScreen) {
                                   displayAdScreen();
                                 } else if (imagesAreLoaded) {
                                   displayImages();
                                 }
                               }
                             * ad click callback {
                                 ???
                               }




















































































































