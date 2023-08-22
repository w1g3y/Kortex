
/* =================================================
 *
 * Entity Name: 'tbl_projteam.sql'
 * Description:
 *
 *
 * $Id: tbl_projteam.sql,v 1.3 2011/06/22 01:33:25 nweeks Exp nweeks $
 *
 * $Log: tbl_projteam.sql,v $
 * Revision 1.3  2011/06/22 01:33:25  nweeks
 * BigInt upgrade
 *
 * Revision 1.2  2008/07/01 03:22:37  nweeks
 * General Checkin
 *
 * Revision 1.1  2007/08/31 07:01:18  nweeks
 * Initial revision
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_projteam.sql...' from rdb$database;


CREATE TABLE tbl_projteam (
  int_projid BIGINT NOT NULL,
  int_contactid BIGINT NOT NULL,
  int_roleid BIGINT NOT NULL,
    PRIMARY KEY(int_projid, int_contactid),
    FOREIGN KEY(int_projectid) REFERENCES tbl_project(int_projectid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid)
);


