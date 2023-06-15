module Cells exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Cells.Data.Coord exposing (Coord)
import Cells.Data.Sheet as Sheet exposing (Sheet)
import Cells.View.Sheet as Sheet
import Html as H
import Set



-- MODEL


type alias Model =
    { sheet : Sheet
    , sheetModel : Sheet.Model
    }


init : Model
init =
    { sheet = Sheet.empty
    , sheetModel = Sheet.init
    }


handlers : Sheet.Handlers Msg
handlers =
    { onChange = ChangedSheet
    , onInput = Input
    }



-- UPDATE


type Msg
    = ChangedSheet Sheet.Msg
    | Input Coord String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangedSheet sheetMsg ->
            Sheet.update { handlers = handlers, sheet = model.sheet } sheetMsg model.sheetModel
                |> Tuple.mapFirst (\sheetModel -> { model | sheetModel = sheetModel })

        Input coord rawInput ->
            ( { model | sheet = Sheet.set coord rawInput model.sheet }
            , Cmd.none
            )



-- VIEW


view : Model -> H.Html Msg
view { sheet, sheetModel } =
    Sheet.view { handlers = handlers, sheet = sheet } sheetModel
