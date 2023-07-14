module TemperatureConverter exposing (main)

import Browser
import Task.TemperatureConverter exposing (Model, Msg, init, update, view)


main : Program () Model Msg
main =
    Browser.element
        { init = always init
        , view = view
        , update = \msg model -> ( update msg model, Cmd.none )
        , subscriptions = always Sub.none
        }
