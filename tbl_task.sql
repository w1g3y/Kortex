
/* =================================================
 *
 * Entity Name: 'tbl_task.sql'
 * Description:
 *
 *
 * $Id: tbl_task.sql,v 1.5 2012/11/30 00:07:59 nweeks Exp nweeks $
 *
 * $Log: tbl_task.sql,v $
 * Revision 1.5  2012/11/30 00:07:59  nweeks
 * Added Task hierarchy (gantt) controls
 *
 * Revision 1.4  2012/11/29 23:58:54  nweeks
 * iAdded project linkage
 *
 * Revision 1.3  2011/06/22 01:33:25  nweeks
 * BigInt upgrade
 *
 * Revision 1.2  2008/07/01 03:22:37  nweeks
 * General Checkin
 *
 * Revision 1.1  2007/08/31 07:01:18  nweeks
 * Initial revision
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_task.sql...' from rdb$database;


CREATE TABLE tbl_task (
  int_taskid BIGINT NOT NULL,
  int_projectid BIGINT,
  int_createdby INTEGER,
  int_createdfor INTEGER,
  str_name VARCHAR(100) NOT NULL,
  str_calltype VARCHAR(40),
  str_department VARCHAR(300),
  blb_desc BLOB SUB_TYPE TEXT ,
  int_priorityid INTEGER default 1 NOT NULL /*  */
  dtm_created TIMESTAMP default 'now',
  dtm_edited TIMESTAMP default 'now',
  int_complete INTEGER, /* 0-100% */
  int_contactid INTEGER,
  int_previoustaskid BIGINT,   /* Handles when this task can start (gantt) */
  int_previousflagid INTEGER,  /* Prev.started, Prev.complete, etc)
    PRIMARY KEY(int_taskid),
    FOREIGN KEY(int_createdby) REFERENCES tbl_user(int_userid),
    FOREIGN KEY(int_createdfor) REFERENCES tbl_user(int_userid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid),
    FOREIGN KEY(int_projectid) REFERENCES tbl_project(int_projectid),
    FOREIGN KEY(int_priorityid) REFERENCES tlkp_listchoices(int_listid)
    FOREIGN KEY(int_previoustaskid) REFERENCES tbl_task(int_taskid),
    FOREIGN KEY(int_previousflagid) REFERENCES tlkp_listchoices(int_listid)
);
CREATE GENERATOR GEN_TBL_TASK;


