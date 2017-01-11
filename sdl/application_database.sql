/**
**/

/* Create database */
drop database  if exists APPLICATION;
create database APPLICATION;
use APPLICATION;

/* Drop tables */
drop table if exists MINER;
drop table if exists MINER_EVENT;
drop table if exists MINER_WEBSITE;
drop table if exists CRYPTO_MINER;
drop table if exists CRYPTO;

/* Table MINER  */
create table MINER (
    ID_MINER int not null,
    POWER_ESTIMATION int not null,
    constraint PK_MINER primary key (ID_MINER)
);

/* Table MINER_WEBSITE */
create table MINER_WEBSITE (
    ID_MINER int not null,
    ID_WEBSITE int not null,
    constraint PK_MINER_WEBSITE primary key (ID_MINER),
    constraint FK_MINER_WEBSITE_ID_MINER foreign key (ID_MINER) references MINER(ID_MINER),
    constraint FK_MINER_WEBSITE_ID_WEBSITE foreign key (ID_WEBSITE) references ADMINISTRATION.WEBSITE(ID_WEBSITE)
);

/* Table MINER_EVENT */
create table MINER_EVENT (
    ID_MINER int not null,
    TIME_EVENT timestamp not null,
    URL varchar(255) null,
    COUNTRY varchar(255) null,
    BROWSER varchar(255) null,
    ENVIRONEMENT varchar(255) null,
    TYPE_EVENT int not null,
    constraint PK_MINER_EVENT primary key (ID_MINER, TIME_EVENT),
    constraint FK_MINER_EVENT_ID_MINER foreign key (ID_MINER) references MINER(ID_MINER)
);


/* Table CRYPTO */
create table CRYPTO (
    ID_CRYPTO int not null,
    CRYPTO_TYPE int not null,
    CRYPTO_VALUE varchar(255),
    constraint PK_CRYPTO primary key (ID_CRYPTO) 
);

/* Table CRYPTO_MINER */
create table CRYPTO_MINER (
    ID_CRYPTO int not null,
    ID_MINER int not null,
    TIME_CREATION timestamp not null,
    constraint PK_CRYPTO_MINER primary key (ID_CRYPTO, ID_MINER),
    constraint FK_CRYPTO_MINER_ID_CRYPTO foreign key (ID_CRYPTO) references CRYPTO(ID_CRYPTO),
    constraint FK_CRYPTO_MINER_ID_MINER foreign key (ID_MINER) references MINER(ID_MINER)
);