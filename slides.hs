minimax algorithm (review)

--              +---+
--              |...|           
--              |X..|           
--            / |...| \          
--           /  +---+  \         
--          /     |     \        
--         v      v      v       
--    +---+     +---+     +---+ 
--    |===|     |===|     |===| 
--    |X==|     |X==|     |X==| 
--    |O..|     |.O.|     |..O| 
--    +---+     +---+     +---+ 
--      |         |         |   
--      v         v         v   
--    +---+     +---+     +---+ 
--    |...|     |...|     |...| 
--    |XX.|     |XX.|     |XX.|   
-- | /|O..|   / |.O.|   / |..O|  |
-- |/ +---+  /  +---+  /  +---+  |
-- |    |   /     |   /     |   /|
--      v  v      v  v      v  v
--    +---+     +---+     +---+ 
--    |===|     |===|     |===| 
--    |XX=|     |XX=|     |XX=| 
--    |OO.|     |.OO|     |O.O| 
--    +---+     +---+     +---+ 
--   Player to play (maximizer)  
--      |   \     |   \     |   \   
--      v    v    v    v    v    v  
--    +---++---++---++---++---++---+
--    |   ||   ||..X||   ||.X.||   |
--    |+80||-99||XX.||-99||XX.||-99|
--    |   ||   ||.OO||   ||O.O||   |
--    +---++---++---++---++---++---+
--     Opponent to play (minimizer)
--      |   \     |   \     |   \
--      v    v    v    v    v    v
--    +---++---++---++---++---++---+
--    |   ||   ||   ||   ||   ||   |
--    |+80||+99||+80||+99||+80||+99|
--    |   ||   ||   ||   ||   ||   |
--    +---++---++---++---++---++---+
--      |         |         |   
--      v         v         v   
--    +---+     +---+     +---+ 
--    |   |     |   |     |   | 
--    |+99|     |+99|     |+99| 
--    |   |     |   |     |   | 
--    +---+     +---+     +---+ 
































































































