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


https://www.yesodweb.com/

The following license covers this documentation, and the source code, except
where otherwise indicated.

Copyright 2012-2015, Michael Snoyman. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
