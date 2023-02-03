{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Main (main) where

import           Data.Default
import           Data.Function                         ((&))
import           Network.HTTP.Types
import           Network.Wai
import           Network.Wai.Middleware.ProblemDetails
import           Test.Hspec
import           Test.Hspec.Wai
import           Test.Hspec.Wai.JSON

testApp :: IO Application
testApp = pure $ problemDetails $ \request respond ->
   case (pathInfo request, requestMethod request) of
    ([], "GET")         -> respond $ responseLBS ok200 [] ""
    (["simple"], "GET") -> throwProblemDetails def
    (["custom"], "GET") -> throwProblemDetails (problemDetails404 & setTitle "Could not find user with that id.")

spec :: Spec
spec = with testApp $ do
  describe "GET /" $
    it "Responds with 200" $
      get "/" `shouldRespondWith` 200

  describe "GET /simple" $
    it "Responds with 200 and the correct Content-Type" $
      get "/simple" `shouldRespondWith` 200 {matchHeaders = ["Content-Type" <:> "application/problem+json"]}

  describe "GET /custom" $
    it "Responds with 404 and the correct JSON body" $
      get "/custom" `shouldRespondWith`
        [json|{"type":"https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/404","title":"Could not find user with that id.","status":404}|]
        { matchStatus = 404
        , matchHeaders = ["Content-Type" <:> "application/problem+json"]
        }

main :: IO ()
main = hspec spec
