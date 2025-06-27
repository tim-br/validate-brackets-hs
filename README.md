# validateBrackets - A Haskell MonadFail Exploration

This small Haskell project demonstrates how to validate a string of parentheses using monadic folding (`foldM`) in polymorphic monads (`Maybe` and `Either`). It showcases how to use custom `MonadFail` instances, pattern matching, and safe error handling in idiomatic Haskell.

## 🔧 Requirements

- [GHC](https://www.haskell.org/ghc/)
- [Stack](https://docs.haskellstack.org/en/stable/README/)

## 🚀 How to Run

```bash
stack run
```

You should see output like:

```
Running validateBrackets ...
Right "Success"
Just "Success"
Left "Unbalanced parens"
```