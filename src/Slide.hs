--------------------------------------------------------------------------------
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                            * Mixing                                        --
--                            * Multiple Styles                               --
--                            * in the Same Haskell Program                   --
--                              * terminal rendering API                      --
--                              * messaging API                               --
--                            > * chatbot API                                 --
--                              * UI                                          --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--------------------------------------------------------------------------------





































{-# LANGUAGE DeriveFunctor, FlexibleContexts, FlexibleInstances, FunctionalDependencies, GADTs, GeneralizedNewtypeDeriving, InstanceSigs, LambdaCase, MultiParamTypeClasses, NumericUnderscores, RecordWildCards, RecursiveDo, ScopedTypeVariables, TupleSections, TypeApplications, TypeFamilies, UndecidableInstances #-}
module Main where

import Control.Concurrent
import Control.Concurrent.Async
import Control.Exception
import Control.Lens
import Control.Monad
import Control.Monad.Free
import Control.Monad.Fix
import Control.Monad.Trans.Class (MonadTrans)
import Control.Monad.Trans.State
import Data.Foldable
import Data.IORef
import Data.Map.Strict (Map)
import Data.Maybe
import Data.Void
import Graphics.Vty as Vty
import Reactive.Banana as Frp
import Reactive.Banana.Frameworks as Frp
import System.Timeout
import qualified Control.Monad.Trans.Class as MonadTrans
import qualified Data.Map.Strict as Map
import qualified Data.Map.Merge.Strict as Map


newtype User = User
  { unUser :: String }
  deriving (Eq, Ord, Show)

human :: User
human = User "human"


data Message = Message
  { author   :: User
  , contents :: String
  }
  deriving (Eq, Show)


data MessageROF = MessageROF
  { sendMessage  :: Message -> IO ()
  , loadMessages :: IO [Message]
  }

-- +---------------------------+
-- | Record Of Functions (ROF) |
-- +---------------------------+
-- advantage: first-class value, can be returned by an IO action
-- advantage: closure is not part of the API, so different implementations can use a different state.
-- compare with a Handle containing an IORef, or a MessageT (ReaderT IORef).
localMessageROF :: IO MessageROF
localMessageROF = do
  ref :: IORef [Message]
      <- newIORef []
  pure $ MessageROF
    { sendMessage = \message
                 -> modifyIORef ref (++ [message])

    , loadMessages = readIORef ref
    }


newtype Channel = Channel
  { unChannel :: String }
  deriving (Eq, Ord, Show)

generalChannel :: Channel
generalChannel = Channel "general"

data MultiChannelMessageROF = MultiChannelMessageROF
  { pickChannel  :: Channel -> MessageROF
  , listChannels :: IO (Map Channel Int)  -- number of messages in each channel
  }

-- advantage: first-class value, can be returned by a pure function
-- disadvantage: can't reuse 'localMessageROF' because we need a different state, and the state is hidden in the closure, unaccessible
localMultiChannelMessageROF :: IO MultiChannelMessageROF
localMultiChannelMessageROF = do
  ref :: IORef (Map Channel [Message])
      <- newIORef (Map.singleton generalChannel [])
  pure $ MultiChannelMessageROF
    { pickChannel = \channel -> MessageROF
        { sendMessage = \message
                     -> modifyIORef ref
                      $ over (at channel . non [])
                             (++ [message])

        , loadMessages = view (at channel . non [])
                     <$> readIORef ref
        }
    , listChannels = over each length
                 <$> readIORef ref
    }


getMessage :: MessageROF
           -> StateT [Message] IO Message
getMessage messageROF@(MessageROF {..}) = do
  lastMessages <- get
  newMessages <- drop (length lastMessages)
             <$> liftIO loadMessages
  case newMessages of
    [] -> do
      liftIO $ threadDelay 1_000_000
      getMessage messageROF
    message : _ -> do
      modify (++ [message])
      pure message

-- +--------------------+
-- | Monad Transformers |
-- +--------------------+
-- advantage: can reuse 'getMessage' because we have access to the state
getChannelMessage :: MultiChannelMessageROF
                  -> Channel
                  -> StateT (Map Channel [Message]) IO Message
getChannelMessage multiChannelMessageROF channel = do
  zoom (at channel . non []) $ do
    getMessage (pickChannel multiChannelMessageROF channel)


type Chatbot = MessageROF -> StateT [Message] IO ()

runChatbot :: MessageROF -> Chatbot -> IO ()
runChatbot messageROF chatbot = evalStateT (chatbot messageROF) []

respondingBot :: String -> (String -> Maybe String) -> Chatbot
respondingBot botName f messageROF = forever $ do
  Message {..} <- getMessage messageROF
  unless (author == self) $ do
    for_ (f contents) $ \response -> do
      liftIO $ sendMessage messageROF $ Message self response
  where
    self :: User
    self = User botName

echobot :: Chatbot
echobot = respondingBot "echobot" Just

channelbot :: MultiChannelMessageROF -> Chatbot
channelbot multiChannelMessageROF messageROF = forever $ do
  Message _ contents <- getMessage messageROF
  case words contents of
    ["/channel", name] -> do
      let channel :: Channel
          channel = Channel name

          welcome :: String
          welcome = "Welcome to channel " ++ show name ++ "!"

          confirmation :: String
          confirmation = "Created channel " ++ show name ++ "."

      liftIO $ sendMessage (pickChannel multiChannelMessageROF channel)
                           (Message self welcome)
      liftIO $ sendMessage messageROF
                           (Message self confirmation)
    _ -> pure ()
  where
    self = User "channelbot"


-- +--------------------+
-- | Combinator Library |
-- +--------------------+
imageForAuthor :: User -> Image
imageForAuthor (User name) = string (defAttr `withStyle` bold) name
                     Vty.<|> string defAttr ": "

imageForMessage :: Message -> Image
imageForMessage (Message {..}) = imageForAuthor author
                         Vty.<|> string defAttr contents

imageForMessages :: [Message] -> Image
imageForMessages = vertCat . fmap imageForMessage

imageForChannel :: Channel -> Int -> Bool -> Image
imageForChannel (Channel name) unreadCount current = string attr name
                                             Vty.<|> numberImage
                                             Vty.<|> string defAttr "  "
  where
    attr | current   = defAttr `withStyle` reverseVideo
         | otherwise = defAttr

    numberImage | unreadCount == 0 = emptyImage
                | otherwise        = emptyImage

imageForChannels :: Channel -> Map Channel Int -> Image
imageForChannels currentChannel = vertCat . fmap (uncurry go) . Map.toList
  where
    go :: Channel -> Int -> Image
    go channel unreadCount = imageForChannel channel
                                             unreadCount
                                             (channel == currentChannel)

pictureForChat :: [Message] -> String -> Picture
pictureForChat messages buffer = (picForImage image) { picCursor = cursor }
  where
    messagesImage :: Image
    messagesImage = imageForMessages messages

    bufferImage :: Image
    bufferImage = imageForMessage (Message human buffer)

    image :: Image
    image = messagesImage
        <-> bufferImage

    cursor :: Cursor
    cursor = Cursor (imageWidth bufferImage) (imageHeight messagesImage)

translateCursorX :: Int -> Cursor -> Cursor
translateCursorX dx = \case
  NoCursor           -> NoCursor
  Cursor         x y -> Cursor         (x + dx) y
  AbsoluteCursor x y -> AbsoluteCursor (x + dx) y

-- a variant of 'Vty.<|>' whose second argument is a 'Picture'
imageThenPicture :: Image -> Picture -> Picture
imageThenPicture image (Picture {..}) = addToTop picture' image
  where
    dx :: Int
    dx = imageWidth image

    picture' :: Picture
    picture' = Picture
      { picCursor = translateCursorX dx picCursor
      , picLayers = fmap (translateX dx) picLayers
      , picBackground = picBackground
      }

runVty :: s                         -- ^ initial state
       -> (s -> IO Picture)         -- ^ onDraw
       -> (s -> Vty.Event -> IO s)  -- ^ onEvent
       -> IO ()
runVty s0 onDraw onEvent = do
  bracket (mkVty =<< standardIOConfig) shutdown $ \vty -> do
    flip fix s0 $ \loop s -> do
      --displayRegion <- displayBounds . outputIface $ vty
      picture <- onDraw s
      update vty picture
      timeout 1_000_000 (nextEvent vty) >>= \case
        Just (EvKey KEsc _) -> do
          pure ()
        Just event -> do
          s' <- onEvent s event
          loop s'
        Nothing -> do
          loop s


appendOne :: a -> [a] -> [a]
appendOne a = (++ [a])

dropLastChar :: String -> String
dropLastChar buffer = take (length buffer - 1) buffer

chat :: MessageROF -> IO ()
chat messageROF = runVty "" onDraw onEvent
  where
    onDraw :: String -> IO Picture
    onDraw buffer = do
      messages <- loadMessages messageROF
      pure $ pictureForChat messages buffer

    onEvent :: String -> Vty.Event -> IO String
    onEvent buffer = \case
      EvKey (KChar c) _ -> do
        pure $ appendOne c buffer
      EvKey KBS _ -> do  -- backspace
        pure $ dropLastChar buffer
      EvKey KEnter _ -> do
        sendMessage messageROF (Message human buffer)
        pure []
      _ -> do
        pure buffer


type Stream a = Frp.Event a

newStream :: MomentIO (Stream a, Frp.Handler a)
newStream = newEvent

mapMaybeS :: (a -> Maybe b) -> Stream a -> Stream b
mapMaybeS f = filterJust . fmap f

accumS :: a -> Stream (a -> a) -> MomentIO (Stream a)
accumS = accumE

compileFrpNetwork :: MomentIO a -> IO (EventNetwork, a)
compileFrpNetwork body = do
  ref <- newIORef undefined
  frpNetwork <- compile $ do
    a <- body
    liftIO $ writeIORef ref a
  a <- readIORef ref
  pure (frpNetwork, a)

runVtyFrp :: Int                 -- fps
          -> ( Stream ()         -- next frame
            -> Stream Vty.Event  -- vty event (e.g. keypress)
            -> MomentIO (Behavior Picture)
             )
          -> IO ()
runVtyFrp fps mkFrpNetwork = do
  (frpNetwork, (triggerNextFrame, triggerVtyEvent, pictureRef)) <- compileFrpNetwork $ do
    (nextFrameS, triggerNextFrame) <- newEvent
    (vtyEventS , triggerVtyEvent ) <- newEvent

    pictureB <- mkFrpNetwork nextFrameS vtyEventS

    picture :: Picture
            <- valueB pictureB
    pictureRef <- liftIO $ newIORef picture
    pictureChangesS <- changes pictureB
    reactimate' $ (fmap . fmap) (writeIORef pictureRef)
                                pictureChangesS

    pure (triggerNextFrame, triggerVtyEvent, pictureRef)

  bracket (mkVty =<< standardIOConfig) shutdown $ \vty -> do
    fix $ \loop -> do
      --displayRegion <- displayBounds . outputIface $ vty
      picture <- readIORef pictureRef
      update vty picture
      timeout (1_000_000 `div` fps) (nextEvent vty) >>= \case
        Just (EvKey KEsc _) -> do
          pure ()
        Just vtyEvent -> do
          triggerVtyEvent vtyEvent
          actuate frpNetwork
          loop
        Nothing -> do
          triggerNextFrame ()
          actuate frpNetwork
          loop

-- +---------------------------------------+
-- | Functional Reactive Programming (FRP) |
-- +---------------------------------------+
-- advantage: state is private to each 'Behavior' and is crystal clear about its mutators
-- disadvantage: fixed graph, can't duplicate part of a graph for each instance of a dynamic list
frpChat :: MessageROF
        -> Stream ()         -- next frame
        -> Stream Vty.Event  -- vty event (e.g. keypress)
        -> MomentIO (Behavior Picture)
frpChat messageROF nextFrameS vtyEventS = mdo
  messagesLoadedB :: Stream [Message]
                  <- mapEventIO (\() -> loadMessages messageROF)
                                nextFrameS
  messagesB :: Behavior [Message]
            <- accumB [] $ unions
             $ [ const     <$> messagesLoadedB
               , appendOne <$> messageSentS
               ]

  let charS :: Stream Char
      charS = flip mapMaybeS vtyEventS $ \case
        EvKey (KChar c) _ -> Just c
        _                 -> Nothing

      backspaceS :: Stream ()
      backspaceS = flip mapMaybeS vtyEventS $ \case
        EvKey KBS _ -> Just ()
        _           -> Nothing

      enterS :: Stream ()
      enterS = flip mapMaybeS vtyEventS $ \case
        EvKey KEnter _ -> Just ()
        _              -> Nothing

  bufferB :: Behavior String
          <- accumB ""
           $ unions [ appendOne    <$> charS
                    , dropLastChar <$  backspaceS
                    , const ""     <$  enterS
                    ]

  let messageSentS :: Stream Message
      messageSentS = Message human <$> bufferB <@ enterS
  reactimate $ sendMessage messageROF <$> messageSentS

  let pictureB :: Behavior Picture
      pictureB = pictureForChat <$> messagesB <*> bufferB
  pure pictureB


data RwsAction r w s a where
  Ask  ::      (r  -> a) -> RwsAction r w s a
  Tell :: w -> (() -> a) -> RwsAction r w s a
  Get  ::      (s  -> a) -> RwsAction r w s a
  Put  :: s -> (() -> a) -> RwsAction r w s a
  deriving Functor

type Rws r w s a = Free (RwsAction r w s) a

rwsAsk :: Rws r w s r
rwsAsk = liftF $ Ask id

rwsTell :: w -> Rws r w s ()
rwsTell w = liftF $ Tell w id

rwsGet :: Rws r w s s
rwsGet = liftF $ Get id

rwsPut :: s -> Rws r w s ()
rwsPut s = liftF $ Put s id

rwsModify :: (s -> s) -> Rws r w s ()
rwsModify f = do
  s <- rwsGet
  rwsPut (f s)

runRws :: forall r w s a. Monoid w
       => Rws r w s a
       -> r -> s -> (w, s, a)
runRws body r s0 = go mempty s0 body
  where
    go :: w -> s -> Rws r w s a -> (w, s, a)
    go w s = \case
      Pure a            -> (w, s, a)
      Free (Ask     cc) -> go w         s  (cc r)
      Free (Tell w' cc) -> go (w <> w') s  (cc ())
      Free (Get     cc) -> go w         s  (cc s)
      Free (Put  s' cc) -> go w         s' (cc ())

runRwsUntilAsk :: forall r w s. Monoid w
               => Rws r w s Void
               -> s -> (w, s, r -> Rws r w s Void)
runRwsUntilAsk body s0 = go mempty s0 body
  where
    go :: w -> s -> Rws r w s Void -> (w, s, r -> Rws r w s Void)
    go w s = \case
      Pure bottom       -> absurd bottom
      Free (Ask     cc) -> (w, s, cc)
      Free (Tell w' cc) -> go (w <> w') s  (cc ())
      Free (Get     cc) -> go w         s  (cc s)
      Free (Put  s' cc) -> go w         s' (cc ())

rwsRepl :: Rws Key [Message] String Void
rwsRepl = forever $ do
  rwsAsk >>= \case
    KChar c -> do
      rwsModify (appendOne c)
    KBS -> do  -- backspace
      rwsModify dropLastChar
    KEnter -> do
      contents <- rwsGet
      rwsTell [Message human contents]
      rwsPut ""
    _ -> do
      pure ()

type Repl = Rws Key [Message] String Void
type ReplSnapshot = ([Message], String, Key -> Repl)


class ( MonadFix m
      , Functor (MtlStream m)
      , Functor (MtlBehavior m), Applicative (MtlBehavior m)
      ) => MonadFrp m where
  data MtlStream   m :: * -> *
  data MtlBehavior m :: * -> *
  mtlAccumS     :: a -> MtlStream m (a -> a) -> m (MtlStream m a)
  mtlStepper    :: a -> MtlStream m a -> m (MtlBehavior m a)
  mtlMapMaybeS  :: (a -> Maybe b) -> MtlStream m a -> MtlStream m b
  mtlNever      :: MtlStream m a
  mtlUnionWith  :: (a -> a -> a) -> MtlStream m a -> MtlStream m a -> MtlStream m a
  mtlApply      :: MtlBehavior m (a -> b) -> MtlStream m a -> MtlStream m b
  mtlMapIO      :: (a -> IO b) -> MtlStream m a -> m (MtlStream m b)
  mtlReactimate :: MtlStream m (IO ()) -> m ()

mtlAccumB :: forall m a. MonadFrp m
          => a -> MtlStream m (a -> a) -> m (MtlBehavior m a)
mtlAccumB a0 aChangeS = do
  aS :: MtlStream m a
     <- mtlAccumS a0 aChangeS
  mtlStepper a0 aS

mtlFilterS :: forall m a. MonadFrp m
           => (a -> Bool) -> MtlStream m a -> MtlStream m a
mtlFilterS p = mtlMapMaybeS $ \a -> if p a then Just a else Nothing

instance (MonadFrp m, Semigroup a) => Semigroup (MtlStream m a) where
  (<>) = mtlUnionWith (<>)

instance (MonadFrp m, Semigroup a) => Monoid (MtlStream m a) where
  mempty = mtlNever

mtlUnions :: MonadFrp m
          => [MtlStream m (a -> a)] -> MtlStream m (a -> a)
mtlUnions = foldr (mtlUnionWith (.)) mtlNever

infixl 4 <@@>
(<@@>) :: MonadFrp m
       => MtlBehavior m (a -> b) -> MtlStream m a -> MtlStream m b
(<@@>) = mtlApply

infixl 4 <@@
(<@@) :: MonadFrp m
      => MtlBehavior m a -> MtlStream m b -> MtlStream m a
behavior <@@ stream= const <$> behavior <@@> stream


instance MonadFrp MomentIO where
  newtype MtlStream   MomentIO a = BaseStream   { unBaseStream   :: Stream   a }
  newtype MtlBehavior MomentIO a = BaseBehavior { unBaseBehavior :: Behavior a }
  mtlAccumS a (BaseStream fS) = BaseStream <$> accumS a fS
  mtlStepper a (BaseStream aS) = BaseBehavior <$> stepper a aS
  mtlMapMaybeS f (BaseStream aS) = BaseStream $ mapMaybeS f aS
  mtlNever = BaseStream never
  mtlUnionWith f (BaseStream s1) (BaseStream s2) = BaseStream $ unionWith f s1 s2
  mtlApply (BaseBehavior fB) (BaseStream aS) = BaseStream $ apply fB aS
  mtlMapIO f (BaseStream aS) = BaseStream <$> mapEventIO f aS
  mtlReactimate (BaseStream aS) = reactimate aS

instance Functor (MtlStream MomentIO) where
  fmap f (BaseStream aS) = BaseStream (fmap f aS)

instance Functor (MtlBehavior MomentIO) where
  fmap f (BaseBehavior aB) = BaseBehavior (fmap f aB)

instance Applicative (MtlBehavior MomentIO) where
  pure = BaseBehavior . pure
  BaseBehavior fB <*> BaseBehavior aB = BaseBehavior (fB <*> aB)


newtype KeyedFrpT k m a = KeyedFrpT
  { runKeyedFrpT :: m a }
  deriving (Functor, Applicative, Monad, MonadFix, MonadIO)

instance MonadTrans (KeyedFrpT k) where
  lift = KeyedFrpT

instance (Ord k, MonadFrp m) => MonadFrp (KeyedFrpT k m) where
  newtype MtlStream   (KeyedFrpT k m) a = KeyedStream   { unKeyedStream   :: MtlStream m (Map k a) }
  newtype MtlBehavior (KeyedFrpT k m) a = KeyedBehavior { unKeyedBehavior :: MtlBehavior m (k -> a) }

  mtlAccumS :: forall a
             . a
            -> MtlStream (KeyedFrpT k m) (a -> a)
            -> KeyedFrpT k m (MtlStream (KeyedFrpT k m) a)
  mtlAccumS a0 aChangeS = KeyedFrpT $ do
    let kaChangeS :: MtlStream m (Map k (a -> a))
        kaChangeS = unKeyedStream aChangeS

        mapChangeS :: MtlStream m (Map k a -> Map k a)
        mapChangeS = mapApply <$> kaChangeS

    mapS :: MtlStream m (Map k a)
         <- mtlAccumS Map.empty mapChangeS
    pure $ KeyedStream mapS
    where
      mapApply :: Map k (a -> a) -> Map k a -> Map k a
      mapApply = Map.merge (Map.mapMissing $ \_ f -> f a0)
                           Map.preserveMissing
                           (Map.zipWithMatched $ \_ f a -> f a)

  mtlStepper :: forall a
              . a
             -> MtlStream (KeyedFrpT k m) a
             -> KeyedFrpT k m (MtlBehavior (KeyedFrpT k m) a)
  mtlStepper a0 aS = KeyedFrpT $ do
    let mapS :: MtlStream m (Map k a)
        mapS = unKeyedStream aS

    mapB :: MtlBehavior m (Map k a)
         <- mtlStepper Map.empty mapS

    let output :: MtlBehavior m (k -> a)
        output = (\ka k -> fromMaybe a0 $ Map.lookup k ka) <$> mapB
    pure $ KeyedBehavior output

  mtlMapMaybeS :: (a -> Maybe b)
               -> MtlStream (KeyedFrpT k m) a
               -> MtlStream (KeyedFrpT k m) b
  mtlMapMaybeS f = KeyedStream
                 . mtlFilterS (not . Map.null)
                 . fmap (Map.mapMaybe f)
                 . unKeyedStream

  mtlNever :: MtlStream (KeyedFrpT k m) a
  mtlNever = KeyedStream mtlNever

  mtlUnionWith :: (a -> a -> a)
               -> MtlStream (KeyedFrpT k m) a
               -> MtlStream (KeyedFrpT k m) a
               -> MtlStream (KeyedFrpT k m) a
  mtlUnionWith f (KeyedStream s1) (KeyedStream s2)
    = KeyedStream $ mtlUnionWith (Map.unionWith f) s1 s2

  mtlApply :: forall a b
            . MtlBehavior (KeyedFrpT k m) (a -> b)
           -> MtlStream (KeyedFrpT k m) a
           -> MtlStream (KeyedFrpT k m) b
  mtlApply fB aS = KeyedStream kbS
    where
      kfB :: MtlBehavior m (k -> a -> b)
      kfB = unKeyedBehavior fB

      kaS :: MtlStream m (Map k a)
      kaS = unKeyedStream aS

      kbS :: MtlStream m (Map k b)
      kbS = Map.mapWithKey <$> kfB <@@> kaS

  mtlMapIO :: forall a b
            . (a -> IO b)
            -> MtlStream (KeyedFrpT k m) a
            -> KeyedFrpT k m (MtlStream (KeyedFrpT k m) b)
  mtlMapIO f aS = KeyedFrpT $ do
    let kaS :: MtlStream m (Map k a)
        kaS = unKeyedStream aS

    kbS :: MtlStream m (Map k b)
        <- mtlMapIO (traverse f) kaS
    pure $ KeyedStream kbS

  mtlReactimate :: MtlStream (KeyedFrpT k m) (IO ())
                -> KeyedFrpT k m ()
  mtlReactimate ioS = KeyedFrpT $ do
    let kioS :: MtlStream m (Map k (IO ()))
        kioS = unKeyedStream ioS
    mtlReactimate $ fmap sequence_ kioS

instance Functor (MtlStream m)
      => Functor (MtlStream (KeyedFrpT k m)) where
  fmap f (KeyedStream aS) = KeyedStream (fmap (fmap f) aS)

instance Functor (MtlBehavior m)
      => Functor (MtlBehavior (KeyedFrpT k m)) where
  fmap f (KeyedBehavior aB) = KeyedBehavior (fmap (fmap f) aB)

instance Applicative (MtlBehavior m)
      => Applicative (MtlBehavior (KeyedFrpT k m)) where
  pure = KeyedBehavior . pure . pure
  KeyedBehavior fB <*> KeyedBehavior aB = KeyedBehavior ((<*>) <$> fB <*> aB)

toKeyedStream :: MonadFrp m
              => MtlStream m (k, a) -> MtlStream (KeyedFrpT k m) a
toKeyedStream = KeyedStream . fmap (uncurry Map.singleton)

toKeyedBehavior :: MonadFrp m
                => MtlBehavior m a -> MtlBehavior (KeyedFrpT k m) a
toKeyedBehavior = KeyedBehavior . fmap const


-- +---------------------------------+
-- | Monad Transformer Library (MTL) |
-- +---------------------------------+
-- advantages: polymorphism, effect-tracking
mtlChat :: forall m. MonadFrp m
        => MtlBehavior m MessageROF
        -> MtlStream m ()         -- next frame
        -> MtlStream m Vty.Event  -- vty event (e.g. keypress)
        -> m (MtlBehavior m Picture)
mtlChat rofB nextFrameS vtyEventS = mdo
  let keyS :: MtlStream m Key
      keyS = flip mtlMapMaybeS vtyEventS $ \case
        EvKey key _ -> Just key
        _           -> Nothing

  let replSnapshot0 :: ReplSnapshot
      replSnapshot0 = runRwsUntilAsk rwsRepl ""

      updateRepl :: Key -> ReplSnapshot -> ReplSnapshot
      updateRepl r (_, s, cc) = runRwsUntilAsk (cc r) s

  replSnapshotS :: MtlStream m ReplSnapshot
                <- mtlAccumS replSnapshot0 (updateRepl <$> keyS)

  let messagesSentS :: MtlStream m [Message]
      messagesSentS = mtlFilterS (not . null)
                    . fmap (\(w, _, _) -> w)
                    $ replSnapshotS
  mtlReactimate $ mapM_ . sendMessage <$> rofB <@@> messagesSentS

  bufferB :: MtlBehavior m String
          <- mtlStepper ""
           . fmap (\(_, s, _) -> s)
           $ replSnapshotS

  messagesLoadedB :: MtlStream m [Message]
                  <- mtlMapIO loadMessages
                              (rofB <@@ nextFrameS)
  messagesB :: MtlBehavior m [Message]
            <- mtlAccumB [] $ mtlUnions
             $ [ const     <$> messagesLoadedB
               , flip (++) <$> messagesSentS
               ]

  let pictureB :: MtlBehavior m Picture
      pictureB = pictureForChat <$> messagesB <*> bufferB
  pure pictureB

multiChannelChat :: forall m. MonadFrp m
                 => MtlBehavior m MultiChannelMessageROF
                 -> MtlStream m ()         -- next frame
                 -> MtlStream m Vty.Event  -- vty event (e.g. keypress)
                 -> m (MtlBehavior m Picture)
multiChannelChat rofB nextFrameS vtyEventS = do
  listChannelsS :: MtlStream m (Map Channel Int)
                <- mtlMapIO listChannels
                            (rofB <@@ nextFrameS)
  channelsB :: MtlBehavior m (Map Channel Int)
            <- mtlStepper (Map.singleton generalChannel 0) listChannelsS

  let previousChannelS :: MtlStream m ()
      previousChannelS = flip mtlMapMaybeS vtyEventS $ \case
        EvKey KUp _ -> Just ()
        _           -> Nothing

      nextChannelS :: MtlStream m ()
      nextChannelS = flip mtlMapMaybeS vtyEventS $ \case
        EvKey KDown _ -> Just ()
        _             -> Nothing

      previousKey :: Ord k => Map k a -> k -> k
      previousKey ka k = maybe k fst $ Map.lookupLT k ka

      nextKey :: Ord k => Map k a -> k -> k
      nextKey ka k = maybe k fst $ Map.lookupGT k ka

  currentChannelB :: MtlBehavior m Channel
                  <- mtlAccumB generalChannel $ mtlUnions
                   $ [ previousKey <$> channelsB <@@ previousChannelS
                     , nextKey     <$> channelsB <@@ nextChannelS
                     ]

  allChannelsPictureB :: MtlBehavior (KeyedFrpT Channel m) Picture
                      <- runKeyedFrpT $ do
    mtlChat (KeyedBehavior $ pickChannel <$> rofB)
            (toKeyedStream $ (,) <$> currentChannelB <@@> nextFrameS)
            (toKeyedStream $ (,) <$> currentChannelB <@@> vtyEventS)

  let sidebarImageB :: MtlBehavior m Image
      sidebarImageB = imageForChannels <$> currentChannelB <*> channelsB

      currentChannelPictureB :: MtlBehavior m Picture
      currentChannelPictureB = unKeyedBehavior allChannelsPictureB <*> currentChannelB

      pictureB :: MtlBehavior m Picture
      pictureB = imageThenPicture <$> sidebarImageB <*> currentChannelPictureB
  pure pictureB



main :: IO ()
main = do
  multiChannelMessageROF <- localMultiChannelMessageROF
  withAsync (runChatbot (pickChannel multiChannelMessageROF generalChannel)
                        echobot) $ \_ -> do
    withAsync (runChatbot (pickChannel multiChannelMessageROF generalChannel)
                          (channelbot multiChannelMessageROF)) $ \_ -> do
      runVtyFrp 1 $ \nextFrameS vtyEventS -> do
        unBaseBehavior <$> multiChannelChat (pure multiChannelMessageROF)
                                            (BaseStream nextFrameS)
                                            (BaseStream vtyEventS)
