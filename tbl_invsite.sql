
/* =================================================
 *
 * Entity Name: 'tbl_invsite.sql'
 * Description:
 *
 *
 * $Id: tbl_invsite.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_invsite.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_invsite.sql...' from rdb$database;

/* --------------
 * Inventory :: Site table
 *
 * Where stock items are actually stored
 * --------------
 */

select 'Linking DNA tbl_invsite' from rdb$database;

CREATE TABLE tbl_invsite (
  int_sitedid INTEGER NOT NULL,
  str_name VARCHAR(64) NOT NULL,
  str_desc VARCHAR(512),
  str_address VARCHAR(32),
  str_city VARCHAR(32),
  str_state VARCHAR(16),
  str_postcode VARCHAR(8),
  str_phoneno VARCHAR(32),
    PRIMARY KEY(int_siteid)
);
CREATE GENERATOR GEN_TBL_INVSITE;

 
