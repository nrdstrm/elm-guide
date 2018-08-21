module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Time exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)


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
    { time : Time
    , active : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( Model 0 True, Cmd.none )



-- UPDATE


type Msg
    = Tick Time
    | Active Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            ( { model | time = time }, Cmd.none )

        Active active ->
            ( { model | active = active }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.active then
        Time.every second Tick
    else
        Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ Html.Attributes.type_ "checkbox", checked model.active, onClick (Active (not model.active)) ] []
        , clock model
        ]


clock : Model -> Html Msg
clock model =
    let
        angle =
            turns (Time.inMinutes model.time)

        handX =
            toString (50 + 40 * cos angle)

        handY =
            toString (50 + 40 * sin angle)
    in
        svg [ viewBox "0 0 100 100", Svg.Attributes.width "300px" ]
            [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
            , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
            ]
