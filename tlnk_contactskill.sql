
/* =================================================
 *
 * Entity Name: 'tlnk_contactskill.sql'
 * Description:
 *
 *
 * $Id: tlnk_contactskill.sql,v 1.2 2008/07/01 03:17:56 nweeks Exp $
 *
 * $Log: tlnk_contactskill.sql,v $
 * Revision 1.2  2008/07/01 03:17:56  nweeks
 * Fixed pkey
 *
 * Revision 1.1  2008/07/01 03:15:57  nweeks
 * Initial revision
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_contactskill.sql...' from rdb$database;


CREATE TABLE tlnk_contactskill (
  int_contactid INTEGER NOT NULL,
  int_skillid INTEGER NOT NULL,
    PRIMARY KEY(int_skillid,int_contactid),
    FOREIGN KEY(int_skillid) REFERENCES tlkp_erpskill(int_skillid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid)
);

