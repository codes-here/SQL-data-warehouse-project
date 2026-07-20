
/*
	==========================================================================================
	Bronze layer loading script
	==========================================================================================
	script puropse: 
	This script is a stored procedure to load data from the external csv files.
	- can calculate the time taken for loading data into bronze layer 
	- can calculate the time taken to load each table in the bronze layer
	- trucates the table before loading data into tables created

	Parameters:
	none.
	this stored procedure doesnot accept any parameters or return any values.

	usage example:

	exec bronze.load_bronze
	==========================================================================================

*/

create or alter procedure bronze.load_bronze as 
begin
	declare @start_time datetime , @end_time datetime , @batch_start_time datetime , @batch_end_time datetime ; 
	begin try
		set @batch_start_time = GETDATE() ; 
		print '=========================================================================' ;
		print 'Loading the bronze layer'; 
		print '=========================================================================' ; 

		print '---------------------------------------------------------------------------' ; 
		print 'Loading crm tables' ; 
		print '---------------------------------------------------------------------------' ; 

		set @start_time = GETDATE() ; 
		print '>> Truncating table: bronze.crm_cust_info'
		truncate table bronze.crm_cust_info ; 

		print '>> inserting data into: bronze.crm_cust_info'
		bulk insert  bronze.crm_cust_info
		from 'C:\Ekko\Computer Science\sql\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2 , 
			fieldterminator = ',' , 
			tablock
		); 
		set @end_time = GETDATE() ; 
		print '>> load duration: ' + cast(datediff (second , @start_time  ,@end_time)as nvarchar ) + ' seconds' ; 
		print '>>-----------------'

		set @start_time = GETDATE() ; 
		print '>> Truncating table: bronze.crm_prd_info'
		truncate table bronze.crm_prd_info  ;
		print '>> inserting data into: bronze.crm_prd_info'
		bulk insert bronze.crm_prd_info
		from 'C:\Ekko\Computer Science\sql\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2 , 
			fieldterminator = ',' , 
			tablock
		) ; 
		set @end_time = GETDATE() ; 
		print '>> Load Duration: ' + cast(datediff(second , @start_time , @end_time)as nvarchar) + ' seconds' ; 
		print '>>-----------------'

		set @start_time = GETDATE() ; 
		print '>> Truncating table: bronze.crm_sales_details'
		truncate table bronze.crm_sales_details ; 
		print '>> inserting data into: bronze.crm_sales_details'
		bulk insert bronze.crm_sales_details
		from 'C:\Ekko\Computer Science\sql\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2 ,
			fieldterminator = ',' ,
			tablock
		); 
		set @end_time = GETDATE() ; 
		print '>> Loading Duration: ' + cast(datediff(second , @start_time , @end_time)as nvarchar ) + ' seconds' ; 
		print '>>-----------------'


		print '---------------------------------------------------------------------------' ; 
		print 'Loading erp tables' ; 
		print '---------------------------------------------------------------------------' ; 
		
		set @start_time = GETDATE();
		print '>> Truncating table: bronze.erp_cust_az12'
		truncate table bronze.erp_cust_az12 ; 
		print '>> inserting data into: bronze.erp_cust_az12'
		bulk insert bronze.erp_cust_az12
		from 'C:\Ekko\Computer Science\sql\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with (
			firstrow = 2 ,
			fieldterminator = ',' , 
			tablock
		);
		set @end_time = GETDATE() ; 
		print 'Loading duration: ' + cast(datediff(second , @start_time , @end_time) as nvarchar) + ' seconds' ; 
		print '>>-----------------'


		set @start_time = GETDATE();
		print '>> Truncating table: bronze.erp_loc_a101'
		truncate table bronze.erp_loc_a101 ; 
		print '>> inserting data into: bronze.erp_loc_a101'
		bulk insert bronze.erp_loc_a101 
		from 'C:\Ekko\Computer Science\sql\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with(
			firstrow = 2 , 
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE() ; 
		print 'Loading duration: ' + cast(datediff(second , @start_time , @end_time) as nvarchar) + ' seconds' ; 
		print '>>-----------------'

		set @start_time = GETDATE();
		print '>> Truncating table: bronze.erp_px_cat_g1v2'
		truncate table bronze.erp_px_cat_g1v2 ;
		print '>> inserting data into: bronze.erp_px_cat_g1v2'
		bulk insert bronze.erp_px_cat_g1v2 
		from 'C:\Ekko\Computer Science\sql\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with (
			firstrow = 2 , 
			fieldterminator = ',' ,
			tablock
		) ;
		set @end_time = GETDATE() ; 
		print 'Loading duration: ' + cast(datediff(second , @start_time , @end_time) as nvarchar) + ' seconds' ; 
		print '>>-----------------'
		set  @batch_end_time  = GETDATE()
		print '======================================================================================'
		print 'Loading bronze layer is complete'
		print '-- total load duration:' + cast(datediff(second , @batch_start_time,@batch_end_time)as nvarchar) +  ' seconds';
		print '======================================================================================'
	end try
	begin catch
		print '==========================================================================================='
		print 'Error occured during loading bronze layer' ; 
		print 'Error message' + error_message() ; 
		print 'Error message' + cast(error_number() as nvarchar) ; 
		print '==========================================================================================='
	end catch
end
