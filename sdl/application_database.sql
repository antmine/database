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
    TIME_EVENT timestamp not null default CURRENT_TIMESTAMP,
    URL varchar(255) not null,
	TAB_ACTIVE boolean null,
    ON_BATTERY boolean null,
    DISCONNECTED boolean null,
    constraint PK_MINER_EVENT primary key (ID_MINER, TIME_EVENT),
    constraint FK_MINER_EVENT_ID_MINER foreign key (ID_MINER) references MINER(ID_MINER)
);
