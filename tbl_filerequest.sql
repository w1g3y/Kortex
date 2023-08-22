
/* =================================================
 *
 * Entity Name: 'tbl_filerequest.sql'
 * Description:
 *
 *
 * $Id: tbl_filerequest.sql,v 1.2 2007/07/19 14:05:32 nweeks Exp $
 *
 * $Log: tbl_filerequest.sql,v $
 * Revision 1.2  2007/07/19 14:05:32  nweeks
 * Removed extra comment
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_filerequest.sql...' from rdb$database;

CREATE TABLE tbl_filerequest (
  int_requestid INTEGER NOT NULL,
  int_fileid INTEGER NOT NULL, 
  dtm_stamp TIMESTAMP DEFAULT 'not' NOT NULL,
  str_email VARCHAR(128) NOT NULL,
    PRIMARY KEY(int_requestid)
);
CREATE GENERATOR GEN_TBL_FILEREQUEST;


