-- I can't believe none of the pretty-printing libraries I've tried does what
-- I want:
-- 
--     |----------------------|
--     foo + (bar * baz) /= baz
--
--     |-----------------|
--       foo + (bar * baz)
--     /=
--       baz
--
--     |-----------|
--       foo + ( bar
--             * baz
--             )
--     /=
--       baz
--
--     |-------|
--       ( foo
--       + ( bar
--         * baz
--         )
--       )
--     /=
--       baz
module Doc
  ( Doc
  , (<+>)
  , above
  , orElse
  , putDocW
  ) where

import Data.String (IsString(..))


-- All the same length
type Render = [String]

renderWidth :: Render -> Int
renderWidth []
  = 0
renderWidth (xs:_)
  = length xs

renderHeight :: Render -> Int
renderHeight = length

infiniteRender :: Render -> Render
infiniteRender r
  = fmap (++ repeat ' ') r
 ++ repeat (repeat ' ')

cropRender :: Int -> Int -> Render -> Render
cropRender w h r
  = take h (fmap (take w) r)

renderAbove :: Render -> Render -> Render
renderAbove render1 render2
  = (cropRender width height1 $ infiniteRender render1)
 ++ (cropRender width height2 $ infiniteRender render2)
  where
    width1 = renderWidth render1
    width2 = renderWidth render2
    width = max width1 width2
    height1 = renderHeight render1
    height2 = renderHeight render2

renderBeside :: Render -> Render -> Render
renderBeside render1 render2
  = zipWith (++)
      (cropRender width1 height $ infiniteRender render1)
      (cropRender width2 height $ infiniteRender render2)
  where
    width1 = renderWidth render1
    width2 = renderWidth render2
    height1 = renderHeight render1
    height2 = renderHeight render2
    height = max height1 height2


data Doc
  = Render Render
  | Above Doc Doc
  | Beside Doc Doc
  | IfFits Doc Doc
  deriving Show

instance Semigroup Doc where
  (<>) = Beside

instance Monoid Doc where
  mempty = Render []

instance IsString Doc where
  fromString s = Render [s]

(<+>) :: Doc -> Doc -> Doc
d1 <+> d2 = d1 <> fromString " " <> d2

above :: Doc -> Doc -> Doc
above = Above

orElse :: Doc -> Doc -> Doc
orElse = IfFits

renderDocW :: Int -> Doc -> Render
renderDocW _ (Render render)
  = render
renderDocW maxW (Above doc1 doc2)
  = renderAbove
      (renderDocW maxW doc1)
      (renderDocW maxW doc2)
renderDocW maxW (Beside doc1 doc2)
  = let render1 = renderDocW maxW doc1
        width1 = renderWidth render1
        render2 = renderDocW (maxW - width1) doc2
 in renderBeside render1 render2
renderDocW maxW (IfFits doc1 doc2)
  = let render1 = renderDocW maxW doc1
        render2 = renderDocW maxW doc2
 in if renderWidth render1 <= maxW
    then render1
    else render2

putDocW :: Int -> Doc -> IO ()
putDocW maxW doc = do
  mapM_ putStrLn $ renderDocW maxW doc
