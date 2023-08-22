
/* =================================================
 *
 * Entity Name: 'tbl_message.sql'
 * Description:
 *
 *
 * $Id: tbl_message.sql,v 1.2 2011/06/22 01:31:57 nweeks Exp $
 *
 * $Log: tbl_message.sql,v $
 * Revision 1.2  2011/06/22 01:31:57  nweeks
 * Mail account changes
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_message.sql...' from rdb$database;

select 'Linking DNA tbl_message ' from rdb$database;

/* tbl_message relies upon tbl_user for message ownership
*/
CREATE TABLE tbl_message (
  int_msgid BIGINT NOT NULL, 
  int_userid BIGINT NOT NULL,
  dtm_stamp TIMESTAMP default 'now' NOT NULL,
  str_subject VARCHAR(128),
  str_upsubject VARCHAR(128),
  blb_headers BLOB SUB_TYPE TEXT,
  blb_message BLOB SUB_TYPE TEXT,
    PRIMARY KEY(int_msgid),
    FOREIGN KEY(int_userid) REFERENCES tbl_user(int_userid)
);
CREATE GENERATOR GEN_TBL_MESSAGE;
CREATE ASC INDEX AIND_MESSAGE_SUBJECT on tbl_message (str_upsubject);
CREATE DESC INDEX DIND_MESSAGE_SUBJECT on tbl_message (str_upsubject);
CREATE ASC INDEX AIND_MESSAGE_STAMP on tbl_message (dtm_stamp);
CREATE DESC INDEX DIND_MESSAGE_STAMP on tbl_message (dtm_stamp);


