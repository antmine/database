/**
* Temporary value : 
*    CLIENT_PASSWORD.HASH_PASSWORD
*
* Not checked : 
*  - email address
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

/** 
** Table ADMIN_CLIENT 
**  The client's birtday date has to been between timestamp zero and now.
**/
create table ADMIN_CLIENT (
    ID_CLIENT int not null,
    NAME varchar(255) not null,
    LASTNAME varchar(255) not null,
    EMAIL_ADDRESS varchar(255) not null,
    DATE_BIRTHDAY date not null,
    STREET varchar(255) not null,
    CITY varchar(255) not null,
    STATE varchar(255) null,
    ZIP_CODE varchar(255) not null,
    COUNTRY varchar(255) not null,
    constraint PK_CLIENT primary key (ID_CLIENT),
    constraint CT_DATE_BIRTHDAY check (DATE_BIRTHDAY  between date '1900-01-01' and sysdate)
);

/* Table CLIENT_PASSWORD */
create table CLIENT_PASSWORD (
    ID_CLIENT int not null,
    HASH_PASSWORD varbinary(255),
    constraint PK_CLIENT_PASSWORD primary key (ID_CLIENT),
    constraint FK_CLIENT_PASSWORD_CLIENT_ID foreign key (ID_CLIENT) references ADMIN_CLIENT(ID_CLIENT)
);

/* Table WEBSITE */
create table WEBSITE (
    ID_WEBSITE int not null,
    NAME varchar(255) null,
    URL varchar(255) not null,
    IS_ACTIVE bit not null default true,
    constraint PK_WEBSITE primary key (ID_WEBSITE),
    constraint CT_WEBSITE_URL unique (URL)
);

/* Table CLIENT_WEBSITE */
create table CLIENT_WEBSITE (
    ID_WEBSITE int not null,
    ID_CLIENT int not null,
    constraint PK_WEBSITE primary key (ID_WEBSITE),
    constraint FK_CLIENT_WEBSITE_ID_WEBSITE foreign key (ID_WEBSITE) references WEBSITE(ID_WEBSITE),
    constraint FK_CLIENT_WEBSITE_CLIENT_ID foreign key (ID_CLIENT) references ADMIN_CLIENT(ID_CLIENT)
);