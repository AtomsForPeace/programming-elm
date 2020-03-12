module Picshare exposing (main)

import Html exposing (Html, div, h1, h2, text, img, i)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Browser

main : Program () { url : String, caption: String, liked: Bool } Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }

initialModel : { url : String, caption : String, liked : Bool }
initialModel =
    { url = baseUrl ++ "1.jpg", caption = "Surfing", liked = False }

view : { url : String, caption : String, liked : Bool } -> Html Msg
view model =
    div []
        [ div [ class "header" ]
            [ h1 [] [ text "Picshare" ] ]
        , div [ class "content-flow" ]
            [ viewDetailedPhoto model ]
        ]

update :
    Msg
    -> { url : String, caption : String, liked : Bool }
    -> { url : String, caption : String, liked : Bool }
update msg model =
    case msg of
        Like ->
            { model | liked = True }
        Unlike ->
            { model | liked = False }



baseUrl : String
baseUrl = "https:/programming-elm.com/"

type Msg
    = Like
    | Unlike

viewDetailedPhoto : { url : String,  caption : String, liked : Bool } -> Html Msg
viewDetailedPhoto model =
    let
        buttonClass =
            if model.liked then
                "fa-heart"
            else
                "fa-heart-o"
        msg =
            if model.liked then
                Unlike
            else
                Like
    in
    div [ class "detailed-photo" ]
        [ img [ src model.url ] []
        , div [ class "photo-info" ]
            [ div [ class "like-button" ]
                [ i
                    [ class "fa fa-2x"
                    , class buttonClass
                    , onClick msg
                    ]
                    []
                ]
            , h2 [ class "caption" ] [ text model.caption ]
            ]
        ]

