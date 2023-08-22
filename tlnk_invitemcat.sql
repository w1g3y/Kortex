
/* =================================================
 *
 * Entity Name: 'tlnk_invitemcat.sql'
 * Description:
 *
 *
 * $Id: tlnk_invitemcat.sql,v 1.2 2007/07/19 14:06:37 nweeks Exp $
 *
 * $Log: tlnk_invitemcat.sql,v $
 * Revision 1.2  2007/07/19 14:06:37  nweeks
 * Further work
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_invitemcat.sql...' from rdb$database;

/* --------------
 * Inventory :: Item to Categories Link Table
 *
 * The grouping of similar items
 * --------------
 */


select 'Linking DNA tlnk_invitemcat' from rdb$database;


CREATE TABLE tlnk_invitemcat (
  int_itemid INTEGER NOT NULL,
  int_catid INTEGER NOT NULL,
    PRIMARY KEY(int_itemid, int_catid),
    FOREIGN KEY(int_catid) REFERENCES tlkp_invcategory (int_catid),
    FOREIGN KEY(int_itemid) REFERENCES tbl_invitem (int_itemid)
);
