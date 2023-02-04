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

problemDetails404 :: ProblemDetails
problemDetails404 = def
  & setStatus 404
  & setTitle "Not Found"
  & setType (fromJust $ parseURI "https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/404")

problemDetails400 :: ProblemDetails
problemDetails400 = def
  & setStatus 400
  & setTitle "Bad Request"
  & setType (fromJust $ parseURI "https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/400")

problemDetails401 :: ProblemDetails
problemDetails401 = def
  & setStatus 401
  & setTitle "Unauthorized"
  & setType (fromJust $ parseURI "https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/401")

problemDetails403 :: ProblemDetails
problemDetails403 = def
  & setStatus 403
  & setTitle "Forbidden"
  & setType (fromJust $ parseURI "https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/403")

problemDetails409 :: ProblemDetails
problemDetails409 = def
  & setStatus 409
  & setTitle "Conflict"
  & setType (fromJust $ parseURI "https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/409")
