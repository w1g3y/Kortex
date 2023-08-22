/* MODEVE_
MOD_EVE is the Events/Projects module for OpenAspect

It handles:
Customer activity, accomodation, and feedback
Provider facilities, specials, promotions
All tables, procedures, triggers, generators are to be prepended with:
meve_*

User table is inherited from mod_user OE module

TODO:
Think about activities having sub-activities(Contract Projects with sub-projects)

===============================
EVE - (Event/Project Management) section
===============================

#
# $Id: modevent.sql,v 1.2 2005/01/14 02:06:30 nweeks Exp nweeks $
# 
# $Log: modevent.sql,v $
# Revision 1.2  2005/01/14 02:06:30  nweeks
# Further mods to hook into CRM.
# Still in progress!
#
# Revision 1.1  2005/01/14 00:32:00  nweeks
# Initial revision
#
#
*/

/* =============================

  Lookup Tables

============================= */


/* Event Types
Construction Project, Software Testing, Company Training Camp
*/
select 'Event Types' from rdb$database;
CREATE TABLE meve_tlkp_eventtype (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_type NUMERIC(18,0) NOT NULL,
  str_type VARCHAR(60) NOT NULL,
    PRIMARY KEY(int_siteid, int_type),
    UNIQUE (int_siteid, str_type)
);
CREATE GENERATOR GEN_MEVE_TLKP_EVENTTYPE;


/* Activity Types
Program Items, Meals, etc
*/
select 'Activity Types' from rdb$database;
CREATE TABLE meve_tlkp_acttype (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_type NUMERIC(18,0) NOT NULL,
  str_type VARCHAR(60) NOT NULL,
    PRIMARY KEY(int_siteid, int_type),
    UNIQUE (int_siteid, str_type)
);
CREATE GENERATOR GEN_MEVE_TLKP_ACTTYPE;

/* Task Types
*/
select 'Task Types' from rdb$database;
CREATE TABLE meve_tlkp_tasktype (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_type NUMERIC(18,0) NOT NULL,
  str_type VARCHAR(60) NOT NULL,
    PRIMARY KEY(int_siteid, int_type),
    UNIQUE (int_siteid, str_type)
);
CREATE GENERATOR GEN_MEVE_TASKTYPE;





/* ==============================

  Base Tables

============================== */
/* Base Event Table
The heirarchy of storage goes as thus:
Event
  -> Ev. Resources(Site Resources) (This campsite(Build.Res) for this conference(Evnt))
  -> Ex. Resources(Human)(HRM for Evnt)
  -> Activities (These Meals(Act) for this conference(event)
    -> Act. Resources(HR for Act)
    -> Act. Resources(Building for Act)
    -> Act. Tasks associated
      -> Task Resources(HR for Task)
      -> Task Resources(Building for Task)
Scheduling/tracking of events/activities/tasks is done by mod_planner
*/
select 'Base Event Table (meve_tbl_event)' from rdb$database;
CREATE TABLE meve_tbl_event (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_eventid NUMERIC(18,0) NOT NULL,
  int_type NUMERIC(18,0),
  str_name VARCHAR(100) NOT NULL,
  str_desc VARCHAR(1000),
  dtm_dbooked DATE,
  dtm_tbooked TIME,
  dtm_dconfirmed DATE,
  dtm_tconfirmed TIME,
  dtm_ddeposit DATE,
  dtm_tdeposit TIME,
  dtm_dpaid DATE,
  dtm_tpaid TIME,
  dtm_dbegin DATE,
  dtm_tbegin TIME,
  dtm_dend DATE,
  dtm_tend TIME,
    PRIMARY KEY(int_siteid, int_eventid),
    FOREIGN KEY(int_siteid, int_type)
      REFERENCES meve_tlkp_eventtype(int_siteid, int_type)
      ON UPDATE CASCADE
);
CREATE GENERATOR gen_meve_tbl_event;

/* Base Activity Table
  Stores the core of the activity
  An activity could be either Activity, Project, Contract, etc.
  Actual Dates, and completion data is stored in mplan_tbl_activity
  This table allows us to hook together resources,
  The other table starts the activity, and monitors it
*/
select 'Base Activity Table (meve_tbl_activity)' from rdb$database;
CREATE TABLE meve_tbl_activity (
  int_siteid INTEGER NOT NULL, 	/* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_activity NUMERIC(18,0) NOT NULL, 	/* The Activity ID (Autogen)*/
  int_eventid NUMERIC(18,0), /* The Event we're linked to */
  int_type NUMERIC(18,0), /* Activity Type */
  str_activity VARCHAR(200) NOT NULL, 	/* Name of the Activity */
  int_assetsrv NUMERIC(18,0), 		/* Has this Activity come from modasset's service scheduling */
  dtm_date DATE DEFAULT 'now' NOT NULL,
  dtm_time TIME DEFAULT 'now' NOT NULL,
  ibl_planned INTEGER, 	/* 0:unplanned, 1:planned */
  ibl_confirmed INTEGER,/* 0:Don't go ahead yet, 1:Go ahead */
  ibl_started INTEGER, /* 0:not started, 1:Started */
  int_percomplete INTEGER, /* <100:not complete, >=100:complete */
  str_ruid NUMERIC(18,0), 	/* Who requested this activity */
  str_puid NUMERIC(18,0), 	/* Who's planning this activity */
  str_cuid NUMERIC(18,0), 	/* Who confirmed this activity, and gave the go-ahead */
    PRIMARY KEY(int_siteid,int_activity),
    FOREIGN KEY(int_siteid,int_eventid)
      REFERENCES meve_tbl_event (int_siteid, int_eventid)
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MEVE_TBL_ACTIVITY;




/* =============================

  Link Tables

============================= */



/* Activity Tasks Table
  Any Activity has Tasks
  Store them here, with some allocation requirements
*/
select 'Activity Tasks Table (meve_tlnk_acttask)' from rdb$database;
CREATE TABLE meve_tlnk_acttask (
  int_siteid INTEGER NOT NULL,	/* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_task NUMERIC(18,0) NOT NULL, 	/* The Task inside the Activity */
  int_activity NUMERIC(18,0) NOT NULL, 	/* The Activity */
  int_assettsk NUMERIC(18,0), 		/* Has this task come from modasset's service scheduling */
  int_deppos NUMERIC(18,0), /* Which position in the department is this for (if at all)*/
  int_restype INTEGER, 		/* Type of Resource required (Welder) */
  int_reqres INTEGER, 		/* Resources required for this task 2:(Welders) */
  int_allocres INTEGER, 	/* Have resources been allocated to this task */
    PRIMARY KEY (int_siteid,int_activity,int_task),
    FOREIGN KEY (int_siteid,int_activity) 
      REFERENCES meve_tbl_activity (int_siteid,int_activity) 
      ON UPDATE CASCADE
/*
    FOREIGN KEY (int_siteid, int_restype) 
      REFERENCES meve_tlkp_restype (int_siteid,int_restype) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid,int_deppos) 
      REFERENCES meve_tlkp_departpos (int_siteid,int_deppos) 
      ON UPDATE CASCADE
*/
);
CREATE GENERATOR GEN_MEVE_TLNK_ACTTASK;


/* Hooks into CRM
People have to attend events/activities
Bookings, deposits, payments, dates and times
Special requirements, feedback
Put it all here
*/

/* Contact to Event Link Table
Who(from CRM) is coming to this event
*/
select 'Event to Contact Table (meve_tlnk_evntcont)' from rdb$database;
CREATE TABLE meve_tlnk_evntcont (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_eventid NUMERIC(18,0) NOT NULL,
  int_contact NUMERIC(18,0) NOT NULL,
  dtm_dbooked DATE,
  dtm_tbooked TIME,
  dtm_dconfirmed DATE,
  dtm_tconfirmed TIME,
  dtm_ddeposit DATE,
  dtm_tdeposit TIME,
  dtm_dpaid DATE,
  dtm_tpaid TIME,
  dtm_dbegin DATE,
  dtm_tbegin TIME,
  dtm_dend DATE,
  dtm_tend TIME,
  flt_deposit NUMERIC(18,2), /* How much deposit has been paid */
  flt_paid NUMERIC(18,2), /* How much remainder has been paid */
  flt_fee NUMERIC(18,2), /* The entire fee (Fee == (Deposit + Paid)) */
  str_specreq VARCHAR(1000), /* Special Requirements */
  str_feedback VARCHAR(2000),
  str_notes VARCHAR(2000),
    PRIMARY KEY(int_siteid, int_eventid, int_contact),
    FOREIGN KEY(int_siteid, int_eventid)
      REFERENCES meve_tbl_event (int_siteid, int_eventid)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_contact)
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact)
      ON UPDATE CASCADE
); 

/* Contact to Activity+Task Table
 * Who(from CRM) is doing this activity
 */
select 'Activity to Contact Table (meve_tlnk_actcont)' from rdb$database;
CREATE TABLE meve_tlnk_actcont (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_activity NUMERIC(18,0) NOT NULL,
  int_task NUMERIC(18,0),
  int_contact NUMERIC(18,0) NOT NULL,
  dtm_dstart DATE,
  dtm_tstart TIME,
  dtm_dfinish DATE,
  dtm_tfinish TIME,
  str_specreq VARCHAR(1000), /* Special Requirements */
  str_feedback VARCHAR(2000),
  str_notes VARCHAR(2000),
    PRIMARY KEY(int_siteid, int_activity, int_contact),
    FOREIGN KEY(int_siteid, int_activity)
      REFERENCES meve_tbl_activity(int_siteid, int_activity)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_activity, int_task)
      REFERENCES meve_tlnk_acttask(int_siteid, int_activity, int_task)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_contact)
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact)
      ON UPDATE CASCADE
);



select 'End of EVE include' from rdb$database;


