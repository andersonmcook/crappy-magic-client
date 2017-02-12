module Main exposing ( .. )
import Html exposing ( .. )
import Html.Attributes exposing ( .. )
import Html.Events exposing ( onClick, onInput )
import Random
import Http
import Json.Decode as Decode exposing ( Decoder, field, succeed )
import Json.Decode.Pipeline as DP exposing ( decode, required, optional, hardcoded )
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
    , owner_name : String
    , owner_email : String
    , video_creator_name : String
    , video_creator_web_address : String
    , video_creator_email : String
    , video_creator_instagram_handle : String
    , price : Float
    , description : String
    , materials : String
    , manufacture_info : String
    , mature_content : Bool
    }


initialItem : Item
initialItem =
  { title = "yo"
  , owner_name = "yo"
  , owner_email = "yo"
  , video_creator_name = "yo"
  , video_creator_web_address = "yo"
  , video_creator_email = "yo"
  , video_creator_instagram_handle = "yo"
  , price = 666.66
  , description = "yo"
  , materials = "yo"
  , manufacture_info = "yo"
  , mature_content = False
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


-- COMMANDS


getItemFromApi : String -> Cmd Msg
getItemFromApi item =
    ( Decode.succeed itemDecoder ) -- broken
        |> Http.get ( "http://localhost:3000/item/" ++ item )
        |> Http.send GetItem
--getEntries =
--    (Decode.list entryDecoder)
--        |> Http.get entriesUrl
--        |> Http.send NewEntries






-- DECODER


itemDecoder : Decoder Item
itemDecoder =
    DP.decode Item
        |> DP.required "title" Decode.string
        |> DP.required "owner_name" Decode.string
        |> DP.required "owner_email" Decode.string
        |> DP.required "video_creator_name" Decode.string
        |> DP.required "video_creator_web_address" Decode.string
        |> DP.required "video_creator_email" Decode.string
        |> DP.required "video_creator_instagram_handle" Decode.string
        |> DP.required "price" Decode.float
        |> DP.required "description" Decode.string
        |> DP.required "materials" Decode.string
        |> DP.required "manufacture_info" Decode.string
        |> DP.required "mature_content" Decode.bool





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
