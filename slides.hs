-- Haskell array access syntax

arr :: Array Int
         (Array Int
           (Array Int
             (Array Int
               (Array Int
                 (Array Int
                   (Array Int
                     (Array Int
                       (Array Int
                         (Array Int
                           (Array Int Double))))))))))

state = arr ! c1 ! c2 ! c3
            ! c4 ! c5 ! c6
            ! c7 ! c8 ! c9
            ! player ! rows
































































































