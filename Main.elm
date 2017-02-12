module Main exposing ( .. )
import Html exposing ( .. )
import Html.Attributes exposing ( .. )
import Html.Events exposing ( onClick, onInput )
import Random
import Http
import Json.Decode as Decode exposing ( Decoder, field, succeed )
import Json.Encode as Encode

--title <String>,
--owner_name <String>,
--owner_email <String>,
--video_creator_name <String>,
--video_creator_web_address <String>,
--video_creator_email <String>,
--video_creator_instagram_handle <String>,
--price <Float>,
--description <String>,
--materials <String>,
--manufacture_info <String>,
--mature_content <Boolean>
type alias Model =
    { item : Item
    , alertMessage : Maybe String
    }


initialModel : Model
initialModel =
    { item = initialItem
    , alertMessage = Nothing
    }


type alias Item =
    { title : String
    , ownerName : String
    , ownerEmail : String
    , videoCreatorName : String
    , videoCreatorWebAddress : String
    , videoCreatorEmail : String
    , videoCreatorInstagramHandle : String
    , price : Float
    , description : String
    , materials : String
    , manufactureInfo : String
    , matureContent : Bool
    }


initialItem : Item
initialItem =
  { title = "yo"
  , ownerName = "hey"
  , ownerEmail = "what"
  , videoCreatorName = "sup"
  , videoCreatorWebAddress = "sup"
  , videoCreatorEmail = "sup"
  , videoCreatorInstagramHandle = "sup"
  , price = 666.66
  , description = "sup"
  , materials = "sup"
  , manufactureInfo = "sup"
  , matureContent = False
  }

-- UPDATE

type Msg
    = GetItem ( Result Http.Error Item )
    --| Mark Int
    --| Sort
    --| NewRandom Int
    --| NewEntries ( Result Http.Error ( List Entry.Entry ) )
    --| CloseAlert
    --| ShareScore
    --| NewScore ( Result Http.Error Score.Score )
    --| SetNameInput String
    --| SaveName
    --| CancelName
    --| ChangeGameState GameState

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetItem ( Ok newItem ) ->
            ( { model | item = newItem }, Cmd.none )
        GetItem ( Err error ) ->
            ( { model | alertMessage = error |> httpErrorToMessage |> Just }, Cmd.none )
        --GetItem ( Ok newItem )
        --NewEntries ( Ok randomEntries ) ->
        --    ( { model | entries = List.sortBy .points randomEntries }, Cmd.none ) -- automatically sort by points
        --NewEntries ( Err error ) -> -- Http.error union type of different possibilities
        --    --( { model | alertMessage = Just ( httpErrorToMessage error ) }, Cmd.none )
        --    ( { model | alertMessage = error |> httpErrorToMessage |> Just }, Cmd.none )




httpErrorToMessage : Http.Error -> String
httpErrorToMessage error =
    case error of
        Http.NetworkError ->
            "Is the server running?"
        Http.BadStatus response ->
            ( toString response.status )
        Http.BadPayload message _ -> -- underscore because we aren't using the second argument
            "Decoding failed: " ++ message
        _ ->
            ( toString error )






-- VIEW


view : Model -> Html Msg
view item =
  h1 [] [ text "hey" ]
--view model =
--    div [ class "content" ]
--        [ viewHeader "Buzzword Bingo"
--        , viewPlayer model.name model.gameNumber
--        , alert CloseAlert model.alertMessage
--        , viewNameInput model
--        , Entry.viewEntryList Mark model.entries
--        , Score.viewScore (Entry.sumMarkedPoints model.entries)
--        , div [ class "button-group"]
--              [ button [ onClick NewGame ] [ text "New Game" ]
--              --,primaryButton NewGame "New Game"
--              --, button [ onClick Sort ] [ text "Sort by Point Value" ]
--              , primaryButton Sort "Sort by Point Value"
--              , button [ onClick ShareScore, disabled ( disableButton model ) ] [ text "Share Score" ]
--              ]
--        --, div [ class "debug" ] [ text (toString model) ]
--        , viewFooter
--        ]





-- INIT


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
      --, subscriptions = ( \_ -> Sub.none ) -- anonymous function _ is to ignore argument
        , subscriptions = ( always Sub.none ) -- same as above also same as lambda calculus TRUE, prefers a over b
        }
