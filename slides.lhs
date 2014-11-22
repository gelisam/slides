

       -------------------   Implementation
      | o .               |
      |-------------------|  * display splash screen
      |                   |  * imagesLoaded := Background { load images }
      |                   |  * splashDone := First(imagesLoaded, Timeout(3))
      |                   |  * on splashDone {
      |                   |      displayAdScreen();
      |    AD             |    }
      |    S C R E E N    |  * adDone := Last(imagesLoaded, Timeout(3))
      |                   |
      |                   |
      |                   |
      |                   |
      |    please click!  |
      |                   |
      |___________________|
      |        ( )        |
       -------------------





















































































































