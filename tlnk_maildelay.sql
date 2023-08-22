
/* =================================================
 *
 * Entity Name: 'tlnk_maildelay.sql'
 * Description:
 *
 *
 * $Id: tlnk_maildelay.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlnk_maildelay.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_maildelay.sql...' from rdb$database;

select 'Linking DNA tlnk_maildelay' from rdb$database;


/* Implement Greylisting at the SMTP server level
 * SenderIP, SendAddr, and Recp tuples have to be resent to cut down spam
 */
CREATE TABLE tlnk_maildelay (
  int_delayid INTEGER NOT NULL,
  str_sendip VARCHAR(64) NOT NULL, /* IP addr of the senders mail server */
  str_sndactmd5 VARCHAR(40) NOT NULL, /* md5 of the senders email address */
  int_accountid INTEGER NOT NULL,
  str_senderemail VARCHAR(256), /* used for the md5 above */
  dtm_stamp TIMESTAMP default 'now' NOT NULL,
  ibl_embargoed INTEGER default 1 not null, /* Embargoed(blocked) by default */
    PRIMARY KEY(int_delayid),
    UNIQUE (str_sendip, str_sndacctmd5, int_accountid),
    FOREIGN KEY(int_accountid) REFERENCES tbl_mailaccount(int_accountid)
);
CREATE GENERATOR GEN_TLNK_MAILDELAY;

