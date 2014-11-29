

       -------------------   Implementation
      | o .               |
      |-------------------|  * display splash screen
      | +---+ +---+ +---+ |  * imagesLoaded := Background { load images }
      | |   | |   | |   | |  * splashDone := First(imagesLoaded, Timeout(3))
      | +---+ +---+ +---+ |  * on splashDone {
      | +---+ +---+ +---+ |      displayAdScreen();
      | |   | |   | |   | |    }
      | +---+ +---+ +---+ |  * adSeen :=       Timeout(3)
      | +---+ +---+       |  * adDone := Last(imagesLoaded, adSeen)
      | |   | |   |  ...  |  * on adDone {
      | +---+ +---+       |      displayImages();
      |                   |    }
      |                   |
      |                   |
      |___________________|
      |        ( )        |
       -------------------





















































































































