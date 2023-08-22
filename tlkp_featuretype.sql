
/* =================================================
 *
 * Entity Name: 'tlkp_featuretype.sql'
 * Description:
 *
 *
 * $Id: tlkp_featuretype.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlkp_featuretype.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_featuretype.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tlkp_featuretype (
  int_featuretypeid INTEGER NOT NULL,
  str_featuretype VARCHAR(100) NOT NULL,
    PRIMARY KEY(int_featuretypeid),
    UNIQUE(str_featuretype)
);
CREATE GENERATOR GEN_TLKP_FEATURETYPE;

