/**
* Temporary value :
*    CLIENT_PASSWORD.HASH_PASSWORD
*
* Not checked :
*  - email address
*  birtday date client
*  - url address
**/

/* Create database */
drop database if exists DASHBOARD;
drop database  if exists APPLICATION;
drop database  if exists ADMINISTRATION;
create database ADMINISTRATION;
use ADMINISTRATION;

/* Drop tables */
drop table if exists ADMIN_CLIENT;
drop table if exists CLIENT_PASSWORD;
drop table if exists WEBSITE;
drop table if exists CLIENT_WEBSITE;

/* Table ADMIN_CLIENT */
create table ADMIN_CLIENT (
    ID_CLIENT int not null auto_increment,
    NAME varchar(255) not null,
    LASTNAME varchar(255) not null,
    EMAIL_ADDRESS varchar(255) not null,
    DATE_BIRTHDAY date not null,
    DATE_CONNECTION date null,
    HASH_PASSWORD varbinary(255) not null,
    IS_VERIFIED bit not null default false,
    IS_ENABLE bit not null default true,
    constraint PK_CLIENT primary key (ID_CLIENT),
    constraint CT_DATE_BIRTHDAY check (DATE_BIRTHDAY  between date '1900-01-01' and sysdate),
    constraint CT_ADMIN_CLIENT_EMAIL unique (EMAIL_ADDRESS)
);

/* Table ADDRESS */
create table ADDRESS (
  ID_CLIENT int not null,
  STREET varchar(255) not null,
  CITY varchar(255) not null,
  STATE varchar(255) null,
  ZIP_CODE varchar(255) not null,
  COUNTRY varchar(255) not null,
  constraint PK_ADDRESS primary key (ID_CLIENT),
  constraint FK_ADDRESS_ID_CLIENT foreign key (ID_CLIENT) references ADMIN_CLIENT(ID_CLIENT) on delete cascade
);

/* Table WEBSITE */
create table WEBSITE (
    ID_WEBSITE char(10) not null,
    NAME varchar(255) not null,
    URL varchar(255) not null,
    DATE_CREATION datetime not null default CURRENT_TIMESTAMP,
    DATE_UPDATE datetime null,
    DATE_ACTIVE_UPDATE datetime null,
    DATE_CHECK datetime null,
    IS_ACTIVE bit not null default true,
    IS_ENABLE bit not null default false,
    constraint PK_WEBSITE primary key (ID_WEBSITE),
    constraint CT_WEBSITE_URL unique (URL)
);

/* Table CLIENT_WEBSITE */
create table CLIENT_WEBSITE (
    ID_WEBSITE char(10) not null,
    ID_CLIENT int not null,
    constraint FK_CLIENT_WEBSITE_ID_WEBSITE foreign key (ID_WEBSITE) references WEBSITE(ID_WEBSITE),
    constraint FK_CLIENT_WEBSITE_CLIENT_ID foreign key (ID_CLIENT) references ADMIN_CLIENT(ID_CLIENT),
    constraint PK_WEBSITE primary key (ID_WEBSITE)
);

/* Table CRYPTO */
create table CRYPTO_CURRENCY (
    ID_CRYPTO char(3) not null,
    NAME varchar(255),
    constraint PK_CRYPTO primary key (ID_CRYPTO)
);

/* Table CRYPTO_USER */
create table CRYPTO_CURRENCY_WEBSITE (
    ID_CRYPTO char(3) not null,
    ID_WEBSITE char(10) not null,
    IS_ENABLE bit not null default true,
    constraint FK_CRYPTO_CURRENCY_WEBSITE_ID_CRYPTO foreign key (ID_CRYPTO) references CRYPTO_CURRENCY(ID_CRYPTO),
    constraint FK_CRYPTO_CURRENCY_WEBSITE_ID_WEBSITE foreign key (ID_WEBSITE) references WEBSITE(ID_WEBSITE),
    constraint PK_CRYPTO_CURRENCY_WEBSITE primary key (ID_CRYPTO, ID_WEBSITE)
);


/* Table CLIENT_URL_ACTIVATION */
create table CLIENT_URL_ACTIVATION (
    ID_CLIENT int not null,
    UUID varchar(255) not null,
    EMAIL_ADDRESS varchar(25) not null,
    constraint FK_CLIENT_URL_ACTIVATION_CLIENT_ID foreign key (ID_CLIENT) references ADMIN_CLIENT(ID_CLIENT),
    constraint PK_CLIENT_URL_ACTIVATION primary key (ID_CLIENT)
);

/* Table CLIENT_URL_RESET */
create table CLIENT_URL_RESET (
    ID_CLIENT int not null,
    UUID varchar(255) not null,
    EMAIL_ADDRESS varchar(25) not null,
    constraint FK_CLIENT_URL_RESET_CLIENT_ID foreign key (ID_CLIENT) references ADMIN_CLIENT(ID_CLIENT),
    constraint PK_CLIENT_URL_RESET primary key (ID_CLIENT)
);

/* Preocdure GET_WEBSITE_TO_CHECK
/* This procedure returns the list of website to check
/* The argument is the number of days whitout a recheck (defaut: 10) */
delimiter //
create procedure GET_WEBSITE_TO_CHECK(IN nbDays int) 
BEGIN
    select ID_WEBSITE, URL from ADMINISTRATION.WEBSITE as notChecked
        where DATE_CHECK_UPDATE is null
        and DATE_CREATION != curdate()
    union
    select ID_WEBSITE, URL from ADMINISTRATION.WEBSITE as recheck
        where IS_ENABLE = false
        and DATE_CHECK_UPDATE >= now() - INTERVAL 1 DAY
    union
    select ID_WEBSITE, URL from ADMINISTRATION.WEBSITE as notChecked
        where IS_ENABLE = true
        and DATE_CHECK_UPDATE <= now() - INTERVAL nbDays DAY;
end //
delimiter ;