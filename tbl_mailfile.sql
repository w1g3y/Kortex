
/* =================================================
 *
 * Entity Name: 'tbl_mailfile.sql'
 * Description:
 *
 *
 * $Id: tbl_mailfile.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_mailfile.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_mailfile.sql...' from rdb$database;

select 'Linking DNA tbl_mailfile' from rdb$database;


/* Small attchments are stored in the blob here,
 * otherwise, they're stored on disk in repo/(00)substr(fileid,-3)/fileid.dat
 * (in gzipped form)
 */
CREATE TABLE tbl_mailfile (
  int_fileid INTEGER NOT NULL,
  int_accountid INTEGER NOT NULL,
  str_sha256 VARCHAR(64),
  str_md5 VARCHAR(40),
  blb_data BLOB SUB_TYPE TEXT, /* If less than a few hundred kB */
    PRIMARY KEY(int_accountid, int_tagid),
    FOREIGN KEY(int_accountid) REFERENCES tbl_mailaccount(int_accountid),
    FOREIGN KEY(int_tagid) REFERENCES tlkp_mailaccounttags(int_tagid)
);


