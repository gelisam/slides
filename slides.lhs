

       -------------------   Implementation
      | o .               |
      |-------------------|  * display splash screen
      | +---+ +---+ +---+ |  * imagesLoaded := Background { load images }
      | |   | |   | |   | |  * splashDone := Either(imagesLoaded, Timeout(3))
      | +---+ +---+ +---+ |  * on splashDone {
      | +---+ +---+ +---+ |      displayAdScreen();
      | |   | |   | |   | |    }
      | +---+ +---+ +---+ |  * adSeen :=       Timeout(3)
      | +---+ +---+       |  * adDone := Both(imagesLoaded, adSeen)
      | |   | |   |  ...  |  * on adDone {
      | +---+ +---+       |      displayImages();
      |                   |    }
      |                   |
      |                   |
      |___________________|
      |        ( )        |
       -------------------





















































































































