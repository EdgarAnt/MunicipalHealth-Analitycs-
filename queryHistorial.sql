use AdminDB;

create table estado(
	id int primary key,
	nombre varchar(50),
);

insert into estado values(1, 'Jalisco');

create table municipios(
	id int primary key,
	nombre varchar(50),
	poblacion int,
	id_estado int,
	foreign key (id_estado) references estado(id) --La clave estado se referencia como ID estado tambien
);

--create table localidades(
--	id int primary key,
--	nombre varchar(100),
--	id_municipio int,
--	foreign key (id_municipio) references municipios(id)
--);

/*SELECT OBJECT_NAME(constraint_object_id) AS ConstraintName
FROM sys.foreign_key_columns
WHERE parent_object_id = OBJECT_ID('localidades');*/

create table servicios_salud(
	id_municipio int primary key,
	sin_afiliacion int,
	con_afiliacion int,
	imss int,
	otros int,
	foreign key (id_municipio) references municipios(id)
);

--create table viviendas(
--	id_localidad int primary key,
--	viviendas_habitadas int,
--	total_viviendas int,
--	foreign key (id_localidad) references localidades(id)
--);

alter table localidades
drop constraint id_municipio;
alter table servicios_salud
drop constraint id_localidad;
alter table viviendas
drop constraint id_localidad;

drop table municipios;
drop table localidades;
drop table servicios_salud;
drop table viviendas;

BULK INSERT municipios
FROM 'C:\Users\Laptop\Desktop\AdministracionBD\municipios.csv'
WITH
(
        FORMAT='CSV',
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',
		CODEPAGE = '65001'
)

--BULK INSERT localidades
--FROM 'C:\Users\asesi\Documents\6)Semestre_6\admindb\localidades.csv'
--WITH
--(
--        FORMAT='CSV',
--		FIRSTROW = 2,
--		FIELDTERMINATOR = ',',
--		ROWTERMINATOR = '\n',
--		CODEPAGE = '65001'
--)

BULK INSERT servicios_salud
FROM 'C:\Users\Laptop\Desktop\AdministracionBD\servicios_salud.csv'
WITH
(
        FORMAT='CSV',
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',
		CODEPAGE = '65001'
)

--BULK INSERT viviendas
--FROM 'C:\Users\asesi\Documents\6)Semestre_6\admindb\viviendas.csv'
--WITH
--(
--        FORMAT='CSV',
--		FIRSTROW = 2,
--		FIELDTERMINATOR = ',',
--		ROWTERMINATOR = '\n',
--		CODEPAGE = '65001'
--)

--select municipios.id, localidades.id, localidades.nombre, sin_afiliacion, con_afiliacion, viviendas_habitadas, total_viviendas from municipios
--inner join localidades
--on localidades.id_municipio = municipios.id
--inner join servicios_salud
--on localidades.id = servicios_salud.id_localidad
--inner join viviendas
--on viviendas.id_localidad = localidades.id

select municipios.id, municipios.nombre, poblacion, sin_afiliacion, con_afiliacion, imss, otros, (otros*100/con_afiliacion) as porcentaje_de_otros from municipios
inner join servicios_salud --Registros de dos tablas si hay valores que coinciden en un campo comun(Aqui se unen las dos tablas?)
on servicios_salud.id_municipio = municipios.id --Indica que si coinciden se combinaran los valores de la columna en este caso id.municipio

--Questions Que es lo que hace otros(Veo que hace una operacion)
--

