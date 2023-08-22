/*
MASS OpenAspect Module
All tables, procedures, triggers, generators are to be prepended with:
mass_*
#
# $Id: modasset.sql,v 1.29 2005/09/13 01:29:22 nweeks Exp nweeks $ #
#
# $Log: modasset.sql,v $
# Revision 1.29  2005/09/13 01:29:22  nweeks
# Removed remnants of the Digital Assets code
#
# Revision 1.28  2004/12/23 05:58:51  nweeks
# Seperated Inventory out from Logistics
#
# Revision 1.27  2004/07/11 23:00:17  nigel
# Rolled out the new boolean type (ibl_)
#
# Revision 1.26  2004/07/09 04:22:18  nigel
# Changed widths again - should be the biggest the indexes can allow
#
# Revision 1.25  2004/07/09 03:08:15  nigel
# Resized some fields for index suitablilty
#
# Revision 1.24  2004/07/06 23:54:52  nigel
# Removed lingo entries(moved out to datapacks system)
#
# Revision 1.23  2004/04/20 02:03:53  nigel
# Fixed unique const. - was worldwide, not site-wide
#
# Revision 1.22  2004/04/05 07:26:45  nigel
# Added lingo entries(not completed)
#
# Revision 1.21  2004/04/02 00:00:01  nigel
# Fixed ssub-categories of  Assets
#
# Revision 1.20  2004/01/19 01:56:31  nigel
# Changes most FK lookups to 64bit Integers.
#
# Revision 1.19  2004/01/06 22:05:36  nigel
# Fixed build documentation
#
# Revision 1.18  2003/10/09 23:43:59  nigel
# Added verbosity to build process
#
# Revision 1.17  2003/10/09 23:35:26  nigel
# Removed domain creation of INT64
#
# Revision 1.16  2003/10/09 23:33:40  nigel
# CHanged INT64 to NUMERIC(18,0)
#
# Revision 1.15  2003/09/22 00:47:45  nigel
# Updated Internal Documentation
#
# Revision 1.14  2003/09/19 00:37:47  nigel
# Re-jigged the build to include mod_planner
#
# Revision 1.13  2003/09/18 22:45:09  nigel
# Renamed external modules, so the calling lines had
# to change as well. Sorry!
#
# Revision 1.12  2003/09/18 01:45:10  nigel
# Added primary keys to log tables
#
# Revision 1.11  2003/09/17 23:10:02  nigel
# Added copyright notice
#
# Revision 1.10  2003/09/03 10:03:48  nigel
# Changes regrding scheduling
# Sheduling will be moved to mod_ERP very soon
#
# Revision 1.9  2003/07/28 03:00:37  nigel
# Added dtm_rstamps for replication fault resolution
#
# Revision 1.8  2003/06/18 03:58:26  nigel
# Changes to lengths of tables...
#
# Revision 1.7  2003/06/18 03:19:47  nigel
# CHanged Prefix again
#
# Revision 1.6  2003/06/18 03:13:28  nigel
# Shortened prefix
#
# Revision 1.5  2003/06/10 01:35:27  nigel
# Fixed RCS Line
#
# Revision 1.4  2003/06/10 01:35:03  nigel
# Further Documentation
#
#
*/

/* ====================================
  Lookup Tables 
  These table typically supply pull-down lists
  for pre-used and common values
==================================== */

/* Asset Types Source:
  A Pull-down list source containing pre-used/pre-setup 
  types of assets
*/
select 'Asset Types Lookup (mass_tlkp_assettype)' from rdb$database;
CREATE TABLE mass_tlkp_assettype (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_type NUMERIC(18,0) NOT NULL,
  str_type VARCHAR(100) NOT NULL,
  ibl_digital INTEGER, /* Is this a digital asset type? */
    PRIMARY KEY (int_siteid,int_type),
    UNIQUE (int_siteid,str_type)
);
CREATE GENERATOR GEN_MASS_TLKP_ASSETTYPE;
INSERT INTO mass_tlkp_assettype (int_siteid, int_type, str_type, ibl_digital)
VALUES (1,gen_id(gen_mass_tlkp_assettype,1),'Generic Digital Asset',1);

SET GENERATOR gen_mass_tlkp_assettype to 1000;



/* Asset Property Categories
   Used for grouping properties
   Operational/Identity/Physical/Software/etc
*/
select 'Property Categories Lookup (mass_tlkp_propcateg)' from rdb$database;
CREATE TABLE mass_tlkp_propcateg (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_categ NUMERIC(18,0) NOT NULL, 
  str_categ VARCHAR(160) NOT NULL,
    PRIMARY KEY (int_siteid, int_categ),
    UNIQUE (int_siteid, str_categ)
);
CREATE GENERATOR GEN_MASS_TLKP_PROPCATEG;


/* Asset Property SUB-Categories
   Used for grouping properties
   Operational/Identity/Physical/Software/etc
   Categories of Asset Properties can have sub-categories
*/
select 'Property Sub-Categories Lookup (mass_tlkp_propsubcateg)' from rdb$database;
CREATE TABLE mass_tlkp_propsubcateg (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_subcateg NUMERIC(18,0) NOT NULL, 
  int_parcateg NUMERIC(18,0) NOT NULL,
  str_subcateg VARCHAR(160) NOT NULL,
    PRIMARY KEY (int_siteid, int_subcateg, int_parcateg),
    FOREIGN KEY (int_siteid, int_parcateg)
      REFERENCES mass_tlkp_propcateg (int_siteid, int_categ)
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MASS_TLKP_PROPSUBCATEG;



/* Property Lookup Source:
  Assets can have unlimited properties- size, weight, voltage, MHz
  Here, constraints are put on values, i.e., 
    no letters in number fields,
    Default values for first use fields
    Help, and tips on property use
*/
select 'Property Lookup (mass_tlkp_property)' from rdb$database;
CREATE TABLE mass_tlkp_Property(
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_pid NUMERIC(18,0) NOT NULL, /* This is the Property's ID */
  int_categ NUMERIC(18,0) NOT NULL, /* The property category(Identity, Operational, etc) */
  int_subcateg NUMERIC(18,0), /* The property category(Identity, Operational, etc) */
  str_pname VARCHAR(160) NOT NULL, /* This is the Property Name */
  str_UPpname VARCHAR(160), /* Property Name IN UPPERCASE FOR SEARCHING */
  str_ptype VARCHAR(100), /* The type(text/number/etc) */
  str_pconst VARCHAR(100), /* Constraint - 0-100%, yes/no, etc */
  str_pdefault VARCHAR(50), /* The default for this value */
  str_help VARCHAR(50), /* A blurb on what to put here */
    PRIMARY KEY (int_siteid,int_pid),
    UNIQUE(int_siteid, int_categ, int_subcateg, str_pname),
    FOREIGN KEY(int_siteid, int_categ) 
      REFERENCES mass_tlkp_propcateg (int_siteid,int_categ) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_subcateg, int_categ) 
      REFERENCES mass_tlkp_propsubcateg (int_siteid,int_subcateg, int_parcateg) 
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MASS_TLKP_PROPERTY;
/* Search Indexes */
CREATE ASC INDEX IND_SRCH_PROP_NAME ON mass_tlkp_Property(str_PName);
CREATE ASC INDEX IND_SRCH_PROP_UPNAME ON mass_tlkp_Property(str_UPPName);



/* Costs Pulldown Source:
  With the purchase/aquisition of any asset, costs are involved.
  Some of these are deductable as losses
  Some are depreciable over time
  Others are not. Setup which ones are which
*/
select 'Costs Lookup (mass_tlkp_cost)' from rdb$database;
CREATE TABLE mass_tlkp_cost (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_cost NUMERIC(18,0) NOT NULL, /* This is the cost ID */
  str_cost VARCHAR(100) NOT NULL,	/* What we call the cost */
  ibl_depreciable INTEGER,	/* Is this cost depreciable */
  flt_deppercent NUMERIC(18,2),	/* Percent for Depreciation */
  ibl_deductable INTEGER,	/* Is this cost depreciable */
  flt_dedpercent NUMERIC(18,2),	/* Percent for Deduction */
    PRIMARY KEY(int_siteid,int_cost),
    UNIQUE(int_siteid, str_cost)
);
CREATE GENERATOR gen_mass_tlkp_cost;
/* Search Indexes (Needs IND_SRCH_ as prefix) */
CREATE ASC INDEX IND_SRCH_COST_NAME on mass_tlkp_cost (str_cost);


/* Asset Location Pulldown Source:
  An Asset has to be sitting somewhere
  Provide a list of locations for this site where
  an asset could be hiding
  Digital Assets have a filesystem location
*/
select 'Locations Lookup (mass_tlkp_location)' from rdb$database;
/* Location Tables */
CREATE TABLE mass_tlkp_Location (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_Loc NUMERIC(18,0) NOT NULL, /* The Location ID */
  str_locname VARCHAR(50) NOT NULL, /* The name of the Location */
  str_locpath VARCHAR(50), /* The path of the Digital Location */
  str_UPLocName VARCHAR(50), /* Location name IN UPPERCASE FOR SEARCHING*/
  str_loctype VARCHAR(10) NOT NULL, /* The type of location(building,filesystem,car,etc)*/
    PRIMARY KEY (int_siteid, int_Loc),
    UNIQUE (int_siteid, str_locname)
);
CREATE GENERATOR gen_mass_tlkp_location;
/* Search Indexes (Needs IND_SRCH_ as prefix) */
CREATE ASC INDEX IND_SRCH_LOCN_NAME ON mass_tlkp_Location (str_LocName);
CREATE ASC INDEX IND_SRCH_LOCN_UPNAME ON mass_tlkp_Location (str_UPLocName);
CREATE ASC INDEX IND_SRCH_LOCN_TYPE ON mass_tlkp_Location (str_LocType);


/* Asset Service Types:
  Assets need fixing from time to time
  Emergency repairs, Preventative Maintenance
  Give names to the jobs you do
  Also, settings on time involved, prices, 
  Re-occuring services, and intervals between services
*/
SELECT 'Service/Maintenance Types Lookup (mass_tlkp_servtype)' from rdb$database;


CREATE TABLE mass_tlkp_servtype (
  int_siteid INTEGER NOT NULL,	/* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_typeid NUMERIC(18,0) NOT NULL,	/* The Type of service */
  str_name VARCHAR(40) NOT NULL,		/* The name of this service */
  str_desc VARCHAR(200),	/* A description for this service */
  flt_esthours NUMERIC(18,1),	/* An estimation of hours */
  flt_cost NUMERIC(18,2),	/* A Cost to the servicer */
  flt_retail NUMERIC(18,2),	/* A Price for the Customer */
  str_servdetail VARCHAR(20000),  /* Details of the service */
  str_interval VARCHAR(30), 	/* Month, km, hours, etc */
  flt_interval NUMERIC(18,2), 	/* 2(months), 5000(km), 200(hours), etc */
  ibl_recurring INTEGER,	/* Does this re-occur(0:repeating, 1-N:1-N times) */
    PRIMARY KEY(int_siteid, int_typeid),
    UNIQUE(int_siteid, str_name)
);
CREATE GENERATOR gen_mass_tlkp_servtype;
/* Search Indexes (Needs IND_SRCH_ as prefix) */
CREATE ASC INDEX IND_SRCH_SERVTYPE_NAME on mass_tlkp_servtype (str_name);
CREATE ASC INDEX IND_SRCH_SERVTYPE_DESC on mass_tlkp_servtype (str_desc);
CREATE ASC INDEX IND_SRCH_SERVTYPE_HOURS on mass_tlkp_servtype (flt_esthours);
CREATE ASC INDEX IND_SRCH_SERVTYPE_RETAIL on mass_tlkp_servtype (flt_retail);
CREATE ASC INDEX IND_SRCH_SERVTYPE_INTTYPE on mass_tlkp_servtype (str_interval);
CREATE ASC INDEX IND_SRCH_SERVTYPE_INTAMT on mass_tlkp_servtype (flt_interval);


/* Standard Service Tasks Source:
  A Service is broken into many tasks
  Name a task, and provide descriptions,
  Estimations of time, cost, and any other notes you need
  Consider this a detailed 'how-to' to perform the task
  These values can be over-ridden at actual service time
    (These are used as defaults)
*/
SELECT 'Service Tasks Lookup (mass_tlkp_servtask)' from rdb$database;
CREATE TABLE mass_tlkp_servtask (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_taskid NUMERIC(18,0) NOT NULL,/* The Task ID */
  str_name VARCHAR(40) NOT NULL,/* A Name for this task */
  str_desc VARCHAR(200),/* A description of the task */
  int_minutes INTEGER,/* Estimation of minutes */
  flt_cost NUMERIC(18,2),/* Cost to servicer */
  flt_retail NUMERIC(18,2),/* Price for Customer */
  str_taskdetail VARCHAR(20000),/* Details of task */
    PRIMARY KEY(int_siteid,int_taskid),
    UNIQUE (int_siteid, str_name)
);
CREATE GENERATOR gen_mass_tlkp_servtask;
/* Search Indexes (Needs IND_SRCH_ as prefix) */
select 'Search Indexes' from rdb$database;
CREATE ASC INDEX IND_SRCH_SERVTASK_NAME on mass_tlkp_servtask (str_name);
CREATE ASC INDEX IND_SRCH_SERVTASK_DESC on mass_tlkp_servtask (str_desc);
CREATE ASC INDEX IND_SRCH_SERVTASK_MINS on mass_tlkp_servtask (int_minutes);
CREATE ASC INDEX IND_SRCH_SERVTASK_RETAIL on mass_tlkp_servtask (flt_retail);





/* Asset Inspection/Condition Monitoring Types:
  What's it called when you go to a motor, and put your
  hand on it, to see if it's running rough
  'Bearing Vibration Check?'
*/
SELECT 'Condition Monitoring Types Lookup (mass_tlkp_monitortype)' from rdb$database;
CREATE TABLE mass_tlkp_monitortype (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_monitor NUMERIC(18,0) NOT NULL,
  str_monitor VARCHAR(50) NOT NULL, /* Visual Inspection, Vib. Analysis */
  str_desc VARCHAR(500), /* Describe the monitoring procedure */
    PRIMARY KEY(int_siteid,int_monitor),
    UNIQUE (int_siteid, str_monitor)
);
CREATE GENERATOR gen_mass_tlkp_monitortype;
/* Search Indexes (Needs IND_SRCH_ as prefix) */

/* Condition State Pulldown Source:
  What would you call the asset in it's current state:
  Wrecked, submerged, smashed, fine, ok, etc
*/

SELECT 'Condition States Lookup (mass_tlkp_condstate)' from rdb$database;
CREATE TABLE mass_tlkp_condstate (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_state NUMERIC(18,0) NOT NULL,
  str_state VARCHAR(50) NOT NULL, /* Fine, Seized, Gone, burnt-out, etc */
    PRIMARY KEY(int_siteid,int_state),
    UNIQUE (int_siteid,str_state)
);
CREATE GENERATOR GEN_MASS_TLKP_CONDSTATE;
/* Search Indexes (Needs IND_SRCH_ as prefix) */


/* Condition Change Causes:
  Why did the condition of the asset change?
  Accident, flood, fire, wear'n'tear, etc
*/
SELECT 'Condition Change Cause Lookup (mass_tlkp_condcause)' from rdb$database;
CREATE TABLE mass_tlkp_condcause (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_cause NUMERIC(18,0) NOT NULL,
  str_cause VARCHAR(50) NOT NULL, /* Wear'n'tear,vandalism,water damage,collision */
  str_desc VARCHAR(2000),
    PRIMARY KEY(int_siteid, int_cause),
    UNIQUE (int_siteid, str_cause)
);
CREATE GENERATOR gen_mass_tlkp_condcause;
/* Search Indexes (Needs IND_SRCH_ as prefix) */





/* ===========================

  Base Tables

=========================== */

/* The Asset Table
  This is where the Asset exists.
  All Properties, Locations, Costs, 
  Depreciation and Disposals,
  Services, Monitoring, and Movements
  Hook back to this table
*/
select 'Base Asset (mass_tbl_asset)' from rdb$database;
CREATE TABLE mass_tbl_asset (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_asset NUMERIC(18,0) NOT NULL, /* This is the ID of the Asset Item */
  str_name VARCHAR(200) NOT NULL, /* This is it's simple name */
  str_desc VARCHAR(500), /* This is it's description */
  int_type NUMERIC(18,0), /* Asset Type  */
  str_serial VARCHAR(50), /* Serial Number */
  str_model VARCHAR(50), /* Model Number */
  int_parent NUMERIC(18,0), /* This asset may be the child of another */
  dtm_create timestamp default 'now', /* when this was created */
  dtm_edit timestamp, /* when this was edited */
  dtm_purch DATE,
  dtm_endoflife DATE,
  dtm_disposal DATE,
  dtm_detailed TIMESTAMP, /* Have properties been set for this asset? (Digital) */
  str_deprecmeth VARCHAR(20), /* Depreciation Method for this asset */
  flt_deprecperc NUMERIC(18,2), /* The Depreciation percentage */
  dtm_depcalcdate DATE, /* Depreciation 'falls on' date (alt. financial years) */ 
    PRIMARY KEY (int_siteid,int_asset),
    FOREIGN KEY(int_siteid,int_type) 
      REFERENCES mass_tlkp_assettype(int_siteid,int_type) 
      ON UPDATE CASCADE
);
CREATE GENERATOR gen_mass_tbl_asset;
SET GENERATOR gen_mass_tbl_asset to 1000;
/* Search Indexes (Needs IND_SRCH_ as prefix) */
CREATE ASC INDEX IND_SRCH_ASSET_NAME on mass_tbl_asset(str_name);
CREATE ASC INDEX IND_SRCH_ASSET_TYPE on mass_tbl_asset(int_type);
CREATE ASC INDEX IND_SRCH_ASSET_PRNT on mass_tbl_asset(int_parent);
CREATE ASC INDEX IND_SRCH_ASSET_PURCH on mass_tbl_asset(dtm_purch);
CREATE ASC INDEX IND_SRCH_ASSET_EOL on mass_tbl_asset(dtm_endoflife);
CREATE ASC INDEX IND_SRCH_ASSET_DISPOSAL on mass_tbl_asset(dtm_disposal);
CREATE ASC INDEX IND_SRCH_ASSET_DEPCALCDATE on mass_tbl_asset(dtm_depcalcdate);
commit;


/* Parts for Services Pulldown Source:
  The complete list of parts.
  This is inherited from mod_logistics
  Handles items, warehousing, freighting,
  consignment, box grouping, and transport logging
  Sure - some companies may not need it, but
  it saves writing the same code twice...
*/

select 'Pulling in MOD_INVENTORY' from rdb$database;
in schema/modinventory.sql;


/* Asset Servicing Register:
  This service for this asset
  The kind of service
  Was it a result of condition monitoring
*/
SELECT 'Asset Servicing Register (mass_tbl_assetserv)' from rdb$database;
CREATE TABLE mass_tbl_assetserv (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_service NUMERIC(18,0) NOT NULL,
  int_asset NUMERIC(18,0) NOT NULL, /* The Asset ID */
  int_typeid NUMERIC(18,0) NOT NULL, /* The Service Type */
  int_monid NUMERIC(18,0), /* As a result of Condition Monitoring entry */
  str_notes VARCHAR(1000),
    PRIMARY KEY(int_siteid,int_service), 
    FOREIGN KEY(int_siteid, int_typeid) 
      REFERENCES mass_tlkp_servtype (int_siteid, int_typeid) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_asset) 
      REFERENCES mass_tbl_asset (int_siteid,int_asset) 
      ON UPDATE CASCADE
);
CREATE GENERATOR gen_mass_tbl_assetserv;
/* Search Indexes (Needs IND_SRCH_ as prefix) */
CREATE ASC INDEX IND_SRCH_ASSSERV_SERVICE on mass_tbl_assetserv(int_service);
CREATE ASC INDEX IND_SRCH_ASSSERV_TYPE on mass_tbl_assetserv(int_typeid);
CREATE ASC INDEX IND_SRCH_ASSSERV_ASSET on mass_tbl_assetserv(int_asset);

/* Service Line Items
  Tasks involved
  Parts Involved (Parts are stored by minv(Inventory))
  Notes of work done
*/
SELECT 'Asset Service Line Items (mass_tbl_assetservline)' from rdb$database;
CREATE TABLE mass_tbl_assetservline (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_service NUMERIC(18,0) NOT NULL,   /* The Service Type ID */
  int_taskid NUMERIC(18,0) DEFAULT 0 NOT NULL, /* Loaded from servtype, but additional ones can be added */
  int_itemid NUMERIC(18,0) DEFAULT 0 NOT NULL, /* Loaded from parts for task */
  str_note VARCHAR(100) default '' NOT NULL,
  str_desc VARCHAR(400),
  dtm_action TIMESTAMP DEFAULT 'now' NOT NULL, /* Date and Time of this line started */
  flt_cost NUMERIC(18,2), /* Can override the standard cost */
  flt_retail NUMERIC(18,2), /* Can override the standard retail */
    PRIMARY KEY(int_siteid,int_service, int_taskid, int_itemid, str_note),
    FOREIGN KEY(int_siteid,int_service) 
      REFERENCES mass_tbl_assetserv (int_siteid,int_service) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_taskid) 
      REFERENCES mass_tlkp_servtask (int_siteid,int_taskid) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_itemid) 
      REFERENCES minv_tbl_item (int_siteid,int_itemid) 
      ON UPDATE CASCADE
);
/* Search Indexes (Needs IND_SRCH_ as prefix) */

/* Service Report
  Further information about the service itself
*/

SELECT 'Service Report (mass_tbl_servicerep)' from rdb$database;
CREATE TABLE mass_tbl_servicerep (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_service NUMERIC(18,0) NOT NULL,
  str_repairer VARCHAR(200),
  str_precond VARCHAR(2000), /* Condition before service */
  str_postcond VARCHAR(2000), /* Condition after service */
  dtm_date DATE,
  dtm_time TIME,
  ibl_invoiced INTEGER,
  ibl_invreceived INTEGER,
  ibl_paymentsent INTEGER,
  ibl_payreceived INTEGER,
  ibl_closed INTEGER,
    PRIMARY KEY(int_siteid,int_service),
    FOREIGN KEY(int_siteid,int_service) 
      REFERENCES mass_tbl_assetserv (int_siteid,int_service)
      ON UPDATE CASCADE
);
/* Search Indexes (Needs IND_SRCH_ as prefix) */


/* Asset Collections (Groups of physical assets(car fleets, etc))*/

select 'Asset Collections (mass_tbl_dassetcoll)' from rdb$database;
CREATE TABLE mass_tbl_assetcoll (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_coll NUMERIC(18,0) NOT NULL,
  str_title VARCHAR(500) NOT NULL, /* Collections must have a title */
  str_desc VARCHAR(2000),
  dtm_create TIMESTAMP default 'now',
  dtm_update TIMESTAMP default 'now',
    PRIMARY KEY(int_siteid,int_coll)
);
CREATE GENERATOR GEN_MASS_TBL_ASSETCOLL;
set generator gen_mass_tbl_assetcoll to 1000;


/* Asset Sub-Collections
The collection of cars in the fleet, has a sub-collection of falcons XR6's*/

select 'Asset Sub-Collections (mass_tbl_subcoll)' from rdb$database;
CREATE TABLE mass_tbl_subcoll (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_coll NUMERIC(18,0) NOT NULL,
  int_subcoll NUMERIC(18,0) NOT NULL,
  str_title VARCHAR(500) NOT NULL, /* Sub-Collections must have a title */
  int_order INTEGER, /* A method of ordering the sub-collections, for display */
  str_desc VARCHAR(2000),
  dtm_create TIMESTAMP default 'now',
  dtm_update TIMESTAMP default 'now',
    PRIMARY KEY(int_siteid,int_coll,int_subcoll),
    FOREIGN KEY(int_siteid,int_coll) 
      REFERENCES mass_tbl_assetcoll (int_siteid, int_coll) 
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MASS_TBL_SUBCOLL;


/* Audit IT Batch Table
This table is populated by a csv parser, and is then read
by a stored procedure, which creates/updates computer assets, and
their properties
*/
select 'IT Auditting batch table (mass_tbl_auditbatch)' from rdb$database;
CREATE TABLE mass_tbl_auditbatch (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_lineid NUMERIC(18,0) NOT NULL,
  int_batchID NUMERIC(18,0) NOT NULL,
  str_field1 VARCHAR(200),
  str_field2 VARCHAR(200),
  str_field3 VARCHAR(200),
  str_field4 VARCHAR(200),
  str_field5 VARCHAR(200),
  str_field6 VARCHAR(200),
  dtm_stamp TIMESTAMP default 'now' NOT NULL,
    PRIMARY KEY(int_siteid,int_batchid,int_lineid)
);
CREATE GENERATOR gen_mass_tbl_auditbatch;
CREATE GENERATOR gen_mass_tbl_batchid;
CREATE INDEX IND_SRCH_MASS_TBL_AB_F1 ON mass_tbl_auditbatch(str_field1);
CREATE INDEX IND_SRCH_MASS_TBL_AB_F2 ON mass_tbl_auditbatch(str_field2);
CREATE INDEX IND_SRCH_MASS_TBL_AB_F3 ON mass_tbl_auditbatch(str_field3);
CREATE INDEX IND_SRCH_MASS_TBL_AB_F4 ON mass_tbl_auditbatch(str_field4);
CREATE INDEX IND_SRCH_MASS_TBL_AB_F5 ON mass_tbl_auditbatch(str_field5);
CREATE INDEX IND_SRCH_MASS_TBL_AB_F6 ON mass_tbl_auditbatch(str_field6);





/* ============================
  Link Tables (Linking base to base, base to lookup, etc)
============================ */





/* Asset Type Standard Properties
  An asset of type 'Computer' might have standard properties: OS Name, OS Version, CPU Make, CPU Model, etc
*/
select 'Asset Type Property Defaults (mass_tlnk_typeprops)' from rdb$database;
CREATE TABLE mass_tlnk_typeprops (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_type NUMERIC(18,0) NOT NULL, /* The Asset Type */
  int_pid NUMERIC(18,0) NOT NULL, /* The Property ID */
    PRIMARY KEY(int_siteid,int_type,int_pid),
    FOREIGN KEY (int_siteid,int_PID) 
      REFERENCES mass_tlkp_Property (int_siteid,int_PID) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid,int_type) 
      REFERENCES mass_tlkp_assettype (int_siteid,int_type) 
      ON UPDATE CASCADE
);
/* Search Indexes (Needs IND_SRCH_ as prefix) */

/* Asset Grouping and Collections */
select 'Asset Collections (mass_tlnk_assetcoll)' from rdb$database;
CREATE TABLE mass_tlnk_assetcoll (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_coll NUMERIC(18,0) NOT NULL, /* Put this asset into a collection */
  int_subcoll NUMERIC(18,0),  /* Can we put this into a sub-collection as well? */
  int_asset NUMERIC(18,0) NOT NULL,
  int_majororder INTEGER default 1,
  int_minororder INTEGER default 1,
      PRIMARY KEY(int_siteid, int_coll, int_asset),
      FOREIGN KEY(int_siteid,int_asset) 
        REFERENCES mass_tbl_Asset (int_siteid,int_asset) 
        ON UPDATE CASCADE,
      FOREIGN KEY(int_siteid,int_coll) 
        REFERENCES mass_tbl_assetcoll (int_siteid,int_coll) 
        ON UPDATE CASCADE,
      FOREIGN KEY(int_siteid,int_coll,int_subcoll) 
        REFERENCES mass_tbl_subcoll (int_siteid,int_coll,int_subcoll) 
        ON UPDATE CASCADE
);



/* Asset Costs link table 
  Which Assets have which costs */
select 'Asset Costs Link Table (mass_tlnk_assetcost)' from rdb$database;
CREATE TABLE mass_tlnk_assetcost (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_asset NUMERIC(18,0) NOT NULL,
  int_cost NUMERIC(18,0) NOT NULL,
  dtm_date DATE DEFAULT 'now' NOT NULL,
  dtm_time TIME default 'now' NOT NULL,
  flt_amount NUMERIC(18,2),
  str_note VARCHAR(500),
    PRIMARY KEY(int_siteid,int_asset,int_cost,dtm_date,dtm_time),
    FOREIGN KEY (int_siteid,int_asset) 
      REFERENCES mass_tbl_Asset (int_siteid,int_asset) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid,int_cost) 
      REFERENCES mass_tlkp_cost (int_siteid,int_cost) 
      ON UPDATE CASCADE
);
/* Search Indexes (Needs IND_SRCH_ as prefix) */



/* Asset Property Link Table 
  Assets have properties - 
  Here's where we store them all */
select 'Asset Property Link Table (mass_tlnk_assetprop)' from rdb$database;
CREATE TABLE mass_tlnk_assetprop (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_asset NUMERIC(18,0) NOT NULL, /* The Asset ID */
  int_PID NUMERIC(18,0) NOT NULL, /* The Property ID */
  str_Text VARCHAR(200) NOT NULL, /* The value for the property */
    PRIMARY KEY (int_siteid, int_asset,int_pid),
    FOREIGN KEY (int_siteid,int_asset) 
      REFERENCES mass_tbl_Asset (int_siteid,int_asset) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid,int_PID) 
      REFERENCES mass_tlkp_Property (int_siteid,int_PID) 
      ON UPDATE CASCADE
);
/* Search Indexes (Needs IND_SRCH_ as prefix) */
CREATE ASC INDEX IND_SRCH_ASSETPROP_ITEM ON mass_tlnk_AssetProp (int_asset);
CREATE ASC INDEX IND_SRCH_ASSETPROP_PROP ON mass_tlnk_AssetProp (int_PID);




/* Location Link:
  Where, exactly, is the asset on this site?
  And, is it a child member of another asset?
  Filtration Unit->Pump->Flow Quage->etc...
  All these could be assets...
*/

select 'Assets in Location Link Table (mass_tlnk_assetlocation)' from rdb$database;
CREATE TABLE mass_tlnk_AssetLocation (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_Loc NUMERIC(18,0) NOT NULL, /* The current Location */
  int_Parent NUMERIC(18,0) NOT NULL, /* The Locations's Parent */
  int_asset NUMERIC(18,0) NOT NULL, /* The Asset at this location */
    PRIMARY KEY (int_siteid, int_Loc, int_Parent, int_asset),
    FOREIGN KEY (int_siteid,int_Loc) 
      REFERENCES mass_tlkp_Location (int_siteid,int_Loc) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid,int_Parent) 
      REFERENCES mass_tlkp_Location (int_siteid,int_Loc) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid,int_asset) 
      REFERENCES mass_tbl_Asset (int_siteid,int_asset) 
      ON UPDATE CASCADE
);
/* Search Indexes (Needs IND_SRCH_ as prefix) */
CREATE ASC INDEX IND_SRCH_ASSLOC_Loc ON mass_tlnk_AssetLocation (int_Loc);
CREATE ASC INDEX IND_SRCH_ASSLOC_Parent ON mass_tlnk_AssetLocation (int_Parent);
CREATE ASC INDEX IND_SRCH_ASSLOC_Asset ON mass_tlnk_AssetLocation (int_asset);



/* Standard tasks for a service
  These tasks are standard for this type of service
  They are to be done in this order
  There are notes to be read */ 
SELECT 'Standard Tasks for a Service (mass_tlnk_servtypetask)' from rdb$database;
CREATE TABLE mass_tlnk_servtypetask (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_typeid NUMERIC(18,0) NOT NULL,	/* Service Type */
  int_taskid NUMERIC(18,0) NOT NULL,	/* Task Involved */
  int_order NUMERIC(18,2) default 0,
  str_notes VARCHAR(10000),
    PRIMARY KEY(int_typeid, int_taskid),
    FOREIGN KEY(int_siteid,int_typeid) 
      REFERENCES mass_tlkp_servtype (int_siteid,int_typeid) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_taskid) 
      REFERENCES mass_tlkp_servtask (int_siteid,int_taskid) 
      ON UPDATE CASCADE
);
/* Search Indexes (Needs IND_SRCH_ as prefix) */

/* Standard parts for task:
  This task involves using the following parts
  There are 'this' many of this part
  They cost 'this' much each
  We'll charge 'this' much each today(overriding default) */
SELECT 'Standard Parts for Task (mass_tlnk_taskparts)' from rdb$database;
CREATE TABLE mass_tlnk_taskparts (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_taskid NUMERIC(18,0) NOT NULL,
  int_itemid NUMERIC(18,0) NOT NULL,
  flt_qty NUMERIC(18,2),
  flt_cost NUMERIC(18,2),
  flt_retail NUMERIC(18,2),
    PRIMARY KEY(int_siteid, int_taskid, int_itemid),
    FOREIGN KEY(int_siteid,int_taskid) 
      REFERENCES mass_tlkp_servtask (int_siteid,int_taskid) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_itemid) 
      REFERENCES minv_tbl_item (int_siteid,int_itemid) 
      ON UPDATE CASCADE
);
/* Search Indexes (Needs IND_SRCH_ as prefix) */


/* Condition Monitoring
  While walking in today, I noticed
  the coffee machine is in a sink full
  of water
  Asset: Coffee Machine, State: Submerged, Cause: Dunked
*/
SELECT 'Condition Monitoring Table (mass_tlnk_assetmonitor)' from rdb$database;
CREATE TABLE mass_tlnk_assetmonitor (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_monid NUMERIC(18,0) NOT NULL,
  int_asset NUMERIC(18,0) NOT NULL,
  int_monitor NUMERIC(18,0) NOT NULL, /* The type of inspection */
  int_state NUMERIC(18,0) NOT NULL, /* The State the asset is in now */
  int_cause NUMERIC(18,0) NOT NULL, /* The reason for the condition change */
  int_reported NUMERIC(18,0), /* Reported by who(if available) */
  dtm_date DATE DEFAULT 'now' NOT NULL,
  dtm_time TIME DEFAULT 'now' NOT NULL,
  str_notes VARCHAR(2000),
    PRIMARY KEY(int_siteid,int_monid),
    FOREIGN KEY (int_siteid,int_asset) 
      REFERENCES mass_tbl_Asset (int_siteid,int_asset) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid,int_monitor) 
      REFERENCES mass_tlkp_monitortype (int_siteid,int_monitor) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid,int_state) 
      REFERENCES mass_tlkp_condstate (int_siteid,int_state) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid,int_cause) 
      REFERENCES mass_tlkp_condcause (int_siteid,int_cause) 
      ON UPDATE CASCADE
);  

CREATE GENERATOR GEN_MASS_TLNK_ASSETMONITOR;

/* Search Indexes (Needs IND_SRCH_ as prefix) */
