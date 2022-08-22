{-# LANGUAGE OverloadedStrings, RankNTypes, ScopedTypeVariables #-}
{-# OPTIONS -Wno-name-shadowing #-}
module Ersatz.Simple
  ( Bit
  , Boolean(true, false, not, (&&), (||), choose)
  , MonadSAT
  , Result(..)

  , Expr(Func1, Func2), namedBit, (/=)
  , findAssignment
  ) where

import Prelude hiding (not, (||), (/=))
import qualified Prelude

import Control.Monad.Trans.State
import Doc (Doc, (<+>), above, orElse, putDocW)
import Data.Foldable (toList)
import Data.String (fromString)
import Ersatz (Bit, Boolean, MonadSAT, Result(..), SAT)
import qualified Ersatz


data Expr
  = Var String Bit
  | Bool Bool
  | Neq Expr Expr
  | Or Expr Expr
  | Func1 String (forall b. Boolean b => b -> b) Expr
  | Func2 String (forall b. Boolean b => b -> b -> b) Expr Expr

instance Boolean Expr where
  bool = Bool
  (&&) = Func2 "and" (Ersatz.&&)
  (||) = Or
  not = Func1 "not" Ersatz.not
  all p = foldr (Ersatz.&&) Ersatz.true . fmap p . toList
  any p = foldr (Ersatz.||) Ersatz.false . fmap p . toList
  xor = Func2 "xor" Ersatz.xor
  
namedBit :: MonadSAT s m => String -> m Expr
namedBit name = do
  bit <- Ersatz.exists
  pure $ Var name bit

(/=) :: Expr -> Expr -> Expr
(/=) = Neq


asBit :: Expr -> Bit
asBit (Var _ bit)
  = bit
asBit (Bool b)
  = Ersatz.bool b
asBit (Neq e1 e2)
  = asBit e1 Ersatz./== asBit e2
asBit (Or e1 e2)
  = asBit e1 Ersatz.|| asBit e2
asBit (Func1 _ f e)
  = f (asBit e)
asBit (Func2 _ f e1 e2)
  = f (asBit e1) (asBit e2)

asBool :: (Bit -> Bool) -> Expr -> Bool
asBool decodeBit = decodeBit . asBit

--asString :: Expr -> String
--asString = go False
--  where
--    -- the Bool indicates whether the string should be wrapped in parens if it
--    -- contains spaces
--    go :: Bool -> Expr -> String
--    go _ (Var name _)
--      = name
--    go _ (Bool b)
--      = show b
--    go parensNeeded (Neq e1 e2)
--      = addParensIfNeeded parensNeeded
--      $ go False e1 ++ "\n  /= " ++ go False e2
--    go parensNeeded (Or e1 e2)
--      = addParensIfNeeded parensNeeded
--      $ go True e1 ++ " || " ++ go True e2
--    go parensNeeded (Func1 name _ e)
--      = addParensIfNeeded parensNeeded
--      $ name ++ " " ++ go True e
--    go parensNeeded (Func2 name _ e1 e2)
--      = addParensIfNeeded parensNeeded
--      $ name ++ " " ++ go True e1 ++ " " ++ go True e2
--
--    addParensIfNeeded :: Bool -> String -> String
--    addParensIfNeeded True s
--      = "(" ++ s ++ ")"
--    addParensIfNeeded False s
--      = s

asDoc :: Expr -> Doc
asDoc = go False
  where
    -- the Bool indicates whether the string should be wrapped in parens if it
    -- contains spaces
    go :: Bool -> Expr -> Doc
    go _ (Var name _)
      = fromString name
    go _ (Bool b)
      = fromString (show b)
    go parensNeeded (Neq e1 e2)
      = opParensIfNeeded parensNeeded "/==" e1 e2
    go parensNeeded (Or e1 e2)
      = opParensIfNeeded parensNeeded "||" e1 e2
    go parensNeeded (Func1 name _ e)
      = addParensIfNeeded parensNeeded
          (fromString name <+> go True e)
    go parensNeeded (Func2 name _ e1 e2)
      = addParensIfNeeded parensNeeded
          (fromString name <+> go True e1 <+> go True e2)

    addParensIfNeeded :: Bool -> Doc -> Doc
    addParensIfNeeded True doc
      = "(" <> doc <> ")"
    addParensIfNeeded False doc
      = doc

    op :: String -> Doc -> Doc -> Doc
    op name doc1 doc2
            = (doc1 <+> fromString name <+> doc2)
     `orElse` ( ("  " <> doc1)
        `above` fromString name
        `above` ("  " <> doc2)
              )

    opParens :: String -> Doc -> Doc -> Doc
    opParens name doc1 doc2
            = ("(" <> doc1 <+> fromString name <+> doc2 <> ")")
     `orElse` ( (padding <> "( " <> doc1)
        `above` (padding <> fromString name <+> doc2)
        `above` (padding <> ")")
              )
      where
        padding :: Doc
        padding = fromString $ replicate (length name - 1) ' '
    
    opParensIfNeeded :: Bool -> String -> Expr -> Expr -> Doc
    opParensIfNeeded False name e1 e2
      = op name (go True e1) (go True e2)
    opParensIfNeeded True name e1 e2
      = opParens name (go True e1) (go True e2)

findInterestingSubExpr :: (Bit -> Bool) -> Expr -> Expr
findInterestingSubExpr decodeBit = go
  where
    go :: Expr -> Expr
    go expr@(Or e1 e2)
      | asBool decodeBit e1
        = go e1
      | asBool decodeBit e2
        = go e2
      | otherwise
        = expr
    go expr
      = expr

newtype VarFreeExpr = VarFreeExpr
  { unVarFreeExpr :: Expr }

substituteVars :: (Bit -> Bool) -> Expr -> VarFreeExpr
substituteVars decodeBit = VarFreeExpr . go
  where
    go :: Expr -> Expr
    go (Var _ bit)
      = Bool $ decodeBit bit
    go (Bool b)
      = Bool b
    go (Neq e1 e2)
      = Neq (go e1) (go e2)
    go (Or e1 e2)
      = Or (go e1) (go e2)
    go (Func1 name f e)
      = Func1 name f (go e)
    go (Func2 name f e1 e2)
      = Func2 name f (go e1) (go e2)

isFullyEvaluated :: VarFreeExpr -> Bool
isFullyEvaluated (VarFreeExpr (Bool _))
  = True
isFullyEvaluated _
  = False

evalOneStep :: VarFreeExpr -> VarFreeExpr
evalOneStep = VarFreeExpr . go . unVarFreeExpr
  where
    go :: Expr -> Expr
    go (Var _ _)
      = error "VarFreeExpr contains a Var"
    go (Bool b)
      = Bool b
    go (Neq (Bool b1) (Bool b2))
      = Bool (b1 Prelude./= b2)
    go (Neq e1 e2)
      = Neq (go e1) (go e2)
    go (Or (Bool b1) (Bool b2))
      = Bool (b1 Prelude.|| b2)
    go (Or e1 e2)
      = Or (go e1) (go e2)
    go (Func1 _ f (Bool b))
      = Bool (f b)
    go (Func1 name f e)
      = Func1 name f (go e)
    go (Func2 _ f (Bool b1) (Bool b2))
      = Bool (f b1 b2)
    go (Func2 name f e1 e2)
      = Func2 name f (go e1) (go e2)

renderExpr :: Expr -> IO ()
renderExpr expr = do
  putStrLn ""
  putStrLn ""
  Doc.putDocW 25 $ asDoc expr

evalStepByStep :: (Bit -> Bool) -> Expr -> IO ()
evalStepByStep decodeBit expr0 = do
  renderExpr expr0
  let expr1 = substituteVars decodeBit expr0
  renderExpr $ unVarFreeExpr expr1
  go expr1
  where
    go :: VarFreeExpr -> IO ()
    go expr
      | isFullyEvaluated expr = do
          pure ()
      | otherwise = do
          let expr' = evalOneStep expr
          renderExpr $ unVarFreeExpr expr'
          go expr'

findAssignment :: State SAT Expr -> IO ()
findAssignment satExpr = do
  let (expr, satProblem) = Ersatz.runSAT' $ do
        expr <- satExpr
        Ersatz.assert (asBit expr)
        pure expr
  (result, assignment) <- Ersatz.z3 satProblem
  case result of
    Satisfied -> do
      let satSolution = Ersatz.solutionFrom assignment satProblem
      let decodeBit :: Bit -> Bool
          decodeBit bit = case Ersatz.decode satSolution bit of
            Just b
              -> b
            Nothing
              -> error "decoding error"
      evalStepByStep decodeBit (findInterestingSubExpr decodeBit expr)
    Unsatisfied -> do
      putStrLn "no assignment exist"
    Unsolved -> do
      putStrLn "too hard for z3"
