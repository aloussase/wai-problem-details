# wai-problem-details

Middleware for returning problem details responses as specified in
https://www.rfc-editor.org/rfc/rfc7807.

```haskell
{-# LANGUAGE OverloadedStrings #-}

import qualified Web.Scotty as S
import Network.Wai.Handler.Warp (run)
import Data.Function ((&))
import Data.Default
import Network.Wai.Middleware.ProblemDetails

app :: IO Application
app = S.scottyApp $ do
  S.get "/default"           $ throwProblemDetails def
  S.get "/predefined"        $ throwProblemDetails problemDetails400
  S.get "/predefined-custom" $ throwProblemDetails (problemDetails404 & setTitle "Ahooy!")

main :: IO ()
main = run 8080 =<< app
```

## License

MIT
