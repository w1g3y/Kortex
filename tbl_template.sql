
/* =================================================
 *
 * Entity Name: 'tbl_template.sql'
 * Description:
 *
 *
 * $Id: tbl_template.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_template.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_template.sql...' from rdb$database;

select 'Linking DNA tbl_template' from rdb$database;

/* --- Page Templates --- 
 *
 * All pages are based on templates
 * that have tags in them, that are replaced by content
 * from a database
 *
 * This allows site-wide changes to happen instantly
 */
CREATE TABLE tbl_template (
  int_templateid INTEGER NOT NULL,
  str_name VARCHAR(64) NOT NULL,
  str_desc VARCHAR(256),
  str_previewimage VARCHAR(32),
  blb_data BLOB SUB_TYPE TEXT,    /* Somewhere to store the markup, with tags to substitute in */
    PRIMARY KEY(int_templateid)
);
CREATE GENERATOR GEN_TBL_TEMPLATE;

