
/* =================================================
 *
 * Entity Name: 'tbl_tranpost.sql'
 * Description:
 *
 *
 * $Id: tbl_transposting.sql,v 1.1 2011/06/22 01:33:25 nweeks Exp nweeks $
 *
 * $Log: tbl_transposting.sql,v $
 * Revision 1.1  2011/06/22 01:33:25  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_transposting.sql...' from rdb$database;

/* --------------
 * Commerce : Transaction Posting Table
 *
 * Inbuilt flexibility for simple posting sets
 * --------------
 */
select 'Linking DNA tbl_transposting' from rdb$database;
/* Transaction Posting Table
 * This table stores what percentage of a transaction is posted to which accounts, depending
 * on transaction type, tax calculation, and amount
 * Also, a 'Posting Label' can be used to redirect amounts to alternative locations
 * Tax can be postd off at any rate, to any account
 * Postings to Cost of Sales, Inventory, etc can be infinitely adjusted
 * This should allow portability to any country's tax system
 * For example: A sale of $11 tax inclusive comes in:
 *   10% of the transamt goes to the tax-received account, and
 *     this amount is taken off the transamt(the transamt was Tax Inclusive)
 *   100% of the Tax-Ex TransAmt is posted +ve to the Income account
 *   100% of the Tax-Ex TransAmt is posted -ve to the Trade Debtors account
 *   100% of the stock/service value is posted -ve to the Inventory account
 *   100% of the stock/service value is posted +ve to the Cost of Sales account
 */
CREATE TABLE tbl_transposting (
  int_siteid INTEGER DEFAULT 1 NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_tpostid NUMERIC(18,0) NOT NULL,
  str_label VARCHAR(100), /* Posting Label */
  str_group VARCHAR(200), /* Posting Group: General Sales, etc */
  int_usewhichamt INTEGER, /* Which value to use for calc: 0:TransAmt, 1:Stock Value, 2:Service Value */
  int_transtype NUMERIC(18,0) NOT NULL, /* References mfin_tlkp_transtype.int_type */
  str_taxIEFC VARCHAR(3) DEFAULT 'E' NOT NULL, /* EXC:Exclusive,INC:Inclusive,ACT:Actual,FRE:Free */
  int_taxtype NUMERIC(18,0), /* References mfin_tlkp_taxtype.int_type */
  flt_calc NUMERIC(18,6), /* Big number, with 6 places of precision. Multiplied against transamt */
  int_destacc NUMERIC(18,0), /* References mfin_tbl_account.int_account */
  int_adjtransamt INTEGER, /* Do we then use this calculated value to adjust the incoming transaction amount? ie take tax out if it's an inclusive transaction */
    PRIMARY KEY(int_siteid, int_tpostid),
    UNIQUE (int_siteid, int_transtype, str_taxIEFC, int_taxtype, int_adjtransamt)
);
CREATE GENERATOR GEN_TBL_TRANSSLICE;



