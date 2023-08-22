
/* =================================================
 *
 * Entity Name: 'tlkp_orderflagtype.sql'
 * Description:
 *
 *
 * $Id: tlkp_orderflagtype.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlkp_orderflagtype.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_orderflagtype.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tlkp_orderflagtype (
  int_flagtypeid INTEGER NOT NULL,
  str_flagtype VARCHAR(100) NOT NULL,
  str_desc VARCHAR(128),
    PRIMARY KEY(int_flagtypeid),
    UNIQUE(str_flagtype)
);
CREATE GENERATOR GEN_TLKP_ORDERFLAGTYPE;



