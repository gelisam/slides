# Slides

Here are the slides for my presentation. As you might have noticed if you saw it live, my slide format is a bit unusual: each slide is a text file, usually with some code in it. This is because I use [git-slides](https://github.com/gelisam/git-slides#readme), a tool I wrote which makes it easy for me to create presentations with lots of code demonstrations in them. Unfortunately, this format makes it harder for you to browse the slides, because it's not a standard format like a pdf file.

The way the format works is that each slide corresponds to a git commit, so if you look at `src/Slide.hs`, you will see the last slide. If you have a git tool which makes it easy to go backwards and forwards in the history, you can use that to look at all the slides. If not, you can try [git-slides](https://github.com/gelisam/git-slides#readme); it's a command-line tool, so you would type `git-slides prev` to go the the previous slide and `git-slides next` to go to the next slide. It also has some vim bindings which call those when you press backspace and space, respectively, and it should be trivial to implement similar bindings for other editors.

Alternatively, here are the slides in text format.

## Slide 0

```haskell
-------------------------------------------------------------------------------
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                         The trick which made                              --
--                      exceptions-0.10.0 possible                           --
--                                                                           --
--                          by Samuel Gélineau                               --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
-------------------------------------------------------------------------------
```

## Slide 1

```haskell
module Main where  {- slide 1 of 7 -}
import Control.Exception.Lifted

-- |
-- >>> runReaderT test1 "foo"
-- "foo"
test1 :: ReaderT String IO ()
test1 = pure () `finally` do { r <- ask; lift (print r) }

-- |
-- >>> execStateT test2 ""
-- ""
-- "foo"
test2 :: StateT String IO ()
test2 = put "foo" `finally` do { s <- get; lift (print s); put "bar" }

-- |
-- >>> runExceptT test3
-- Right ()
test3 :: ExceptT String IO ()
test3 = pure () `finally` throwError "oops"
```

## Slide 2

```haskell
module Main where  {- slide 2 of 7 -}
import UnliftIO.Exception

-- |
-- >>> runReaderT test1 "foo"
-- "foo"
test1 :: ReaderT String IO ()
test1 = pure () `finally` do { r <- ask; lift (print r) }

-- |
-- >>> execStateT test2 ""
-- error: no instance for (MonadUnliftIO StateT s IO)
--
test2 :: StateT String IO ()
test2 = put "foo" `finally` do { s <- get; lift (print s); put "bar" }

-- |
-- >>> runExceptT test3
-- error: no instance for (MonadUnliftIO ExceptT e IO)
test3 :: ExceptT String IO ()
test3 = pure () `finally` throwError "oops"
```

## Slide 3

```haskell
module Main where  {- slide 3 of 7 -}
import Control.Monad.Catch  {- exceptions-0.10.0 -}

-- |
-- >>> runReaderT test1 "foo"
-- "foo"
test1 :: ReaderT String IO ()
test1 = pure () `finally` do { r <- ask; lift (print r) }

-- |
-- >>> execStateT test2 ""
-- "foo"
-- "bar"
test2 :: StateT String IO ()
test2 = put "foo" `finally` do { s <- get; lift (print s); put "bar" }

-- |
-- >>> runExceptT test3
-- Left "oops"
test3 :: ExceptT String IO ()
test3 = pure () `finally` throwError "oops"
```

## Slide 4

```haskell
module Main where  {- slide 4 of 7 -}


finally :: IO a -> IO b -> IO a

class Hard m where
  liftAnything :: (IO a -> IO b -> IO a)
               -> (m  a -> m  b -> m  a)

class Easy m where
  liftedFinally :: m a -> m b -> m a
```

## Slide 5

```haskell
module Main where  {- slide 5 of 7 -}


finally :: IO a -> IO b -> IO a

class Hard m where
  liftAnything :: (IO a -> IO b -> IO a)
               -> (m  a -> m  b -> m  a)

class Easy m where
  liftedFinally :: m a -> m b -> m a


finally' :: IO a
         -> (Maybe a -> IO b)
         -> IO b

class Easier m where
  liftedFinally' :: m a
                 -> (Maybe a -> m b)
                 -> m b
```

## Slide 6

```haskell
module Main where  {- slide 6 of 7 -}


finally :: IO (a, StateM) -> IO (b, StateM) -> IO (a, StateM)

class Hard m where
  liftAnything :: (IO a -> IO b -> IO a)
               -> (m  a -> m  b -> m  a)

class Easy m where
  liftedFinally :: m a -> m b -> m a


finally' :: IO a
         -> (Maybe a -> IO b)
         -> IO b

class Easier m where
  liftedFinally' :: m a
                 -> (Maybe a -> m b)
                 -> m b
```

## Slide 7

```haskell
module Main where  {- slide 7 of 7 -}


finally :: IO (a, StateM) -> IO (b, StateM) -> IO (a, StateM)

class Hard m where
  liftAnything :: (IO a -> IO b -> IO a)
               -> (m  a -> m  b -> m  a)

class Easy m where
  liftedFinally :: m a -> m b -> m a


finally' :: IO (a, StateM)
         -> (Maybe (a, StateM) -> IO (b, StateM))
         -> IO (b, StateM)

class Easier m where
  liftedFinally' :: m a
                 -> (Maybe a -> m b)
                 -> m b
```

## Slide 8

```haskell
-------------------------------------------------------------------------------
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                              Thank you!                                   --
--                                                                           --
--                    Go forth and implement libraries!                      --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
--                                                                           --
-------------------------------------------------------------------------------
```
