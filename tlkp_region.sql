
/* =================================================
 *
 * Entity Name: 'tlkp_region.sql'
 * Description:
 *
 *
 * $Id: tlkp_region.sql,v 1.1 2007/09/02 08:15:50 nweeks Exp $
 *
 * $Log: tlkp_region.sql,v $
 * Revision 1.1  2007/09/02 08:15:50  nweeks
 * Initial revision
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_region.sql...' from rdb$database;


CREATE TABLE tlkp_region (
  int_regionid INTEGER NOT NULL,
  str_region VARCHAR(64),
  str_state VARCHAR(32),
    PRIMARY KEY(int_regionid),
    UNIQUE(str_region,str_state)
);
CREATE GENERATOR GEN_TLKP_REGION;


