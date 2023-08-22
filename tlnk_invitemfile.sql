
/* =================================================
 *
 * Entity Name: 'tlnk_invitemfile.sql'
 * Description:
 *
 *
 * $Id: tlnk_invitemfile.sql,v 1.1 2008/07/01 03:22:37 nweeks Exp $
 *
 * $Log: tlnk_invitemfile.sql,v $
 * Revision 1.1  2008/07/01 03:22:37  nweeks
 * Initial revision
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_invitemfile.sql...' from rdb$database;


CREATE TABLE tlnk_invitemfile (
  int_fileid INTEGER NOT NULL,
  int_itemid INTEGER NOT NULL,
  str_desc VARCHAR(256),  /* Mugshot, etc */
  str_collection VARCHAR(32),  /* Mugshot, etc */
    PRIMARY KEY(int_fileid, int_itemid),
    FOREIGN KEY(int_fileid) REFERENCES tbl_file(int_fileid),
    FOREIGN KEY(int_itemid) REFERENCES tbl_invitem(int_itemid)
);

