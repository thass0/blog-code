-- | Parse binary expressions by recursive descent.
--
-- <expr> ::= <term> { ("+" | "-") <term> }
-- <term> ::= <factor> { ("*" | "/") <factor> }
-- <factor> ::= "(" <expr> ")" | <num>
--
-- λ :l Expr
-- [1 of 2] Compiling Main             ( Expr.hs, interpreted )
-- Ok, one module loaded.
-- λ parseTest (pExpr <* eof) "7 + 42 * 9"
-- Add (Num 7) (Mul (Num 42) (Num 9))
-- λ parseTest (pExpr <* eof) "2 * 3 / 4 * 5"
-- Mul (Div (Mul (Num 2) (Num 3)) (Num 4)) (Num 5)
-- λ parseTest (pExpr <* eof) "8 * (10 - 6)"
-- Mul (Num 8) (Sub (Num 10) (Num 6))

import Data.Void
import Control.Applicative hiding (many)
import Text.Megaparsec
import Text.Megaparsec.Char
import Text.Megaparsec.Char.Lexer as L

import Data.Functor (($>))

data Expr
  = Add Expr Expr  -- +
  | Sub Expr Expr  -- -
  | Mul Expr Expr  -- *
  | Div Expr Expr  -- /
  | Num Int
  deriving (Show, Eq)

type Parser = Parsec Void String

spaceConsumer :: Parser ()
spaceConsumer = L.space space1 empty empty

pSymbol :: String -> Parser String
pSymbol = L.symbol spaceConsumer

pLexeme :: Parser a -> Parser a
pLexeme = L.lexeme spaceConsumer

inParens :: Parser a -> Parser a
inParens = between (pSymbol "(") (pSymbol ")")

pNum :: Parser Expr
pNum = Num <$> pLexeme L.decimal

pFactor :: Parser Expr
pFactor = inParens pExpr <|> pNum

binExprL :: Parser Expr
         -> Parser (Expr -> Expr -> Expr)
         -> Parser Expr
binExprL pSide pOperator = do
  lhs <- pSide
  rhs <- many $ flip <$> pOperator <*> pSide
  pure $ foldl (\expr f -> f expr) lhs rhs

-- pTerm :: Parser Expr
-- pTerm = do
--   lhs <- pFactor
--   rhs <- many $ flip <$> pOperator <*> pFactor
--   pure $ foldl (\expr f -> f expr) lhs rhs
--   where
--     pOperator = (pSymbol "*" $> Mul) <|> (pSymbol "/" $> Div)

pTerm :: Parser Expr
pTerm = binExprL pFactor ((pSymbol "*" $> Mul) <|> (pSymbol "/" $> Div))

-- pExpr :: Parser Expr
-- pExpr = do
--   lhs <- pTerm
--   rhs <- many $ flip <$> pOperator <*> pTerm
--   pure $ foldl (\expr f -> f expr) lhs rhs
--   where
--     pOperator = (pSymbol "+" $> Add) <|> (pSymbol "-" $> Sub)

pExpr :: Parser Expr
pExpr = binExprL pTerm ((pSymbol "+" $> Add) <|> (pSymbol "-" $> Sub))
