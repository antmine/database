/**
**/

/* Create database */
drop database if exists DASHBOARD;
create database DASHBOARD;
use DASHBOARD;

/* Drop tables */
drop table if exists CRYPTO_MONEY;
drop table if exists COUNTRY_RANKING_TEMPLATE;
drop table if exists OS_RANKING_TEMPLATE;
drop table if exists STATS_WEBSITE_TEMPLATE;


/* Table CRYPTO_MONEY */
create table CRYPTO_MONEY (
    ID_CRYPTO int not null,
    ID_CLIENT int not null,
    PERCENT int not null,
    IS_PAID bit not null default 0,
    constraint PK_CRYPTO_MONEY primary key (PERCENT),
    constraint FK_CRYPTO_MONEY_ID_CRYPTO foreign key (ID_CRYPTO) references APPLICATION.CRYPTO(ID_CRYPTO),
    constraint FK_CRYPTO_MONEY_ID_CLIENT foreign key (ID_CLIENT) references ADMINISTRATION.ADMIN_CLIENT(ID_CLIENT),
    constraint CT_CRYPTO_MONEY_PERCENT check (PERCENT between 0 and 100)
);

/**
** Table COUNTRY_RANKING_TEMPLATE
** This table is a template for COUNTRY_RANKING_[ID_WEBSITE]
**/
create table COUNTRY_RANKING_TEMPLATE (
    DATE_RANK int not null,
    COUNTRY varchar(255) not null,
    RANK int not null,
    constraint PK_COUNTRY_RANKING_TEMPLATE primary key (DATE_RANK, RANK),
    constraint CT_COUNTRY_RANKING_TEMPLATE_RANK check (RANK between 1 and 10)
);

/**
** Table OS_RANKING_TEMPLATE
** This table is a template for OS_RANKING_[ID_WEBSITE]
**/
create table OS_RANKING_TEMPLATE (
    DATE_RANK int not null,
    OS varchar(255) not null,
    RANK int not null,
    constraint PK_OS_RANKING_TEMPLATE primary key (DATE_RANK, RANK),
    constraint CT_OS_RANKING_TEMPLATE_RANK check (RANK between 1 and 10)
);


/**
** Table STATS_WEBSITE_TEMPLATE
** This table is a template for STATS_WEBSITE_[ID_WEBSITE]
**/
create table STATS_WEBSITE_TEMPLATE (
    DATE_RANK int not null,
    NB_VISITE int not null,
    AVERAGE_TIME int not null,
    constraint PK_COUNTRY_RANKING_TEMPLATE primary key (DATE_RANK)
);

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

/* Trigger to create stat website table */
DELIMITER $$
create procedure PR_WEBSITE_STATS_TABLES_CREATION(in WEBSITE_ID int)
begin
	call _PR_CREATION_TABLE_LIKE(CONCAT('COUNTRY_RANKING_', WEBSITE_ID), 'COUNTRY_RANKING_TEMPLATE');
	call _PR_CREATION_TABLE_LIKE(CONCAT('STATS_WEBSITE_', WEBSITE_ID), 'STATS_WEBSITE_TEMPLATE');
	call _PR_CREATION_TABLE_LIKE(CONCAT('OS_RANKING_', WEBSITE_ID), 'OS_RANKING_TEMPLATE');
END $$
DELIMITER ;
