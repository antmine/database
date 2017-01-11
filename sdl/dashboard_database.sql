/**
**/

/* Create database */
drop database if exists DASHBOARD;
create database DASHBOARD;
use DASHBOARD;

/* Drop tables */
drop table if exists VISITORS_WEBSITE;
drop table if exists MOST_VIEWED_PAGES;
drop table if exists COUNTRY_RANKING;
drop table if exists CRYPTO_MONEY;

create table VISITORS_WEBSITE (
    ID_WEBSITE char(10) not null,
    DATE_EVENT date not null,
    NB_VISITOR int not null,
    NB_MINER int not null,
    AVERAGE_TIME float not null,
    constraint PK_VISITORS_WEBSITE primary key (ID_WEBSITE, DATE_EVENT)
);

create table MOST_VIEWED_PAGES (
    ID_WEBSITE char(10) not null,
    DATE_EVENT date not null,
    URL varchar(255) not null,
    NB_VISITOR int not null,
    constraint FK_MOST_VIEWED_PAGES_ID_WEBSITE foreign key (ID_WEBSITE) references VISITORS_WEBSITE(ID_WEBSITE),
    constraint PK_MOST_VIEWED_PAGES primary key (ID_WEBSITE, DATE_EVENT, URL)
);

create table COUNTRY_RANKING (
    ID_WEBSITE char(10) not null,
    COUNTRY varchar(255) not null,
    DATE_EVENT date not null,
    NB_VISITOR int not null,
    constraint PK_COUNTRY_RANKING primary key (ID_WEBSITE, DATE_EVENT, COUNTRY),
    constraint FK_COUNTRY_RANKING_ID_WEBSITE foreign key (ID_WEBSITE) references VISITORS_WEBSITE(ID_WEBSITE)
);

create table CRYPTO_MONEY (
    ID_WEBSITE char(10) not null,
    DATE_EVENT date not null,
    CRYPTO varchar(255) not null,
    AMOUNT float not null,
    constraint PK_CRYPTO_MONEY primary key (ID_WEBSITE, DATE_EVENT, CRYPTO),
    constraint FK_CRYPTO_MONEY_ID_WEBSITE foreign key (ID_WEBSITE) references VISITORS_WEBSITE(ID_WEBSITE)
);
