
/* =================================================
 *
 * Entity Name: 'tbl_account.sql'
 * Description:
 *
 *
 * $Id: tbl_account.sql,v 1.2 2011/06/22 01:29:32 nweeks Exp $
 *
 * $Log: tbl_account.sql,v $
 * Revision 1.2  2011/06/22 01:29:32  nweeks
 * Shuffled account fields
 *
 * Revision 1.1  2008/07/01 03:18:03  nweeks
 * Initial revision
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_account.sql...' from rdb$database;

/* --------------
 * Commerce :: Account Table
 *
 * Flexible descriptions, ownership, and extendible tags/categories
 * DEPENDS: tlkp_choices, tbl_user, tbl_account
 * --------------
 */


CREATE TABLE tbl_account (
  int_accountid BIGINT NOT NULL,
  int_childof BIGINT,  /* Used for nesting accounts */
  int_ccprefix INTEGER default 0 not null,    /* Company Code Center Prefix (GL Sandboxing) */
  int_arreprefix INTEGER DEFAULT 0 not null,    /* Area Code Prefix */
  INT_ACCPREFIX INTEGER default 0 not null,   /* Account Code Prefix (1:Assets) */
  INT_ACODE INTEGER default 0 not null,      /* Acount Code (2200: General Expense) */
  lkp_acctypeid BIGINT,
  str_name VARCHAR(64) NOT NULL,
  str_desc VARCHAR(512),
  int_contactid BIGINT, /* Primary Account Holder */
/* ------ Banking Extensions -------- */
  int_bsb BIGINT DEFAULT 0 NOT NULL,   /* Banking Module */
  int_accplanid BIGINT NOT NULL,   /* Banking Module - saving, loan, mortgage */
/* ------ Cached Balances ------ */
  flt_lastbalance NUMERIC(18,4),
  dtm_lastcalc TIMESTAMP DEFAULT 'now' NOT NULL,
    PRIMARY KEY(int_accountid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid),
    FOREIGN KEY(int_childof) REFERENCES tbl_account (int_accountid),
    FOREIGN KEY(lkp_acctypeid) REFERENCES tlkp_choices (int_choiceid),
    FOREIGN KEY(int_accplanid) REFERENCES tbl_accountplan (int_accountplanid)
);
CREATE GENERATOR GEN_TBL_ACCOUNT;



 
