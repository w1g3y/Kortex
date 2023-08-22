
/* =================================================
 *
 * Entity Name: 'tbl_costcode.sql'
 * Description:
 *
 *
 * $Id: tbl_costcode.sql,v 1.1 2011/06/22 01:29:32 nweeks Exp $
 *
 * $Log: tbl_costcode.sql,v $
 * Revision 1.1  2011/06/22 01:29:32  nweeks
 * Initial revision
 *
 * Revision 1.1  2008/07/01 03:18:03  nweeks
 * Initial revision
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_costcode.sql...' from rdb$database;

/* --------------
 * Commerce :: CostCode Table
 *
 * Flexible descriptions, ownership, and extendible tags/categories
 * --------------
 */


CREATE TABLE tbl_costcode (
  int_costcodeid BIGINT NOT NULL,
  int_childof BIGINT,  /* Used for nesting costcodes */
  int_ccprefix varchar(3) default '' NOT NULL,    /* Cost Code Prefix */
  int_typeid INTEGER NOT NULL,
  str_name VARCHAR(64) NOT NULL,
  str_desc VARCHAR(512),
  int_ownerid BIGINT,
  flt_lastbalance NUMERIC(18,4),
  dtm_balancecalc TIMESTAMP DEFAULT 'now' NOT NULL,
    PRIMARY KEY(int_costcodeid),
    FOREIGN KEY(int_ownerid) REFERENCES tbl_user(int_userid),
    FOREIGN KEY(int_childof) REFERENCES tbl_costcode (int_costcodeid)
);
CREATE GENERATOR GEN_TBL_COSTCODE;



 
