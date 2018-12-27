--2 - Crear una tabla
exec sp_tables @table_name = 'Empleado'
exec sp_tables @table_owner = 'dbo'
exec sp_columns 'Empleado'

if object_id('usuarios') is not null
  drop table usuarios;

create table usuarios (
  nombre varchar(30),
  clave varchar(10)
);

exec sp_columns 'usuarios'

--3.- Insert select
 insert into usuarios (nombre, clave) values ('Mariano','payaso');
 insert into usuarios (clave, nombre) values ('River','Juan');
 insert into usuarios (nombre,clave) values ('Boca','Luis');
 
 select * from usuarios;
 
 --13.-Identity
 create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(15),
  precio float
 );
 
 select * from bdPrueba.dbo.libros
 
 insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',23)

insert into libros (titulo,autor,editorial,precio)
  values('Uno','Richard Bach','Planeta',18);
insert into libros (titulo,autor,editorial,precio)
  values('Aprenda PHP','Mario Molina','Siglo XXI',45.60);
insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais de maravillas','Lewis Carroll','Paidos',15.50);
/*
delete from libros
  where codigo = 4*/

exec sp_columns libros

insert into libros (titulo,autor,editorial,precio)
values('Martin Fierro','Jose Hernandez','Paidos',25);

--Valor de inicio
select ident_seed('libros')
--Valor de incremento
select ident_incr('libros')

set identity_insert libros on;

insert into libros (codigo,titulo,autor)
 values (100,'Matematica estas ahi','Paenza');
 
 insert into libros (codigo,titulo,autor)
 values (1,'Ilusiones','Richard Bach');
 
 set identity_insert libros off
 
 insert into libros (titulo,autor)
  values ('Uno','Richard Bach');
  
select * from bdPrueba.dbo.libros

--15.-Truncate
begin tran --rollback
-- Truncamos la tabla:
truncate table libros;

-- Ingresamos nuevamente algunos registros:
insert into libros (titulo,autor,editorial,precio)
  values ('El aleph','Borges','Emece',25.60);
insert into libros (titulo,autor,editorial,precio)
  values ('Uno','Richard Bach','Planeta',18);

-- Si seleccionamos todos los registros vemos que la secuencia se reinició en 1:
select * from libros;

-- Eliminemos todos los registros con "delete":
delete from libros;

-- Ingresamos nuevamente algunos registros:
insert into libros (titulo,autor,editorial,precio)
  values ('El aleph','Borges','Emece',25.60);
insert into libros (titulo,autor,editorial,precio)
  values ('Uno','Richard Bach','Planeta',18);

-- Seleccionamos todos los registros y vemos que la secuencia continuó:
select * from libros;

--17.-Text type
 create table prueba(
  ctexto1 char(5),
  vtexto2 varchar(5)
 );
 
 insert into prueba (ctexto1, vtexto2)
  values ('Uno','Bach');
  
select len(ctexto1), len(vtexto2) from prueba

select titulo+'-'+autor+'-'+isnull(editorial,'')
  from libros;

select @@VERSION
select user_name()

--25.-Manejo cadenas
select substring(titulo+'-'+autor+'-'+isnull(editorial,''),10,5)
  from libros;

select ltrim(STR(1234156.467))
select ltrim(STR(1234156.567))
select ltrim(STR(1234156.565, 10, 2))
select ltrim(STR(1234156.565, 5, 2))

select STUFF('abcde',1,0,'opqrs')
select LEN('abc')
select LEFT('buen dia', 5)

select replace('xxx.sqlserverya.com','x','w')
select reverse('Hola')

select patindex('%or%', 'Jorge Luis Borges')
select patindex('%ar%', 'Jorge Luis Borges')

select charindex('or','Jorge Luis Borges')
select charindex('or','Jorge Luis Borges',4)
select charindex('or','Jorge Luis Borges',14)

select REPLICATE('Hola',5)
select 'Hola' + SPACE(2) + 'que' + SPACE(1) + 'tal'

--26.-Funciones matematicas
select ABS(-10)
select ABS(10)

select CEILING(12.34)
select floor(12.34)

select 10%5
select 10%4

select POWER(2,3)

select round(123.456, 1)
select round(123.456, 2)
select round(123.456, 3)
select round(123.456, -1)
select round(123.456, -2)
select round(123.456, -3)

select SIGN(5), SIGN(-8), SIGN(0)
select SQRT(SQUARE(5))

select COUNT(*) from libros;
select COUNT(1) from libros;
select COUNT(editorial) from libros;
select COUNT(isnull(editorial,'')) from libros;
select editorial, COUNT(1) from libros
group by editorial

 select count_big(*)   from libros;

--Rollup with one row for group by
 select editorial, COUNT(1) from libros
group by editorial with rollup

--Original query
select * from AdventureWorks2008R2.Person.Person

--Show total by person type and title
select PersonType, Title Title, COUNT(1) 
from AdventureWorks2008R2.Person.Person
group by PersonType, Title 
order by PersonType, Title

--Calculate subtotals and grand total
/*
select isnull(PersonType,'') PersonType, 
		isnull(Title,'') Title, 
		COUNT(1) Num
from AdventureWorks2008R2.Person.Person
group by PersonType, Title with rollup
*/

select case grouping(PersonType) --grouping command does not accept isnull command
			when 1 then 'Total' 
			else PersonType end as PersonType, 
		case grouping(Title)
			when 1 then 'Total'
			else Title end as Title, 
		COUNT(1) Num
from AdventureWorks2008R2.Person.Person
group by PersonType, Title with rollup

--Calculate grand total
select PersonType, Title Title, COUNT(1) 
from AdventureWorks2008R2.Person.Person
group by PersonType, Title 
--order by PersonType, Title
union all
select 'ZTotal', '', COUNT(1) 
from AdventureWorks2008R2.Person.Person
order by PersonType, Title

select case grouping(PersonType)
		when 1 then 'Total' 
		else PersonType end as PersonType, 
		case grouping(isnull(Title,''))
		when 1 then 'Total'
		else  isnull(Title,'') end as Title, 
		COUNT(1) Num
from AdventureWorks2008R2.Person.Person
group by rollup((PersonType, isnull(Title,'')))

--Calculate only subtotals
select PersonType, Title Title, COUNT(1) 
from AdventureWorks2008R2.Person.Person
group by PersonType, Title 
union
select PersonType, 'Z', COUNT(1) 
from AdventureWorks2008R2.Person.Person
group by PersonType
order by PersonType, Title

--39.-Modificador group by (rollup)
if object_id('visitantes') is not null
  drop table visitantes;

create table visitantes(
  nombre varchar(30),
  edad tinyint,
  sexo char(1),
  domicilio varchar(30),
  ciudad varchar(20),
  telefono varchar(11),
  montocompra decimal(6,2) not null
);

go

insert into visitantes
  values ('Susana Molina',28,'f',null,'Cordoba',null,45.50); 
insert into visitantes
  values ('Marcela Mercado',36,'f','Avellaneda 345','Cordoba','4545454',22.40);
insert into visitantes
  values ('Alberto Garcia',35,'m','Gral. Paz 123','Alta Gracia','03547123456',25); 
insert into visitantes
  values ('Teresa Garcia',33,'f',default,'Alta Gracia','03547123456',120);
insert into visitantes
  values ('Roberto Perez',45,'m','Urquiza 335','Cordoba','4123456',33.20);
insert into visitantes
  values ('Marina Torres',22,'f','Colon 222','Villa Dolores','03544112233',95);
insert into visitantes
  values ('Julieta Gomez',24,'f','San Martin 333','Alta Gracia',null,53.50);
insert into visitantes
  values ('Roxana Lopez',20,'f','null','Alta Gracia',null,240);
insert into visitantes
  values ('Liliana Garcia',50,'f','Paso 999','Cordoba','4588778',48);
insert into visitantes
  values ('Juan Torres',43,'m','Sarmiento 876','Cordoba',null,15.30);
  
  -- Cantidad de visitantes por ciudad y el total de visitantes
select ciudad,
  count(*) as cantidad
  from visitantes
  group by ciudad with rollup;

-- Filas de resumen cuando agrupamos por 2 campos, "ciudad" y "sexo":
 select ciudad,sexo,
  count(*) as cantidad
  from visitantes
  group by ciudad,sexo
  with rollup;

-- Para conocer la cantidad de visitantes y la suma de sus compras agrupados
-- por ciudad y sexo,
 select ciudad,sexo,
  --count(*) as cantidad,
  sum(montocompra) as total
  from visitantes
  group by ciudad,sexo
  with rollup;
  
--40.-Modificador group by (cube)
if object_id('empleados') is not null
  drop table empleados;

create table empleados (
  documento varchar(8) not null,
  nombre varchar(30),
  sexo char(1),
  estadocivil char(1),--c=casado, s=soltero,v=viudo
  seccion varchar(20),
  primary key (documento)
);

go

insert into empleados
  values ('22222222','Alberto Lopez','m','c','Sistemas');
insert into empleados
  values ('23333333','Beatriz Garcia','f','c','Administracion');
insert into empleados
  values ('24444444','Carlos Fuentes','m','s','Administracion');
insert into empleados
  values ('25555555','Daniel Garcia','m','s','Sistemas');
insert into empleados
  values ('26666666','Ester Juarez','f','c','Sistemas');
insert into empleados
  values ('27777777','Fabian Torres','m','s','Sistemas');
insert into empleados
  values ('28888888','Gabriela Lopez','f','c','Sistemas');
insert into empleados
  values ('29999999','Hector Garcia','m','c','Administracion');
insert into empleados
  values ('30000000','Ines Torres','f','c','Administracion');
insert into empleados
  values ('11111111','Juan Garcia','m','v','Administracion');
insert into empleados
  values ('12222222','Luisa Perez','f','v','Administracion');
insert into empleados
  values ('31111111','Marcela Garcia','f','s','Administracion');
insert into empleados
  values ('32222222','Nestor Fuentes','m','c','Sistemas');
insert into empleados
  values ('33333333','Oscar Garcia','m','s','Sistemas');
insert into empleados
  values ('34444444','Patricia Juarez','f','c','Administracion');
insert into empleados
  values ('35555555','Roberto Torres','m','c','Sistemas');
insert into empleados
  values ('36666666','Susana Torres','f','c','Administracion');

select sexo,estadocivil,seccion,
  count(*) from empleados
  group by sexo,estadocivil,seccion
  with rollup;

select sexo,estadocivil,seccion,
  count(*) from empleados
  group by sexo,estadocivil,seccion
  with cube;
  
select count(distinct(title)) from AdventureWorks2008R2.Person.Person
--select count(title) from AdventureWorks2008R2.Person.Person

select distinct(title) from AdventureWorks2008R2.Person.Person
where Title is not null

--44.-Clausula top
select top 3 with ties PersonType, Title, FirstName, LastName
from AdventureWorks2008R2.Person.Person order by PersonType

exec sp_helpconstraint empleados

--66.-Inner Join
if (object_id('clientes')) is not null
drop table clientes;
if (object_id('provincias')) is not null
drop table provincias;

 create table clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(20),
  codigoprovincia tinyint not null,
  primary key(codigo)
 );

 create table provincias(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
 );
 
  insert into provincias (nombre) values('Cordoba');
 insert into provincias (nombre) values('Santa Fe');
 insert into provincias (nombre) values('Corrientes');

 insert into clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
 insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
 insert into clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
 insert into clientes values ('Perez Luis','Sarmiento 444','Rosario',2);
 insert into clientes values ('Pereyra Lucas','San Martin 555','Cruz del Eje',1);
 insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe',2);
 insert into clientes values ('Torres Fabiola','Alem 777','Ibera',3);
 
  select c.nombre,domicilio,ciudad,p.nombre
  from clientes as c
  join provincias as p
  on c.codigoprovincia=p.codigo
  where p.nombre = 'Santa Fe'
  order by p.nombre
  
  --94.-Subconsultas any-some-all
if object_id('libros') is not null
  drop table libros;
if object_id('editoriales') is not null
  drop table editoriales;

create table editoriales(
  codigo tinyint identity,
  nombre varchar(30),
  primary key (codigo)
);
 
create table libros (
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial tinyint,
  precio decimal(5,2),
  primary key(codigo),
 constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
   on update cascade,
);

go

insert into editoriales values('Planeta');
insert into editoriales values('Emece');
insert into editoriales values('Paidos');
insert into editoriales values('Siglo XXI');

insert into libros values('Uno','Richard Bach',1,15);
insert into libros values('Ilusiones','Richard Bach',4,18);
insert into libros values('Puente al infinito','Richard Bach',2,20);
insert into libros values('Aprenda PHP','Mario Molina',4,40);
insert into libros values('El aleph','Borges',2,10);
insert into libros values('Antología','Borges',1,20);
insert into libros values('Cervantes y el quijote','Borges',3,25);

select * from editoriales
select * from libros

-- Mostramos los títulos de los libros de "Borges" de editoriales que 
-- han publicado también libros de "Richard Bach":
select titulo
  from libros
  where autor like '%Borges%' and
  codigoeditorial = any
   (select e.codigo
    from editoriales as e
    join libros as l
    on codigoeditorial=e.codigo
    where l.autor like '%Bach%');
    
-- Realizamos la misma consulta pero empleando "all" en lugar de "any":
select titulo, codigoeditorial
  from libros
  where autor like '%Borges%' and
  codigoeditorial = all
   (select e.codigo
    from editoriales as e
    join libros as l
    on codigoeditorial=e.codigo
    where l.autor like '%Bach%');

-- Mostramos los títulos y precios de los libros "Borges" cuyo precio 
-- supera a ALGUN precio de los libros de "Richard Bach":
 select titulo,precio
  from libros
  where autor like '%Borges%' and
  precio > any
   (select precio
    from libros
    where autor like '%Bach%');
    
-- Veamos la diferencia si empleamos "all" en lugar de "any":
 select titulo,precio
  from libros
  where autor like '%Borges%' and
  precio > all
   (select precio
    from libros
    where autor like '%Bach%');