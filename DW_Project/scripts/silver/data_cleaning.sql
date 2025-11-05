
-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT cst_id,COUNT(*)
FROM bronze.crm_cust_info
group by cst_id
having COUNT(*) > 1 OR cst_id IS NULL


-- Select one of the IDs that has duplicate values

SELECT *
FROM bronze.crm_cust_info
WHERE cst_id = 29466

-- Using a window function (ROW_NUMBER) in order to assign a unique number to each row in a result set, based on a defined order

SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info

-- Query to identify all the duplicates and nulls of our dataset

WITH row_table AS (
SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info )

SELECT * from row_table
WHERE flag_last != 1


-- Query to retrieve data without duplicates. 

WITH cleaned_table AS (
SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info )

SELECT * from cleaned_table
WHERE flag_last = 1



-- Checking Customer Information Tables

SELECT * 
FROM bronze.crm_cust_info

-- Checking unwanted spaces (this is for string columns)
-- Expectation : No results

SELECT cst_firstname 
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

SELECT cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)

SELECT cst_marital_status
FROM bronze.crm_cust_info
WHERE cst_marital_status != TRIM(cst_marital_status)






----------------------- Query to retrieve data without duplicates and without spaces. -----------------------

WITH cleaned_table AS (
SELECT cst_id, 
	   cst_key, 
	   TRIM(cst_firstname) AS cst_firstname , 
	   TRIM(cst_lastname) AS cst_lastname, 
	   cst_marital_status, 
	   cst_gndr, 
	   cst_create_date, 
	   ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info )

SELECT * from cleaned_table
WHERE flag_last = 1

--------------------------------------------------------------------------------------------------------------



-- Data Cardinality, change the values that look ambiguous and confusing for something more formal and clear, Ex. M -> Male / M -> Married

select *, 
	   case
	     when cst_marital_status = 'S' then 'Single'
		 when cst_marital_status = 'M' then 'Married'
		 else 'N/A'
		end
		
from bronze.crm_cust_info

where cst_marital_status is null 


select *, 
	   case
	     when cst_gndr = 'F' then 'Female'
		 when cst_gndr = 'M' then 'Male'
		 else 'N/A'
		end 
from bronze.crm_cust_info


--------- Query to retrieve data without duplicates and without spaces and with data cardinality name conventions applied, ---------------------
--------- also noticed that the UPPER function was applied so that means we are making our values all upper case and will be unsensitive. ------

WITH cleaned_table AS (
SELECT cst_id, 
	   cst_key, 
	   TRIM(cst_firstname) AS cst_firstname , 
	   TRIM(cst_lastname) AS cst_lastname, 
	   case
	     when UPPER(cst_marital_status) = 'S' then 'Single'
		 when UPPER(cst_marital_status) = 'M' then 'Married'
		 else 'N/A'
		end as cst_marital_status,
	    
	   case
	     when UPPER(cst_gndr) = 'F' then 'Female'
		 when UPPER(cst_gndr) = 'M' then 'Male'
		 else 'N/A'
		end as cst_gndr,
	   cst_create_date, 
	   ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info )

SELECT * from cleaned_table
WHERE flag_last = 1
order by 5,6


--------------------------------------------------------------------------------------------------------------------------------------------------------------





 

