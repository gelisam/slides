import Data.Map as Map


next :: Map Int Int
next = Map.fromList [ (1, 2)
                    , (2, 3)
                    , (3, 4)
                    ]

main :: IO ()
main = do
    print $ do i <- Map.lookup 2 next
               j <- Map.lookup i next
               k <- Map.lookup j next
               return k
    print $ let i = next ! 2
                j = next ! i
                k = next ! j
            in k


































































































