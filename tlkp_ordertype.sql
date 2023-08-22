
/* =================================================
 *
 * Entity Name: 'tlkp_ordertype.sql'
 * Description:
 *
 *
 * $Id: tlkp_ordertype.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlkp_ordertype.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_ordertype.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tlkp_ordertype (
  int_ordertypeid INTEGER NOT NULL,
  str_ordertype VARCHAR(100) NOT NULL,
  str_desc VARCHAR(128),
    PRIMARY KEY(int_ordertypeid),
    UNIQUE(str_ordertype)
);
CREATE GENERATOR GEN_TLKP_ORDERTYPE;


