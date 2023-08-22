
/* =================================================
 *
 * Entity Name: 'tlnk_invitemtagvals.sql'
 * Description:
 *
 *
 * $Id: tlnk_invitemtagvals.sql,v 1.1 2007/07/19 14:06:37 nweeks Exp $
 *
 * $Log: tlnk_invitemtagvals.sql,v $
 * Revision 1.1  2007/07/19 14:06:37  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_invitemtagvals.sql...' from rdb$database;

CREATE TABLE tlnk_invitemtagvals (
  int_itemid INTEGER NOT NULL,
  int_tagid INTEGER NOT NULL,
  str_value VARCHAR(128),
  blb_value VARCHAR(128),
    PRIMARY KEY(int_itemid,int_tagid),
    FOREIGN KEY(int_itemid) REFERENCES tbl_invitem(int_itemid),
    FOREIGN KEY(int_tagid) REFERENCES tlkp_invitemtag(int_tagid)
);

