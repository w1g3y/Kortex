
/* =================================================
 *
 * Entity Name: 'tlkp_mailaccounttag.sql'
 * Description:
 *
 *
 * $Id: tlkp_mailaccounttag.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlkp_mailaccounttag.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_mailaccounttag.sql...' from rdb$database;

select 'Linking DNA tlkp_mailaccounttag' from rdb$database;

create table tlkp_mailaccounttag (
  int_tagid INTEGER NOT NULL,
  str_tag VARCHAR(64) NOT NULL,
  str_group VARCHAR(16), /* Group related tags together */
  str_type VARCHAR(16) default 'text' NOT NULL
  str_default VARCHAR(64),
  str_help VARCHAR(256),
  int_order INTEGER,  /* Helps layout the configuration screens */
    PRIMARY KEY(int_tagid)
);
CREATE GENERATOR GEN_TLKP_MAILACCOUNTTAG;
CREATE INDEX IND_MAILACCTAG_TAG ON tlkp_mailaccounttag(str_tag);
