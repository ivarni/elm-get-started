import Html exposing (Html, h1, div, button, text)
import Html.App as Html
import Html.Events exposing (onClick)
import Random exposing(generate, int)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

--Model

type alias Model =
    { dieFace: Int
    }

--Update

type Msg
    = Roll
    | NewFace Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Roll ->
            (model, Random.generate NewFace (Random.int 1 6))

        NewFace newFace ->
            (Model newFace, Cmd.none)

--Subscriptions
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


--View

view : Model -> Html Msg
view model =
    div []
    [ h1 [] [ text (toString model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]


--Init

init : (Model, Cmd Msg)
init =
    (Model 1, Cmd.none)
