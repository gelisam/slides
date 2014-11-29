

       -------------------   Implementation
      | o .               |
      |-------------------|  * display splash screen
      | +---+ +---+ +---+ |  * imagesLoaded := Background { load images }
      | |   | |   | |   | |  * splashDone := First(imagesLoaded, Timeout(3))
      | +---+ +---+ +---+ |  * on splashDone {
      | +---+ +---+ +---+ |      displayAdScreen();
      | |   | |   | |   | |    }
      | +---+ +---+ +---+ |  
      | +---+ +---+       |  * adDone := Last(imagesLoaded, Timeout(3))
      | |   | |   |  ...  |  * on adDone {
      | +---+ +---+       |      displayImages();
      |                   |    }
      |                   |
      |                   |
      |___________________|
      |        ( )        |
       -------------------





















































































































