
/* =================================================
 *
 * Entity Name: 'tbl_invsiteitemqty.sql'
 * Description:
 *
 *
 * $Id: tbl_invsiteitemqty.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_invsiteitemqty.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_invsiteitemqty.sql...' from rdb$database;

/* --------------
 * Inventory :: Item table
 *
 * Flexible descriptions, ownership, and extendible tags/categories
 * --------------
 */

select 'Linking DNA tbl_invsiteitemqty' from rdb$database;

CREATE TABLE tbl_invsiteitemqty (
  int_itemid BIGINT NOT NULL,
  int_siteid BIGINT NOT NULL,
  int_instock NUMERIC(18,4) default 1,
  int_onhold NUMERIC(18,4) default 0, /* In shopping cart, before payment made */
  int_onorder NUMERIC(18,4) default 0, /* Coming from supplier */
  int_intransit NUMERIC(18,4) default 0, /* Being shipped */
    PRIMARY KEY(int_itemid, int_siteid),
    FOREIGN KEY(int_itemid) REFERENCES tbl_invitem (int_itemid),
    FOREIGN KEY(int_siteid) REFERENCES tbl_invsite (int_itemid)
);

