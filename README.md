# Arcana
Arcana is a web app designed to make school more fun by adding a competitive element. It is designed to fit courses that include both exams and other assessments, and where students are grouped by class or houses. 

Arcana makes use of Redis and PostgreSQL in production and is currently hosted on Heroku. 

## Setup

1. Install Ruby
2. Install Rails
3. ```brew install redis``` (If Redis is not installed)
3. ```git clone https://github.com/Arvoreniad/arcana```
4. ```cd arcana && bundle install``` (Bundle Installation may require ```sudo```)
5. ```rake db:schema:load``` (App uses SQLite in development)
6. ```rails s``` & ```redis-server```
  
