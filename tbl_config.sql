/* =================================================
 *
 * Entity Name: 'tbl_config.sql'
 * Description:
 *
 *
 * $Id: tbl_config.sql,v 1.1 2011/06/22 01:29:23 nweeks Exp $
 *
 * $Log: tbl_config.sql,v $
 * Revision 1.1  2011/06/22 01:29:23  nweeks
 * Initial revision
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_config.sql...' from rdb$database;


/* --- System Config ---
 * Business Setup is managed and stored here, and tlkp_choices is merely for pull-down menu sources
 * 
 */
CREATE TABLE TBL_CONFIG (
  INT_PARAMETER BIGINT NOT NULL,
  STR_PARAMGRP VARCHAR(64) NOT NULL,
  STR_PARAMSUBGRP VARCHAR(64) NOT NULL,
  STR_PARAMETER VARCHAR(64),
  STR_VALUE VARCHAR(256),
    PRIMARY KEY(int_parameter)

);
CREATE GENERATOR GEN_TBL_CONFIG;

