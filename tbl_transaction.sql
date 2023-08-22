
/* =================================================
 *
 * Entity Name: 'tbl_transaction.sql'
 * Description:
 *
 *
 * $Id: tbl_transaction.sql,v 1.6 2011/06/22 01:33:25 nweeks Exp nweeks $
 *
 * $Log: tbl_transaction.sql,v $
 * Revision 1.6  2011/06/22 01:33:25  nweeks
 * BigInt upgrade
 *
 * Revision 1.5  2008/09/09 01:04:34  nweeks
 * *** empty log message ***
 *
 * Revision 1.4  2008/07/01 03:22:37  nweeks
 * General Checkin
 *
 * Revision 1.3  2007/10/13 10:23:50  nweeks
 * Removed superfluous int_itemid - replaced by int_invitemid and int_servitemid
 *
 * Revision 1.2  2007/08/31 06:28:51  nweeks
 * Added text-based transtype, and service item link
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_transaction.sql...' from rdb$database;

/* --------------
 * Commerce : Transaction
 *
 * Inbuilt flexibility for simple accounting
 * --------------
 */
select 'Linking DNA tbl_transaction' from rdb$database;

CREATE TABLE tbl_transaction (
  int_transid BIGINT NOT NULL,
  int_ttypeid INTEGER NOT NULL,
  dtm_stamp TIMESTAMP default 'now' NOT NULL,
  dte_date DATE default 'now' NOT NULL,
  tme_time TIME default 'now' NOT NULL,
  int_accountid BIGINT,  /* Link into Chart of Accounts */
  int_costcodeid BIGINT, /* Link to Cost Centers */
  int_projectid BIGINT, /* Link to Project */
  int_userid BIGINT,  /* Might be hooked to a user */
  int_contactid BIGINT,  /* Might be applied to a contact */
  int_invitemid BIGINT,  /* Might be hooked to an inventory item */ 
  int_servitemid BIGINT,  /* Might be hooked to an service item */ 
  int_childof BIGINT, /* might refer to a previous transaction */
  str_name VARCHAR(256),  /* Transaction might need a name */
  str_desc VARCHAR(1024),
  flt_amount NUMERIC(18,4),
  flt_taxamt NUMERIC(18,4),
  int_qty NUMERIC(18,6),
  str_taxtype VARCHAR(16) default 'GST' NOT NULL,
  str_taxiefc VARCHAR(8) default 'E' not null, /* Inclusive,Exclusive,Free,Custom */
  ibl_cancelled INTEGER default 0, /* This transaction has been cancelled */
    PRIMARY KEY(int_transid)
);
CREATE GENERATOR GEN_TBL_transaction;


alter table tbl_transaction add constraint trans_fktype FOREIGN KEY(int_ttypeid) REFERENCES tlkp_ttype(int_ttypeid);
alter table tbl_transaction add constraint trans_fkaccid FOREIGN KEY(int_accountid) REFERENCES tbl_account(int_accountid);
alter table tbl_transaction add constraint trans_fkccode FOREIGN KEY(int_costcodeid) REFERENCES tbl_costcode(int_costcodeid);
alter table tbl_transaction add constraint trans_fkproject FOREIGN KEY(int_projectid) REFERENCES tbl_project(int_projectid);
alter table tbl_transaction add constraint trans_fkuser FOREIGN KEY(int_userid) REFERENCES tbl_user(int_userid);
alter table tbl_transaction add constraint trans_fkchild FOREIGN KEY(int_childof) REFERENCES tbl_transaction(int_transid);
alter table tbl_transaction add constraint trans_fkinve FOREIGN KEY(int_invitemid) REFERENCES tbl_invitem(int_itemid);
alter table tbl_transaction add constraint trans_fkserv FOREIGN KEY(int_servitemid) REFERENCES tbl_serviceitem(int_servitemid);
alter table tbl_transaction add constraint trans_fkcont FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid);



