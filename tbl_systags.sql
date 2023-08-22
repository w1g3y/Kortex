
/* =================================================
 *
 * Entity Name: 'tbl_systags.sql'
 * Description:
 *
 *
 * $Id: tbl_systags.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_systags.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_systags.sql...' from rdb$database;

select 'Linking DNA tbl_systags' from rdb$database;

/* --- Systags ---
 * System tags are included at the template level, not the page level
 * As a result, they provide consistency across all pages
 */
CREATE TABLE tbl_systags (
  int_systagid INTEGER NOT NULL,
  str_tagname VARCHAR(32),
  str_lang VARCHAR(2) DEFAULT 'en', /* just incase we supply different systags for different langs */
  str_valuetype VARCHAR(16),
  blb_data BLOB SUB_TYPE TEXT,
  int_order INTEGER,  /* In case dependencies arise */
    PRIMARY KEY(int_systagid)
);
CREATE GENERATOR GEN_TBL_SYSTAGS;

