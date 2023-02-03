module Network.Wai.Middleware.ProblemDetails
(
    module Network.Wai.Middleware.ProblemDetails.Internal.Types
  , module Network.Wai.Middleware.ProblemDetails.Internal.Exception
  , module Network.Wai.Middleware.ProblemDetails.Internal.Defaults
  , problemDetails
)
where

import           Network.Wai.Middleware.ProblemDetails.Internal.Defaults
import           Network.Wai.Middleware.ProblemDetails.Internal.Exception
import           Network.Wai.Middleware.ProblemDetails.Internal.Types

import           Control.Exception                                        (catch)
import           Data.Aeson                                               (encode)
import           Data.ByteString
import           Data.Maybe                                               (fromMaybe)
import           Data.Text.Encoding                                       (encodeUtf8)
import           Network.HTTP.Types                                       (mkStatus,
                                                                           ok200)
import           Network.Wai                                              (Middleware,
                                                                           Response,
                                                                           responseLBS)


problemDetails :: Middleware
problemDetails app = \request respond -> app request respond `catch` (respond . catchProblemDetails)
  where
    catchProblemDetails :: ProblemDetailsException -> Response
    catchProblemDetails (ProblemDetailsException pd) = responseLBS
      (uncurry mkStatus $ getStatus pd)
      [("Content-Type", "application/problem+json")]
      (encode pd)

    getStatus :: ProblemDetails -> (Int, ByteString)
    getStatus pd = case (status pd, title pd) of
      (Just status', Just title') -> (status', encodeUtf8 title')
      _                           -> (200, "Ok")

