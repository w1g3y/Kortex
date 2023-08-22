
/* =================================================
 *
 * Entity Name: 'tlkp_invitemtag.sql'
 * Description:
 *
 *
 * $Id: tlkp_invitemtag.sql,v 1.1 2007/07/19 14:06:37 nweeks Exp $
 *
 * $Log: tlkp_invitemtag.sql,v $
 * Revision 1.1  2007/07/19 14:06:37  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_invitemtag.sql...' from rdb$database;

CREATE TABLE tlkp_invitemtag (
  int_tagid INTEGER NOT NULL,
  str_name VARCHAR(32) NOT NULL,
  str_group VARCHAR(32),
  str_desc VARCHAR(256),
  int_order INTEGER default 0,
    PRIMARY KEY(int_tagid),
    UNIQUE (str_name)
);
CREATE GENERATOR GEN_TLKP_INVITEMTAG;

