module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Random


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { dieFaceA : Int
    , dieFaceB : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 1 1, Cmd.none )



-- UPDATE


type Msg
    = Roll
    | NewFaceA Int
    | NewFaceB Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Cmd.batch
                [ Random.generate NewFaceA (Random.int 1 6)
                , Random.generate NewFaceB (Random.int 1 6)
                ]
            )

        NewFaceA value ->
            ( { model | dieFaceA = value }, Cmd.none )

        NewFaceB value ->
            ( { model | dieFaceB = value }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (toString model.dieFaceA) ]
        , h1 [] [ text (toString model.dieFaceB) ]
        , button [ onClick Roll ] [ text "Roll" ]
        ]
