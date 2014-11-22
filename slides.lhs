

       -------------------   Implementation
      | o .               |
      |-------------------|  * display splash screen
      |                   |  * start a background thread {
      |                   |      load all images
      |                   |      notify main thread
      |                   |    }
      |    SPLASH         |  * images callback {
      |    S C R E E N    |      if (showingSplashScreen) {
      |                   |        displayAdScreen();
      |                   |      }
      |                   |    }
      |                   |      
      |    please wait... |      
      |                   |      
      |___________________|  
      |        ( )        |
       -------------------





















































































































