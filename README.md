Guara API
=======================

[![build status](https://gitlab.com/fiuba-memo2/tp2/invernalia-api/badges/master/build.svg)](https://gitlab.com/fiuba-memo2/tp2/invernalia-api/commits/master)

## PostgreSQL setup

Follow these steps to initialize the PostgreSQL databases:

1. Install PostgreSQL if needed. On Ubuntu you can do this by running:
`sudo apt-get install -y postgresql-9.5 postgresql-contrib postgresql-server-dev-9.5`
1. Create development and test databases by running:
`sudo -u postgres psql --dbname=postgres -f ./create_dev_and_test_dbs.sql`

## Padrino application setup

1. Run **_bundle install --without staging production_**, to install all application dependencies
1. Run **_bundle exec rake_**, to run all tests and ensure everything is properly setup
1. Run **_RACK_ENV=development bundle exec rake db:migrate db:seed_**, to setup the development database
1. Run **_bundle exec padrino start -h 0.0.0.0_**, to start the application

## Some conventions to work on it:

* Follow existing coding conventions
* Use feature branch
* Add descriptive commits messages to every commit
* Write code and comments in English
* Use REST routes

## Enviroment variables setup:

* Give a value to HTTP_API_TOKEN if you wish to secure the API
* HTTP_RACK_ENV should be set according to which enviroment you are running the application, for example production or development

## How to deploy to heroku:
* Sign up in heroku: https://signup.heroku.com/
* Create a new application
* Add Heroku Postgres resource (Resources -> Find more add-ons -> Heroku Postgres -> Install Heroku Postgres)
* Go to settings -> reveal config vars, and add the same variables described in the previous step (you should also see DATABASE_URL if you installed Heroku Postgres correctly)
* Go to .gitlab-cy.yml, and if for example, you are deploying to a staging enviroment, configure the deploy_staging stage with your heroku app name and api-key (api-key should be set in gitlab enviroment variables but at the moment this gitlab's feature is bugged)
* Make sure you have a Procfile
* Merge the current branch to staging branch and it will deploy automatically to heroku 
* Repeat as many times as environments need (You may also need production enviroment)

## How to use the API:
* Basically the purpose of this system is for professors to upload subjects and qualify students. Students can see the academic offer, suscribe to a subject and check their status in each one of them (qualification and current status). Also they can check their suscriptions, average and total of approved subjects

Using Postman on localhost enviroment

Always use the header s
Content-Type application/json
API_TOKEN your-api-token (if configured previously)

* For a professor to upload a subject: 

Send a POST request to http://localhost:3000/materias with a body like this:
{ "codigo": "9231", "nombreMateria": "Organizacion de datos", "modalidad": "parciales", "docente": "Luis", "laboratorio": false, "cupo": 220, "proyector": true }

* Check current academic offer 

Send a GET request to http://localhost:3000/materias/all. In this example, we should see
{"oferta":[{"codigo":1009,"materia":"Algoritmos I","docente":"pepe"}]}

* For a student to check academic offer without the subjects he already approved:

Send a GET request to http://localhost:3000/materias with a PARAM like this:
usernameAlumno: juanperez

* For a student to check his inscriptions:

Send a GET request to http://localhost:3000/inscripciones with a PARAM like this:
usernameAlumno: juanperez


* To suscribe a student to a subject 
Send a POST request to http://localhost:3000/alumnos with a body like this:
{"nombre_completo":"Juan Perez","codigo_materia": "1009" ,"username_alumno": "juanperez"}

* To check the status and qualification of a student in a subject:

Send a GET request to http://localhost:3000/materias/estado with two PARAMS like these:
usernameAlumno: juanperez
codigoMateria: 1009

or GET http://localhost:3000/materias/estado?usernameAlumno=juanperez&codigoMateria=1009

* To qualify a student in a subject

Send a POST request to http://localhost:3000/calificar with a body like this:
{"username_alumno": "juanperez", "codigo_materia": "1009", "notas": "[10,8]"}

* For a student to check his average/quantity of approved subjects:

Send a GET request to http://localhost:3000/promedio with a PARAM like this:
usernameAlumno: juanperez

