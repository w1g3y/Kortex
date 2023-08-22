
/* =================================================
 *
 * Entity Name: 'tlkp_erpskill.sql'
 * Description:
 *
 *
 * $Id: tlkp_erpskill.sql,v 1.1 2008/07/01 03:07:42 nweeks Exp $
 *
 * $Log: tlkp_erpskill.sql,v $
 * Revision 1.1  2008/07/01 03:07:42  nweeks
 * Initial revision
 *
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_erpskill.sql...' from rdb$database;


CREATE TABLE tlkp_erpskill (
  int_skillid INTEGER NOT NULL,
  str_skillgroup VARCHAR(64),
  str_skill VARCHAR(64),
  str_desc VARCHAR(256),
  int_order INTEGER,
    PRIMARY KEY(int_skillid),
    UNIQUE(str_skillgroup, str_skill)
);
CREATE GENERATOR GEN_TLKP_erpskill;
