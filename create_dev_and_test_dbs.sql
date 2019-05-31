CREATE ROLE guaraapi WITH LOGIN PASSWORD 'guaraapi'  CREATEDB;

CREATE DATABASE guaraapi_development;
CREATE DATABASE guaraapi_test;

GRANT ALL PRIVILEGES ON DATABASE "guaraapi_development" to guaraapi;
GRANT ALL PRIVILEGES ON DATABASE "guaraapi_test" to guaraapi;
