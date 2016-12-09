module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import String.Extra exposing (humanize)
import Material.Grid as Grid
import Material.List as Lists
import Material.Options as Options
import Material.Scheme


type Msg
    = ListItemClick String


type alias Model =
    { items : List String
    , selectedItems : List String
    }


model : Model
model =
    { items = [ "filter_1", "filter_2", "filter_3", "filter_4", "filter_5" ]
    , selectedItems = []
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ListItemClick item ->
            { model | selectedItems = List.append model.selectedItems [ item ] }


displayItem : String -> Html Msg
displayItem item =
    Lists.li
        []
        [ Lists.content
            [ Options.attribute <| Html.Events.onClick (ListItemClick item) ]
            [ Lists.avatarIcon item []
            , text (humanize item)
            ]
        ]


view : Model -> Html Msg
view model =
    Grid.grid []
        [ Grid.cell
            [ Grid.size Grid.All 2 ]
            [ Lists.ul [] (List.map displayItem model.items) ]
        , Grid.cell
            [ Grid.size Grid.All 2 ]
            [ Lists.ul [] (List.map displayItem model.selectedItems) ]
        ]
        |> Material.Scheme.top


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
