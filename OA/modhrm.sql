/* ==================
 * mod_hrm module for OpenAspect
 *
 * This is a product of parts of mod_erp, and consultation with HRM experts
 *
 * It was decided to break HRM out into a seperate module to reduce
 * complexity in ERP tables (ERP will then become EVENT management
 * ==================
 * $Id: modhrm.sql,v 1.3 2005/09/13 00:59:30 nweeks Exp nweeks $
 *
 * $Log: modhrm.sql,v $
 * Revision 1.3  2005/09/13 00:59:30  nweeks
 * Removed timestamps from human-usable fields
 *
 * Revision 1.2  2005/01/14 02:05:57  nweeks
 * This is the new HRM module for OpenAspect
 * It's still in progress, ready for the 008 release
 *
 * Revision 1.1  2005/01/14 00:08:26  nweeks
 * Initial revision
 *
 * ==================
 */

/* =============================

  Lookup Tables

============================= */

/* Resource Types Lookup
  What is this resource?
  Conference Hall, Welder, Bodyguard, etc
*/
select 'Human Resource Types Lookup Table (mhrm_tlkp_restype)' from rdb$database;
CREATE TABLE mhrm_tlkp_restype (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_restype BIGINT NOT NULL,   /* The code of the resource type */
  str_restype VARCHAR(150) NOT NULL, /* The name of type */
    PRIMARY KEY(int_siteid,int_restype),
    UNIQUE(int_siteid,str_restype)
);
CREATE GENERATOR GEN_MHRM_TLKP_RESTYPE;


/* The department in the organisation */
select 'Department in the Organisation' from rdb$database;
CREATE TABLE mhrm_tlkp_department (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_department BIGINT NOT NULL,
  str_depcode VARCHAR(10),
  str_department VARCHAR(40),
  str_desc VARCHAR(2000),
    PRIMARY KEY(int_siteid, int_department),
    UNIQUE (int_siteid, str_depcode),
    UNIQUE (int_siteid, str_department)
);
CREATE GENERATOR gen_mhrm_tlkp_department;

/* The Job's Position, and associated info */
CREATE TABLE mhrm_tlkp_position (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_position BIGINT NOT NULL,
  str_poscode VARCHAR(10),
  str_position VARCHAR(40),
  str_desc VARCHAR(2000),
    PRIMARY KEY(int_siteid,int_position),
    UNIQUE(int_siteid,str_poscode),
    UNIQUE(int_siteid,str_position)
);
CREATE GENERATOR gen_mhrm_tlkp_position;


/* tlkp_departpos
What positions, and how many, are available in what departments
*/
CREATE TABLE mhrm_tlkp_departpos (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_deppos BIGINT NOT NULL,
  int_department BIGINT NOT NULL,
  int_position BIGINT NOT NULL,
  int_count INTEGER NOT NULL, /* how many of this position, in this departm
ent */
    PRIMARY KEY(int_siteid,int_deppos),
    UNIQUE (int_siteid,int_department, int_position),
    FOREIGN KEY(int_siteid,int_department)
      references mhrm_tlkp_department (int_siteid,int_department)
      on update cascade,
    FOREIGN KEY(int_siteid,int_position)
      references mhrm_tlkp_position (int_siteid,int_position)
      on update cascade
);
CREATE GENERATOR GEN_MHRM_TLKP_DEPARTPOS;

/* ==============================

  Base Tables

============================== */

/* Resource Table
  Stores each resource(employee, contractor, consultant, etc), it's type, 
  and a description
  A Resource is any entity that can perform a function:
  employees, Maintenance Teams,
  Halls, centers, accomodation centers, etc
*/
select 'Resource Table (mhrm_tbl_resource)' from rdb$database;
CREATE TABLE mhrm_tbl_resource (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_resid BIGINT NOT NULL,     /* This ResourceID */
  int_restype BIGINT NOT NULL,   /* What type is this resource */
  str_surname VARCHAR(20) NOT NULL,
  str_names VARCHAR(40) NOT NULL,
  str_gender VARCHAR(1), 
  dtm_dob DATE, 
  str_desc VARCHAR(500),
  int_contact BIGINT,    /* Is this resource a contact from CRM? */
  int_emcontact1 BIGINT, /* Emergency Contact one */
  int_emcontact2 BIGINT, /* Emergency Contact two */
  int_position BIGINT, /* Does this resource fill a position */
  int_department BIGINT, /* And is it a member of a department */
  str_address VARCHAR(100),
  str_city VARCHAR(100),
  str_state VARCHAR(100),
  str_postcode VARCHAR(100),
  str_country VARCHAR(100),
  str_note1 VARCHAR(1000),
  str_note2 VARCHAR(1000),
  str_note3 VARCHAR(1000),
  str_note4 VARCHAR(1000),
    PRIMARY KEY (int_siteid,int_resid),
    UNIQUE (int_siteid, str_surname, str_names),
    UNIQUE (int_siteid, int_contact),
    FOREIGN KEY (int_siteid, int_restype)
      REFERENCES mhrm_tlkp_restype (int_siteid,int_restype)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_contact)
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_emcontact1)
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_emcontact2)
      REFERENCES mcrm_tbl_contact (int_siteid, int_contact)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_position)
      REFERENCES mhrm_tlkp_position (int_siteid, int_position)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_department)
      REFERENCES mhrm_tlkp_department (int_siteid, int_department)
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MHRM_TBL_RESOURCE;

/* =============================

  Link Tables

============================= */

/*
 * Resource Employment History
 */
select 'Resource Employment History (mhrm_tlnk_resemphist)' from rdb$database;
CREATE TABLE mhrm_tlnk_resemphist (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_histid BIGINT NOT NULL, /* PKey */
  int_resid BIGINT NOT NULL,     /* This ResourceID */
  str_position VARCHAR(1000),
  str_status VARCHAR(10),
  dtm_commence DATE,
  dtm_terminate DATE,
  str_reason VARCHAR(1000),
    PRIMARY KEY(int_siteid, int_histid, int_resid),
    FOREIGN KEY(int_siteid, int_resid)
      REFERENCES mhrm_tbl_resource (int_siteid, int_resid)
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MHRM_TLNK_RESEMPHIST;


/*
 * Resource Payroll Data
 */
select 'Resource Payroll Data (mhrm_tlnk_respaydata)' from rdb$database;
CREATE TABLE mhrm_tlnk_respaydata (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_resid BIGINT NOT NULL,     /* This ResourceID */
  int_department BIGINT NOT NULL,
  int_position BIGINT NOT NULL,
  str_datatype VARCHAR(10) NOT NULL, /* Salary,HourlyRate,BaseWage,Allowance,Deduction,ShiftPenal */
  flt_data NUMERIC(18,6),
    PRIMARY KEY(int_siteid, int_resid, int_department, int_position, str_datatype),
    FOREIGN KEY (int_siteid, int_resid)
      REFERENCES mhrm_tbl_resource (int_siteid, int_resid)
      ON UPDATE CASCADE
);


/*
 * Resource Leave Periods 
 */
select 'Resource Leave Periods (mhrm_tlnk_resleaveper)' from rdb$database;
CREATE TABLE mhrm_tlnk_resleaveper (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_leaveid BIGINT NOT NULL,
  int_resid BIGINT NOT NULL,     /* This ResourceID */
  str_leavetype VARCHAR(2) DEFAULT 'AL' NOT NULL, /* AL, LS, CL, SL */
  dtm_leavestart DATE NOT NULL,
  dtm_leaveend DATE NOT NULL,
  str_notes VARCHAR(1000),
    PRIMARY KEY(int_siteid, int_leaveid, int_resid),
    FOREIGN KEY (int_siteid, int_resid)
      REFERENCES mhrm_tbl_resource (int_siteid, int_resid)
      ON UPDATE CASCADE
); 
CREATE GENERATOR GEN_MHRM_TLNK_RESLEAVEPER;

/*
 * Resource Leave Balance
 */
select 'Resource Leave Balance (mhrm_tlnk_resleavebal)' from rdb$database;
CREATE TABLE mhrm_tlnk_resleavebal (
  int_siteid INTEGER NOT NULL,  /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_resid BIGINT NOT NULL,
  dtm_asof DATE NOT NULL,
  flt_annual NUMERIC(18,4),
  flt_lngsrv NUMERIC(18,4),
  flt_sicklv NUMERIC(18,4),
  flt_compass NUMERIC(18,4),
    PRIMARY KEY(int_siteid, int_resid, dtm_asof),
    FOREIGN KEY (int_siteid, int_resid)
      REFERENCES mhrm_tbl_resource (int_siteid, int_resid)
      ON UPDATE CASCADE
);

  
  
 
  





/* Resource Grouping Table
  A resource be a member of another resource
  i.e. An Employee in a Maintenance Gang
*/
select 'Resource Grouping Table (mhrm_tlnk_resgroup)' from rdb$database;
CREATE TABLE mhrm_tlnk_resgroup (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_resid BIGINT NOT NULL,
  int_parentid BIGINT NOT NULL,
    PRIMARY KEY(int_siteid, int_resid, int_parentid),
    FOREIGN KEY(int_siteid,int_resid)
      REFERENCES mhrm_tbl_resource (int_siteid,int_resid)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_parentid)
      REFERENCES mhrm_tbl_resource (int_siteid,int_resid)
      ON UPDATE CASCADE
);

/* Resource Scheduling
  Here, we actually schedule resources to tasks of activities
  Using the requirements of the above table(mhrm_tlnk_acttask)
  We Assign resources to the task
  Event:Training Conference, Activity:Dinner, Resource:Dining Hall

*/
select 'Resource Scheduling (mhrm_tlnk_schedres)' from rdb$database;
CREATE TABLE mhrm_tlnk_schedres (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_sched BIGINT NOT NULL,     /* A unique ID for this sched entry
 */
  int_activity BIGINT NOT NULL,  /* The Activity */
  int_task BIGINT NOT NULL,      /* The task therein */
  int_resid BIGINT NOT NULL,     /* This resource */
  int_deppos BIGINT, /* Which position in the department is this for
 (if at all)*/
  dtm_indate DATE DEFAULT 'now' NOT NULL, /* Date put into system */
  dtm_intime TIME DEFAULT 'now' NOT NULL, /* Time put into system */
  dtm_startdate DATE NOT NULL,  /* What day would we like this started */
  dtm_starttime TIME NOT NULL,  /* What time of day to start */
  ibl_requested INTEGER,        /* Scheduling request sent (Can you work) *
/
  ibl_confirm INTEGER,          /* Request granted (Yes, we can) */
  ibl_complete INTEGER,         /* 0,1 The task was completed */
  ibl_timetaken INTEGER,        /* Incremental time (In seconds) worked/use
d */
  flt_percent INTEGER,          /* (0-100%) How much of the task was comple
ted */
  str_notes VARCHAR(20000),     /* Explain why it was not done!! */
   PRIMARY KEY(int_siteid,int_sched),
    FOREIGN KEY(int_siteid,int_activity)
      REFERENCES meve_tbl_activity (int_siteid,int_activity)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_activity,int_task)
      REFERENCES meve_tlnk_acttask (int_siteid,int_activity,int_task)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_resid)
      REFERENCES mhrm_tbl_resource (int_siteid,int_resid)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_deppos)
      REFERENCES mhrm_tlkp_departpos (int_siteid,int_deppos)
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MHRM_TLNK_SCHEDRES;


/* Resource Timesheet
  Employees only. It makes no sense to ask
  a conference theater to use a computer.
  Timesheet entries are used to influence
  the percent completed for the allocations of resources to tasks
  If the percentcomplete goes over 100%, time has gone over...
  Each row has the start and stop time for slices of work.
  If other tasks interrupt, the first is split, and the intermediate is ins
erted
  (Taken care of by Stored Proc)
*/
select 'Resource Timesheet (mhrm_tlnk_restime)' from rdb$database;
CREATE TABLE mhrm_tlnk_restime (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_resid BIGINT NOT NULL,     /* This resource (In this case, an employee) */
  int_activity BIGINT NOT NULL,  /* The activity in question */
  int_task BIGINT NOT NULL,      /* The Task for the Activity */
  dtm_strtdate DATE NOT NULL, /* When time on this began */
  dtm_strttime TIME NOT NULL, /* When time on this began */
  dtm_enddate DATE NOT NULL,   /* When time on this ended */
  dtm_endtime TIME NOT NULL,   /* When time on this ended */
    PRIMARY KEY(int_siteid, int_resid,int_activity,int_task,dtm_strtdate, dtm_strttime,dtm_enddate,dtm_endtime),
    FOREIGN KEY(int_siteid, int_resid)
      REFERENCES mhrm_tbl_resource (int_siteid,int_resid)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_activity)
      REFERENCES meve_tbl_activity (int_siteid,int_activity)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid,int_activity,int_task)
      REFERENCES meve_tlnk_acttask (int_siteid,int_activity,int_task)
      ON UPDATE CASCADE
);

