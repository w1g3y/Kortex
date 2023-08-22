
/* =================================================
 *
 * Entity Name: 'tbl_templatetags.sql'
 * Description:
 *
 *
 * $Id: tbl_templatetags.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_templatetags.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_templatetags.sql...' from rdb$database;

select 'Linking DNA tbl_templatetags' from rdb$database;

/* --- Template Tags --- 
 * Here we control which tags appear in which templates.
 * (used for creating nice forms to fill in the blanks)
 */
CREATE TABLE tbl_templatetags (
  int_templateid INTEGER NOT NULL,
  int_tagid INTEGER NOT NULL,
  int_order INTEGER,
    PRIMARY KEY(int_templateid, int_tagid),
    FOREIGN KEY(int_templateid) REFERENCES tbl_template(int_templateid),
    FOREIGN KEY(int_tagid) REFERENCES tbl_tags(int_tagid)
);

