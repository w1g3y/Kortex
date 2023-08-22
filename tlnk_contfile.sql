
/* =================================================
 *
 * Entity Name: 'tlnk_contfile.sql'
 * Description:
 *
 *
 * $Id: tlnk_contfile.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlnk_contfile.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_contfile.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tlnk_contfile (
  int_fileid INTEGER NOT NULL,
  int_contactid INTEGER NOT NULL,
  str_collection VARCHAR(32),  /* Mugshot, etc */
    PRIMARY KEY(int_fileid),
    FOREIGN KEY(int_fileid) REFERENCES tbl_file(int_fileid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid)
);

