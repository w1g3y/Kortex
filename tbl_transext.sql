
/* =================================================
 *
 * Entity Name: 'tbl_transext.sql'
 * Description:
 *
 *
 * $Id: tbl_transext.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_transext.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_transext.sql...' from rdb$database;

/* --------------
 * Commerce : Transaction Extensions
 *
 * Inbuilt flexibility for simple accounting
 * --------------
 */

CREATE TABLE tbl_transext (
  int_transid INTEGER NOT NULL,
  int_extid INTEGER NOT NULL,
  int_value INTEGER,
  flt_value NUMERIC(18,4),
  dte_value DATE,
  tme_value TIME,
  str_value VARCHAR(128),
  blb_value BLOB SUB_TYPE TEXT,
    PRIMARY KEY(int_transid, int_extid),
    FOREIGN KEY(int_typeid) REFERENCES tlkp_transtype(int_typeid),
    FOREIGN KEY(int_userid) REFERENCES tbl_user(int_userid),
    FOREIGN KEY(int_itemid) REFERENCES tbl_invitem(int_itemid),
    FOREIGN KEY(int_childof) REFERENCES tbl_transaction(int_transid)
);
CREATE GENERATOR GEN_TBL_transaction;



