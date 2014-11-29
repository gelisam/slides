

       -------------------   Implementation
      | o .               |
      |-------------------|  * display splash screen
      | +---+ +---+ +---+ |  * imagesLoaded := Background { load images }
      | |   | |   | |   | |  * splashDone := First(imagesLoaded, Timeout(3))
      | +---+ +---+ +---+ |  * on splashDone {
      | +---+ +---+ +---+ |      displayAdScreen();
      | |   | |   | |   | |    }
      | +---+ +---+ +---+ |  * adSeen := First(Timeout(3), Click())
      | +---+ +---+       |  * adDone := Last(imagesLoaded, adSeen)
      | |   | |   |  ...  |  * on adDone {
      | +---+ +---+       |      displayImages();
      |                   |    }
      |                   |
      |                   |
      |___________________|
      |        ( )        |
       -------------------





















































































































