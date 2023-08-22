
/* =================================================
 *
 * Entity Name: 'tbl_pagenote.sql'
 * Description:
 *
 *
 * $Id: tbl_pagenote.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_pagenote.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_pagenote.sql...' from rdb$database;

select 'Linking DNA tbl_pagenote' from rdb$database;

/* --- Page Notes ---
 * Every page can have comments.
 * Bit like a blog on every page
 */
CREATE TABLE tbl_pagenote (
  int_noteid INTEGER NOT NULL,
  int_pageid INTEGER NOT NULL,
  dtm_created TIMESTAMP DEFAULT 'now' NOT NULL,
  str_lang VARCHAR(2) default 'en' NOT NULL,
  str_valuetype VARCHAR(16) default 'text',    /* Special people can make HTML notes with links */
  blb_note BLOB SUB_TYPE TEXT, /* Store the text of the blob */ 
  int_createdby INTEGER,
  int_editedby INTEGER,
    PRIMARY KEY(int_noteid),
    FOREIGN KEY(int_pageid) REFERENCES tbl_page(int_pageid)
);
CREATE GENERATOR GEN_TBL_PAGENOTE;
  


