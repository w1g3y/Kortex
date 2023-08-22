
/* =================================================
 *
 * Entity Name: 'tbl_publication.sql'
 * Description:
 *
 *
 * $Id: tbl_publication.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_publication.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_publication.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tbl_publication (
  int_pubid INTEGER NOT NULL,
  str_pubname VARCHAR(64) NOT NULL,
  int_pubtype INTEGER,
  str_desc VARCHAR(128),
    PRIMARY KEY(int_pubid),
    FOREIGN KEY(int_pubtype) REFERENCES tlkp_pubtype(int_pubtypeid)
);
CREATE GENERATOR GEN_TBL_PUBLICATION;



