# Extract 

There is a source system and what we want to do is to get our data from the source and move it to the target, source and target can be database tables. The first step is to specify which data we have to load from the source, then we have to prepare it and load it later to the target so this step in the ETL process we call it **"Extract"**.

**/Extraction Methods/**
**Pull Extraction** - Pull data from the source.
**Push Extraction** - Source system is pushing the data to the data warehouse.

**/Extraction Types/**
**Full Extraction** - All records from tables and every day we load all the data to the data warehouse.
**Incremental Extraction** - Everyday we are going to identify only the new changing data so we dont have to load the whole thing.

**/Extraction Techniques/**
**Manual Data Extraction** - Someone has to access the source system and extract it manually.
**Database Queryng** - We connect ourselves to the DB and we query in order to extract the data.
**File Parsing** - We have a file that we have to pass it to the data warehouse. 
**API Calls** - Connect to an API and create the calls to extract the data.
**Event Based Streming** - Check if the data is available in streaming like in Kafka.
**CDC** - Stands for Change Data Capture, it is very similar to streaming.
**Web Scraping** - Here we have a code that is going to run and extract all the information from the Web.
