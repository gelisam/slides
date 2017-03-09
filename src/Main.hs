{-# LANGUAGE RankNTypes #-}                                                                                            {-# LANGUAGE RecordWildCards #-}
import Control.Monad.Trans.State







data Game   = Game   { _player :: Player }
data Player = Player { _pos    :: Vec2D  }
data Vec2D  = Vec2D  { _x, _y  :: Int    }

movePlayer :: (Int, Int) -> State Game ()
movePlayer (dx, dy) = do
  modify (\(Game (Player (Vec2D  x       y      ))) ->
            Game (Player (Vec2D (x + dx) y      )))
  modify (\(Game (Player (Vec2D  x       y      ))) ->
            Game (Player (Vec2D  x      (y + dy))))






































infix 4 +=
(+=) :: Num a => Setter' s a -> a -> State s ()
setter += dx = modify $ setter (+ dx)


type Setter' s a = (a -> a) -> (s -> s)

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
