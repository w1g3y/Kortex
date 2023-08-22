
/* =================================================
 *
 * Entity Name: 'tblx_contact.sql'
 * Description:
 *
 *
 * $Id: tblx_contact.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tblx_contact.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tblx_contact.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tblx_contact (
  int_tagid INTEGER NOT NULL,
  int_contactid INTEGER NOT NULL,
  int_value INTEGER,
  dte_value DATE,
  tme_value TIME,
  str_value VARCHAR(256),
  blb_value BLOB SUB_TYPE TEXT,
    PRIMARY KEY(int_tagid,int_contactid),
    FOREIGN KEY(int_tagid) REFERENCES tlkp_exttag (int_tagid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid)
);




