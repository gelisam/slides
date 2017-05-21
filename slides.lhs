

       -------------------   Implementation
      | o .               |
      |-------------------|  * display splash screen
      | +---+ +---+ +---+ |  * imagesLoaded := Background { load images }
      | |   | |   | |   | |  * splashDone := Either(imagesLoaded, Timeout(3))
      | +---+ +---+ +---+ |  * on splashDone {
      | +---+ +---+ +---+ |      displayAdScreen();
      | |   | |   | |   | |    }
      | +---+ +---+ +---+ |  * adDone := Both(imagesLoaded, Timeout(3))
      | +---+ +---+       |  * on adDone {
      | |   | |   |  ...  |      displayImages();
      | +---+ +---+       |    }
      |                   |
      |                   |
      |                   |
      |___________________|
      |        ( )        |
       -------------------





















































































































