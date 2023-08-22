/* MOD_OKENA 
Okena is an enterprise class CRM + ERP module for OpenAspect
Now, it's a CRM module only - ERP was split out, and into site resources, and HR resources


All tables, procedures, triggers, generators for the crm part of mod_mcrm are to be prepended with:
mcrm_*

User table is inherited from mod_user OA module
#
# $Id: modcrm.sql,v 1.28 2004/08/30 23:41:55 nweeks Exp nweeks $
#
# $Log: modcrm.sql,v $
# Revision 1.28  2004/08/30 23:41:55  nweeks
# Rejigged addresses into a direct linktable between contact and addrtype
# Saves on admin
#
# Revision 1.27  2004/08/30 23:37:52  nweeks
# Added indexes for searching
#
# Revision 1.26  2004/07/11 23:13:25  nigel
# Rolled out the new boolean type (ibl_)
#
# Revision 1.25  2004/07/08 23:47:40  nigel
# Various changes
#
# Revision 1.24  2004/05/18 01:28:57  nigel
# Moved publications out to their own module: mod_pub
#
# Revision 1.23  2004/05/11 02:07:50  nigel
# Additions to cater for publications, and subscriptions
#
# Revision 1.22  2004/04/29 03:11:24  nigel
# Broke apart tbl_contact a little differently.
# Enables CM to produce a better screen automatically
#
# Revision 1.21  2004/04/20 03:24:26  nigel
# Fixed tbl_contgroup
#
# Revision 1.20  2004/04/20 02:32:53  nigel
# A few changes
#
# Revision 1.19  2004/04/20 02:05:46  nigel
# Fixed more unique constraints
# Need to be site-wide, not worldwide.
#
# Revision 1.18  2004/04/20 01:56:54  nigel
# Hooked up dealtypes
#
# Revision 1.17  2004/01/12 22:48:35  nigel
# Added a few generators that were missing
#
# Revision 1.16  2004/01/06 22:32:18  nigel
# Fixed a build message
#
# Revision 1.15  2004/01/06 22:23:32  nigel
# Fixed a bug
#
# Revision 1.14  2004/01/06 22:16:47  nigel
# Fixed build comments
#
# Revision 1.13  2003/12/16 04:43:24  nigel
# Fixed Ref Integ for Pipelining
# There may be further changes here...dunno yet.
#
# Revision 1.12  2003/12/16 04:35:59  nigel
# Added pipelining support
#
# Revision 1.11  2003/11/11 23:25:19  nigel
# Fixed build messages
#
# Revision 1.10  2003/11/10 10:03:12  nigel
# Removed license: included from elsewhere
#
# Revision 1.9  2003/11/10 06:33:46  nigel
# Further tables work
#
# Revision 1.8  2003/11/07 02:45:00  nigel
# Added referential integrity to already existing tables
#
# Revision 1.7  2003/10/09 23:36:41  nigel
# Changed INT64 to BIGINT
#
# Revision 1.6  2003/09/30 00:42:57  nigel
# Updated license
#
# Revision 1.5  2003/09/30 00:42:28  nigel
# Updated license
#
# Revision 1.4  2003/09/17 23:12:55  nigel
# Updated Copyright notice
#
# Revision 1.3  2003/09/17 23:00:22  nigel
# Added Changelog lines.
#
#
*/

/* ========================
CRM - (Customer Relationship Management) Specific Tables
Opportunity and lead support: Finding and managing leads and opportunities
Contact Management: Creating and keeping customers. Personal and business info.
Sales: Evolution of a lead into a sale, then to a closed sale
Competition Watchdog: Lead Origin tracking, and competition for the customer
Sales Force: Quotas, performance indiciators, commissions
Quoting: Salesperson can easily get the right price to the customer quickly
Sales order and Invoicing: Managing quotes, order, sales, returns, etc
Activity: Email, phone calls, faxes, letters, tasks and appointments
======================== */

/* ===============================
Possible tables(far too many actually. Only implement the ones we need) 
account
activity
activity party
business unit
business unit news article
communications:(appointment,chat,email,fax,letter,phone,order,quote,incident,incidentresolution,order close,quote close,opportunity close,failed communications(bad address, etc))
competitor info:(address,contact details,revenue report)
contacts:(name,address,contact methods, preffered cont. method,banned cont. method)
sales:(discount, discount type, contract, contract detail, contract template, invoice, invoice detail, literature, literature item, order, order detail, order close) 

Publications/Literature
Subscribers to Publications/Literature
Quotes and Orders
Delivery lists for subscribers to publications(Logistics Hooks)
=============================== */

/* =================
  LOOKUP TABLES
================= */
/* Contact Types
Account holder, lead, client, competitor,
employee, organization, user, team, etc.
*/
SELECT 'Contact Types Lookup (mcrm_tlkp_conttype)' from rdb$database;
CREATE TABLE mcrm_tlkp_conttype (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_conttypeid INTEGER NOT NULL,
  str_conttype VARCHAR(50) NOT NULL,
  str_desc VARCHAR(300),
    PRIMARY KEY(int_siteid,int_conttypeid),
    UNIQUE (int_siteid, str_conttype)
);
CREATE GENERATOR GEN_MCRM_TLKP_CONTTYPE;

INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'Personal');
INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'Advertising');
INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'Accounting');
INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'Construction');
INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'Civil Engineering');
INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'Subscriber');
INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'Sub-Contractor');
INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'Suppplier');
INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'Transport');
INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'Government');
INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'Education');
INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'Health');
INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'IT Suppliers');
INSERT INTO mcrm_tlkp_conttype (int_siteid,int_conttypeid,str_conttype)
VALUES (1,gen_id(gen_mcrm_tlkp_conttype,1),'Telecommunications');

SET GENERATOR gen_mcrm_tlkp_conttype to 1000;

/* Contact Tags
This table stores what JSON-style tags to store for a type of contact
Supplier->Default PO account
Customer->Default payment terms
*/
select 'Contact Tags (mcrm_tlkp_conttag)' from rdb$database;
CREATE TABLE mcrm_tlkp_conttags (
 int_siteid INTEGER NOT NULL, /* Replication support */
 dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
 int_tagid INTEGER NOT NULL, /* The id of the Tag */
 int_conttypeid INTEGER NOT NULL, /* References mcrm_tlkp_conttype */
 str_tag VARCHAR(100) NOT NULL, /* The text of the tag */
 str_fmt VARCHAR(10) default 'txt', /* The format of the value */
    PRIMARY KEY(int_siteid, int_conttype, int_tagid),
    UNIQUE (int_siteid, str_tagid),
    FOREIGN KEY(int_siteid, int_conttypeid) REFERENCES mcrm_tlkp_conttype (int_siteid, int_conttypeid) ON UPDATE CASCADE
);
CREATE GENERATOR gen_mcrm_tlkp_conttag;


/* Address Types
Home, Work, Billing, Postal, Delivery, etc.
*/
SELECT 'Address Types Lookup Table (mcrm_tlkp_addrtype)' from rdb$database;
CREATE TABLE mcrm_tlkp_addrtype (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_addrtypeid BIGINT NOT NULL,
  str_addrtype VARCHAR(50) NOT NULL,
    PRIMARY KEY(int_siteid, int_addrtype),
    UNIQUE (int_siteid, str_addrtype)
);
CREATE GENERATOR GEN_MCRM_TLKP_ADDRTYPE;

INSERT INTO mcrm_tlkp_addrtype (int_siteid, int_addrtype, str_addrtype)
VALUES (1,gen_id(GEN_MCRM_TLKP_ADDRTYPE,1),'Home');
INSERT INTO mcrm_tlkp_addrtype (int_siteid, int_addrtype, str_addrtype)
VALUES (1,gen_id(GEN_MCRM_TLKP_ADDRTYPE,1),'Work');
INSERT INTO mcrm_tlkp_addrtype (int_siteid, int_addrtype, str_addrtype)
VALUES (1,gen_id(GEN_MCRM_TLKP_ADDRTYPE,1),'Holiday');
INSERT INTO mcrm_tlkp_addrtype (int_siteid, int_addrtype, str_addrtype)
VALUES (1,gen_id(GEN_MCRM_TLKP_ADDRTYPE,1),'Billing');
INSERT INTO mcrm_tlkp_addrtype (int_siteid, int_addrtype, str_addrtype)
VALUES (1,gen_id(GEN_MCRM_TLKP_ADDRTYPE,1),'Postal');
INSERT INTO mcrm_tlkp_addrtype (int_siteid, int_addrtype, str_addrtype)
VALUES (1,gen_id(GEN_MCRM_TLKP_ADDRTYPE,1),'Delivery');
SET GENERATOR gen_mcrm_tlkp_addrtype to 1000;

/* Phone/Email Types
Home, Work, mobile, private, international, parent, sibling, childs, etc
*/
SELECT 'Phone/Email Types (mcrm_tlkp_phomailtypes)' from rdb$database;
CREATE TABLE mcrm_tlkp_phomailtype (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_phomailtype BIGINT NOT NULL,
  str_usedfortype VARCHAR(1) DEFAULT 'P' NOT NULL, /* P:phone,E:email,F:fax */
  str_phomailtype VARCHAR(50) NOT NULL, /* Home, Work, Private, etc */
    PRIMARY KEY(int_siteid, int_phomailtype),
    UNIQUE (int_siteid, str_phomailtype)
);
CREATE GENERATOR GEN_MCRM_TLKP_PHOMAILTYPE;

INSERT INTO mcrm_tlkp_phomailtype (int_siteid,int_phomailtype,str_usedfortype,str_phomailtype)
VALUES (1,gen_id(gen_mcrm_tlkp_phomailtype,1),'P','Home No.');
INSERT INTO mcrm_tlkp_phomailtype (int_siteid,int_phomailtype,str_usedfortype,str_phomailtype)
VALUES (1,gen_id(gen_mcrm_tlkp_phomailtype,1),'P','Extension No.');
INSERT INTO mcrm_tlkp_phomailtype (int_siteid,int_phomailtype,str_usedfortype,str_phomailtype)
VALUES (1,gen_id(gen_mcrm_tlkp_phomailtype,1),'P','Work No.');
INSERT INTO mcrm_tlkp_phomailtype (int_siteid,int_phomailtype,str_usedfortype,str_phomailtype)
VALUES (1,gen_id(gen_mcrm_tlkp_phomailtype,1),'P','Mobile No.');
INSERT INTO mcrm_tlkp_phomailtype (int_siteid,int_phomailtype,str_usedfortype,str_phomailtype)
VALUES (1,gen_id(gen_mcrm_tlkp_phomailtype,1),'P','Private No.');
INSERT INTO mcrm_tlkp_phomailtype (int_siteid,int_phomailtype,str_usedfortype,str_phomailtype)
VALUES (1,gen_id(gen_mcrm_tlkp_phomailtype,1),'P','Next of Kin No.');
INSERT INTO mcrm_tlkp_phomailtype (int_siteid,int_phomailtype,str_usedfortype,str_phomailtype)
VALUES (1,gen_id(gen_mcrm_tlkp_phomailtype,1),'E','Home Email');
INSERT INTO mcrm_tlkp_phomailtype (int_siteid,int_phomailtype,str_usedfortype,str_phomailtype)
VALUES (1,gen_id(gen_mcrm_tlkp_phomailtype,1),'E','Work Email');
INSERT INTO mcrm_tlkp_phomailtype (int_siteid,int_phomailtype,str_usedfortype,str_phomailtype)
VALUES (1,gen_id(gen_mcrm_tlkp_phomailtype,1),'E','Private Email');
INSERT INTO mcrm_tlkp_phomailtype (int_siteid,int_phomailtype,str_usedfortype,str_phomailtype)
VALUES (1,gen_id(gen_mcrm_tlkp_phomailtype,1),'E','Overseas Email');
INSERT INTO mcrm_tlkp_phomailtype (int_siteid,int_phomailtype,str_usedfortype,str_phomailtype)
VALUES (1,gen_id(gen_mcrm_tlkp_phomailtype,1),'F','Work Fax No.');
INSERT INTO mcrm_tlkp_phomailtype (int_siteid,int_phomailtype,str_usedfortype,str_phomailtype)
VALUES (1,gen_id(gen_mcrm_tlkp_phomailtype,1),'E','Home Fax No.');
INSERT INTO mcrm_tlkp_phomailtype (int_siteid,int_phomailtype,str_usedfortype,str_phomailtype)
VALUES (1,gen_id(gen_mcrm_tlkp_phomailtype,1),'E','Private Fax No.');

SET GENERATOR gen_mcrm_tlkp_phomailtype to 1000;

/* 
  Priority Table
*/
SELECT 'Priority Lookup Table (mcrm_tlkp_priority)' from rdb$database;
CREATE TABLE mcrm_tlkp_priority(
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_priority BIGINT NOT NULL,
  str_priority VARCHAR(50) NOT NULL,
  str_desc VARCHAR(1000),
    PRIMARY KEY(int_siteid, int_priority),
    UNIQUE (int_siteid, str_priority)
);
CREATE GENERATOR gen_mcrm_tlkp_priority;


/* 
  Status Table
*/
select 'Status Lookup Table (mcrm_tlkp_status)' from rdb$database;
CREATE TABLE mcrm_tlkp_status (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_status BIGINT NOT NULL,
  str_status VARCHAR(50) NOT NULL,
  str_desc VARCHAR(1000),
    PRIMARY KEY(int_siteid, int_status),
    UNIQUE(int_siteid, str_status)
);
CREATE GENERATOR gen_mcrm_tlkp_status;


/* 
  Resolution Table
  How a dealing was resolved/closed
*/
select 'Resolution Lookup Table (mcrm_tlkp_resolution)' from rdb$database;
CREATE TABLE mcrm_tlkp_resolution (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_resolution BIGINT NOT NULL,
  str_resolution VARCHAR(50) NOT NULL,
  str_desc VARCHAR(1000),
    PRIMARY KEY(int_siteid, int_resolution),
    UNIQUE (int_siteid, str_resolution)
);
CREATE GENERATOR gen_mcrm_tlkp_resolution;


/* 
   Dealing Types Table
  What kind of dealing is this
*/
select 'Dealing Type Lookup Table (mcrm_tlkp_dealtype)' from rdb$database;
CREATE TABLE mcrm_tlkp_dealtype (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_dealtype BIGINT NOT NULL,
  str_dealtype VARCHAR(50) NOT NULL,
  str_desc VARCHAR(1000),
    PRIMARY KEY(int_siteid, int_dealtype),
    UNIQUE (int_siteid, str_dealtype)
);
CREATE GENERATOR gen_mcrm_tlkp_dealtype;

INSERT INTO mcrm_tlkp_dealtype (int_siteid, int_dealtype, str_dealtype)
VALUES (1,GEN_ID(gen_mcrm_tlkp_dealtype,1),'Initial Phone Call');
INSERT INTO mcrm_tlkp_dealtype (int_siteid, int_dealtype, str_dealtype)
VALUES (1,GEN_ID(gen_mcrm_tlkp_dealtype,1),'FollowUp Phone Call');
INSERT INTO mcrm_tlkp_dealtype (int_siteid, int_dealtype, str_dealtype)
VALUES (1,GEN_ID(gen_mcrm_tlkp_dealtype,1),'Initial Letter');
INSERT INTO mcrm_tlkp_dealtype (int_siteid, int_dealtype, str_dealtype)
VALUES (1,GEN_ID(gen_mcrm_tlkp_dealtype,1),'Followup Letter');
INSERT INTO mcrm_tlkp_dealtype (int_siteid, int_dealtype, str_dealtype)
VALUES (1,GEN_ID(gen_mcrm_tlkp_dealtype,1),'Initial Email');
INSERT INTO mcrm_tlkp_dealtype (int_siteid, int_dealtype, str_dealtype)
VALUES (1,GEN_ID(gen_mcrm_tlkp_dealtype,1),'FollowUp Email');
INSERT INTO mcrm_tlkp_dealtype (int_siteid, int_dealtype, str_dealtype)
VALUES (1,GEN_ID(gen_mcrm_tlkp_dealtype,1),'Initial Meeting');
INSERT INTO mcrm_tlkp_dealtype (int_siteid, int_dealtype, str_dealtype)
VALUES (1,GEN_ID(gen_mcrm_tlkp_dealtype,1),'FollowUp Meeting');

SET GENERATOR gen_mcrm_tlkp_dealtype to 1000;

/*
  Region/Location Table
  Pricing and deals might be dependent on location
*/
select 'Region Table (mcrm_tlkp_region)' from rdb$database;
CREATE TABLE mcrm_tlkp_region (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_region BIGINT NOT NULL,
  str_region VARCHAR(100) NOT NULL,
  str_desc VARCHAR(1000),
  flt_discount NUMERIC(18,2), /* Default discount for this region */
    PRIMARY KEY(int_siteid, int_region),
    UNIQUE (int_siteid, str_region)
);

/* Contact Groups
Set up a set of contact groups, for mailouts, marketing, etc
The unique constraint on int_siteid, and str_group, is to allow a 'waiting for approval before purchase' group on every site.
*/
SELECT 'Contact Groups (mcrm_tlkp_contgroup)' from rdb$database;
CREATE TABLE mcrm_tlkp_contgroup (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_group BIGINT NOT NULL, /* The Group's unique ID */
  str_group VARCHAR(100) NOT NULL, /* Name of the group */
  str_desc VARCHAR(1000), /* A brief description */
  str_notes VARCHAR(5000), /* Notes about the Group */
    PRIMARY KEY (int_siteid, int_group),
    UNIQUE (int_siteid, str_group)
);
CREATE GENERATOR GEN_MCRM_TBL_CONTGROUP;


/* Deal Pipelining
 - guide or 'script' the dealings through to a sale
Elaborate Pipeline Flow (All possible pipeline steps):
Lead -> Pre approach -> Interview(first) -> Opportunity Analysis -> Determine Solution -> Solution Proposal/Recommendation -> Interview(subsequent) -> Solution Development -> Solution Presentation -> Customer Evaluation -> Interview(Negotiation) -> Commitment to buy -> Solution Delivery -> Follow up -> Sales Recommendation
*/
SELECT 'Dealings Pipeline (mcrm_tlkp_pipeline)' from rdb$database;
CREATE TABLE mcrm_tlkp_pipeline (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_pipeline BIGINT NOT NULL,
  str_pipename VARCHAR(150) NOT NULL,
  str_pipedesc VARCHAR(2000), /* Describe this pipeline */
    PRIMARY KEY(int_siteid,int_pipeline),
    UNIQUE(int_siteid, str_pipename)
);
CREATE GENERATOR GEN_MCRM_TLKP_PIPELINE;
INSERT INTO mcrm_tlkp_pipeline (int_siteid, int_pipeline,str_pipename,str_pipedesc)
values (1,gen_id(gen_mcrm_tlkp_pipeline,1),'General Sales','Use this one for normal sales');

/* Store the structure of the pipeline */
SELECT 'Dealing Pipeline Steps (mcrm_tbl_pipesteps)' from rdb$database;
CREATE TABLE mcrm_tlkp_pipesteps (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_pipestep BIGINT NOT NULL,
  int_pipeline BIGINT NOT NULL,
  int_prev INTEGER,
  str_name VARCHAR(100) NOT NULL,
  str_stepdesc VARCHAR(2000), /* Describe this step */
    PRIMARY KEY(int_siteid,int_pipestep),
    FOREIGN KEY(int_siteid,int_pipeline) 
      REFERENCES mcrm_tlkp_pipeline (int_siteid,int_pipeline) 
      ON UPDATE CASCADE
);  
CREATE GENERATOR GEN_MCRM_TLKP_PIPESTEPS;
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Lead');
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Pre approach');
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Interview (first)');
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Opportunity Analysis');
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Determine Solution');
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Solution Proposal/Recommendation');
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Interview (subsequent)');
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Solution Development');
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Solution Presentation');
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Customer Solution Evaluation');
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Interview (negotiation)');
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Commitment to Buy');
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Follow up');
INSERT INTO mcrm_tlkp_pipesteps (int_siteid,dtm_rstamp,int_pipestep,int_pipeline,int_prev,str_name) values (1,'now',gen_id(gen_mcrm_tlkp_pipesteps,1),1,null,'Sales Recommendation');


/* ======================

  MAIN BASE TABLES

====================== */

/* Addresses
Because address info is used so often in CRM, it makes sense
to dedicate a whole table to it, rather than repeat
essentially the same schema all over the place.
Then, in hindsight, the extra administration didn't make sense.
So, I rebuilt the linktable between contact and addrtype, and put the info there.
*/

/* Central Phone/Email Repository
Because Phone, Email are used so often, we dedicate a central table to it
Well, we used to...
As the table above was removed, so has this one.
The info has been linked together in the link table instead
*/


/* Contact Table
This is a central core entity, referenced by many other sections
Each contact has a 'contact person', stored in the main people table
with several different contact methods per contact.
*/
SELECT 'Central Contact Table (mcrm_tbl_contact)' from rdb$database;
CREATE TABLE mcrm_tbl_contact (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_contact BIGINT NOT NULL,
  int_conttype INTEGER, /* Looks up contact types */
  str_title VARCHAR(10), /* Mr, Mrs, Miss, Ms, Doctor, Rabbi, etc */
  str_lastname VARCHAR(50) NOT NULL,
  str_firstname VARCHAR(50),
  str_midnames VARCHAR(100),
  dtm_dateofbirth DATE,
  str_gender VARCHAR(1),
  ibl_active INTEGER, /* Active person? 1:yes, 0:no */
  int_dasset BIGINT, /* Digital Asset ID of picture */
  str_imgref VARCHAR(50), /* Alternative href for image */
  str_phone VARCHAR(20),
  str_address VARCHAR(200),
  str_suburb VARCHAR(50),
  str_city VARCHAR(50),
  str_state VARCHAR(50),
  str_country VARCHAR(100),
  str_postcode VARCHAR(10),
    PRIMARY KEY(int_siteid, int_contact),
    FOREIGN KEY(int_siteid, int_conttype) 
      REFERENCES mcrm_tlkp_conttype (int_siteid, int_conttype) 
      ON UPDATE CASCADE
); 
CREATE GENERATOR GEN_MCRM_TBL_CONTACT;
CREATE ASC INDEX IND_MCRM_TBL_CONTLAST on mcrm_tbl_contact (str_lastname);
CREATE ASC INDEX IND_MCRM_TBL_CONTFIRST on mcrm_tbl_contact (str_firstname);
CREATE ASC INDEX IND_MCRM_TBL_CONTPHONE on mcrm_tbl_contact (str_phone);




/* Account Table 
  Stores account information, and links to contacts table for name, address, etc
  (Not actually a finance account, but a dealings account...)
*/
SELECT 'Main Account Table (mcrm_tbl_account)' from rdb$database;
CREATE TABLE mcrm_tbl_account (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_account BIGINT NOT NULL,
  str_account VARCHAR(200) NOT NULL,
  dtm_create TIMESTAMP,
  dtm_edited TIMESTAMP,
  dtm_closed TIMESTAMP,
  int_pricontact BIGINT, /* Link to contacts table */
  ibl_prefcontmeth INTEGER, /* Preffered Contact Method - Link to conttypes */
  ibl_donotphone INTEGER, /* Do not phone under any circumstances */
  ibl_donotemail INTEGER, /* Do not email under any circumstances */
  ibl_donotfax INTEGER, /* Do not fax under any circumstances */
  ibl_active INTEGER, /* Active account? 1:yes, 0:no */
  /* Commercial Information */
  int_manager BIGINT, /* Manager in person repo */
  int_managphone BIGINT, /* Manager phone in repo */
  int_managemail BIGINT, /* Manager Email in repo */
  int_pricelevel INTEGER, /* Pricing level for this account */
  int_origlead BIGINT, /* The original lead for this account */
  int_owneruid BIGINT, /* The owner user for this account */
  int_ownerteam BIGINT, /* The owning team for this account */
  int_territory INTEGER, /* The territory this account falls under */
  /* Financial Info - cached for speed here(possily won't be used) */
  flt_ageing30 NUMERIC(18,2),
  flt_ageing60 NUMERIC(18,2),
  flt_ageing90 NUMERIC(18,2),
  flt_ageing120 NUMERIC(18,2),
  flt_owingtotal NUMERIC(18,2),
    PRIMARY KEY(int_siteid,int_account),
    FOREIGN KEY(int_siteid, int_pricontact) 
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_origlead) 
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_manager) 
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_owneruid) 
      REFERENCES muser_tbl_user (int_siteid, int_uid) 
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MCRM_TBL_ACCOUNT;

/* User Groups
(Teams/Departments/etc)
*/
SELECT 'User Teams/Groups (MCRM_TBL_USERGROUP)' from rdb$database;
CREATE TABLE mcrm_tbl_usergroup (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_group BIGINT NOT NULL,
  int_uid BIGINT NOT NULL,
  str_comment VARCHAR(400),
    PRIMARY KEY(int_siteid, int_group),
    UNIQUE (int_siteid, int_group, int_uid),
    FOREIGN KEY(int_siteid,int_uid) 
      REFERENCES muser_tbl_user(int_siteid,int_uid) 
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MCRM_TBL_USERGROUP;



/* 
  Contact Dealings
  When phone calls are made, meetings attended, etc, put them here
  This is the stub that's referenced by planner for future meetings, etc.
  
*/
SELECT 'Contact Dealings (mcrm_tbl_contdeal)' from rdb$database;
CREATE TABLE mcrm_tbl_contdeal (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_dealing BIGINT NOT NULL, /* The Dealing ID */
  int_contact BIGINT NOT NULL, /* The Contact */
  int_dealtype INTEGER NOT NULL, /* Type of Dealing(Phone/sale/etc) */
  int_pipestep BIGINT, /* Step in the Pipeline */
  int_priority BIGINT,
  int_status BIGINT,
  int_resolution BIGINT,
  int_uidrecord INTEGER NOT NULL, /* Who recorded this dealing */
  int_uidfor INTEGER NOT NULL, /* Who this dealing was for */
  int_uidfollowup INTEGER NOT NULL, /* Who is assigned to follow this up */
  str_resolution varchar(20),
  str_field1name VARCHAR(20),
  str_field2name VARCHAR(20),
  str_field3name VARCHAR(20),
  str_field1data VARCHAR(1000),
  str_field2data VARCHAR(1000),
  str_field3data VARCHAR(1000),
    PRIMARY KEY(int_siteid, int_dealing),
    FOREIGN KEY(int_siteid, int_contact) 
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_dealtype) 
      REFERENCES mcrm_tlkp_dealtype (int_siteid, int_dealtype) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid, int_status)
      REFERENCES mcrm_tlkp_status (int_siteid, int_status)
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid, int_priority)
      REFERENCES mcrm_tlkp_priority (int_siteid, int_priority)
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid, int_resolution)
      REFERENCES mcrm_tlkp_resolution (int_siteid, int_resolution)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_pipestep)
      REFERENCES mcrm_tlkp_pipesteps (int_siteid, int_pipestep)
      ON UPDATE CASCADE
    
);
CREATE GENERATOR GEN_MCRM_TBL_CONTDEAL;
    
  



  
/* ==========================

  LINK TABLES

=========================== */


/* Publication Subscriptions
Which contacts subscribe to what publications
(Publications are now external via mod_pub)
*/
select 'Publication Subscriptions (mcrm_tlnk_pubsub)' from rdb$database;
CREATE TABLE mcrm_tlnk_pubsubs (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_contact BIGINT NOT NULL,
  int_pubid BIGINT NOT NULL,
  int_altaddr BIGINT, /* Use an alternate address for this publication */
  str_freightmeth VARCHAR(50), /* Bike, Car, Van, Truck, Email, Mailout */
    PRIMARY KEY(int_siteid, int_contact, int_pubid),
    FOREIGN KEY(int_siteid, int_contact)
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_pubid)
      REFERENCES modpub_tbl_publication (int_siteid, int_pubid)
      ON UPDATE CASCADE
);


/* Values for Contact Tags
This stores the value appliciable to the XML-style tag
Supplier ID 45, Type:Supplier, Tag:Default PO account, Value:'General Purchases'
Customer ID 489,  Type:Customer, Tag:Default payment terms, Value:'30days'
*/
CREATE TABLE mcrm_tlnk_conttags (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_contact BIGINT NOT NULL, /* The Contact ID */
  int_conttype INTEGER NOT NULL, /* References mcrm_tlkp_conttype */
  int_tag INTEGER NOT NULL, /* References the tag store */
  str_value VARCHAR(200), /* Value for the tag */
    PRIMARY KEY(int_siteid, int_contact, int_conttype, int_tag),
    FOREIGN KEY(int_siteid, int_contact) REFERENCES mcrm_tbl_contact(int_siteid, int_contact),
    FOREIGN KEY(int_siteid, int_conttype, int_tag) REFERENCES mcrm_tlkp_conttag(int_siteid, int_conttype, int_tag)
);




/* Contact Addresses Link Table
*/

SELECT 'Contact Addresses Link Table (mcrm_tlnk_contaddr)' from rdb$database;
CREATE TABLE mcrm_tlnk_contaddr (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_contact BIGINT NOT NULL,
  int_addrtype BIGINT NOT NULL,
  str_address VARCHAR(200),
  str_suburb VARCHAR(50),
  str_city VARCHAR(50),
  str_state VARCHAR(50),
  str_country VARCHAR(100),
  str_postcode VARCHAR(10),
  /* ----- GIS MAPPING ----- */
  int_longitude NUMERIC(18,15),
  int_latitude NUMERIC(18,15),
  int_accmail INTEGER, /* Accepting mail at this address? */
  int_secview INTEGER, /* Minimum security level for viewing */
  int_secedit INTEGER, /* Minimum security level for editing */
    PRIMARY KEY(int_siteid, int_contact, int_addrtype),
    FOREIGN KEY(int_siteid, int_contact)
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_addrtype)
      REFERENCES mcrm_tlkp_addrtype (int_siteid, int_addrtype)
      ON UPDATE CASCADE
);



/* Contact Phone/Email Link Table
*/

SELECT 'Contact Phone/Email Link Table (mcrm_tlnk_contphonemail)' from rdb$database;
CREATE TABLE mcrm_tlnk_contphonemail (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_contact BIGINT NOT NULL,
  int_phomailtype INTEGER DEFAULT 1 NOT NULL,
  str_number VARCHAR(20),
  str_email VARCHAR(50),
  ibl_active INTEGER, /* Is this active? */
  int_secview INTEGER, /* Minimum security level for viewing */
  int_secedit INTEGER, /* Minimum security level for editing */
    PRIMARY KEY(int_siteid, int_contact, int_phomailtype),
    FOREIGN KEY(int_siteid, int_contact)
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_phomailtype) 
      REFERENCES mcrm_tlkp_phomailtype (int_siteid, int_phomailtype) 
      ON UPDATE CASCADE
);


/* Contact group to Contact link
Connect Contacts into a Contact Group
*/

SELECT 'Contact to Contact-group link table (mcrm_tlnk_contgroup)' from rdb$database;
CREATE TABLE mcrm_tlnk_contgroup (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_group BIGINT NOT NULL, /* This is a contact group */
  int_contact BIGINT NOT NULL,
    PRIMARY KEY(int_siteid, int_group, int_contact),
    FOREIGN KEY(int_siteid, int_contact)
      references mcrm_tbl_contact (int_siteid, int_contact)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_group)
      references mcrm_tlkp_contgroup (int_siteid, int_group)
      ON UPDATE CASCADE
);



/* Contact to User Group link
Which user/group is the representative for this contact
*/
SELECT 'Contact to User Group/Team link table (mcrm_tlnk_groupconn)' from rdb$database;
CREATE TABLE mcrm_tlnk_groupconn (
  int_siteid INTEGER NOT NULL, 	/* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_group BIGINT NOT NULL, /* The Group ID */
  int_contact BIGINT NOT NULL, /* References the contacts table */
  ibl_public INTEGER DEFAULT 1, /* Public by default */
  str_notes VARCHAR(5000),
    PRIMARY KEY(int_siteid, int_contact, int_group),
    FOREIGN KEY(int_siteid, int_contact) 
      references mcrm_tbl_contact (int_siteid, int_contact) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_group) 
      references mcrm_tbl_usergroup (int_siteid, int_group) 
      ON UPDATE CASCADE
);
CREATE GENERATOR gen_mcrm_tlnk_groupconn;

/* Contact to User link
Which user is the representative for this contact
A User created this contact entry. Record who here.
*/
SELECT 'Contact to Representative User link table (mcrm_tlnk_connrep)' from rdb$database;
CREATE TABLE mcrm_tlnk_connrep (
  int_siteid INTEGER NOT NULL, 	/* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_contact BIGINT NOT NULL, /* References the contacts table */
  int_uid BIGINT NOT NULL, /* The user(who's logged in) */
  ibl_public INTEGER DEFAULT 1, /* Public by default */
  str_notes VARCHAR(5000),
    PRIMARY KEY(int_siteid, int_contact, int_uid),
    FOREIGN KEY(int_siteid, int_contact) 
      references mcrm_tbl_contact (int_siteid, int_contact) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_uid) 
      references muser_tbl_user (int_siteid, int_uid) 
      ON UPDATE CASCADE
);




/* Contact to Account link table
An Account may have more contacts than just it's primary contact
stored in mcrm_tbl_account.
Link more contacts to an account here
*/
SELECT 'Contact to Account link table (mcrm_tlnk_connacc)' from rdb$database;
CREATE TABLE mcrm_tlnk_connacc (
  int_siteid INTEGER NOT NULL, 	/* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_account BIGINT NOT NULL, /* The Account ID */
  int_contact BIGINT NOT NULL, /* The Contact ID */
  str_type VARCHAR(20), /* What type of reationship is this? */
  str_notes VARCHAR(1000), /* Any notes on this relationship */
    PRIMARY KEY(int_siteid, int_account, int_contact),
    FOREIGN KEY(int_siteid, int_contact) 
      references mcrm_tbl_contact (int_siteid, int_contact) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_account) 
      references mcrm_tbl_account (int_siteid, int_account) 
      ON UPDATE CASCADE
);


