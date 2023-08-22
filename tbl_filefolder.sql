
/* =================================================
 *
 * Entity Name: 'tbl_filefolder.sql'
 * Description:
 *
 *
 * $Id: tbl_filefolder.sql,v 1.1 2008/07/01 03:22:37 nweeks Exp $
 *
 * $Log: tbl_filefolder.sql,v $
 * Revision 1.1  2008/07/01 03:22:37  nweeks
 * Initial revision
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_filefolder.sql...' from rdb$database;


CREATE TABLE tbl_filefolder (
  int_folderid INTEGER NOT NULL, 
  int_childof INTEGER,
    PRIMARY KEY(int_folderid)
);
CREATE GENERATOR GEN_TBL_FILEFOLDER;


