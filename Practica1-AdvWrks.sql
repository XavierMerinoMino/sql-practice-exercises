/*
select * from INFORMATION_SCHEMA.COLUMNS where table_name = 'PersonaNatural'
select * from INFORMATION_SCHEMA.COLUMNS where table_name = 'Persona'
*/

select * from AdventureWorks2008R2.Person.Person

select CurrencyCode, Name 
from AdventureWorks2008R2.Sales.Currency

select distinct FirstName as Primer_Nombre
from AdventureWorks2008R2.Person.Person

select * from AdventureWorks2008R2.Person.Person
where PersonType != 'EM'

select top 5 Cur.CurrencyCode, Cur.Name 
from AdventureWorks2008R2.Sales.Currency Cur
where Cur.Name like '%dollar%'
order by Cur.CurrencyCode desc

select pro.ListPrice, * from AdventureWorks2008R2.Production.Product pro
where pro.ListPrice not between 100 and 500
order by pro.ListPrice desc

select * from AdventureWorks2008R2.Production.Product
where Color in ('Red', 'Silver')

select * from AdventureWorks2008R2.Production.Product
where Color like '_l%'

select distinct isnull(color,'')
from AdventureWorks2008R2.Production.Product

select * from AdventureWorks2008R2.Production.Product
where Color is null

select * 
from AdventureWorks2008R2.Production.Product
where isnull(Color, '') = ''

select COUNT(distinct jobtitle) as CargosDiferentes
from AdventureWorks2008R2.HumanResources.Employee
where OrganizationLevel in (2,3)

select Name, TaxRate
from AdventureWorks2008R2.Sales.SalesTaxRate
where Name like '%Canad%'

select Name, sum(taxrate) as Tasa
from AdventureWorks2008R2.Sales.SalesTaxRate
where Name like '%Canad%'
group by Name

select avg(vacationhours) as 'AvgVacHours',
		sum(sickleavehours) as 'SckLftHours'
from AdventureWorks2008R2.HumanResources.Employee
where JobTitle like 'Vice President%'

select DATEPART(YYYY,OrderDate) as 'Year',
		SUM(TotalDue) as 'Total Order Amount'
from AdventureWorks2008R2.Sales.SalesOrderHeader
group by DATEPART(YYYY,OrderDate)
order by DATEPART(YYYY,OrderDate) desc

select SalesOrderID, SUM(LineTotal) as SubTotal
from AdventureWorks2008R2.Sales.SalesOrderDetail
group by SalesOrderID
having SUM(LineTotal) > 100000

select COUNT(*) from AdventureWorks2008R2.Production.Product
select COUNT(*) from AdventureWorks2008R2.Production.ProductInventory
select COUNT(*) from AdventureWorks2008R2.Production.Product, 
					 AdventureWorks2008R2.Production.ProductInventory
select COUNT(*) from AdventureWorks2008R2.Production.Product pro, 
					 AdventureWorks2008R2.Production.ProductInventory proin
where pro.ProductID = proin.ProductID

select COUNT(*) from AdventureWorks2008R2.Production.Product pro join 
					 AdventureWorks2008R2.Production.ProductInventory proin
on pro.ProductID = proin.ProductID

select COUNT(*)
from AdventureWorks2008R2.Production.Product pro,
AdventureWorks2008R2.Production.ProductCategory procat,
AdventureWorks2008R2.Production.ProductSubcategory subcat
where pro.ProductSubcategoryID = subcat.ProductSubcategoryID
and subcat.ProductCategoryID = procat.ProductCategoryID
and ISNULL(pro.ProductSubcategoryID, '') <> ''

select COUNT(*)
from AdventureWorks2008R2.Production.Product pro join
AdventureWorks2008R2.Production.ProductSubcategory subcat
on pro.ProductSubcategoryID = subcat.ProductSubcategoryID
join AdventureWorks2008R2.Production.ProductCategory procat
on subcat.ProductCategoryID = procat.ProductCategoryID
where ISNULL(pro.ProductSubcategoryID, '') <> ''

select COUNT(*)
from AdventureWorks2008R2.Production.Product pro inner join
AdventureWorks2008R2.Production.ProductSubcategory subcat
on pro.ProductSubcategoryID = subcat.ProductSubcategoryID
inner join AdventureWorks2008R2.Production.ProductCategory procat
on subcat.ProductCategoryID = procat.ProductCategoryID
where ISNULL(pro.ProductSubcategoryID, '') <> ''

select top 1000 * from AdventureWorks2008R2.Person.Person
select top 1000 * from AdventureWorks2008R2.Person.PersonPhone
select top 1000 * from AdventureWorks2008R2.Person.PhoneNumberType

select per.FirstName, per.MiddleName, per.LastName,
perpho.PhoneNumber, phnuty.Name
from AdventureWorks2008R2.Person.Person per join
AdventureWorks2008R2.Person.PersonPhone perpho
on per.BusinessEntityID = perpho.BusinessEntityID
join AdventureWorks2008R2.Person.PhoneNumberType phnuty
on perpho.PhoneNumberTypeID = phnuty.PhoneNumberTypeID
order by per.FirstName, per.MiddleName, per.LastName

select top 100 * from AdventureWorks2008R2.Person.Person per
--select top 100 * from AdventureWorks2008R2.HumanResources.Employee
select top 100 * from AdventureWorks2008R2.HumanResources.EmployeeDepartmentHistory
select top 100 * from AdventureWorks2008R2.HumanResources.Department

select top 100 * from AdventureWorks2008R2.Person.Person per join
AdventureWorks2008R2.HumanResources.EmployeeDepartmentHistory emdehi
on per.BusinessEntityID = emdehi.BusinessEntityID
join AdventureWorks2008R2.HumanResources.Department dep
on emdehi.DepartmentID = dep.DepartmentID
where convert(varchar(10), emdehi.StartDate, 111) between '2006/01/01' and '2007/12/31'

/*
use master
go
create database bdPrueba
on
(NAME = bdPrueba_dat,
FILENAME = 'C:\Xavier\BaseDatos\bdPrueba_dat.mdf',
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH = 5)
log on
(name = bdPrueba_log,
FILENAME = 'C:\Xavier\BaseDatos\bdPrueba_log.ldf',
SIZE = 5,
MAXSIZE = 25,
FILEGROWTH = 5
)
go
*/
/*
use bdPrueba
go
create table Persona
(kIdPersona			int				not null,
vNombres			varchar(50)		null,
vApellidos			varchar(50)		null,
dFechaNacimiento	datetime		null,
vSexo				varchar(1)		null
constraint Persona_perId_pk primary key (kIdPersona)
);
go
*/

/*
use bdPrueba
go
create table PersonaNatural
(kIdPersonaNatural		int,
aIdPersona				int			not null,
vCedula					varchar(10)	null,
vNacionalidad			varchar(50),
constraint PK_PerNat_IdPerNat primary key (kIdPersonaNatural),
constraint FK_PerNat_IdPer foreign key (aIdPersona)
			references Persona(kIdPersona)
)
*/

/*
use bdPrueba
go
create index IDX_Per_NombreApellido
on Persona (vNombres, vApellidos)
go
*/

/*
use bdPrueba
go
create table PersonaJuridica
(kIdPersonaJuridica		int			not null,
aIdPersona				int			not null,
vRUC					varchar(13)	null,
vRazonSocial			varchar(50) null);
go

alter table PersonaJuridica
add constraint PK_PerJur_IdPerJur primary key (kIdPersonaJuridica)
go

alter table PersonaJuridica
add constraint FK_PerJur_IdPer foreign key (aIdPersona)
			references Persona(kIdPersona)
			on delete cascade
			on update cascade
go
*/

/*
alter table PersonaJuridica add dFechaRUC datetime NULL
alter table PersonaJuridica drop column dFechaRUC
*/

--Check columns of a table
use bdPrueba
go


/*
use bdPrueba
go
insert into Persona
(kIdPersona, vNombres, vApellidos, dFechaNacimiento, vSexo)
values
(1, 'Jordy', 'Lema',convert(datetime, '1997/07/31', 111), 'M')
go

insert into Persona
(kIdPersona, vNombres, vApellidos, dFechaNacimiento, vSexo)
values
(2, 'Xavier', 'Merino',convert(datetime, '1986/12/21', 111), 'M')
go

insert into Persona
(kIdPersona, vNombres, vApellidos, dFechaNacimiento, vSexo)
values
(3, 'Kathy', 'Palma',convert(datetime, '1978/03/30', 111), 'F')
go

--update bdPrueba.dbo.Persona set vApellidos = 'Lemas'
--where kIdPersona = 1

insert into PersonaNatural
(kIdPersonaNatural, aIdPersona, vCedula, vNacionalidad)
values
(1, 1, '0999999999', 'italiana')
go

insert into PersonaNatural
(kIdPersonaNatural, aIdPersona, vCedula, vNacionalidad)
values
(2, 2, '0888888888', 'ecuatoriana')
go

insert into PersonaNatural
(kIdPersonaNatural, aIdPersona, vCedula, vNacionalidad)
values
(3, 3, '0777777777', 'rusa')
go
*/

select * from bdPrueba.dbo.Persona
select * from bdPrueba.dbo.PersonaNatural

select pernat.vNacionalidad
from bdPrueba.dbo.Persona per join
bdPrueba.dbo.PersonaNatural pernat on
per.kIdPersona = pernat.aIdPersona
where per.vSexo = 'M'

/*
begin tran --rollback
update pernat
set pernat.vNacionalidad = 'ecuatoriana'
from bdPrueba.dbo.Persona per join
bdPrueba.dbo.PersonaNatural pernat on
per.kIdPersona = pernat.aIdPersona
where per.vSexo = 'M'
*/

/*
begin tran --rollback
delete pernat
from bdPrueba.dbo.Persona per join
bdPrueba.dbo.PersonaNatural pernat on
per.kIdPersona = pernat.aIdPersona
where per.kIdPersona = 3
*/

/*
begin tran --rollback
truncate table bdPrueba.dbo.Persona
*/

select * from bdPrueba.dbo.Persona
select * from bdPrueba.dbo.PersonaNatural

begin tran --rollback
declare @ErrorVar int;

insert into bdPrueba.dbo.Persona
(kIdPersona, vNombres, vApellidos, dFechaNacimiento, vSexo)
values
(4, 'Katherine', 'Pinto',convert(datetime, '1998/01/01', 111), 'F')

insert into bdPrueba.dbo.PersonaNatural
(kIdPersonaNatural, aIdPersona, vCedula, vNacionalidad)
values
(4, 4, '0666666666', 'francesa')

select @ErrorVar = @@ERROR

if (@ErrorVar <> 0)
	rollback
else
	commit
go

begin tran
begin try
	insert into bdPrueba.dbo.Persona
	(kIdPersona, vNombres, vApellidos, dFechaNacimiento, vSexo)
	values
	(5, 'Jonathan', 'Palma',convert(datetime, '1988/02/10', 111), 'M')

	insert into bdPrueba.dbo.PersonaNatural
	(kIdPersonaNatural, aIdPersona, vCedula, vNacionalidad)
	values
	(5, 5, '0555555555', 'pensilvano')
end try
begin catch
	select ERROR_NUMBER() as ErrorNumber,
			ERROR_SEVERITY() as ErrorSeverity,
			ERROR_STATE() as ErrorState,
			ERROR_PROCEDURE() as ErrorProcedure,
			ERROR_LINE() as ErrorLine,
			ERROR_MESSAGE() as ErrorMessage
			
	if @@trancount > 0
		rollback
end catch

if @@trancount > 0
	commit

--Vistas
use bdPrueba
go
create view vConsultaPersona 
--(Nombres, Apellidos, Fecha_Nacimiento, Cedula, Nacionalidad) 
as
select per.vNombres as Nombre, per.vApellidos, per.dFechaNacimiento,
		pernat.vCedula, pernat.vNacionalidad
from bdPrueba.dbo.Persona per
join bdPrueba.dbo.PersonaNatural pernat
on per.kIdPersona = pernat.aIdPersona
where per.vSexo = 'F'

select * from bdPrueba.dbo.vConsultaPersona
order by vCedula

--Stored Procedures
use bdPrueba
go
create procedure ConsultarDatosPersona
@vCedula		varchar(10) = null
as
set nocount on
	select per.vNombres as Nombre, per.vApellidos, per.dFechaNacimiento,
			pernat.vCedula, pernat.vNacionalidad
	from bdPrueba.dbo.Persona per
	join bdPrueba.dbo.PersonaNatural pernat
	on per.kIdPersona = pernat.aIdPersona
	where vCedula = @vCedula
set nocount off
go

/*
use bdPrueba
go
drop procedure dbo.ConsultarDatosPersona
*/

exec bdPrueba.dbo.ConsultarDatosPersona @vCedula = '0999999999'
exec AdventureWorks2008R2.dbo.uspGetBillOfMaterials 717, '2004/04/19'
select * FROM AdventureWorks2008R2.[Production].[BillOfMaterials] 
order by [ProductAssemblyID]

use bdPrueba
go
create procedure ConsultarNumPersonas
@iNumPersonas		int output
as
set nocount on
	select @iNumPersonas = COUNT(1)
	from bdPrueba.dbo.Persona
set nocount off
go

declare @iNP int
exec bdPrueba.dbo.ConsultarNumPersonas @iNumPersonas = @iNP output
select @iNP

sp_helptext ConsultarNumPersonas

/***********************************************************************************/
use bdPrueba
go
alter procedure dbo.IngresarPersona
@vNombres				varchar(50),
@vApellidos				varchar(50),
@dFechaNacimiento		varchar(10),
@vSexo					varchar(1),
@iIdPersona				int output
as
set nocount on
	
	begin tran
	begin try
		--declare @iVarPersona int
		select @iIdPersona = MAX(kIdPersona)
		from bdPrueba.dbo.Persona
		select @iIdPersona = isnull(@iIdPersona, 0) + 1
	
		insert into Persona
		(kIdPersona, vNombres, vApellidos, dFechaNacimiento, vSexo)
		values
		(@iIdPersona, @vNombres, @vApellidos, convert(datetime, @dFechaNacimiento, 111), @vSexo)
		
	end try
	begin catch
		select ERROR_NUMBER() as ErrorNumber,
			ERROR_SEVERITY() as ErrorSeverity,
			ERROR_STATE() as ErrorState,
			ERROR_PROCEDURE() as ErrorProcedure,
			ERROR_LINE() as ErrorLine,
			ERROR_MESSAGE() as ErrorMessage
			
		if @@trancount > 0
			rollback
	end catch
	
	if @@trancount > 0
		commit
	
set nocount off
go
/***********************************************************************************/
use bdPrueba
go
alter procedure dbo.IngresarPersonaNatural
@vCedula				varchar(10),
@vNacionalidad			varchar(50),
@vNombres				varchar(50),
@vApellidos				varchar(50),
@dFechaNacimiento		varchar(10),
@vSexo					varchar(1)
as
set nocount on
	
	begin tran
	begin try
		declare @iVarIdPersona int,
				@iVarIdPersonaNatural int
	
		exec bdPrueba.dbo.IngresarPersona @vNombres = @vNombres,
			@vApellidos = @vApellidos,
			@dFechaNacimiento = @dFechaNacimiento,
			@vSexo = @vSexo,
			@iIdPersona = @iVarIdPersona output
	
		select @iVarIdPersonaNatural = MAX(kIdPersonaNatural)
			from bdPrueba.dbo.PersonaNatural
			select @iVarIdPersonaNatural = isnull(@iVarIdPersonaNatural, 0) + 1
	
		insert into PersonaNatural
		(kIdPersonaNatural, aIdPersona, vCedula, vNacionalidad)
		values
		(@iVarIdPersonaNatural, @iVarIdPersona, @vCedula, @vNacionalidad)
		
	end try
	begin catch
		select ERROR_NUMBER() as ErrorNumber,
			ERROR_SEVERITY() as ErrorSeverity,
			ERROR_STATE() as ErrorState,
			ERROR_PROCEDURE() as ErrorProcedure,
			ERROR_LINE() as ErrorLine,
			ERROR_MESSAGE() as ErrorMessage
			
		if @@trancount > 0
			rollback
	end catch
	
	if @@trancount > 0
		commit
	
set nocount off
go
/********************************************************************************/
/*
declare @iVarPrueba int
select @@TRANCOUNT as select1
begin tran
	select @@TRANCOUNT as select2
	exec bdPrueba.dbo.IngresarPersona
	@vNombres = 'Prueba1',
	@vApellidos	= 'Prueba1',
	@dFechaNacimiento = '2018/12/02',
	@vSexo = 'F',
	@iIdPersona = @iVarPrueba output
	select @@TRANCOUNT as select3
	
	begin tran
		select @@TRANCOUNT as select4
		exec bdPrueba.dbo.IngresarPersona
		@vNombres = 'Prueba2',
		@vApellidos	= 'Prueba2',
		@dFechaNacimiento = '2018/12/02',
		@vSexo = 'M',
		@iIdPersona = @iVarPrueba output
		select @@TRANCOUNT as select5
*/
--rollback
select * from bdPrueba.dbo.Persona
select * from bdPrueba.dbo.PersonaNatural

exec bdPrueba.dbo.IngresarPersonaNatural
@vCedula = '0222222222',
@vNacionalidad = 'belga',
@vNombres = 'Prueba2',
@vApellidos	= 'Prueba2',
@dFechaNacimiento = '2018/20/02',
@vSexo = 'F'