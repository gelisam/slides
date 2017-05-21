

       -------------------   Implementation
      | o .               |
      |-------------------|  * display splash screen
      |                   |  * imagesLoaded := Background { load images }
      |                   |  * splashDone := Either(imagesLoaded, Timeout(3))
      |                   |  * on splashDone {
      |                   |      displayAdScreen();
      |    AD             |    }
      |    S C R E E N    |  * adDone := Both(imagesLoaded, Timeout(3))
      |                   |
      |                   |
      |                   |
      |                   |
      |    please click!  |
      |                   |
      |___________________|
      |        ( )        |
       -------------------





















































































































