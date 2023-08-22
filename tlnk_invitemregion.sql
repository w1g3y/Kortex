
/* =================================================
 *
 * Entity Name: 'tlnk_invitemregion.sql'
 * Description:
 *
 *
 * $Id: tlnk_invitemregion.sql,v 1.1 2008/07/01 03:22:37 nweeks Exp $
 *
 * $Log: tlnk_invitemregion.sql,v $
 * Revision 1.1  2008/07/01 03:22:37  nweeks
 * Initial revision
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

select 'Linking DNA tlnk_invitemregion.sql...' from rdb$database;

/* --------------
 * Inventory :: Item to Regions Link Table
 *
 * The grouping of similar items
 * --------------
 */


CREATE TABLE tlnk_invitemregion (
  int_itemid INTEGER NOT NULL,
  int_regionid INTEGER NOT NULL,
    PRIMARY KEY(int_itemid, int_regionid),
    FOREIGN KEY(int_regionid) REFERENCES tlkp_region (int_regionid),
    FOREIGN KEY(int_itemid) REFERENCES tbl_invitem (int_itemid)
);
