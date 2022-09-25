-------------------------------------------------------------------------------
-- 2.3.3. BIGGER input?                                                      --
-------------------------------------------------------------------------------

xor :: Bool -> Bool -> Bool   -- exists x y. xor (not x) y /= not (xor x y)
                              -- 2 bits

labelImage :: Image -> Text   -- exists pixels. (labelImage x == labelImage y)
                              --             && (distance x y < 0.1)
                              -- 256*256 * 3     =   196 608 integers
                              -- 256*256 * 3 * 8 = 1 572 864 bits













type Image = ()
type Text = ()

xor = undefined

labelImage = undefined

main :: IO ()
main = do
  let _xor = xor
  let _labelImage = labelImage
  putStrLn "-------------------------"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "--     typechecks.     --"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "-------------------------"
