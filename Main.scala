
data Rectangle = Rectangle
  { width :: Double
  , height :: Double
  }

data Circle = Circle
  { radius :: Double
  }


rectangleArea :: Rectangle -> Double
rectangleArea (Rectangle w h) = w * h

circleArea :: Circle -> Double
circleArea (Circle r) = pi * r ^ 2
















































































main :: IO ()
main = putStrLn "typechecks."
