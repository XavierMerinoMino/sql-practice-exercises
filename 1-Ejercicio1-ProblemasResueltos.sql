select * from bdPrueba.dbo.Departamento
select * from bdPrueba.dbo.Empleado

--1. Obtener los datos completos de los empleados.
select * from bdPrueba.dbo.Empleado

--2. Obtener los datos completos de los departamentos
select * from bdPrueba.dbo.Departamento

--3. Obtener los datos de los empleados con cargo 'Secretaria'.
select * from bdPrueba.dbo.Empleado where cargoE like 'Secretaria'

--4. Obtener el nombre y salario de los empleados.
select nomEmp, (salEmp + comisionE) as Salario from bdPrueba.dbo.Empleado

--5. Obtener los datos de los empleados vendedores, ordenado por nombre.
select emp.* from bdPrueba.dbo.Empleado emp join
			bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
where dep.codDepto in (2000, 2100, 2200, 2300)
order by emp.nomEmp

--6. Listar el nombre de los departamentos
select distinct(nombreDpto) from bdPrueba.dbo.Departamento

--7. Listar el nombre de los departamentos, ordenado por nombre
select distinct(nombreDpto) from bdPrueba.dbo.Departamento order by nombreDpto

--8. Listar el nombre de los departamentos, ordenado por ciudad
select nombreDpto from bdPrueba.dbo.Departamento order by ciudad

--9. Listar el nombre de los departamentos, ordenado por ciudad, en orden inverso
select nombreDpto from bdPrueba.dbo.Departamento order by ciudad desc

--10. Obtener el nombre y cargo de todos los empleados, ordenado por salario
select nomEmp, cargoE from bdPrueba.dbo.Empleado order by (salEmp + comisionE)

--11. Obtener el nombre y cargo de todos los empleados, ordenado por cargo y por salario
select nomEmp, cargoE from bdPrueba.dbo.Empleado order by cargoE, (salEmp + comisionE)

--12. Obtener el nombre y cargo de todos los empleados, en orden inverso por cargo
select nomEmp, cargoE from bdPrueba.dbo.Empleado order by cargoE desc, nomEmp 

--13. Listar los salarios y comisiones de los empleados del departamento 2000
select emp.nomEmp, emp.salEmp, emp.comisionE from bdPrueba.dbo.Empleado emp join
			bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
where dep.codDepto = '2000'

--14. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión
select emp.nomEmp, emp.salEmp, emp.comisionE from bdPrueba.dbo.Empleado emp join
			bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
where dep.codDepto = '2000'
order by emp.comisionE

--15. Listar todas las comisiones
select comisionE from bdPrueba.dbo.Empleado

--16. Listar las comisiones que sean diferentes, ordenada por valor
select distinct(comisionE) from bdPrueba.dbo.Empleado order by comisionE

--17. Listar los diferentes salarios
select distinct(salEmp) from bdPrueba.dbo.Empleado

--18. Obtener el valor total a pagar que resulta de sumar a los empleados del departamento 3000 una
--bonificación de $500.000, en orden alfabético del empleado
select emp.nomEmp, (emp.salEmp + emp.comisionE + 500000) valorPagar
from bdPrueba.dbo.Empleado emp join
	bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
where dep.codDepto = '3000'
order by emp.nomEmp

--19. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
select * from bdPrueba.dbo.Empleado 
where comisionE > salEmp

--20. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
select * from bdPrueba.dbo.Empleado 
where comisionE <= (salEmp * 0.3)

--21. Elabore un listado donde para cada fila, figure ‘Nombre’ y ‘Cargo’ antes del valor respectivo para
--cada empleado
select nomEmp Nombre, cargoE Cargo, salEmp + comisionE Valor from bdPrueba.dbo.Empleado 

--22. Hallar el salario y la comisión de aquellos empleados cuyo número de documento de identidad es
--superior al '19.709.802'
select * from bdPrueba.dbo.Empleado where nDIEmp > '19.709.802'

--23. Listar los empleados cuyo salario es menor o igual que el 40% de su comisión
select * from bdPrueba.dbo.Empleado where salEmp <= (comisionE * 0.4)

--24. Divida los empleados, generando un grupo cuyo nombre inicie por la letra J y termine en la letra Z.
--Liste estos empleados y su cargo por orden alfabético.
select *
from bdPrueba.dbo.Empleado --where nomEmp like 'j%'
where substring(nomEmp, 1, charindex(' ', nomEmp)) like 'J%'
order by nomEmp

--25. Listar el salario, la comisión, el salario total (salario + comisión), documento de identidad del
--empleado y nombre, de aquellos empleados que tienen comisión superior a $1.000.000, ordenar el
--informe por el número del documento de identidad
select salEmp, comisionE, (salEmp + comisionE) SalarioTotal, nDIEmp, nomEmp from bdPrueba.dbo.Empleado
where comisionE > 1000000 order by nDIEmp

--26. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión
select salEmp, comisionE, (salEmp + comisionE) SalarioTotal, nDIEmp, nomEmp from bdPrueba.dbo.Empleado
where isnull(comisionE,0) = 0 order by nDIEmp

--27. Hallar el nombre de los empleados que tienen un salario superior a $1.000.000, y tienen como jefe al
--empleado con documento de identidad '31.840.269'
select nomEmp from bdPrueba.dbo.Empleado where jefeID = '31.840.269' and salEmp > 1000000

--28. Hallar el conjunto complementario del resultado del ejercicio anterior.
select * from bdPrueba.dbo.Empleado where jefeID = '31.840.269' and salEmp > 1000000
select * from bdPrueba.dbo.Empleado 
where (jefeID = '31.840.269' and salEmp <= 1000000) or isnull(jefeID,'') <> '31.840.269' order by isnull(jefeID, ''), salEmp

--29. Hallar los empleados cuyo nombre no contiene la cadena “MA”
select * from bdPrueba.dbo.Empleado where lower(nomEmp) not like '%ma%'

--30. Obtener los nombres de los departamentos que no sean “Ventas” ni “Investigación” NI
--‘MANTENIMIENTO’, ordenados por ciudad.
select * from bdPrueba.dbo.Departamento
where codDepto not in (2000, 2100, 2200, 2300, 3000, 4000, 4100, 4200, 4300) order by ciudad

--31. Obtener el nombre y el departamento de los empleados con cargo 'Secretaria' o 'Vendedor', que
--no trabajan en el departamento de “PRODUCCION”, cuyo salario es superior a $1.000.000,
--ordenados por fecha de incorporación.
select emp.nomEmp, dep.nombreDpto from bdPrueba.dbo.Empleado emp join
			bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
where dep.codDepto <> 1500
and cargoE in ('Secretaria', 'Vendedor')
and salEmp > 1000000
order by fecIncorporacion

--32. Obtener información de los empleados cuyo nombre tiene exactamente 11 caracteres
select * from bdPrueba.dbo.Empleado where len(nomEmp) = 11

--33. Obtener información de los empleados cuyo nombre tiene al menos 11 caracteres
select * from bdPrueba.dbo.Empleado where len(nomEmp) >= 11

--34. Listar los datos de los empleados cuyo nombre inicia por la letra 'M', su salario es mayor a $800.000
--o reciben comisión y trabajan para el departamento de 'VENTAS'
select * from bdPrueba.dbo.Empleado emp join
			bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
where lower(emp.nomEmp) like 'm%'
and (salEmp > 800000 or isnull(comisionE,0) > 0)
and dep.codDepto in (2000, 2100, 2200, 2300)

--35. Obtener los nombres, salarios y comisiones de los empleados que reciben un salario situado entre la
--mitad de la comisión la propia comisión
select nomEmp, salEmp, comisionE from bdPrueba.dbo.Empleado
where salEmp between (comisionE / 2) and comisionE

--36. Suponga que la empresa va a aplicar un reajuste salarial del 7%. Listar los nombres de los empleados, su
--salario actual y su nuevo salario, indicando para cada uno de ellos si tiene o no comisión
select nomEmp, salEmp,(salEmp * 1.07) NuevoSalario, comisionE  from bdPrueba.dbo.Empleado

--37. Obtener la información disponible del empleado cuyo número de documento de identidad sea:
--'31.178.144', '16.759.060', '1.751.219', '768.782', '737.689', '19.709.802', '31.174.099', '1.130.782'
select * from bdPrueba.dbo.Empleado emp join
			bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
where emp.nDIEmp in ('31.178.144', '16.759.060', '1.751.219', '768.782', 
'737.689', '19.709.802', '31.174.099', '1.130.782')

--38. Entregar un listado de todos los empleados ordenado por su departamento, y alfabético dentro del
--departamento.
select * from bdPrueba.dbo.Empleado emp join
			bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
order by dep.nombreDpto, emp.nomEmp

--39. Entregar el salario más alto de la empresa.
select max(salEmp) from bdPrueba.dbo.Empleado

--40. Entregar el total a pagar por comisiones, y el número de empleados que las reciben.
select sum(1) NumEmployees, sum(comisionE) TotalComision 
from bdPrueba.dbo.Empleado where isnull(comisionE,0) > 0

--41. Entregar el nombre del último empleado de la lista por orden alfabético.
select top 1 nomEmp from bdPrueba.dbo.Empleado order by nomEmp desc

--42. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
select max(salEmp) MaxSalary, min(salEmp) MinSalary, (max(salEmp) - min(salEmp)) Diff
from bdPrueba.dbo.Empleado

--43. Conocido el resultado anterior, entregar el nombre de los empleados que reciben el salario más alto
--y más bajo. Cuanto suman estos salarios?
declare @vIdMaxEmp varchar(30), @vIdMinEmp varchar(30)
select top 1 @vIdMaxEmp = nomEmp from bdPrueba.dbo.Empleado order by salEmp asc
select top 1 @vIdMinEmp = nomEmp from bdPrueba.dbo.Empleado order by salEmp desc

select @vIdMaxEmp MaxSalary, @vIdMinEmp MinSalary, (max(salEmp) + min(salEmp)) Total
from bdPrueba.dbo.Empleado

--44. Entregar el número de empleados de sexo femenino y de sexo masculino, por departamento.
select dep.nombreDpto, emp.sexEmp, count(1) Num from bdPrueba.dbo.Empleado emp join
			bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
group by dep.nombreDpto, emp.sexEmp
order by dep.nombreDpto, emp.sexEmp

--45. Hallar el salario promedio por departamento.
select dep.nombreDpto, round(sum(salEmp)/sum(1), 2) SalarioProm from bdPrueba.dbo.Empleado emp join
			bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
group by dep.nombreDpto

--46. Hallar el salario promedio por departamento, considerando aquellos empleados cuyo salario supera
--$900.000, y aquellos con salarios inferiores a $575.000. Entregar el código y el nombre del
--departamento.
select dep.codDepto, dep.nombreDpto, round(sum(salEmp)/sum(1), 2) SalarioProm 
from bdPrueba.dbo.Empleado emp join
	bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
where (emp.salEmp > 900000 or emp.salEmp < 575000)
group by dep.codDepto, dep.nombreDpto

--47. Entregar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa.
--Ordenarlo por departamento.
declare @avgSalEmp float
select @avgSalEmp = round(avg(salEmp),2) from bdPrueba.dbo.Empleado

select nomEmp from bdPrueba.dbo.Empleado where salEmp >= @avgSalEmp
order by codDepto

--48. Hallar los departamentos que tienen más de tres (3) empleados. Entregar el número de empleados de
--esos departamentos.
select dep.nombreDpto, count(1) NumEmp 
from bdPrueba.dbo.Empleado emp join
	bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
where (emp.salEmp > 900000 or emp.salEmp < 575000)
group by dep.nombreDpto
having count(1) > 3

--49. Obtener la lista de empleados jefes, que tienen al menos un empleado a su cargo. Ordene el informe
--inversamente por el nombre.
select nomEmp from bdPrueba.dbo.Empleado where nDIEmp in
(select distinct(jefeID) from bdPrueba.dbo.Empleado where jefeID IS not null)
order by nomEmp desc

--50. Hallar los departamentos que no tienen empleados
select dep.codDepto, count(1) NumEmp 
from bdPrueba.dbo.Empleado emp join
	bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
group by dep.codDepto
having count(1) = 0

--51. Entregar un reporte con el numero de cargos en cada departamento y cual es el promedio de salario
--de cada uno. Indique el nombre del departamento en el resultado.
select dep.codDepto, emp.cargoE, count(1) NumEmp, round(AVG(salEmp),2) SalProm 
from bdPrueba.dbo.Empleado emp join
	bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
group by dep.codDepto, emp.cargoE

--52. Entregar el nombre del departamento cuya suma de salarios sea la más alta, indicando el valor de la
--suma.
select top 1 dep.nombreDpto, SUM(salEmp) sumSal
from bdPrueba.dbo.Empleado emp join
	bdPrueba.dbo.Departamento dep
on emp.codDepto = dep.codDepto
group by dep.nombreDpto
order by sumSal desc

--53. Entregar un reporte con el código y nombre de cada jefe, junto al número de empleados que dirige.
--Puede haber empleados que no tengan supervisores, para esto se indicará solamente el numero de
--ellos dejando los valores restantes en NULL.
select e1.jefeID, e2.nomEmp, COUNT(1) numEmp
from bdPrueba.dbo.Empleado e1 join 
	bdPrueba.dbo.Empleado e2 
	on e1.jefeID = e2.nDIEmp
where e1.jefeID is not null
group by e1.jefeID, e2.nomEmp
order by e1.jefeID, e2.nomEmp