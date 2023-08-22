
/* =================================================
 *
 * Entity Name: 'tbl_fileaccess.sql'
 * Description:
 *
 *
 * $Id: tbl_fileaccess.sql,v 1.2 2011/06/22 01:31:57 nweeks Exp $
 *
 * $Log: tbl_fileaccess.sql,v $
 * Revision 1.2  2011/06/22 01:31:57  nweeks
 * made changes to global file repo
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_fileaccess.sql...' from rdb$database;

select 'Linking DNA tbl_fileaccess' from rdb$database;

CREATE TABLE tbl_fileaccess (
  int_accessid BIGINT NOT NULL,
  int_fileid BIGINT NOT NULL, 
  dtm_stamp TIMESTAMP DEFAULT 'not' NOT NULL,
  str_ipaddr VARCHAR(32),
    PRIMARY KEY(int_accessid)
);
CREATE GENERATOR GEN_TBL_FILEACCESS;
