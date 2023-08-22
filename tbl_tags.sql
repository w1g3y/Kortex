
/* =================================================
 *
 * Entity Name: 'tbl_tags.sql'
 * Description:
 *
 *
 * $Id: tbl_tags.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_tags.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_tags.sql...' from rdb$database;

select 'Linking DNA tbl_tags' from rdb$database;

/* --- Tags --- 
 * Used in the Content Management module
 * Templates have tags in them that are substituted.
 * Here we control/reuse the tags, and their value type
 */
CREATE TABLE tbl_tags (
  int_tagid INTEGER NOT NULL,
  str_tagname VARCHAR(64) NOT NULL,
  str_valuetype VARCHAR(16),   /* Integer, Free Text, HTML, Date, PHP, etc */
  int_order INTEGER,	/* In case dependencies arise */
    PRIMARY KEY(int_tagid)
);
CREATE GENERATOR GEN_TBL_TAGS;

