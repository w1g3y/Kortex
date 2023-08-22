
/* =================================================
 *
 * Entity Name: 'tbl_package.sql'
 * Description:
 *
 *
 * $Id: tbl_package.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_package.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_package.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tbl_package (
  int_packageid INTEGER NOT NULL,
  str_name VARCHAR(64) NOT NULL,
  str_desc VARCHAR(512),
  str_notes VARCHAR(1024),
    PRIMARY KEY(int_packageid)
);
CREATE GENERATOR GEN_TBL_PACKAGE;

