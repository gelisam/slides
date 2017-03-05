{-# LANGUAGE RankNTypes #-}                                                                                            {-# LANGUAGE RecordWildCards #-}
import Control.Monad.Trans.State

type Setter' s a = (a -> a) -> (s -> s)

(+=) :: Num a => Setter' s a -> a -> State s ()
setter += dx = modify $ setter (+ dx)


data Game   = Game   { _player :: Player }
data Player = Player { _pos    :: Vec2D  }
data Vec2D  = Vec2D  { _x, _y  :: Int    }

movePlayer :: (Int, Int) -> State Game ()
movePlayer (dx, dy) = do
  player.pos.x += dx
  player.pos.y += dy








































infix 4 +=


player :: Setter' Game   Player
pos    :: Setter' Player Vec2D
x      :: Setter' Vec2D  Int
y      :: Setter' Vec2D  Int
player f (Game   {..}) = Game   { _player = f _player, .. }
pos    f (Player {..}) = Player { _pos    = f _pos   , .. }
x      f (Vec2D  {..}) = Vec2D  { _x      = f _x     , .. }
y      f (Vec2D  {..}) = Vec2D  { _y      = f _y     , .. }



main :: IO ()
main = putStrLn "done."
