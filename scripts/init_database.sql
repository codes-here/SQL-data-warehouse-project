/*
=====================================================================================
Create Databases & Schemas
=====================================================================================
Script Purpose:
	The Purpose of the script is to create a database named DataWarehouse after checking
	if it already exists.

	if the database exists it drops the database and creates a newone with same name.

	Aditionally the script creates three new schemas within the database 'Bronze' , 'Silver'
	and 'Gold'.

WARNING:
	Running the script will drop the entire 'DataWarehouse' database if it exists.
	All the data in the database will permanantly deleted. Proceed with caution and 
	ensure you have proper backups before running this script.
*/
use master ;
go

--Drop and recreate dataWarehouse database 

if exists (select 1 from sys.databases where name = 'dataWarehouse')
begin
	Alter Database DataWarehouse set single_user with rollback immediate ; 
	Drop database dataWarehouse ; 
End ; 
go


-- create dataWarehouse database 
create database dataWarehouse ; 
go

use dataWarehouse  ;
go

-- create schemas
create schema bronze ; 
go
create schema silver ;
go
create schema gold ; 
go

