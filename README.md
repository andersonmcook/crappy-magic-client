# crappy-magic-client

[Server Repo](https://github.com/calebgregory/crappy-magic)

Requirements
* [Node 6.0 or greater](https://nodejs.org/)
* [npm](https://www.npmjs.com/)
* [Elm](http://elm-lang.org/)

[Elm Syntax Highlighting](https://guide.elm-lang.org/get_started.html#configure-your-editor)

Install Elm

`npm i -g elm`

Install core packages

`elm package install`

Install live recompiling

`npm i -g elm-live@2.6.1`

Run live compiling, open in browser, output to index.js, debug messages
(Main.elm is placeholder name at the moment)

`elm-live Main.elm --open --output=index.js --debug`


API
GET /item/:number
  returns json formatted
```{
  title <String>,
  owner_name <String>,
  owner_email <String>,
  video_creator_name <String>,
  video_creator_web_address <String>,
  video_creator_email <String>,
  video_creator_instagram_handle <String>,
  price <Float>,
  description <String>,
  materials <String>,
  manufacture_info <String>,
  mature_content <Boolean>
}```

GET /videos/12345
```
<video autoplay controls>
  <source src="http://localhost:4002/videos/12345" type="video/mp4" />
</video>```
