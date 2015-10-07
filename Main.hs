

-- Category Syntax: a do-notation for categories
-- https://github.com/gelisam/category-syntax


rearrange1 :: Either (Either a1 a2) (Either b1 b2)
           -> Either (Either a1 b1) (Either a2 b2)
rearrange1 = $(syntax [|do
    ((x1,x2), (y1,y2)) <- getInput
    returnC ((x1,y1), (x2,y2))
  |])

rearrange2 :: FreeCategory
rearrange2 = ?









rearrange3 :: Either (Either a1 a2) (Either b1 b2)
           -> Either (Either a1 b1) (Either a2 b2)
             -- ((x1, x2), (y1,y2)))
rearrange3 = associate
             -- (x1, (x2, (y1,y2)))
         >>> second coassociate
             -- (x1, ((x2,y1), y2))
         >>> second (first swap)
             -- (x1, ((y1,x2), y2))
         >>> coassociate
             -- ((x1, (y1,x2)), y2)
         >>> first coassociate
             -- (((x1,y1), x2), y2)
         >>> associate
             -- ((x1,y1), (x2,y2))
         >>> returnC  -- aka Category.id
             -- ((x1,y1), (x2,y2))
































































































main :: IO ()
main = putStrLn "typechecks."
