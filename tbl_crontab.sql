
/* =================================================
 *
 * Entity Name: 'tbl_crontab.sql'
 * Description:
 *
 *
 * $Id: tbl_crontab.sql,v 1.1 2012/06/14 03:11:39 nweeks Exp $
 *
 * $Log: tbl_crontab.sql,v $
 * Revision 1.1  2012/06/14 03:11:39  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_crontab.sql...' from rdb$database;

/* --------------
 * System :: CronTab Table
 *
 * Used for scheduling system tasks, events, etc
 * --------------
 */

drop table tbl_crontab;

commit;

CREATE TABLE tbl_crontab (
  int_crontabid BIGINT NOT NULL,
  str_minute VARCHAR(8),
  str_hour VARCHAR(8),
  str_dayofweek VARCHAR(8),
  str_dayofmonth VARCHAR(8),
  str_monthofyear VARCHAR(8),
  str_command VARCHAR(64),
  str_desc varchar(256),
    PRIMARY KEY(int_crontabid)
);
CREATE GENERATOR GEN_TBL_CRONTAB;



 
