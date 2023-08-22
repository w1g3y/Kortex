
/* =================================================
 *
 * Entity Name: 'tbl_timesheet.sql'
 * Description:
 *
 *
 * $Id: tbl_timesheet.sql,v 1.2 2011/06/22 01:33:25 nweeks Exp nweeks $
 *
 * $Log: tbl_timesheet.sql,v $
 * Revision 1.2  2011/06/22 01:33:25  nweeks
 * BigInt upgrade
 *
 * Revision 1.1  2009/01/22 01:21:01  nweeks
 * Initial revision
 *
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_timesheet.sql...' from rdb$database;


CREATE TABLE tbl_timesheet (
  INT_TIMESHEETID BIGINT NOT NULL,
  INT_USERID BIGINT NOT NULL,
  INT_TASKID BIGINT NOT NULL,
  DTM_SDATE DATE,
  DTM_STIME TIME,
  DTM_EDATE DATE,
  DTM_ETIME TIME,
);
CREATE GENERATOR GEN_TBL_TIMESHEET;


ALTER TABLE TBL_TIMESHEET ADD FOREIGN KEY (INT_USERID) REFERENCES TBL_USER
(INT_USERID);

ALTER TABLE TBL_TIMESHEET ADD FOREIGN KEY (INT_TASKID) REFERENCES TBL_TASK
(INT_TASKID);



