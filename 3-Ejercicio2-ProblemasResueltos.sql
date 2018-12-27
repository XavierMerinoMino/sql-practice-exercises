select * from bdPrueba.dbo.temple1
select * from bdPrueba.dbo.tdepar2

--1.- Obtener una lista de todas las empleadas de los departamentos que empiecen por D y por E. 
--La lista anterior debe contener información sobre el número de personal, nombre, apellido y número de teléfono.
select tem.nuempl, tem.nombre, tem.apellido, tem.tlfn
from bdPrueba.dbo.temple1 tem
join bdPrueba.dbo.tdepar2 tde
on tem.dept = tde.numdep
where tem.sexo = 'M'
and tde.nomdep like '[D-E]%'

--2.- Obtener un listado de todos los empleados (nombre y apellido) que ganan más de 2000€ al mes 
--y que entraron en la compañía después del 1 de Enero de 1975. También se quiere la información 
--correspondiente a su código de trabajo y al número de personal de sus directores.
select tem.nombre, tem.apellido, tem.codtra, tde.numdirec
from bdPrueba.dbo.temple1 tem
join bdPrueba.dbo.tdepar2 tde
on tem.dept = tde.numdep
where tem.salario > 2000
and tem.feching > '1975-01-01'

--3.- Obtener una lista con el apellido, número de departamento y salario mensual de los empleados 
--de los departamentos ‘A00’, ‘B01’, ‘C01’ y ‘D01’. La salida se quiere en orden descendente de salario 
--dentro de cada departamento.
select tem.apellido, tem.dept, tem.salario
from bdPrueba.dbo.temple1 tem
where tem.dept in ('A00', 'B01', 'C01', 'D01')
order by tem.dept, tem.salario desc

--4.- Se pide una lista que recupere el salario medio de cada departamento junto con el número de empleados 
--que tiene. El resultado no debe incluir empleados que tengan un código de trabajo mayor que 54, 
--ni departamentos con menos de tres empleados. Se quiere ordenada por número de departamento.
select tde.numdep, tde.nomdep, convert(decimal(11,2), round(AVG(tem.salario), 2)) SalarioMedio, COUNT(1) NumEmpleados
from bdPrueba.dbo.temple1 tem
join bdPrueba.dbo.tdepar2 tde
on tem.dept = tde.numdep
where tem.codtra > 54
group by tde.numdep, tde.nomdep
having COUNT(1) >= 3
order by tde.numdep

--5.- Seleccionar todos los empleados de los departamentos ‘D11’ y ‘E11’ cuyo primer apellido empiece por S.
select * 
from bdPrueba.dbo.temple1 tem
where tem.dept in ('D11', 'E11')
and tem.apellido like 'S%'

--6.- Obtener el nombre, apellido y fecha de ingreso de los directores de departamento ordenados 
--por número de personal.
select tem1.nombre, tem1.apellido, tem1.feching, COUNT(1) NumEmpleados
from bdPrueba.dbo.temple1 tem
join bdPrueba.dbo.tdepar2 tde
on tem.dept = tde.numdep
join bdPrueba.dbo.temple1 tem1
on tde.numdirec = tem1.nuempl
group by tem1.nombre, tem1.apellido, tem1.feching
order by tem1.nombre 

select * from bdPrueba.dbo.tdepar2 order by numdirec

--7.- Obtener un listado de las mujeres de los departamentos que empiecen por D y por E cuyo 
--nivel de educación sea superior a la media; en este caso también ordenados por número de personal.
select tem.nombre, tem.apellido, tem.niveduc, tde.nomdep
from bdPrueba.dbo.temple1 tem
join bdPrueba.dbo.tdepar2 tde
on tem.dept = tde.numdep
where tem.sexo = 'M'
and tde.nomdep like '[D-E]%'
and tem.niveduc > (select avg(niveduc) from bdPrueba.dbo.temple1 tem1 where tem1.sexo = 'M' group by tem1.sexo)
order by tem.nuempl