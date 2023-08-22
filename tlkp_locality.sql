
/* =================================================
 *
 * Entity Name: 'tlkp_locality.sql'
 * Description:
 *
 *
 * $Id: tlkp_locality.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlkp_locality.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_locality.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tlkp_locality (
  int_localityid INTEGER NOT NULL,
  str_suburb VARCHAR(64),
  str_state VARCHAR(32),
  str_postcode VARCHAR(16),
    PRIMARY KEY(int_localityid),
    UNIQUE(str_suburb,str_state,str_postcode)
);
CREATE GENERATOR GEN_TLKP_LOCALITY;


