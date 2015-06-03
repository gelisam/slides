-- matrix multiplication
import Data.Array

--                    +---+---+
--  +---+---+---+     |  7|  8|     +---+---+
--  | 1 | 2 | 3 |     +---+---+     | 58| 64|
--  +---+---+---+  *  |  9| 10|  =  +---+---+
--  | 4 | 5 | 6 |     +---+---+     |139|154|
--  +---+---+---+     | 11| 12|     +---+---+
--                    +---+---+
--             xs            ys            zs

xs :: Array (Int, Int) Double
xs = listArray ((1,1), (2,3)) [ 1.0, 2.0, 3.0
                              , 4.0, 5.0, 6.0
                              ]

ys :: Array (Int, Int) Double
ys = array ((1,1), (3,2)) [ ((1,1),  7.0) , ((1,2),  8.0)
                          , ((2,1),  9.0) , ((2,2), 10.0)
                          , ((3,1), 11.0) , ((3,2), 12.0)
                          ]

zs :: Array (Int, Int) Double
zs = array ((1,1), (2,2)) [pair i k | i <- [1,2]
                                    , k <- [1,2]
                                    ]
  where
    pair i k = ((i,k), value i k)
    value i k = sum [term i j k | j <- [1,2,3]]
    term i j k = xs ! (i,j)
               * ys ! (j,k)


main :: IO ()
main = print zs


























































































-- -- matrix multiplication
-- {-# LANGUAGE ScopedTypeVariables #-}
-- 
-- import Data.Array
-- import Data.List
-- 
-- mult :: forall a. Num a
--      => Array (Int, Int) a
--      -> Array (Int, Int) a
--      -> Array (Int, Int) a
-- mult xs ys | jbounds1 == jbounds2 = zs
--            | otherwise            = error "incompatible arrays"
--   where
--     zs = array zbounds [cell i k | i <- range ibounds
--                                  , k <- range kbounds
--                                  ]
--     
--     cell :: Int -> Int -> ((Int, Int), a)
--     cell i k = ((i, k), value i k)
--     
--     value :: Int -> Int -> a
--     value i k = sum [term i j k | j <- range jbounds1]
--     
--     term :: Int -> Int -> Int -> a
--     term i j k = xs ! (i,j)
--                * ys ! (j,k)
--     
--     ((iLow, jLow1), (iHigh, jHigh1)) = bounds xs
--     ((jLow2, kLow), (jHigh2, kHigh)) = bounds ys
--     
--     ibounds = (iLow, iHigh)
--     jbounds1 = (jLow1, jHigh1)
--     jbounds2 = (jLow2, jHigh2)
--     kbounds = (kLow, kHigh)
--     
--     zbounds = ((iLow, kLow), (iHigh, kHigh))
-- 
-- 
-- fromList :: [[Double]] -> Array (Int, Int) Double
-- fromList xss = listArray ((1,1), (h,w))
--                          (concat xss)
--   where
--     w = length (head xss)
--     h = length xss
-- 
-- toList :: Array (Int, Int) Double -> [[Double]]
-- toList xss = [[xss ! (j,i) | i <- range ibounds] | j <- range jbounds]
--   where
--     ((jLo, iLo), (jHi, iHi)) = bounds xss
--     ibounds = (iLo, iHi)
--     jbounds = (jLo, jHi)
-- 
-- xs :: Array (Int, Int) Double
-- xs = fromList [[1,2,3]
--               ,[4,5,6]]
-- 
-- ys :: Array (Int, Int) Double
-- ys = fromList [[7,8]
--               ,[9,10]
--               ,[11,12]]
-- 
-- 
-- main :: IO ()
-- main = print $ toList $ mult xs ys
