# Load

In this final stage of the process we are going to take the new transformed and prepared data and insert it into the final destination or target.

**/Load Types/**
**Processing Types**:
**Batch Processing** - Here we load the data warehouse in one big patch of data that is going to run and load the data warehouse, it is only one time job in order to refresh the content so we schedule the data warehouse in order to load it once or twice per day.
**Streming Processing** - In case there is a change in the source we are going to process this change as soon as possible through all the layers of the data warehouse.

**Load Methods**:
**Full Load**- We can truncate and then insert, this means we make an empty table and insert everything from scrath. Or do an update insert, this is called upsert so we can update all the records and then insert the new one. Also drop, create, insert ( this is very similar to truncate and insert).
**Incremental Load**- Upsert (update and insert), also we can do Append the data to the table without having to update anything, also Merge (similar to upsert).

**Slowly Changing Dimensions (SCD)**:
**SCD 0 (No Historization)**- Nothing should be changed at all, so no updates.
**SCD 1 (Overwrite)**- Here we update the records with new information from the source system by overwriting the old value, so we loose the course history.
**SCD 2 (Historization)**- All the changes that we get from the source system we are inserting the new records but without overwrite or delete the old data, so here we active the new records and inactive the previous ones.

