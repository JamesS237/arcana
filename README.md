# Arcana
Arcana is a web app designed to make school more fun by adding a competitive element. It is designed to fit courses that include both exams and other assessments, and where students are grouped by class or houses. 

Arcana makes use of Redis and PostgreSQL in production and is currently hosted on Heroku. 

## Setup

1. Install Ruby
2. Install Rails
3. ```brew install redis``` 
4. ```brew install elasticsearch``` 
5. ```git clone https://github.com/Arvoreniad/arcana```
6. ```cd arcana && make install``` 
7. ```rake db:schema:load``` (App uses SQLite in development)
8. ```rails s``` & ```redis-server``` & ```elasticsearch```


## License

The MIT License (MIT)

Copyright (c) 2014 Alexander Nielsen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
