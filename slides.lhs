

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
      |                   |      } else {
      |                   |        displayImages();
      |                   |      }
      |    please wait... |    }
      |                   |    
      |___________________|    
      |        ( )        |
       -------------------





















































































































