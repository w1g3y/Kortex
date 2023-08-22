
/* =================================================
 *
 * Entity Name: 'tlkp_invqty.sql'
 * Description:
 *
 *
 * $Id: tlkp_invqty.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlkp_invqty.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_invqty.sql...' from rdb$database;

/* --------------
 * Inventory :: Quantities
 *
 * Quantities (EA, 1-10,10-50,50-100,100+, etc)
 * --------------
 */

select 'Linking DNA tlkp_invqty' from rdb$database;


CREATE TABLE tlkp_invqty (
  int_qtyid INTEGER NOT NULL,
  int_low INTEGER default 1 NOT NULL,
  int_high INTEGER default 1 NOT NULL,
  str_qty VARCHAR(16) default 'EA',
    PRIMARY KEY(int_qtyid)
);
CREATE GENERATOR GEN_TLKP_INVQTY;
