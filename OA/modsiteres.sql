/* MOD_SITERES
This module is the Site Resources module for OpenAspect.
It manages:
Room bookings for contact rentals, accomodation(Hotel, Camp, etc)
Room bookings and attendences (Conference, restaurant)
Table Bookings(Cafe, Restaurant)
And much more.

Prefix is:
msres_*

User table is inherited from mod_user OE module

#
# $Id: modsiteres.sql,v 1.1 2004/07/12 06:33:40 nigel Exp nigel $
#
# $Log: modsiteres.sql,v $
# Revision 1.1  2004/07/12 06:33:40  nigel
# Initial revision
#
#
*/

/* =============================

  Lookup Tables

============================= */

/* Resource Types Lookup
  What is this resource?
  Conference Hall, Welder, Bodyguard, etc
*/
select 'Resource Types Lookup Table (msres_tlkp_restype)' from rdb$database;
CREATE TABLE msres_tlkp_restype (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_restype BIGINT NOT NULL, 	/* The code of the resource type */
  str_restype VARCHAR(150) NOT NULL, /* The name of type */
    PRIMARY KEY(int_siteid,int_restype),
    UNIQUE(int_siteid,str_restype)
);
CREATE GENERATOR GEN_MERP_TLKP_RESTYPE;

/* Resource Properties Categories
Used for grouping properties for a resource
*/
select 'Resource Property Categories Lookup (msres_tlkp_propcateg)' from rdb$database;
CREATE TABLE msres_tlkp_propcateg (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_categ BIGINT NOT NULL, 
  str_categ VARCHAR(150) NOT NULL,
    PRIMARY KEY (int_siteid, int_categ),
    UNIQUE (int_siteid, str_categ)
);
CREATE GENERATOR GEN_MERP_TLKP_PROPCATEG;


/* Resource Property SUB-Categories
   Used for grouping properties
   Operational/Identity/Physical/Features/etc
   Categories of Resource Properties can have sub-categories
*/
select 'Property Sub-Categories Lookup (msres_tlkp_propsubcateg)' from rdb$database;
CREATE TABLE msres_tlkp_propsubcateg (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_subcateg BIGINT NOT NULL, 
  int_parcateg BIGINT NOT NULL,
  str_subcateg VARCHAR(150) NOT NULL,
    PRIMARY KEY (int_siteid, int_subcateg, int_parcateg),
    FOREIGN KEY (int_siteid, int_parcateg)
      REFERENCES msres_tlkp_propcateg (int_siteid, int_categ)
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MSRES_TLKP_PROPSUBCATEG;


/* Property Lookup Source:
  Resources can have unlimited properties- size, weight, voltage, MHz
  Here, constraints are put on values, i.e., 
    no letters in number fields,
    Default values for first use fields
    Help, and tips on property use
*/
select 'Property Lookup (msres_tlkp_property)' from rdb$database;
CREATE TABLE msres_tlkp_Property(
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_pid BIGINT NOT NULL, /* This is the Property's ID */
  int_categ BIGINT NOT NULL, /* The property category(Identity, Operational, etc) */
  int_subcateg BIGINT, /* The property category(Identity, Operational, etc) */
  str_pname VARCHAR(150) NOT NULL, /* This is the Property Name */
  str_UPpname VARCHAR(150), /* Property Name IN UPPERCASE FOR SEARCHING */
  str_ptype VARCHAR(150), /* The type(text/number/etc) */
  str_pconst VARCHAR(150), /* Constraint - 0-100%, yes/no, etc */
  str_pdefault VARCHAR(50), /* The default for this value */
  str_help VARCHAR(50), /* A blurb on what to put here */
    PRIMARY KEY (int_siteid,int_pid),
    UNIQUE(int_siteid, int_categ, str_pname),
    FOREIGN KEY(int_siteid, int_categ) 
      REFERENCES msres_tlkp_propcateg (int_siteid,int_categ) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_subcateg, int_categ) 
      REFERENCES msres_tlkp_propsubcateg (int_siteid,int_subcateg, int_parcateg) 
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MERP_TLKP_PROPERTY;



/* ==============================

  Base Tables

============================== */

/* Resource Table
  Stores each resource, it's type, and a description
  A Resource is any entity that can perform a function:
  employees, Maintenance Teams,
  Halls, centers, accomodation centers, etc
*/
select 'Resource Table (msres_tbl_resource)' from rdb$database;
CREATE TABLE msres_tbl_resource (
  int_siteid INTEGER NOT NULL,	/* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_resid BIGINT NOT NULL,	/* This ResourceID */
  int_restype BIGINT NOT NULL, 	/* What type is this resource */
  str_name VARCHAR(150) NOT NULL,
  str_desc VARCHAR(500),
  int_contact BIGINT, 	/* Is this resource a contact from CRM? */
  int_position BIGINT, /* Does this resource fill a position */
  int_department BIGINT, /* And is it a member of a department */
  str_address VARCHAR(100),
  str_city VARCHAR(100),
  str_state VARCHAR(100),
  str_postcode VARCHAR(100),
  str_country VARCHAR(100),
    PRIMARY KEY (int_siteid,int_resid),
    UNIQUE (int_siteid, str_name),
    UNIQUE (int_siteid, int_contact),
    FOREIGN KEY (int_siteid, int_restype) 
      REFERENCES msres_tlkp_restype (int_siteid,int_restype) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_contact)
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_position)
      REFERENCES msres_tlkp_position (int_siteid, int_position)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_department)
      REFERENCES msres_tlkp_department (int_siteid, int_department)
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MERP_TBL_RESOURCE;




/* =============================

  Link Tables

============================= */


/* Resource Property Link Table 
  Resource have properties - 
  Here's where we store them all */
select 'Resource Property Link Table (msres_tlnk_resproperty)' from rdb$database;
CREATE TABLE msres_tlnk_resproperty (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_resid BIGINT NOT NULL, /* The Resource ID */
  int_PID BIGINT NOT NULL, /* The Property ID */
  str_Text VARCHAR(200) NOT NULL, /* The value for the property */
    PRIMARY KEY (int_siteid, int_resid,int_pid),
    FOREIGN KEY (int_siteid,int_resid) 
      REFERENCES msres_tbl_resource (int_siteid,int_resid) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid,int_PID) 
      REFERENCES msres_tlkp_Property (int_siteid,int_PID) 
      ON UPDATE CASCADE
);


/* Resource Grouping Table
  A resource be a member of another resource
  i.e. An Employee in a Maintenance Gang
  A chair in a cafeteria(joke, but possible)
*/
select 'Resource Grouping Table (msres_tlnk_resgroup)' from rdb$database;
CREATE TABLE msres_tlnk_resgroup (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_resid BIGINT NOT NULL,
  int_parentid BIGINT NOT NULL,
    PRIMARY KEY(int_siteid, int_resid, int_parentid),
    FOREIGN KEY(int_siteid,int_resid) 
      REFERENCES msres_tbl_resource (int_siteid,int_resid) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_parentid) 
      REFERENCES msres_tbl_resource (int_siteid,int_resid) 
      ON UPDATE CASCADE
);
  

/* Resource Properties Link Table
A Hotel room resource might have properties, ie:
spa:yes;
dbl_bed:no
twin_single:yes
TV:yes
etc.
*/

/* Resource Scheduling
  Here, we actually schedule resources to tasks of activities
  Using the requirements of the above table(msres_tlnk_acttask)
  We Assign resources to the task
  Event:Training Conference, Activity:Dinner, Resource:Dining Hall
  
*/
select 'Resource Scheduling (msres_tlnk_schedres)' from rdb$database;
CREATE TABLE msres_tlnk_schedres (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_sched BIGINT NOT NULL, 	/* A unique ID for this sched entry */
  int_activity BIGINT NOT NULL, 	/* The Activity */
  int_task BIGINT NOT NULL, 	/* The task therein */
  int_resid BIGINT NOT NULL, 	/* This resource */
  int_deppos BIGINT, /* Which position in the department is this for (if at all)*/
  dtm_indate DATE DEFAULT 'now' NOT NULL, /* Date put into system */
  dtm_intime TIME DEFAULT 'now' NOT NULL, /* Time put into system */
  dtm_startdate DATE NOT NULL, 	/* What day would we like this started */
  dtm_starttime TIME NOT NULL, 	/* What time of day to start */
  ibl_requested INTEGER,  	/* Scheduling request sent (Can you work) */
  ibl_confirm INTEGER, 		/* Request granted (Yes, we can) */
  ibl_complete INTEGER, 	/* 0,1 The task was completed */
  ibl_timetaken INTEGER, 	/* Incremental time (In seconds) worked/used */
  flt_percent INTEGER, 		/* (0-100%) How much of the task was completed */
  str_notes VARCHAR(20000), 	/* Explain why it was not done!! */
   PRIMARY KEY(int_siteid,int_sched),
    FOREIGN KEY(int_siteid,int_activity) 
      REFERENCES msres_tbl_activity (int_siteid,int_activity) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_activity,int_task) 
      REFERENCES msres_tlnk_acttask (int_siteid,int_activity,int_task) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_resid) 
      REFERENCES msres_tbl_resource (int_siteid,int_resid) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_deppos) 
      REFERENCES msres_tlkp_departpos (int_siteid,int_deppos) 
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MERP_TLNK_SCHEDRES;

/* Hooks into CRM
People have to attend events/activities
Bookings, deposits, payments, dates and times
Special requirements, feedback
Put it all here
*/

/* Contact Accomodation Resource Assignments */
select 'Contact Build. Resource Assignments (msres_tlnk_contbresass)' from rdb$database;
CREATE TABLE msres_tlnk_contbresass (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_eventid BIGINT NOT NULL, /* Which Event */
  int_contact BIGINT NOT NULL, /* The Contact */
  int_resid BIGINT NOT NULL, /* The resource for this contact (bed) */
  dtm_dstart DATE, /* From when */
  dtm_tstart TIME, /* From when */
  dtm_dend DATE, /* To When */
  dtm_tend TIME, /* To When */
    PRIMARY KEY(int_siteid, int_eventid, int_contact, int_resid),
    FOREIGN KEY(int_siteid, int_eventid)
      REFERENCES msres_tbl_event (int_siteid, int_eventid)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_contact)
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_resid)
      REFERENCES msres_tbl_resource (int_siteid, int_resid)
      ON UPDATE CASCADE
);


select 'End of SITE RESOURCES include' from rdb$database;


