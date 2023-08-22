
/* =================================================
 *
 * Entity Name: 'tlkp_pubtype.sql'
 * Description:
 *
 *
 * $Id: tlkp_pubtype.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlkp_pubtype.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_pubtype.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tlkp_pubtype (
  int_pubtypeid INTEGER NOT NULL,
  str_pubtype VARCHAR(100) NOT NULL,
    PRIMARY KEY(int_pubtypeid),
    UNIQUE(str_pubtype)
);
CREATE GENERATOR GEN_TLKP_PUBTYPE;

