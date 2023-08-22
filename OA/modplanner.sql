/* mod_planner module for OpenAspect
(MPLN prefix)

Handles planning, scheduling, and repetition for
Assets
Logistics
CRM (Customer meetings, sales, orders)
ERP (Employee tasks, timesheet, projects, activities, meetings, contracts)

More stuff to come later...
#
# $Id: modplanner.sql,v 1.15 2005/09/13 01:47:17 nweeks Exp nweeks $
#
# $Log: modplanner.sql,v $
# Revision 1.15  2005/09/13 01:47:17  nweeks
# Removed timestamps from humen-usable fields
#
# Revision 1.14  2004/07/11 23:14:51  nigel
# Rolled out the new boolean type (ibl_)
#
# Revision 1.13  2004/04/20 02:12:34  nigel
# Fixed up a worldwide constraint...
# changed to a sitewide one.
#
# Revision 1.12  2004/04/19 22:49:20  nigel
# Linked up tlkp_plantype (Was missing ref integ)
#
# Revision 1.11  2004/01/14 03:53:54  nigel
# Change to activity to module link table
# consignment is changed name
#
# Revision 1.10  2003/12/11 02:44:02  nigel
# Fixed ordering of module links to activity
#
# Revision 1.9  2003/12/11 02:35:29  nigel
# Fixed the stub planner relations
#
# Revision 1.8  2003/09/30 00:43:31  nigel
# Updated license
#
# Revision 1.7  2003/09/19 00:37:31  nigel
# Fixed the hierarchy bug
#
# Revision 1.6  2003/09/18 05:56:40  nigel
# Documented the ascii art a little more
#
# Revision 1.5  2003/09/18 05:30:15  nigel
# Did a nice little ascii-art picture to explain hierarchy system
#
# Revision 1.4  2003/09/18 05:10:35  nigel
# Added better planning code
#
# Revision 1.3  2003/09/17 23:13:30  nigel
# Updated Copyright notice
#
# Revision 1.2  2003/09/17 22:59:14  nigel
# Added changelog lines
#
#
*/

/* Lookup Tables
*/

/* Planner Entry Type lookup table
Is this used for: Asset Maintenance/CRM Meeting/Freight Shipment/Contract dates/etc
*/
SELECT 'Planner Entry Types Lookup table (mpln_tlkp_plantype)' from RDB$DATABASE;
CREATE TABLE mpln_tlkp_plantype (
  int_siteid INTEGER NOT NULL, /* Replication SUpport */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_type INTEGER NOT NULL,
  str_module VARCHAR(5), /* OpenAspect module: MASS/MLOGI/MCRM/MERP/MPLN */
  str_type VARCHAR(30) NOT NULL,
  str_desc VARCHAR(2000),
    PRIMARY KEY(int_siteid, int_type),
    UNIQUE (int_siteid,str_type)
);



/* Base Tables
mpln_tbl_planitem
mpln_tbl_planner
*/

/* Plan Item Table
These are the place-holders for the super-sets of every schedulable item from every module
The entries in the table are the ones with the dates/times
The links to the other modules are done with the link table
*/
select 'Plan Item Table (mpln_tbl_planitem)' from rdb$database;
CREATE TABLE mpln_tbl_planitem (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_activity BIGINT NOT NULL,
  ibl_planned INTEGER, /* Planning stage yes/no */
  ibl_active INTEGER, /* Go ahead with plan */
  int_type INTEGER, /* References mpln_tlkp_plantype */
  dtm_dentered DATE DEFAULT 'now',
  dtm_tentered TIME DEFAULT 'now',
  dtm_dupdated DATE DEFAULT 'now',
  dtm_tupdated TIME DEFAULT 'now',
  dtm_startdate DATE, /* (Proposed) */
  dtm_starttime TIME, /* (Proposed) */
  dtm_stopdate DATE, /* (Proposed) */
  dtm_stoptime TIME, /* (Proposed) */
  int_estdur NUMERIC(18,2), /* Estimated Duration */
  str_durunit VARCHAR(10), /* Duration Units: Minute/Hour/Month/etc */
  ibl_completed INTEGER, /* <100:not complete, >=100:complete */
    PRIMARY KEY(int_siteid, int_activity)
);
CREATE GENERATOR GEN_MPLN_TBL_PLANITEM;
  


/* Planner Table
This stores a planner entry for an activity, it's length of time, and status
This is the calendar. The master control. All dates/times outside this table are suggestions/defaults/guides.
*/
select 'Planner Central Storage (mpln_tbl_planner)' from rdb$database;
CREATE TABLE mpln_tbl_planner (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_plan BIGINT NOT NULL,
  int_type BIGINT,
  int_activity BIGINT NOT NULL, /* Hooks into Activity */
  dtm_startdate DATE,
  dtm_starttime TIME,
  dtm_stopdate DATE,
  dtm_stoptime TIME,
  dtm_haltdate DATE, /* Finished or not, Work must have stopped here */
  dtm_halttime TIME, /* May collide with other entries following) */
  int_estdur NUMERIC(18,2), /* Estimated Duration */
  str_durunit VARCHAR(10), /* DUration Units: Minute/Hour/Month/etc */
  ibl_completed INTEGER, /* Is it finished? */
  flt_complete NUMERIC(18,2), /* How far through is it? */
    PRIMARY KEY(int_siteid, int_plan, int_activity),
    FOREIGN KEY(int_siteid, int_activity) 
      REFERENCES mpln_tbl_planitem (int_siteid, int_activity) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid, int_type)
      REFERENCES mpln_tlkp_plantype (int_siteid, int_type)
      ON UPDATE CASCADE
);

/* Plan Injector 
This table stores the intervals/repeat dates
so that plans can repeat automatically
*/
select 'Repeating Plan Injector (mpln_tbl_planinjector)' from rdb$database;
CREATE TABLE mpln_tbl_planinjector (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_activity BIGINT NOT NULL,
  int_injecttype INTEGER, /* 0:once off, 1:interval, 2:fixed point */
  flt_interval NUMERIC(18,2), /* How many intervals(mode '1') */
  str_interval VARCHAR(10), /* Unit of Interval(day/week/month/year) */
  str_pointtype VARCHAR(10), /* Type of point (h_d,d_w,d_m,w_m,m_y */
  int_point BIGINT, /* 5(h_d)=5am every day, 5(d_m)=5th of every month, 2(w_m)=2nd week of every month */
  int_repeats INTEGER, /* How many times to repeat this?(-1:forever,0:none,n:ntimes) */
  int_remaining INTEGER, /* How many repeats are left('n' mode only) */
  str_notes VARCHAR(2000),
    PRIMARY KEY(int_siteid, int_activity)
);
  

/* =============

Link Tables

============= */  

/* Activity to Module Link Table
  Unfortunately, the referential integrity of this table has to be
  enforced programatically by layers above, otherwise, we'll have
  to keep adding to this table as new modules come on-line

  A few nice triggers should sort that out...;-)
*/
select 'Activity to Module Link Table (mpln_tlnk_actmodule)' from rdb$database;
CREATE TABLE mpln_tlnk_actmodule (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_activity BIGINT NOT NULL,
  int_order INTEGER DEFAULT 0 NOT NULL,
  int_assservid BIGINT, /* Asset Service ID */
  int_assmonid BIGINT, /* Asset Monitoring ID */
  int_consid BIGINT, /* Logistics Consignment ID */
  int_crmdealid BIGINT, /* CRM Dealings ID */
  int_erpvid BIGINT, /* Asset Service ID */
    PRIMARY KEY (int_siteid, int_activity, int_order),
    FOREIGN KEY (int_siteid, int_activity) 
      REFERENCES mpln_tbl_planitem (int_siteid, int_activity) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid, int_assservid) 
      REFERENCES mass_tbl_assetserv (int_siteid, int_service) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid, int_assmonid)
      REFERENCES mass_tlnk_assetmoNitor (int_siteid, int_monid)
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid, int_consid) 
      REFERENCES mlogi_tbl_consignment (int_siteid, int_consid) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid, int_crmdealid) 
      REFERENCES mcrm_tbl_contdeal (int_siteid, int_dealing) 
      ON UPDATE CASCADE
);

/* Activity Hierarchy
Activities can have sub-activities, dependencies, etc
Store them here
Dependencies:
  CWFP: Child Waits for Parent(before start)
    These can continue to the right(beads pulled out flat)
  PWFC: Parent waits for Child(s)(before complete - usually master activity)
    These Drop cstraight down into child tasks(hanging beads)
Graphing: CWFP's go sideways, PWFC's go downwards
1Project(PWFC)
  |
  |-2Design App(CWFP) -> 3Build App(CWFP,PWFC) -> -> -> -> -> -> -> -> 8Sell App(CWFP,PWFC)
                           |                                           |
                           |-4Build DB(CWFP) -> -> -> 5Test DB(CWFP)   |-9Advertise(CWFP) -> 10Sell(CWFP)
                           |
                           |-6Build Interface(CWFP) -> -> 7Test Interface(CWPF)
pact	cact	PWFC	CWFP
1	2	1	0	(2 can start immediately)
2	3	0	1	(3 can start as soon as 2 is finished)
3	4	1	0	(4 starts in order to close 3)
3	6	1	0	(6 starts in order to close 3) (if(5=done && 7=done){3=done})
4	5	0	1	(when 4 is done, 5 starts)
6	7	0	1	(when 6 is done, 7 starts)
3	8	0	1	(3 has to finish before 8 can begin)
8	9	1	0	(9 starts in order to close 8)
9	10	0	1	(when 9 is done, 10 starts)
When 10 is done, 8 will close, and 1 can close


When all children of 'Project' are complete(it's a PWFC), it completes...
*/
select 'Activity Hierarchy Storage (mpln_tlnk_acthier)' from rdb$database;
CREATE TABLE mpln_tlnk_acthier (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_pact BIGINT NOT NULL, /* Parent Activity */
  int_cact BIGINT NOT NULL, /* Child Activity */
  int_pwfc INTEGER, /* Parent waits for Child (Before Complete) */
  int_cwfp INTEGER, /* Child waits for Parent (before start) */
  flt_order NUMERIC(18,2) DEFAULT 0 NOT NULL, /* To help presentation on printouts, etc */
    PRIMARY KEY(int_siteid, int_pact, int_cact, flt_order),
    FOREIGN KEY(int_siteid, int_pact) 
      REFERENCES mpln_tbl_planitem (int_siteid, int_activity) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_cact) 
      REFERENCES mpln_tbl_planitem (int_siteid, int_activity) 
      ON UPDATE CASCADE
);

