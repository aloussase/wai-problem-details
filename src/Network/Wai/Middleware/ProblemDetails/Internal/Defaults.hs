module Network.Wai.Middleware.ProblemDetails.Internal.Defaults
(
    problemDetails400
  , problemDetails404
)
where

import           Network.Wai.Middleware.ProblemDetails.Internal.Types

import           Data.Default
import           Data.Function                                        ((&))
import           Data.Maybe                                           (fromJust)
import           Network.URI                                          (parseURI)

-- | 'problemDetails404' returns an instance of 'ProblemDetails' representing a 404 Not Found problem.
problemDetails404 :: ProblemDetails
problemDetails404 = def
  & setStatus 404
  & setTitle "Not Found"
  & setType (fromJust $ parseURI "https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/404")

-- | 'problemDetails400'
problemDetails400 :: ProblemDetails
problemDetails400 = def
  & setStatus 400
  & setTitle "Bad Request"
  & setType (fromJust $ parseURI "https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/400")
