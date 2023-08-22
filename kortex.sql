connect "localhost:/var/db/firebird/kortex.fdb";

commit;

drop database;

commit;

CREATE DATABASE 'localhost:/var/db/firebird/kortex.fdb' DEFAULT CHARACTER SET NONE ;

commit;

/*  External Function declarations */
DECLARE EXTERNAL FUNCTION SUBSTR 
CSTRING(255) CHARACTER SET NONE, SMALLINT, SMALLINT
RETURNS CSTRING(255) CHARACTER SET NONE FREE_IT
ENTRY_POINT 'IB_UDF_substr' MODULE_NAME 'ib_udf';


in tlkp_listchoices.sql;


/*  Generators or sequences */
CREATE GENERATOR GEN_TBL_ACCOUNT;
CREATE GENERATOR GEN_TBL_APP;
CREATE GENERATOR GEN_TBL_CONFIG;
CREATE GENERATOR GEN_TBL_CONTACT;
CREATE GENERATOR GEN_TBL_COSTCODE;
CREATE GENERATOR GEN_TBL_HISTORY;
CREATE GENERATOR GEN_TBL_INVITEM;
CREATE GENERATOR GEN_TBL_INVOICE;
CREATE GENERATOR GEN_TBL_INVOICEID;
CREATE GENERATOR GEN_TBL_ITEM;
CREATE GENERATOR GEN_TBL_MESSAGE;
CREATE GENERATOR GEN_TBL_OPTION;
CREATE GENERATOR GEN_TBL_ORDERNOTES;
CREATE GENERATOR GEN_TBL_PLAN;
CREATE GENERATOR GEN_TBL_ROLE;
CREATE GENERATOR GEN_TBL_SCHEDULE;
CREATE GENERATOR GEN_TBL_SECTION;
CREATE GENERATOR GEN_TBL_SERVICEITEM;
CREATE GENERATOR GEN_TBL_TASK;
CREATE GENERATOR GEN_TBL_TASKEVENT;
CREATE GENERATOR GEN_TBL_TIMESHEET;
CREATE GENERATOR GEN_TBL_TRANSACTION;
CREATE GENERATOR GEN_TBL_TRANSSLICE;
CREATE GENERATOR GEN_TBL_USER;
CREATE GENERATOR GEN_TBL_XCODE;
CREATE GENERATOR GEN_TBL_XDOC;
CREATE GENERATOR GEN_TBL_XDOCVID;
CREATE GENERATOR GEN_TBL_XIMPORT;
CREATE GENERATOR GEN_TBL_XIMPORTLOG;
CREATE GENERATOR GEN_TBL_XTAG;
CREATE GENERATOR GEN_TBL_XTRACE;
CREATE GENERATOR GEN_TLKP_ACCTYPE;
CREATE GENERATOR GEN_TLKP_ERPSKILL;
CREATE GENERATOR GEN_TLKP_INVITEMTYPE;
CREATE GENERATOR GEN_TLKP_INVMANUFACTURER;
CREATE GENERATOR GEN_TLKP_INVMANUFMODEL;
CREATE GENERATOR GEN_TLKP_LOCALITY;
CREATE GENERATOR GEN_TLKP_TRANSTYPE;
CREATE GENERATOR GEN_TLKP_TTYPE;
CREATE GENERATOR GEN_TLKP_XCODE_TYPE;
CREATE GENERATOR GEN_TLNK_INVITEMPRICE;



/* Table: TBL_ACCOUNT, Owner: NIGEL */
CREATE TABLE TBL_ACCOUNT (INT_ACCOUNTID BIGINT NOT NULL,
        INT_BSB BIGINT default 0 NOT NULL,
        INT_CHILDOF BIGINT,
        INT_CCPREFIX BIGINT NOT NULL,
        INT_ACCPREFIX BIGINT NOT NULL,
        INT_ACODE BIGINT,
        INT_ACCTYPEID BIGINT NOT NULL,
        INT_ACCPLANID BIGINT,
        STR_NAME VARCHAR(64) NOT NULL,
        STR_DESC VARCHAR(512),
        INT_OWNERID BIGINT,
        FLT_LASTBALANCE NUMERIC(18, 4),
        DTM_BALANCECALC TIMESTAMP DEFAULT 'now' NOT NULL,
        STR_REPCALCTYPE VARCHAR(16),
PRIMARY KEY (INT_ACCOUNTID));

/* Table: TBL_APP, Owner: NIGEL */
CREATE TABLE TBL_APP (INT_APPID BIGINT NOT NULL,
        STR_NAME VARCHAR(128) NOT NULL,
        STR_URL1 VARCHAR(257),
        STR_URL2 VARCHAR(256),
        STR_DBPATH VARCHAR(64) NOT NULL,
        STR_APPURL VARCHAR(256),
PRIMARY KEY (INT_APPID));

/* Table: TBL_CONFIG, Owner: NIGEL */
CREATE TABLE TBL_CONFIG (INT_PARAMETER BIGINT NOT NULL,
        STR_PARAMGRP VARCHAR(64) NOT NULL,
        STR_PARAMSUBGRP VARCHAR(64) NOT NULL,
        STR_PARAMETER VARCHAR(64) NOT NULL,
        STR_VALUE VARCHAR(256),
PRIMARY KEY (INT_PARAMETER));

/* Table: TBL_CONTACT, Owner: NIGEL */
CREATE TABLE TBL_CONTACT (INT_CONTACTID BIGINT NOT NULL,
        STR_COMPANYNAME VARCHAR(128),
        STR_TITLE VARCHAR(32),
        STR_FIRSTNAME VARCHAR(32),
        STR_MIDDLENAME VARCHAR(32),
        STR_SURNAME VARCHAR(32),
        STR_FLATNUMBER VARCHAR(16),
        STR_STREETNUMBER VARCHAR(16),
        STR_STREETNAME VARCHAR(64),
        STR_STREETXTRA VARCHAR(64),
        STR_ADDRESS VARCHAR(256),
        STR_SUBURB VARCHAR(32),
        STR_STATE VARCHAR(16),
        STR_POSTCODE VARCHAR(16),
        STR_AREA_CODE VARCHAR(14),
        STR_AC_PHONE VARCHAR(14),
        STR_PHONE VARCHAR(16),
        DTM_VERIFIED TIMESTAMP,
        DTM_DEVERIFIED TIMESTAMP,
        INT_LOCALITY BIGINT,
        STR_USERNAME VARCHAR(32),
        STR_PASSWORD VARCHAR(32),
        INT_NEWCONTACTID NUMERIC(18, 0),
PRIMARY KEY (INT_CONTACTID));

/* Table: TBL_DOCREGISTER, Owner: NIGEL */
CREATE TABLE TBL_DOCREGISTER (INT_DOCID NUMERIC(18, 0) NOT NULL,
        STR_TYPE VARCHAR(16) NOT NULL,
        INT_CONTACTID NUMERIC(18, 0),
        INT_INVOICEID NUMERIC(18, 0),
        STR_NAME VARCHAR(128),
        BLB_NOTES BLOB SUB_TYPE TEXT SEGMENT SIZE 80,
        DTE_DATE DATE,
        STR_GROUP VARCHAR(64) default 'top',
        STR_PARENTGROUP VARCHAR(64),
CONSTRAINT PK_DRDOCID PRIMARY KEY (INT_DOCID));

/* Table: TBL_HISTORY, Owner: NIGEL */
CREATE TABLE TBL_HISTORY (INT_EVENTID NUMERIC(18, 0) NOT NULL,
        INT_USERID BIGINT NOT NULL,
        DTM_EVENT TIMESTAMP default 'now' NOT NULL,
        IBL_AUTHSUCCESS BIGINT,
        DTM_SESSCREATE TIMESTAMP,
        DTM_SESSDESTROY TIMESTAMP,
PRIMARY KEY (INT_EVENTID));

/* Table: TBL_INVITEM, Owner: NIGEL */
CREATE TABLE TBL_INVITEM (INT_ITEMID BIGINT NOT NULL,
        INT_TYPEID BIGINT NOT NULL,
        STR_NAME VARCHAR(64) NOT NULL,
        STR_DESC VARCHAR(512),
        INT_OWNERID BIGINT,
        INT_MODELID BIGINT,
        INT_MANUFID BIGINT,
        STR_SIZEWEIGHT VARCHAR(64),
        STR_UPCBARCODE VARCHAR(32),
        INT_DELIV_LEAD_DAYS BIGINT,
        STR_SELLUNIT VARCHAR(16),
        INT_SELLQTY BIGINT,
        STR_BULKUNIT VARCHAR(16),
        INT_BULKQTY NUMERIC(18, 4),
        STR_BUYUNIT VARCHAR(16),
        INT_BUYQTY NUMERIC(18, 4),
PRIMARY KEY (INT_ITEMID));

/* Table: TBL_INVOICE, Owner: NIGEL */
CREATE TABLE TBL_INVOICE (INT_INVOICEID NUMERIC(18, 0) NOT NULL,
        DTE_DATE DATE DEFAULT 'now',
        INT_INVOICENUM BIGINT NOT NULL,
        INT_CONTACTID NUMERIC(18, 0) NOT NULL,
        DTM_PRINTED TIMESTAMP,
        DTM_EMAILED TIMESTAMP,
        DTM_FAXED TIMESTAMP,
CONSTRAINT PK_INVOICE PRIMARY KEY (INT_INVOICEID));

/* Table: TBL_ITEM, Owner: NIGEL */
CREATE TABLE TBL_ITEM (INT_ITEMID BIGINT NOT NULL,
        STR_NAME VARCHAR(128) NOT NULL,
        STR_DESC VARCHAR(4096),
        STR_BARCODE VARCHAR(32),
PRIMARY KEY (INT_ITEMID));

/* Table: TBL_LOG, Owner: NIGEL */
CREATE TABLE TBL_LOG (DTM_STAMP TIMESTAMP DEFAULT 'now' NOT NULL,
        STR_LOG VARCHAR(1024));

/* Table: TBL_OPTION, Owner: NIGEL */
CREATE TABLE TBL_OPTION (INT_OPTIONID BIGINT NOT NULL,
        INT_CHILDOF BIGINT,
        INT_SECTIONID BIGINT NOT NULL,
        STR_TYPE VARCHAR(10),
        STR_GROUP VARCHAR(30),
        STR_NAME VARCHAR(50),
        STR_DESC VARCHAR(256),
        STR_XCODE VARCHAR(64),
        STR_ICON VARCHAR(50),
        STR_HREF VARCHAR(50),
        STR_ARGS VARCHAR(100),
        INT_ORDER BIGINT,
        STR_SPARE1 VARCHAR(30),
        STR_SPARE2 VARCHAR(30),
        STR_SPARE3 VARCHAR(30),
        STR_SPARE4 VARCHAR(30),
PRIMARY KEY (INT_OPTIONID));

/* Table: TBL_PLANNER, Owner: NIGEL */
CREATE TABLE TBL_PLANNER (INT_PLANID NUMERIC(18, 0) NOT NULL,
        STR_NAME VARCHAR(100) NOT NULL,
        BLB_DESC BLOB SUB_TYPE TEXT SEGMENT SIZE 80,
        DTE_START DATE,
        TME_START TIME,
        DTE_END DATE,
        TME_END TIME,
PRIMARY KEY (INT_PLANID));

/* Table: TBL_PRIORITY, Owner: NIGEL */
CREATE TABLE TBL_PRIORITY (STR_NAME VARCHAR(40) NOT NULL,
        INT_PRIORITY BIGINT NOT NULL,
        STR_DESC VARCHAR(200),
PRIMARY KEY (STR_NAME));

/* Table: TBL_REPORT, Owner: NIGEL */
CREATE TABLE TBL_REPORT (INT_REPORTID BIGINT NOT NULL,
        IBL_ACTIVE BIGINT default 1,
        STR_REPORT VARCHAR(64) NOT NULL,
        STR_HEADERSQL VARCHAR(256),
        STR_HEADERMARKUP VARCHAR(2048),
        STR_BODYSQL VARCHAR(256),
        STR_BODYMARKUP VARCHAR(2048),
        STR_BODYGROUPING VARCHAR(256),
        STR_FOOTERSQL VARCHAR(256),
        STR_FOOTERMARKUP VARCHAR(2048),
        STR_FOOTERTOTALS VARCHAR(256),
CONSTRAINT PKEY_REPORT PRIMARY KEY (INT_REPORTID));

/* Table: TBL_ROLE, Owner: NIGEL */
CREATE TABLE TBL_ROLE (INT_ROLEID BIGINT NOT NULL,
        STR_ROLENAME VARCHAR(32) NOT NULL,
        STR_DESC VARCHAR(256),
UNIQUE (STR_ROLENAME),
PRIMARY KEY (INT_ROLEID));

/* Table: TBL_SCHEDULE, Owner: NIGEL */
CREATE TABLE TBL_SCHEDULE (INT_SCHEDID NUMERIC(18, 0) NOT NULL,
        INT_TASKID NUMERIC(18, 0) NOT NULL,
        INT_USERID NUMERIC(18, 0) NOT NULL,
        DTM_DATE DATE,
        TME_TIME TIME,
        STR_NOTES VARCHAR(4096),
PRIMARY KEY (INT_SCHEDID));

/* Table: TBL_SECTION, Owner: NIGEL */
CREATE TABLE TBL_SECTION (INT_SECTIONID BIGINT NOT NULL,
        STR_NAME VARCHAR(32) NOT NULL,
        STR_CODE VARCHAR(32) NOT NULL,
        STR_ICON VARCHAR(128),
        STR_DESC VARCHAR(64),
        INT_ORDER BIGINT,
PRIMARY KEY (INT_SECTIONID));

/* Table: TBL_SERVICEITEM, Owner: NIGEL */
CREATE TABLE TBL_SERVICEITEM (INT_SERVITEMID BIGINT NOT NULL,
        STR_NAME VARCHAR(128) NOT NULL,
        STR_DESC VARCHAR(512),
        FLT_PRICE NUMERIC(18, 3),
        STR_TAXIEFC VARCHAR(1) default 'E',
PRIMARY KEY (INT_SERVITEMID));

/* Table: TBL_TASK, Owner: NIGEL */
CREATE TABLE TBL_TASK (INT_TASKID NUMERIC(18, 0) NOT NULL,
        INT_CREATEDBY NUMERIC(18, 0),
        INT_CREATEDFOR NUMERIC(18, 0),
        STR_NAME VARCHAR(100) NOT NULL,
        STR_CALLTYPE VARCHAR(40),
        STR_DEPARTMENT VARCHAR(300),
        BLB_DESC BLOB SUB_TYPE TEXT SEGMENT SIZE 80,
        INT_PRIORITY BIGINT default 1 NOT NULL,
        DTM_CREATED TIMESTAMP default 'now',
        DTM_EDITED TIMESTAMP default 'now',
        INT_COMPLETE BIGINT,
        INT_CONTACTID BIGINT,
PRIMARY KEY (INT_TASKID));

/* Table: TBL_TASKALLOC, Owner: NIGEL */
CREATE TABLE TBL_TASKALLOC (INT_TASKID NUMERIC(18, 0) NOT NULL,
        INT_USERID NUMERIC(18, 0) NOT NULL,
        DTM_ALLOC TIMESTAMP,
PRIMARY KEY (INT_TASKID, INT_USERID));

/* Table: TBL_TASKEVENT, Owner: NIGEL */
CREATE TABLE TBL_TASKEVENT (INT_TASKEVENTID NUMERIC(18, 0) NOT NULL,
        INT_TASKID NUMERIC(18, 0) NOT NULL,
        INT_USERID BIGINT NOT NULL,
        DTM_SDATE DATE NOT NULL,
        TME_STIME TIME,
        DTM_EDATE DATE,
        TME_ETIME TIME,
        STR_EVENT VARCHAR(256),
        STR_NOTES VARCHAR(4096),
        BLB_DATA BLOB SUB_TYPE TEXT SEGMENT SIZE 80,
        IBL_PRIVATE BIGINT default 0,
PRIMARY KEY (INT_TASKEVENTID));

/* Table: TBL_TASKNOTES, Owner: NIGEL */
CREATE TABLE TBL_TASKNOTES (INT_NOTEID NUMERIC(18, 0) NOT NULL,
        INT_TASKID NUMERIC(18, 0) NOT NULL,
        DTM_TIMESTAMP TIMESTAMP default 'now',
        STR_NOTE VARCHAR(5000),
PRIMARY KEY (INT_NOTEID, INT_TASKID));

/* Table: TBL_TIMESHEET, Owner: NIGEL */
CREATE TABLE TBL_TIMESHEET (INT_TIMESHEETID NUMERIC(18, 0) NOT NULL,
        INT_USERID BIGINT NOT NULL,
        INT_TASKID BIGINT NOT NULL,
        DTM_SDATE DATE,
        DTM_STIME TIME,
        DTM_EDATE DATE,
        DTM_ETIME TIME,
PRIMARY KEY (INT_TIMESHEETID));

/* Table: TBL_TRANSACTION, Owner: NIGEL */
CREATE TABLE TBL_TRANSACTION (INT_TRANSID BIGINT NOT NULL,
        INT_TTYPEID BIGINT NOT NULL,
        DTM_STAMP TIMESTAMP default 'now' NOT NULL,
        DTE_DATE DATE default 'now' NOT NULL,
        TME_TIME TIME default 'now' NOT NULL,
        INT_ACCOUNTID BIGINT,
        INT_USERID BIGINT,
        INT_INVITEMID BIGINT,
        INT_SERVITEMID BIGINT,
        INT_CHILDOF BIGINT,
        INT_CONTACTID BIGINT,
        STR_NAME VARCHAR(256),
        FLT_AMOUNT NUMERIC(18, 4),
        FLT_TAXAMT NUMERIC(18, 4),
        INT_QTY NUMERIC(18, 6),
        STR_TAXTYPE VARCHAR(16) default 'GST' NOT NULL,
        STR_TAXIEFC VARCHAR(8) default 'E' NOT NULL,
        IBL_CANCELLED BIGINT default 0,
        IBL_INVOICED BIGINT default 0,
        STR_DESC VARCHAR(8192),
        IBL_CLOSED BIGINT default 0,
PRIMARY KEY (INT_TRANSID));

/* Table: TBL_TRANSSLICE, Owner: NIGEL */
CREATE TABLE TBL_TRANSSLICE (INT_SITEID BIGINT DEFAULT 1 NOT NULL,
        DTM_RSTAMP TIMESTAMP DEFAULT 'now' NOT NULL,
        INT_TSLICEID NUMERIC(18, 0) NOT NULL,
        STR_LABEL VARCHAR(100),
        STR_GROUP VARCHAR(200),
        INT_USEWHICHAMT BIGINT,
        INT_TRANSTYPE NUMERIC(18, 0) NOT NULL,
        STR_TAXIEFC VARCHAR(3) DEFAULT 'E' NOT NULL,
        INT_TAXTYPE NUMERIC(18, 0),
        FLT_CALC NUMERIC(18, 6),
        INT_DESTACC NUMERIC(18, 0),
        INT_ADJTRANSAMT BIGINT,
        TEMP VARCHAR(456),
PRIMARY KEY (INT_SITEID, INT_TSLICEID),
UNIQUE (INT_SITEID, INT_TRANSTYPE, STR_TAXIEFC, INT_TAXTYPE, INT_ADJTRANSAMT));

/* Table: TBL_USER, Owner: NIGEL */
CREATE TABLE TBL_USER (INT_USERID BIGINT NOT NULL,
        STR_USERNAME VARCHAR(64) NOT NULL,
        STR_PASSWORD VARCHAR(64) NOT NULL,
        STR_FULLNAME VARCHAR(128),
        STR_EMAIL VARCHAR(64),
        STR_HPHONE VARCHAR(16),
        STR_WPHONE VARCHAR(16),
        STR_MPHONE VARCHAR(16),
        STR_NOTES VARCHAR(256),
        INT_AUTHLEVEL BIGINT,
        INT_NEWUSERID NUMERIC(18, 0),
PRIMARY KEY (INT_USERID),
UNIQUE (STR_USERNAME));

/* Table: TBL_XCODE, Owner: NIGEL */
CREATE TABLE TBL_XCODE (INT_VERSIONID BIGINT NOT NULL,
        STR_XCODE VARCHAR(64) NOT NULL,
        STR_NAME VARCHAR(64),
        STR_RELEASE VARCHAR(32),
        STR_TYPE VARCHAR(10),
        INT_LASTEDITOR BIGINT,
        DTM_MODTIME TIMESTAMP,
        STR_DESC VARCHAR(256),
        BLB_CODE BLOB SUB_TYPE TEXT SEGMENT SIZE 80,
        INT_TYPEID BIGINT,
        STR_MD5 VARCHAR(40),
PRIMARY KEY (INT_VERSIONID));

/* Table: TBL_XDOC, Owner: NIGEL */
CREATE TABLE TBL_XDOC (INT_VERSIONID BIGINT NOT NULL,
        INT_XDOCID BIGINT NOT NULL,
        INT_CHILDOF BIGINT,
        STR_NAME VARCHAR(128) NOT NULL,
        STR_INTRO VARCHAR(512),
        BLB_DATA BLOB SUB_TYPE TEXT SEGMENT SIZE 80,
        INT_ORDER BIGINT,
        DTM_STAMP TIMESTAMP default 'now' NOT NULL,
CONSTRAINT PK_XDOC PRIMARY KEY (INT_VERSIONID));

/* Table: TBL_XHIST, Owner: NIGEL */
CREATE TABLE TBL_XHIST (DTM_STAMP TIMESTAMP default 'now' NOT NULL,
        STR_SESSID VARCHAR(64),
        INT_USERID BIGINT,
        STR_REQUEST VARCHAR(128),
        STR_REQHASH VARCHAR(64),
        STR_PTITLE VARCHAR(64));

/* Table: TBL_XIMPORT, Owner: NIGEL */
CREATE TABLE TBL_XIMPORT (INT_SESSIONID BIGINT NOT NULL,
        STR_NAME VARCHAR(256),
        DTM_CREATED TIMESTAMP DEFAULT 'now' NOT NULL,
        STR_DESC VARCHAR(2048),
PRIMARY KEY (INT_SESSIONID));

/* Table: TBL_XIMPORTLOG, Owner: NIGEL */
CREATE TABLE TBL_XIMPORTLOG (INT_LOGID BIGINT NOT NULL,
        INT_SESSIONID BIGINT NOT NULL,
        DTM_STAMP TIMESTAMP default 'now' NOT NULL,
        STR_TEXT VARCHAR(4096),
PRIMARY KEY (INT_LOGID));

/* Table: TBL_XIMPORTMAP, Owner: NIGEL */
CREATE TABLE TBL_XIMPORTMAP (INT_SESSIONID BIGINT NOT NULL,
        INT_COLUMN BIGINT NOT NULL,
        STR_TABLE VARCHAR(64),
        STR_FIELD VARCHAR(64),
PRIMARY KEY (INT_SESSIONID, INT_COLUMN));

/* Table: TBL_XTAG, Owner: NIGEL */
CREATE TABLE TBL_XTAG (INT_XTAGID BIGINT NOT NULL,
        STR_TAG VARCHAR(32) NOT NULL,
        STR_GROUP VARCHAR(64),
        STR_DESC VARCHAR(256),
        STR_TYPE VARCHAR(16) NOT NULL,
        STR_DEFAULT VARCHAR(64),
        INT_ORDER BIGINT,
PRIMARY KEY (INT_XTAGID),
UNIQUE (STR_TAG));

/* Table: TBL_XTAGVAL, Owner: NIGEL */
CREATE TABLE TBL_XTAGVAL (STR_TABLE VARCHAR(64) NOT NULL,
        STR_FIELD VARCHAR(64) NOT NULL,
        INT_XTAGID BIGINT NOT NULL,
        STR_LANG VARCHAR(3) DEFAULT 'en',
        STR_VALUE VARCHAR(512),
        BLB_VALUE BLOB SUB_TYPE TEXT SEGMENT SIZE 80,
PRIMARY KEY (STR_TABLE, STR_FIELD, INT_XTAGID));

/* Table: TBL_XTRACE, Owner: NIGEL */
CREATE TABLE TBL_XTRACE (INT_TRACEID NUMERIC(18, 0) NOT NULL,
        DTM_STAMP TIMESTAMP default 'now' NOT NULL,
        STR_SESSION VARCHAR(32),
        STR_ENTRY VARCHAR(2048),
PRIMARY KEY (INT_TRACEID));

/* Table: TLKP_ACCTYPE, Owner: NIGEL */
CREATE TABLE TLKP_ACCTYPE (INT_ACCTYPEID BIGINT NOT NULL,
        STR_ACCTYPE VARCHAR(64),
        STR_DESC VARCHAR(256),
        INT_ORDER BIGINT,
        IBL_POSITIVECALC BIGINT,
PRIMARY KEY (INT_ACCTYPEID),
UNIQUE (STR_ACCTYPE));

/* Table: TLKP_ERPSKILL, Owner: NIGEL */
CREATE TABLE TLKP_ERPSKILL (INT_SKILLID BIGINT NOT NULL,
        STR_SKILLGROUP VARCHAR(64),
        STR_SKILL VARCHAR(64),
        STR_DESC VARCHAR(256),
        INT_ORDER BIGINT,
PRIMARY KEY (INT_SKILLID),
UNIQUE (STR_SKILLGROUP, STR_SKILL));

/* Table: TLKP_INVITEMTYPE, Owner: NIGEL */
CREATE TABLE TLKP_INVITEMTYPE (INT_TYPEID BIGINT NOT NULL,
        STR_TYPE VARCHAR(32),
        STR_DESC VARCHAR(128),
PRIMARY KEY (INT_TYPEID));

/* Table: TLKP_INVMANUFACTURER, Owner: NIGEL */
CREATE TABLE TLKP_INVMANUFACTURER (INT_MANUFID BIGINT NOT NULL,
        STR_NAME VARCHAR(64) NOT NULL,
        SDX_NAME VARCHAR(16),
        STR_DESC VARCHAR(512),
        STR_XTRA VARCHAR(512),
        STR_TEMP VARCHAR(56),
PRIMARY KEY (INT_MANUFID));

/* Table: TLKP_INVMANUFMODEL, Owner: NIGEL */
CREATE TABLE TLKP_INVMANUFMODEL (INT_MODELID BIGINT NOT NULL,
        INT_MANUFID BIGINT NOT NULL,
        STR_MODEL VARCHAR(64) NOT NULL,
        SDX_MODEL VARCHAR(16),
        STR_XTRA VARCHAR(32),
        SDX_XTRA VARCHAR(16),
PRIMARY KEY (INT_MODELID, INT_MANUFID));

/* Table: TLKP_LOCALITY, Owner: NIGEL */
CREATE TABLE TLKP_LOCALITY (INT_LOCALITYID BIGINT NOT NULL,
        STR_SUBURB VARCHAR(64),
        STR_STATE VARCHAR(32),
        STR_POSTCODE VARCHAR(16),
PRIMARY KEY (INT_LOCALITYID),
UNIQUE (STR_SUBURB, STR_STATE, STR_POSTCODE));

/* Table: TLKP_TAX, Owner: NIGEL */
CREATE TABLE TLKP_TAX (STR_TAXTYPE VARCHAR(16) NOT NULL,
        FLT_INCTOEXMULT NUMERIC(18, 8),
        FLT_EXTOINCMULT NUMERIC(18, 8),
        STR_NOTES VARCHAR(8196),
PRIMARY KEY (STR_TAXTYPE));

/* Table: TLKP_TTYPE, Owner: NIGEL */
CREATE TABLE TLKP_TTYPE (INT_TTYPEID BIGINT NOT NULL,
        STR_TTYPE VARCHAR(64),
        STR_DESC VARCHAR(256),
        STR_SUMCODE VARCHAR(2),
PRIMARY KEY (INT_TTYPEID),
UNIQUE (STR_TTYPE));

/* Table: TLKP_XCODE_TYPE, Owner: NIGEL */
CREATE TABLE TLKP_XCODE_TYPE (INT_TYPEID BIGINT NOT NULL,
        STR_TYPE VARCHAR(32),
        STR_DESC VARCHAR(256),
        INT_ORDER BIGINT,
PRIMARY KEY (INT_TYPEID),
UNIQUE (STR_TYPE));

/* Table: TLNK_APPUSER, Owner: NIGEL */
CREATE TABLE TLNK_APPUSER (INT_USERID BIGINT NOT NULL,
        INT_APPID BIGINT NOT NULL,
        STR_APPUSERID BIGINT,
        STR_APPUSERNAME VARCHAR(64),
PRIMARY KEY (INT_USERID, INT_APPID));

/* Table: TLNK_CONTACTSKILL, Owner: NIGEL */
CREATE TABLE TLNK_CONTACTSKILL (INT_CONTACTID BIGINT NOT NULL,
        INT_SKILLID BIGINT NOT NULL,
PRIMARY KEY (INT_SKILLID, INT_CONTACTID));

/* Table: TLNK_DOCREGTRANS, Owner: NIGEL */
CREATE TABLE TLNK_DOCREGTRANS (IBL_ACTIVE BIGINT default 1,
        INT_DOCID NUMERIC(18, 0) NOT NULL,
        INT_TRANSID NUMERIC(18, 0) NOT NULL,
        INT_POSX BIGINT,
        INT_POSY BIGINT,
        STR_NOTES VARCHAR(1024),
CONSTRAINT PK_DRT_DT PRIMARY KEY (INT_DOCID, INT_TRANSID));

/* Table: TLNK_INVITEMPRICE, Owner: NIGEL */
CREATE TABLE TLNK_INVITEMPRICE (INT_PRICEID NUMERIC(18, 0) NOT NULL,
        INT_ITEMID BIGINT NOT NULL,
        STR_UNIT VARCHAR(32),
        DTE_PRICE DATE,
        TME_PRICE TIME,
        INT_MINQTY NUMERIC(18, 4),
        INT_MAXQTY NUMERIC(18, 4),
        FLT_PRICE NUMERIC(18, 6),
        STR_DESC VARCHAR(256),
PRIMARY KEY (INT_PRICEID),
UNIQUE (INT_PRICEID, INT_ITEMID, STR_UNIT));

/* Table: TLNK_INVOICEITEMS, Owner: NIGEL */
CREATE TABLE TLNK_INVOICEITEMS (INT_INVOICEID BIGINT NOT NULL,
        INT_TRANSID BIGINT NOT NULL,
        DTM_STAMP TIMESTAMP default 'now');

/* Table: TLNK_ROLEOPTION, Owner: NIGEL */
CREATE TABLE TLNK_ROLEOPTION (INT_ROLEID BIGINT NOT NULL,
        INT_OPTIONID BIGINT NOT NULL,
PRIMARY KEY (INT_ROLEID, INT_OPTIONID));

/* Table: TLNK_ROLESECTION, Owner: NIGEL */
CREATE TABLE TLNK_ROLESECTION (INT_ROLEID BIGINT NOT NULL,
        INT_SECTIONID BIGINT NOT NULL,
PRIMARY KEY (INT_ROLEID, INT_SECTIONID));

/* Table: TLNK_ROLEXCODE, Owner: NIGEL */
CREATE TABLE TLNK_ROLEXCODE (INT_ROLEID BIGINT NOT NULL,
        STR_XCODE VARCHAR(64) NOT NULL,
PRIMARY KEY (INT_ROLEID, STR_XCODE));

/* Table: TLNK_USERROLE, Owner: NIGEL */
CREATE TABLE TLNK_USERROLE (INT_USERID BIGINT NOT NULL,
        INT_ROLEID BIGINT NOT NULL,
PRIMARY KEY (INT_USERID, INT_ROLEID));

/*  Index definitions for all user tables */
CREATE INDEX IND_INV_NAME ON TBL_INVITEM (STR_NAME);
CREATE INDEX IND_INV_UPC ON TBL_INVITEM (STR_UPCBARCODE);
CREATE INDEX IND_OPTION_GROUP ON TBL_OPTION (STR_GROUP);
CREATE INDEX IND_OPTION_ORDER ON TBL_OPTION (INT_ORDER);
CREATE DESCENDING INDEX IND_XCODE_MODTIME ON TBL_XCODE (DTM_MODTIME);
CREATE INDEX IND_XCODE_XCODE ON TBL_XCODE (STR_XCODE);

ALTER TABLE TBL_ACCOUNT ADD CONSTRAINT FK_ACCTYPE FOREIGN KEY (INT_ACCTYPEID) REFERENCES TLKP_ACCTYPE (INT_ACCTYPEID);

ALTER TABLE TBL_ACCOUNT ADD FOREIGN KEY (INT_OWNERID) REFERENCES TBL_USER (INT_USERID);

ALTER TABLE TBL_ACCOUNT ADD FOREIGN KEY (INT_CHILDOF) REFERENCES TBL_ACCOUNT (INT_ACCOUNTID);

ALTER TABLE TBL_CONTACT ADD FOREIGN KEY (INT_LOCALITY) REFERENCES TLKP_LOCALITY (INT_LOCALITYID);

ALTER TABLE TBL_HISTORY ADD FOREIGN KEY (INT_USERID) REFERENCES TBL_USER (INT_USERID);

ALTER TABLE TBL_INVITEM ADD FOREIGN KEY (INT_OWNERID) REFERENCES TBL_USER (INT_USERID);

ALTER TABLE TBL_INVITEM ADD FOREIGN KEY (INT_TYPEID) REFERENCES TLKP_INVITEMTYPE (INT_TYPEID);

ALTER TABLE TBL_INVITEM ADD FOREIGN KEY (INT_MODELID, INT_MANUFID) REFERENCES TLKP_INVMANUFMODEL (INT_MODELID, INT_MANUFID);

ALTER TABLE TBL_OPTION ADD FOREIGN KEY (INT_CHILDOF) REFERENCES TBL_OPTION (INT_OPTIONID);

ALTER TABLE TBL_OPTION ADD FOREIGN KEY (INT_SECTIONID) REFERENCES TBL_SECTION (INT_SECTIONID);

ALTER TABLE TBL_SCHEDULE ADD FOREIGN KEY (INT_TASKID) REFERENCES TBL_TASK (INT_TASKID);

ALTER TABLE TBL_SCHEDULE ADD FOREIGN KEY (INT_USERID) REFERENCES TBL_USER (INT_USERID);

ALTER TABLE TBL_TASK ADD CONSTRAINT FK_CONTACT FOREIGN KEY (INT_CONTACTID) REFERENCES TBL_CONTACT (INT_CONTACTID);

ALTER TABLE TBL_TASK ADD FOREIGN KEY (INT_CREATEDBY) REFERENCES TBL_USER (INT_USERID);

ALTER TABLE TBL_TASK ADD FOREIGN KEY (INT_CREATEDFOR) REFERENCES TBL_USER (INT_USERID);

ALTER TABLE TBL_TASKALLOC ADD FOREIGN KEY (INT_TASKID) REFERENCES TBL_TASK (INT_TASKID) ON UPDATE CASCADE;

ALTER TABLE TBL_TASKALLOC ADD FOREIGN KEY (INT_USERID) REFERENCES TBL_USER (INT_USERID) ON UPDATE CASCADE;

ALTER TABLE TBL_TASKEVENT ADD FOREIGN KEY (INT_TASKID) REFERENCES TBL_TASK (INT_TASKID);

ALTER TABLE TBL_TASKEVENT ADD FOREIGN KEY (INT_USERID) REFERENCES TBL_USER (INT_USERID);

ALTER TABLE TBL_TASKNOTES ADD FOREIGN KEY (INT_TASKID) REFERENCES TBL_TASK (INT_TASKID) ON UPDATE CASCADE;

ALTER TABLE TBL_TIMESHEET ADD FOREIGN KEY (INT_USERID) REFERENCES TBL_USER (INT_USERID);

ALTER TABLE TBL_TIMESHEET ADD FOREIGN KEY (INT_TASKID) REFERENCES TBL_TASK (INT_TASKID);

ALTER TABLE TBL_TRANSACTION ADD CONSTRAINT FK_TRANS_CONTACT FOREIGN KEY (INT_CONTACTID) REFERENCES TBL_CONTACT (INT_CONTACTID);

ALTER TABLE TBL_TRANSACTION ADD FOREIGN KEY (INT_TTYPEID) REFERENCES TLKP_TTYPE (INT_TTYPEID);

ALTER TABLE TBL_TRANSACTION ADD FOREIGN KEY (INT_ACCOUNTID) REFERENCES TBL_ACCOUNT (INT_ACCOUNTID);

ALTER TABLE TBL_TRANSACTION ADD FOREIGN KEY (INT_USERID) REFERENCES TBL_USER (INT_USERID);

ALTER TABLE TBL_TRANSACTION ADD FOREIGN KEY (INT_CHILDOF) REFERENCES TBL_TRANSACTION (INT_TRANSID);

ALTER TABLE TBL_TRANSACTION ADD FOREIGN KEY (INT_INVITEMID) REFERENCES TBL_INVITEM (INT_ITEMID);

ALTER TABLE TBL_TRANSACTION ADD FOREIGN KEY (INT_SERVITEMID) REFERENCES TBL_SERVICEITEM (INT_SERVITEMID);

ALTER TABLE TBL_XCODE ADD CONSTRAINT FK_TYPE FOREIGN KEY (INT_TYPEID) REFERENCES TLKP_XCODE_TYPE (INT_TYPEID);

ALTER TABLE TBL_XCODE ADD FOREIGN KEY (INT_LASTEDITOR) REFERENCES TBL_USER (INT_USERID);

ALTER TABLE TBL_XIMPORTLOG ADD FOREIGN KEY (INT_SESSIONID) REFERENCES TBL_XIMPORT (INT_SESSIONID);

ALTER TABLE TBL_XIMPORTMAP ADD FOREIGN KEY (INT_SESSIONID) REFERENCES TBL_XIMPORT (INT_SESSIONID);

ALTER TABLE TBL_XTAGVAL ADD FOREIGN KEY (INT_XTAGID) REFERENCES TBL_XTAG (INT_XTAGID);

ALTER TABLE TLKP_INVMANUFMODEL ADD FOREIGN KEY (INT_MANUFID) REFERENCES TLKP_INVMANUFACTURER (INT_MANUFID);

ALTER TABLE TLNK_APPUSER ADD FOREIGN KEY (INT_USERID) REFERENCES TBL_USER (INT_USERID);

ALTER TABLE TLNK_APPUSER ADD FOREIGN KEY (INT_APPID) REFERENCES TBL_APP (INT_APPID);

ALTER TABLE TLNK_CONTACTSKILL ADD FOREIGN KEY (INT_SKILLID) REFERENCES TLKP_ERPSKILL (INT_SKILLID);

ALTER TABLE TLNK_CONTACTSKILL ADD FOREIGN KEY (INT_CONTACTID) REFERENCES TBL_CONTACT (INT_CONTACTID);

ALTER TABLE TLNK_DOCREGTRANS ADD CONSTRAINT FK_DRT_T FOREIGN KEY (INT_DOCID) REFERENCES TBL_DOCREGISTER (INT_DOCID);

ALTER TABLE TLNK_INVITEMPRICE ADD CONSTRAINT FK_ITEM_PRICE FOREIGN KEY (INT_ITEMID) REFERENCES TBL_INVITEM (INT_ITEMID);

ALTER TABLE TLNK_INVOICEITEMS ADD CONSTRAINT FK_TII_TRANSID FOREIGN KEY (INT_TRANSID) REFERENCES TBL_TRANSACTION (INT_TRANSID);

ALTER TABLE TLNK_ROLEOPTION ADD FOREIGN KEY (INT_ROLEID) REFERENCES TBL_ROLE (INT_ROLEID);

ALTER TABLE TLNK_ROLEOPTION ADD FOREIGN KEY (INT_OPTIONID) REFERENCES TBL_OPTION (INT_OPTIONID);

ALTER TABLE TLNK_ROLESECTION ADD FOREIGN KEY (INT_SECTIONID) REFERENCES TBL_SECTION (INT_SECTIONID);

ALTER TABLE TLNK_ROLESECTION ADD FOREIGN KEY (INT_ROLEID) REFERENCES TBL_ROLE (INT_ROLEID);

ALTER TABLE TLNK_ROLEXCODE ADD FOREIGN KEY (INT_ROLEID) REFERENCES TBL_ROLE (INT_ROLEID);

ALTER TABLE TLNK_USERROLE ADD FOREIGN KEY (INT_USERID) REFERENCES TBL_USER (INT_USERID);

ALTER TABLE TLNK_USERROLE ADD FOREIGN KEY (INT_ROLEID) REFERENCES TBL_ROLE (INT_ROLEID);
SET TERM ^ ;

/* Triggers only will work for SQL triggers */
CREATE TRIGGER MMK$APP FOR TBL_APP 
ACTIVE BEFORE INSERT OR UPDATE OR DELETE POSITION 100 
AS
    DECLARE VARIABLE str_logging VARCHAR(1024);
  BEGIN

    IF ( CURRENT_USER = 'replication' ) THEN
    BEGIN
      str_logging = 'DEBUG:  MMK$APP launched as replication. Skipping active section.';
    END
    ELSE
    BEGIN
      str_logging = 'DEBUG:  MMK$APP launched as a normal user';
      /* ----------------------------------------------
       * Put all your active section from this point on
       * ----------------------------------------------
       */





      /* ----------------------------------------------
       * End of Active Trigger Section
       * ----------------------------------------------
       */
    END
      /* Write the logging field to the log file */
      insert into tbl_log(str_log) values (:str_logging);
  END ^

CREATE TRIGGER TRG_TRANSACTION_TAX FOR TBL_TRANSACTION 
ACTIVE BEFORE INSERT OR UPDATE POSITION 0 
AS 
  DECLARE VARIABLE flt_price NUMERIC(18,6);
  DECLARE VARIABLE flt_pretax NUMERIC(18,4);
  DECLARE VARIABLE flt_taxadj NUMERIC(18,4);
  DECLARE VARIABLE str_taxiefc VARCHAR(1);
BEGIN
  /* -----------------------
   * Handling Stock or Inventory items, and
   * adjusting price accordingly
   * -----------------------
   */


  if(NEW.str_taxiefc is not null)THEN
  BEGIN
    NEW.str_taxiefc = upper(NEW.str_taxiefc);
  END

 if(NEW.str_taxtype IS NOT NULL) THEN
  BEGIN
    NEW.str_taxtype = upper(NEW.str_taxtype);
  END

  if(NEW.flt_taxamt IS NULL)THEN
    NEW.flt_taxamt = 0;


  /* If it's an inventory item, get the matching price for it */
  if (NEW.int_INVITEMID != 0 AND NEW.INT_INVITEMID IS NOT NULL) THEN
  BEGIN
    /* Get the value of the item */
    select first 1 flt_price
    from tlnk_invitemprice
    WHERE int_itemid = NEW.int_invitemid
    AND dte_price <= 'now'
    AND tme_price <= 'now'
    AND (int_maxqty >= NEW.int_invitemid OR int_maxqty = 0)
    ORDER BY dte_price desc, tme_price desc
    INTO :flt_price;

  END



  if(NEW.int_servitemid != 0 AND NEW.int_servitemid IS NOT NULL) THEN
  BEGIN
    /* A Service amount has been provided. Go get the amount */
    SELECT first 1 flt_price, str_taxiefc
    FROM tbl_serviceitem
    WHERE int_servitemid = NEW.int_servitemid
    INTO :flt_price, :str_taxiefc;

 /*
  * NEW.str_DESC = NEW.str_desc || ' %%ServItemPrice:$' || :flt_price || ', TaxIEFC: ' || :str_taxiefc || '.';
  */
   


    /* Service Items default to Tax Exclusive */
    if(:str_taxiefc IS NULL OR :str_taxiefc = '') THEN
    BEGIN
   /*   NEW.str_DESC = NEW.str_desc || '  TaxIEFC defaulted to E';*/
      str_taxiefc = 'E';
    END

    /* Allow NEW taxiefc's to override the one from serviceitem */
    if(NEW.str_taxiefc IS NULL OR NEW.str_taxiefc = '') THEN
    BEGIN
      /* NEW.str_DESC = NEW.str_desc || ' %%Allowing Default IEFC of ' || :str_taxiefc; */
      NEW.str_taxiefc = :str_taxiefc;
    END
    ELSE
    BEGIN
      /* NEW.str_DESC = NEW.str_desc || ' %%Allowing Override IEFC of ' || NEW.str_taxiefc;*/


    END
    
  END

  /* -------------------------
   *   B O R D E R   C A S E S
   *
   * Service Items can have a Zero value,
   * But allow a value to be specified in tbl_transaction.flt_amount
   *
   * Stock Items have to have a value, and Qty is used to derive value
   *
   * -------------------------
   */


  /* Service Item, No set price, and a quantity */
  if(
    (NEW.int_servitemid != 0 
    AND NEW.int_servitemid IS NOT NULL)
  AND
    (:flt_price = 0 AND :flt_price IS NOT NULL)
  ) THEN
  BEGIN
    /* Zero-value Service Item detected.
     * Use flt_amount * int_qty to establish
     * Transaction amount
     */
    NEW.flt_amount = NEW.flt_amount * NEW.int_qty;
  END



  /* Service Item, Service Set Price, and Quantity */
  if(
    (NEW.int_servitemid != 0
    AND NEW.int_servitemid IS NOT NULL)
  AND
    (:flt_price != 0 AND :flt_price IS NOT NULL)
  ) THEN
  BEGIN
    /* Standard Service Item Price detected
     * Service Value * Qty
     */
    NEW.flt_amount = :flt_price * NEW.int_qty;
  END


  /* Inventory Item, Inventory Price, and qty */
  if (NEW.int_INVITEMID != 0 
  AND NEW.INT_INVITEMID IS NOT NULL
  AND :flt_price IS NOT NULL
  ) THEN
  BEGIN
    /* Inventory Item Handler */
    NEW.flt_amount = :flt_price * NEW.int_qty;
  END



  /* ---------------------------
   * Tax Slicing
   *
   * This will be smarter, but for now,
   * We slice 10% off if it's GST Tax, and adjust amounts
   * ---------------------------
   */


  flt_pretax = NEW.flt_amount;

  if(upper(NEW.str_taxtype) = 'GST' AND NEW.str_taxiefc = 'E') THEN
  BEGIN
    NEW.flt_taxamt = (NEW.flt_amount / 10);
  END

  if(upper(NEW.str_taxtype) = 'GST' AND NEW.str_taxiefc = 'I') THEN
  BEGIN
    flt_taxadj = 0;
    NEW.flt_taxamt = (NEW.flt_amount / 11);
    NEW.flt_amount = (NEW.flt_amount - NEW.flt_taxamt); 
    while(NEW.flt_amount + NEW.flt_taxamt + :flt_taxadj < :flt_pretax) DO
    BEGIN 
      flt_taxadj = (:flt_taxadj + 0.0001);
    END
    if(:flt_taxadj > 0.0001) THEN
    BEGIN
      NEW.flt_taxamt = (NEW.flt_taxamt + :flt_taxadj);
      /* NEW.str_DESC = NEW.str_desc || ' (Tax Rounding: $' || :flt_taxadj || ')';*/
    END
    /* NEW.str_DESC = NEW.str_desc || '  %%IEFC changed to System Default of E'; */
    NEW.str_taxiefc = 'E';
  END



END ^

COMMIT WORK ^
SET TERM ; ^

/* Comments for database objects. */
COMMENT ON EXTERNAL FUNCTION SUBSTR IS '';

/*

in tbl_invsiteitemqty.sql
*/
