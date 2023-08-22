
/* =================================================
 *
 * Entity Name: 'tlkp_contacttype.sql'
 * Description:
 *
 *
 * $Id: tlkp_contacttype.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlkp_contacttype.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_contacttype.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tlkp_contacttype (
  int_contacttypeid INTEGER NOT NULL,
  str_contacttype VARCHAR(50) NOT NULL,
    PRIMARY KEY(int_contacttypeid),
    UNIQUE(str_contacttype)
);
CREATE GENERATOR GEN_TLKP_CONTACTTYPE;

