
/* =================================================
 *
 * Entity Name: 'tlnk_mailaccountvalues.sql'
 * Description:
 *
 *
 * $Id: tlnk_mailaccountvalues.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlnk_mailaccountvalues.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_mailaccountvalues.sql...' from rdb$database;

select 'Linking DNA tlnk_mailaccountvalues' from rdb$database;

CREATE TABLE tlnk_mailaccountvalues (
  int_accountid INTEGER NOT NULL,
  int_tagid INTEGER NOT NULL,
  str_value VARCHAR(128),
    PRIMARY KEY(int_accountid, int_tagid),
    FOREIGN KEY(int_accountid) REFERENCES tbl_mailaccount(int_accountid),
    FOREIGN KEY(int_tagid) REFERENCES tlkp_mailaccounttags(int_tagid)
);


