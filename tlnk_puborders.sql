
/* =================================================
 *
 * Entity Name: 'tlnk_puborders.sql'
 * Description:
 *
 *
 * $Id: tlnk_puborders.sql,v 1.2 2011/06/22 01:33:25 nweeks Exp nweeks $
 *
 * $Log: tlnk_puborders.sql,v $
 * Revision 1.2  2011/06/22 01:33:25  nweeks
 * BigInt Upgrade
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_puborders.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tlnk_puborders (
  int_orderid BIGINT NOT NULL,
  int_pubid INTEGER NOT NULL,
  int_contactid INTEGER NOT NULL,
  int_ordertypeid INTEGER NOT NULL,
  dtm_date DATE NOT NULL,
  int_flagtypeid INTEGER NOT NULL,
    PRIMARY KEY(int_orderid),
    FOREIGN KEY(int_pubid) REFERENCES tbl_publication(int_pubid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid),
    FOREIGN KEY(int_ordertypeid) REFERENCES tlkp_ordertype(int_ordertypeid),
    FOREIGN KEY(int_flagtypeid) REFERENCES tlkp_orderflagtype(int_flagtypeid)
);
CREATE GENERATOR GEN_TBL_PUBORDERS;

   
