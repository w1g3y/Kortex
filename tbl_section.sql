
/* =================================================
 *
 * Entity Name: 'tbl_section.sql'
 * Description:
 *
 *
 * $Id: tbl_section.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_section.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_section.sql...' from rdb$database;

select 'Linking DNA tbl_section' from rdb$database;

/* --- Section Table --- */
CREATE TABLE tbl_section (
  int_sectionid INTEGER NOT NULL,
  str_name VARCHAR(64) NOT NULL,
  str_code VARCHAR(32),
  int_order INTEGER,
    PRIMARY KEY(int_sectionid),
    UNIQUE(str_name)
);
CREATE GENERATOR GEN_TBL_SECTION;




