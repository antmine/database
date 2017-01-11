-- insert into ADMINISTRATION.WEBSITE(ID_WEBSITE, NAME, URL)
-- values (21, "toot", "toto.com");
-- 
-- call DASHBOARD.PR_WEBSITE_STATS_TABLES_CREATION(21);

/* Trigger to create table*/
DELIMITER $$
create procedure _PR_CREATION_TABLE_LIKE(in TABLE_NAME varchar(255), in TABLE_REFERENCE varchar(255))
begin
	set @sql = CONCAT('create table ', TABLE_NAME, ' like ', TABLE_REFERENCE);
    prepare stmt from @sql;
    execute stmt;
    deallocate prepare stmt;
END $$
DELIMITER ;