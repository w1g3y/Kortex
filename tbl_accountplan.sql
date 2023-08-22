
/* =================================================
 *
 * Entity Name: 'tbl_accountplan.sql'
 * Description:
 *
 *
 * $Id$
 *
 * $Log$
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_accountplan.sql...' from rdb$database;

/* --------------
 * Commerce :: AccountPlan Table
 *
 * Sets interest rates for +ve, -ve, thresholds, and calculation/applied rates
 * DEPENDS: tlkp_choices, tbl_user, tbl_account
 * --------------
 */


CREATE TABLE tbl_accountplan (
  int_accountplanid BIGINT NOT NULL,
  lkp_plantypeid BIGINT NOT NULL,
  str_name VARCHAR(64) NOT NULL,
  str_desc VARCHAR(512),
  flt_posbalinterest NUMERIC(9,6),
  flt_posbalthreshold NUMERIC(15,3),
  flt_negbalinterest NUMERIC(9,6),
  flt_negbalthreshold NUMERIC(15,3),
    PRIMARY KEY(int_accountplanid),
    FOREIGN KEY(lkp_plantypeid) REFERENCES tlkp_choices (int_choiceid)
);
CREATE GENERATOR GEN_TBL_ACCOUNTPLAN;



 
