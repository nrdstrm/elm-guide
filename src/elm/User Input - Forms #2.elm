module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Char exposing (isDigit, isLower, isUpper)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type Validation
    = None
    | Ok
    | Error String


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    , valid : Validation
    }


model : Model
model =
    { age = ""
    , name = ""
    , password = ""
    , passwordAgain = ""
    , valid = None
    }



-- UPDATE


type Msg
    = Name String
    | Age String
    | Password String
    | PasswordAgain String
    | Validate


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Age age ->
            { model | age = age }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

        Validate ->
            { model | valid = validate model }


validate : Model -> Validation
validate model =
    if model.password /= model.passwordAgain then
        Error "Passwords do not match"
    else if String.length model.password < 8 then
        Error "Password to short"
    else if not (String.any isDigit model.password) then
        Error "Password must contain digits"
    else if not (String.any isUpper model.password) then
        Error "Password must contain uppercase"
    else if not (String.any isLower model.password) then
        Error "Password must contain lowercase"
    else if String.length model.age == 0 then
        Error "Enter age"
    else if not (String.all isDigit model.age) then
        Error "Age must be a number"
    else
        Ok



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "text", placeholder "Age", onInput Age ] []
        , input [ type_ "password", placeholder "Password", onInput Password ] []
        , input [ type_ "password", placeholder "Repeat password", onInput PasswordAgain ] []
        , button [ onClick Validate ] [ text "Submit" ]
        , viewValidation model
        ]


viewValidation : Model -> Html Msg
viewValidation model =
    let
        ( color, message ) =
            case model.valid of
                Ok ->
                    ( "green", "Ok" )

                Error error ->
                    ( "red", error )

                None ->
                    ( "black", "Enter details" )
    in
        div [ style [ ( "color", color ) ] ] [ text message ]
