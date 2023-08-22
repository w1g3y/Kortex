
/* =================================================
 *
 * Entity Name: 'tlnk_contactgroup.sql'
 * Description:
 *
 *
 * $Id: tlnk_contactgroup.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlnk_contactgroup.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_contactgroup.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tlnk_contactgroup (
  int_contactgroupid INTEGER NOT NULL,
  int_contactid INTEGER NOT NULL,
    PRIMARY KEY(int_contactgroupid,int_contactid),
    FOREIGN KEY(int_contactgroupid) REFERENCES tlkp_contactgroup(int_contactgroupid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid)
);

