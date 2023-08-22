
/* =================================================
 *
 * Entity Name: 'tlkp_invcategory.sql'
 * Description:
 *
 *
 * $Id: tlkp_invcategory.sql,v 1.2 2007/09/12 21:01:34 nweeks Exp $
 *
 * $Log: tlkp_invcategory.sql,v $
 * Revision 1.2  2007/09/12 21:01:34  nweeks
 * removed recursive structure, and added groups and ordering.
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_invcategory.sql...' from rdb$database;

/* --------------
 * Inventory :: Item Categories
 *
 * The grouping of similar items
 * --------------
 */
select 'Linking DNA tbl_invcategory' from rdb$database;


CREATE TABLE tlkp_invcategory (
  int_catid INTEGER NOT NULL,
  str_catgroup VARCHAR(32),
  str_name VARCHAR(32),
  str_desc VARCHAR(128),
  int_order INTEGER default 0,
    PRIMARY KEY(int_catid),
    FOREIGN KEY(int_childof) REFERENCES tlkp_invcategory (int_catid)
);
CREATE GENERATOR GEN_TLKP_INVCATEGORY;
