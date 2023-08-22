
/* =================================================
 *
 * Entity Name: 'tlkp_contactgroup.sql'
 * Description:
 *
 *
 * $Id: tlkp_contactgroup.sql,v 1.2 2011/06/22 01:33:25 nweeks Exp nweeks $
 *
 * $Log: tlkp_contactgroup.sql,v $
 * Revision 1.2  2011/06/22 01:33:25  nweeks
 * BigInt Upgrade
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_contactgroup.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tlkp_contactgroup (
  int_contactgroupid BIGINT NOT NULL,
  str_contactgroup VARCHAR(100) NOT NULL,
    PRIMARY KEY(int_contactgroupid),
    UNIQUE(str_contactgroup)
);
CREATE GENERATOR GEN_TLKP_CONTACTGROUP;


