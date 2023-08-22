
/* =================================================
 *
 * Entity Name: 'tbl_contactreps.sql'
 * Description:
 *
 *
 * $Id: tbl_contactreps.sql,v 1.2 2011/06/22 01:29:32 nweeks Exp $
 *
 * $Log: tbl_contactreps.sql,v $
 * Revision 1.2  2011/06/22 01:29:32  nweeks
 * unknown change
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_contactreps.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

/* Contact Representatives */
/* Contact Representatives */
CREATE TABLE tbl_contactreps (
  int_userid BIGINT NOT NULL,
  int_contactid BIGINT NOT NULL,
    PRIMARY KEY(int_userid,int_contactid),
    FOREIGN KEY(int_userid) REFERENCES tbl_user(int_userid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid)
    
);

