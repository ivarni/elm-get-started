import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String
import Regex
import String

main =
    Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }

--Model

type alias Model =
    { name : String
    , age : String
    , password : String
    , passwordAgain : String
    , submitted : Bool
    }

model : Model
model =
    Model "" "" "" "" False

--Update

type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Submit

update : Msg -> Model -> Model
update action model =
  case action of
    Name name ->
      { model | name = name }

    Age age ->
      { model | age = age }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Submit ->
      { model | submitted = True }

--View

view : Model -> Html Msg
view model =
    div []
        [ input [type' "text", placeholder "Name", onInput Name] []
        , input [type' "number", placeholder "Age", onInput Age] []
        , input [type' "password", placeholder "Password", onInput Password] []
        , input [type' "password", placeholder "Re-enter password", onInput PasswordAgain] []
        , div [] [
          input [type' "submit", onClick Submit] []
        ]
        , viewValidation model
        ]

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if not (model.submitted) then
        ("green", "OK")
      else if String.length model.password < 8 then
        ("red", "Password must be at least 8 chars")
      else if not (Regex.contains (Regex.regex "\\d") model.password) then
        ("red", "Password must contain a digit")
      else if model.password == model.passwordAgain then
        ("green", "OK")
      else
        ("red", "Passwords do not match!")
  in
    div [style [("color", color)]] [ text message ]
