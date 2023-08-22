
/* =================================================
 *
 * Entity Name: 'tlnk_contacttype.sql'
 * Description:
 *
 *
 * $Id: tlnk_contacttype.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlnk_contacttype.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_contacttype.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tlnk_contacttype (
  int_contacttypeid INTEGER NOT NULL,
  int_contactid INTEGER NOT NULL,
    PRIMARY KEY(int_contacttypeid,int_contactid),
    FOREIGN KEY(int_contacttypeid) REFERENCES tlkp_contacttype(int_contacttypeid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid)
);

