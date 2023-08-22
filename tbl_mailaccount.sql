
/* =================================================
 *
 * Entity Name: 'tbl_mailaccount.sql'
 * Description:
 *
 *
 * $Id: tbl_mailaccount.sql,v 1.2 2011/06/22 01:31:57 nweeks Exp $
 *
 * $Log: tbl_mailaccount.sql,v $
 * Revision 1.2  2011/06/22 01:31:57  nweeks
 * Mail account changes
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_mailaccount.sql...' from rdb$database;

select 'Linking DNA tbl_mailaccount' from rdb$database;


/* tbl_message relies upon tbl_user for message ownership
*/
CREATE TABLE tbl_mailaccount (
  int_accountid BIGINT NOT NULL, 
  int_userid BIGINT NOT NULL,
  str_name VARCHAR(256),
    PRIMARY KEY(int_accountid),
    FOREIGN KEY(int_tagid) REFERENCES tbl_mailaccounttag(int_tagid),
    FOREIGN KEY(int_userid) REFERENCES tbl_user(int_userid)
);
CREATE GENERATOR GEN_TBL_MESSAGE;
CREATE ASC INDEX AIND_MESSAGE_SUBJECT on tbl_message (str_upsubject);
CREATE DESC INDEX DIND_MESSAGE_SUBJECT on tbl_message (str_upsubject);
CREATE ASC INDEX AIND_MESSAGE_STAMP on tbl_message (dtm_stamp);
CREATE DESC INDEX DIND_MESSAGE_STAMP on tbl_message (dtm_stamp);


