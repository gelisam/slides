module Main where
import Data.IORef                                                                                                                                                                                                        ; import Data.Sequence ((|>)); import qualified Data.Sequence as Seq; import Data.Foldable as Seq (toList)

-- ROF-based implementation


-- sendMessage  :: ChannelROF -> Message -> IO ()
-- loadMessages :: ChannelROF -> IO [Message]
data ChannelROF = ChannelROF
  { sendMessage  :: Message -> IO ()
  , loadMessages :: IO [Message]
  }

localMessageROF :: IO ChannelROF
localMessageROF = do
  ref <- newIORef Seq.empty
  pure $ ChannelROF
    { sendMessage  = \msg -> modifyIORef ref (|> msg)
    , loadMessages = Seq.toList <$> readIORef ref
    }



















































































































data Message = Message


main :: IO ()
main = putStrLn "typechecks."
