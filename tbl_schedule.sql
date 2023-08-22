
/* =================================================
 *
 * Entity Name: 'tbl_schedule.sql'
 * Description:
 *
 *
 * $Id: tbl_schedule.sql,v 1.3 2011/06/22 01:33:25 nweeks Exp nweeks $
 *
 * $Log: tbl_schedule.sql,v $
 * Revision 1.3  2011/06/22 01:33:25  nweeks
 * BigInt upgrade
 *
 * Revision 1.2  2008/07/01 03:22:37  nweeks
 * General Checkin
 *
 * Revision 1.1  2007/08/31 07:01:18  nweeks
 * Initial revision
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_schedule.sql...' from rdb$database;


CREATE TABLE tbl_schedule (
  int_scheduleid BIGINT NOT NULL,
  int_taskid BIGINT NOT NULL,
  int_userid BIGINT NOT NULL,
  dtm_sdate DATE NOT NULL,
  tme_stime TIME,
  dtm_edate DATE,
  tme_etime TIME,
  str_notes VARCHAR(4096),
  ibl_private INTEGER default 0,  /* non-private schedule items are visible to other users. Duh */
    PRIMARY KEY(int_scheduleid),
    FOREIGN KEY(int_taskid) REFERENCES tbl_task(int_taskid),
    FOREIGN KEY(int_userid) REFERENCES tbl_user(int_userid)
);
CREATE GENERATOR gen_tbl_schedule;



