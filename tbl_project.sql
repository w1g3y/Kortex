
/* =================================================
 *
 * Entity Name: 'tbl_project.sql'
 * Description:
 *
 *
 * $Id: tbl_project.sql,v 1.3 2012/11/29 23:58:24 nweeks Exp nweeks $
 *
 * $Log: tbl_project.sql,v $
 * Revision 1.3  2012/11/29 23:58:24  nweeks
 * Fixed generator name
 *
 * Revision 1.2  2012/11/29 23:49:34  nweeks
 * This is the Project Management table
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_project.sql...' from rdb$database;


CREATE TABLE tbl_project (
  int_projectid BIGINT NOT NULL,
  int_childofid BIGINT,
  str_projname VARCHAR(100) NOT NULL,
  str_projnotes BLOB SUB_TYPE TEXT,
  dte_propstart date,
  dtm_propend date,
  dte_actualstart date,
  dte_actualend date,
  dtm_created TIMESTAMP default 'now',
  dtm_edited TIMESTAMP default 'now',
  int_complete INTEGER, /* 0-100% */
  int_priority INTEGER, /* 1-5 */  (1: high, 5:low)
  ibl_timetracking INTEGER,
  ibl_changedigest INTEGER,
    PRIMARY KEY(int_projectid),
    FOREIGN KEY(int_childofid) REFERENCES tbl_project(int_projectid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid),
    FOREIGN KEY(int_priorityid) REFERENCES tlkp_priority(int_priorityid)
);
CREATE GENERATOR GEN_TBL_PROJECT;


