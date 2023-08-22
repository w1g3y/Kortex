
/* =================================================
 *
 * Entity Name: 'tbl_contactchain.sql'
 * Description:
 *
 *
 * $Id: tbl_contactchain.sql,v 1.3 2011/06/22 01:29:32 nweeks Exp $
 *
 * $Log: tbl_contactchain.sql,v $
 * Revision 1.3  2011/06/22 01:29:32  nweeks
 * unknown change
 *
 * Revision 1.2  2008/07/01 03:22:37  nweeks
 * General Checkin
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_contactchain.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tbl_contactchain (
  int_contactid BIGINT NOT NULL,
  int_childof BIGINT NOT NULL,
  str_relationship VARCHAR(64),
  blb_notes BLOB SUB_TYPE TEXT,
    PRIMARY KEY(int_contactid,int_childof),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid),
    FOREIGN KEY(int_childof) REFERENCES tbl_contact(int_contactid)
);

in tbl_file.sql;

