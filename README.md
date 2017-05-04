# Calculator-API
RESTful API using Yesod

## Build:
In a terminal, cd to the project directory and:
stack build

## Run:
In a terminal, cd to the project directory and:
stack exec calculator-api

##Examples:
Can be run inside any web-browser.

localhost:3000/add/3/4
{"result":7}

localhost:3000/sub/10/5
{"result":5}

localhost:3000/mul/2/3
{"result":6}

localhost:3000/div/14/7
{"result":2}

localhost:3000
{"result":"None"}

localhost:3000/login/a/c
{"result":"Forbidden"}

localhost:3000/history
{"result":"null"}

localhost:3000/login/a/b
{"result":"OK"}

localhost:3000
{"result":"a"}

localhost:3000/logout
{"result":"OK"}

localhost:3000/history
{"result":["mul 10 3","add 4 6","sub 2 2"]}

