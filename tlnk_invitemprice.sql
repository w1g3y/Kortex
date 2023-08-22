
/* =================================================
 *
 * Entity Name: 'tlnk_invitemprice.sql'
 * Description:
 *
 *
 * $Id: tlnk_invitemprice.sql,v 1.3 2008/07/01 03:22:37 nweeks Exp $
 *
 * $Log: tlnk_invitemprice.sql,v $
 * Revision 1.3  2008/07/01 03:22:37  nweeks
 * Inventory Item Price. Stores the prices of items in inventory, and their quantity scalings
 * (Buy in bulk and save, etc)
 *
 * Revision 1.2  2007/07/19 14:06:37  nweeks
 * Further work
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_invitemprice.sql...' from rdb$database;

/* --------------
 * Inventory :: Item Pricing
 *
 * Sale prices per qty
 * --------------
 */


select 'Linking DNA tlnk_invitemprice' from rdb$database;


CREATE TABLE tlnk_invitemprice (
  int_itemid INTEGER NOT NULL,
  int_qtyid INTEGER NOT NULL,
  int_unitid INTEGER NOT NULL,
  flt_saleprice NUMERIC(18,3),
    PRIMARY KEY(int_itemid, int_qtyid),
    FOREIGN KEY(int_qtyid) REFERENCES tlkp_invqty (int_qtyid),
    FOREIGN KEY(int_unitid) REFERENCES tlkp_invunit (int_unitid)
    
);
