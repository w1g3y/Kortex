
/* =================================================
 *
 * Entity Name: 'tbl_invitem.sql'
 * Description:
 *
 *
 * $Id: tbl_invitem.sql,v 1.3 2008/09/09 01:04:34 nweeks Exp $
 *
 * $Log: tbl_invitem.sql,v $
 * Revision 1.3  2008/09/09 01:04:34  nweeks
 * *** empty log message ***
 *
 * Revision 1.2  2008/07/01 03:22:37  nweeks
 * General Checkin
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_invitem.sql...' from rdb$database;

/* --------------
 * Inventory :: Item table
 *
 * Flexible descriptions, ownership, and extendible tags/categories
 * --------------
 */

select 'Linking DNA tbl_invitem' from rdb$database;

CREATE TABLE tbl_invitem (
  int_itemid INTEGER NOT NULL,
  int_typeid INTEGER NOT NULL,
  str_name VARCHAR(64) NOT NULL,
  str_desc VARCHAR(512),
  int_ownerid INTEGER,
  int_modelid INTEGER,
  int_manufid INTEGER,
  int_upcbarcode INTEGER,
  str_3of9barcode VARCHAR(32),
    PRIMARY KEY(int_itemid),
    FOREIGN KEY(int_ownerid) REFERENCES tbl_user(int_userid),
    FOREIGN KEY(int_typeid) REFERENCES tlkp_invitemtype(int_typeid),
    FOREIGN KEY(int_modelid, int_manufid) REFERENCES tlkp_invmanufmodel (int_modelid, int_manufid)
);
CREATE GENERATOR GEN_TBL_INVITEM;



 
