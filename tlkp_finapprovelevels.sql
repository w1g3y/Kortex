
/* =================================================
 *
 * Entity Name: 'tlkp_finapprovelevels.sql'
 * Description:
 *
 *
 * $Id: tlkp_finapprovelevels.sql,v 1.1 2008/07/01 03:07:42 nweeks Exp $
 *
 * $Log: tlkp_finapprovelevels.sql,v $
 * Revision 1.1  2008/07/01 03:07:42  nweeks
 * Initial revision
 *
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_finapprovelevels.sql...' from rdb$database;


CREATE TABLE tlkp_finapprovelevels (
  int_approveid BIGINT NOT NULL,
  str_approvelevelname VARCHAR(64),
  str_desc VARCHAR(256),
  flt_limit numeric(18,3),
    PRIMARY KEY(int_approveid),
    UNIQUE(str_approvelevelname)
);
CREATE GENERATOR GEN_TLKP_finapprovelevels;
