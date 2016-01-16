{-# LANGUAGE ScopedTypeVariables #-}
import Data.Map as Map
import Control.Exception


next :: Map Int Int
next = Map.fromList [ (1, 2)
                    , (2, 3)
                    , (3, 4)
                    ]


lookupPlusOne :: Maybe Int
lookupPlusOne = do
    x <- Map.lookup 4 next
    return (x + 1)

lookupPlusTwo :: Maybe Int
lookupPlusTwo = do
    x <- lookupPlusOne
    return (x + 1)


bangPlusOne :: Int
bangPlusOne = (next ! 4) + 1

bangPlusTwo :: Int
bangPlusTwo = bangPlusOne + 1

main :: IO ()
main = do
    case lookupPlusTwo of
      Just _  -> print "succeeded."
      Nothing -> print "failed."
    
    catch (do let r = bangPlusTwo
              r `seq` print "succeeded.")
          (\(err :: SomeException) -> do
              print "failed.")




































































































