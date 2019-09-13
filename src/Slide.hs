respondToHttpPost :: (MonadAssets m, MonadDatabase m) => m ()
respondToHttpPost = do
  update
  render

update :: MonadDatabase m => m ()
update = do
  writeDb "updated value"

render :: (MonadAssets m, MonadDatabase m) => m ()
render = do
  getAsset "myImage.jpg"
  writeDb "oops" -- Ok


topLevel :: AssetsT (DatabaseT IO) ()
topLevel = do
  respondToHttpPost

main :: IO ()
main = do
  r <- runDatabaseT . runAssetsT $ topLevel
  print r



























































































class Monad m => MonadAssets m where
  getAsset :: String -> m ()

class Monad m => MonadDatabase m where
  writeDb :: String -> m ()


data AssetsT m a = AssetsT { runAssetsT :: m a }

data DatabaseT m a = DatabaseT { runDatabaseT :: m a }


instance Monad m => MonadAssets (AssetsT m) where
  getAsset _ = pure ()

instance Monad m => MonadDatabase (DatabaseT m) where
  writeDb _ = pure ()


instance Functor m => Functor (AssetsT m) where
  fmap f = AssetsT . fmap f . runAssetsT

instance Applicative m => Applicative (AssetsT m) where
  pure = AssetsT . pure
  AssetsT mf <*> AssetsT mx = AssetsT (mf <*> mx)

instance Monad m => Monad (AssetsT m) where
  ax >>= f = AssetsT $ do
    x <- runAssetsT ax
    runAssetsT (f x)

instance MonadDatabase m => MonadDatabase (AssetsT m) where
  writeDb = AssetsT . writeDb


instance Functor m => Functor (DatabaseT m) where
  fmap f = DatabaseT . fmap f . runDatabaseT

instance Applicative m => Applicative (DatabaseT m) where
  pure = DatabaseT . pure
  DatabaseT mf <*> DatabaseT mx = DatabaseT (mf <*> mx)

instance Monad m => Monad (DatabaseT m) where
  ax >>= f = DatabaseT $ do
    x <- runDatabaseT ax
    runDatabaseT (f x)

instance MonadAssets m => MonadAssets (DatabaseT m) where
  getAsset = DatabaseT . getAsset
