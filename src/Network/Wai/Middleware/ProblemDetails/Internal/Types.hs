module Network.Wai.Middleware.ProblemDetails.Internal.Types
(
    ProblemDetails
  , setType
  , setTitle
  , title
  , setDetail
  , setInstance
  , setExtensions
  , setStatus
  , status
)
where

import           Data.Aeson     (FromJSON, ToJSON, Value)
import           Data.Default
import           Data.Text      (Text)
import qualified Data.Text      as T
import           Deriving.Aeson
import           GHC.Generics   (Generic)
import           Network.URI    (URI)

data ProblemDetails = ProblemDetails
  { pdType       :: !(Maybe Text)       -- 'about:blank' when not present.
                                        -- This URI, when specified, should resolve to an HTML resource.
  , pdTitle      :: !(Maybe Text)
  , pdStatus     :: !(Maybe Int)
  , pdDetail     :: !(Maybe Text)
  , pdInstance   :: !(Maybe Text)       -- Identifies a specific occurrence of the problem.
  , pdExtensions :: !(Maybe Value)
  }
  deriving stock (Show, Generic)
  deriving (ToJSON)
  via CustomJSON '[OmitNothingFields, FieldLabelModifier '[StripPrefix "pd", CamelToSnake]] ProblemDetails

instance Default ProblemDetails where
  def = ProblemDetails Nothing Nothing Nothing Nothing Nothing Nothing

-- | 'status' return the status for this 'ProblemDetails'
status :: ProblemDetails -> Maybe Int
status = pdStatus

-- | 'setType' sets the type field of the problem details object.
setType :: URI -> ProblemDetails -> ProblemDetails
setType uri pd = pd {pdType = Just $ T.pack $ show uri}

setStatus :: Int -> ProblemDetails -> ProblemDetails
setStatus status pd = pd {pdStatus = Just status}

-- | 'title' return the title for this 'ProblemDetails'
title :: ProblemDetails -> Maybe Text
title = pdTitle

-- | 'setTitle' sets the title field of the problem details object.
setTitle :: Text -> ProblemDetails -> ProblemDetails
setTitle title pd = pd {pdTitle = Just title}

-- | 'setDetail' sets the detail field of the problem details object.
setDetail :: Text -> ProblemDetails -> ProblemDetails
setDetail detail pd = pd {pdDetail = Just detail}

-- | 'setInstance' sets the instance field of the problem details object.
setInstance :: URI -> ProblemDetails -> ProblemDetails
setInstance inst pd = pd {pdInstance = Just $ T.pack $ show inst}

-- | 'setExtensions' adds the provided extensions to the problem details object.
setExtensions :: Value -> ProblemDetails -> ProblemDetails
setExtensions exts pd = pd {pdExtensions = Just exts}
