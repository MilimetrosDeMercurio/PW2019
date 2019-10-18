--***Todos el proceso inicial y dueno es user uca?
--***Se debe ejecutar la base original de ucasoft (modicifada con la herencia) o solo las bases de las empresas

--1. Crear un segundo tablespace denominado SAAS para albergar las bases de datos de cada empresa.
--a) Haga que este tablespace sea el que funcione por defecto para efectuar todas las instrucciones a partir de la presente
--b) Considere que e punto de montaje de almacenamiento SAN dedicado a tal fin está en /mnt/saas. 
create tablespace SAAS location '/mnt/saas';

--2. Cree usuarios en el SGBD para cada una de las empresas con permiso de creación de BD. 
--Clientes actuales: powerrepuestos, laatencao, simon y moonbucks
create user powerrepuestos with password 'ucasoft' createdb;
create user laatencao with password 'ucasoft' createdb;
create user simon with password 'ucasoft' createdb;
create user moonbucks with password 'ucasoft' createdb;

--3. Cada uno de los usuarios anteriores deberá crear una base de datos con su mismo nombre.
\c - powerrepuestos 
create database powerrepuestos;
\c - laatencao 
create database laatencao;
\c - simon 
create database simon;
\c - moonbucks 
create database moonbucks;

--5. Ejecute en cada bd y con cada usuario administrador los script de creacion de tablas e insercion de datos de la bd ucasoft
\c powerrepuestos powerrepuestos
\i estructura-ucasoft.sql
\i datos-ucasoft.sql
\c laatencao laatencao
\i estructura-ucasoft.sql
\i datos-ucasoft.sql
\c simon simon
\i estructura-ucasoft.sql
\i datos-ucasoft.sql
\c moonbucks  moonbucks
\i estructura-ucasoft.sql
\i datos-ucasoft.sql

--6. Conceda permiso de conexión y creación de cada BD al usuario uca
\c powerrepuestos powerrepuestos
grant create, connect on database powerrepuestos to uca;
\c laatencao laatencao
grant create, connect on database laatencao to uca;
\c simon simon
grant create, connect on database simon to uca;
\c moonbucks  moonbucks
grant create, connect on database moonbucks to uca;

--7. Conceda permiso de uso al esquema public de cada base de datos al usuario uca.
\c powerrepuestos powerrepuestos
grant usage on schema public to uca;
\c laatencao laatencao
grant usage on schema public to uca;
\c simon simon
grant usage on schema public to uca;
\c moonbucks  moonbucks
grant usage on schema public to uca;

--8. Conceda en cada BD todos los privilegios sobre todas las tablas al usuario uca. Con un solo comando grant
\c powerrepuestos powerrepuestos
grant all privileges on all tables in schema public to uca;
\c laatencao laatencao
grant all privileges on all tables in schema public to uca;
\c simon simon
grant all privileges on all tables in schema public to uca;
\c moonbucks moonbucks
grant all privileges on all tables in schema public to uca;

--9. Con el usuario uca cree un esquema denominado gestion en cada base de datos 
\c powerrepuestos uca
create schema gestion;
\c laatencao 
create schema gestion;
\c simon 
create schema gestion;
\c moonbucks 
create schema gestion;

--10. *Cree en dicho esquema un tipo de datos compuesto denominado tipo_sentencia de dos campos:
--un enumerado llamado clase con los valores select, insert, delete y update
--texto denominado cadena
--***FALTA EL RESTO DE LAS BASES DE DATOS
\c powerrepuestos uca
drop type gestion.valores;
create type gestion.valores as enum ('select','insert','delete','update');

drop type gestion.tipo_sentencia;
create type gestion.tipo_sentencia AS(
clase gestion.valores,
candena text
);

--11. *Ejecute en el esquema la sentencia de creación de una tabla para futura auditoría
--fechahora timestamp pk not null, sentencia tipo_sentencia, array de textos => informacion text[], 
--***FALTA EL RESTO DE LAS BASES DE DATOS
\c powerrepuestos uca
drop table if exists gestion.auditoria;
create table gestion.auditoria(
fechahora timestamp NOT NULL PRIMARY KEY,
sentencia gestion.tipo_sentencia,
informacion text[]
);

--12. **PORBAR**Particione la tabla de auditoría (anteriormente creada) por rango de fehas, cree una paticion para cada año 2019 y 2020; y default
--Siempre dentro del esquema? Sería alter o create?
\c powerrepuestos uca
create table gestion.auditoria(
fechahora timestamp NOT NULL PRIMARY KEY,
sentencia tipo_sentencia,
informacion text[]
) PARTITION BY RANGE(fechahora);

create table gestion.auditoria_2019 partition of gestion.auditoria for values from (timestamp '01/01/2019') to (timestamp '01/01/2020');
create table gestion.auditoria_2020 partition of gestion.auditoria for values from (timestamp '01/01/2020') to (timestamp '01/01/2021');
create table gestion.auditoria_default of gestion.auditoria default;

--13. Utilice la función generate_series para insertar valores en la tabla particionada. 
--***Se le deben colocar parametros?
insert into gestion.auditoria values(generate_series('2019-01-01 00:00'::timestamp,'2021-12-31 12:00','2920 hours'),null,null)
--*****POR QUE SALEN TABLAS DE OTRA BASE???