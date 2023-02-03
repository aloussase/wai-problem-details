module Network.Wai.Middleware.ProblemDetails.Internal.Exception
(
    ProblemDetailsException (..)
  , throwProblemDetails
  , throwProblemDetailsIO
)
where

import           Control.Exception                                    (Exception,
                                                                       throw,
                                                                       throwIO)

import           Network.Wai.Middleware.ProblemDetails.Internal.Types (ProblemDetails)

newtype ProblemDetailsException = ProblemDetailsException ProblemDetails
  deriving stock Show
  deriving anyclass Exception

-- | 'throwProblemDetails'
throwProblemDetails :: ProblemDetails -> a
throwProblemDetails = throw . ProblemDetailsException

-- | 'throwProblemDetailsIO'
throwProblemDetailsIO :: ProblemDetails -> IO a
throwProblemDetailsIO = throwIO . ProblemDetailsException
