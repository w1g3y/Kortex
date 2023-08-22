
/* =================================================
 *
 * Entity Name: 'tbl_pagetags.sql'
 * Description:
 *
 *
 * $Id: tbl_pagetags.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_pagetags.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_pagetags.sql...' from rdb$database;

select 'Linking DNA tbl_pagetags' from rdb$database;

/* --- Page Tags --- 
 * Here we store the values for the tags on the page.
 * HTML tags are simply echoed
 * PHP tags are evalled, and the $phpout variable echoed
 */
CREATE TABLE tbl_pagetags (
  int_versionid INTEGER NOT NULL,
  dtm_version TIMESTAMP DEFAULT 'now' NOT NULL,
  ibl_mod INTEGER default 0 NOT NULL,  /* Has this tag been moderated */
  int_pageid INTEGER NOT NULL,
  int_tagid INTEGER NOT NULL,
  str_lang VARCHAR(2) DEFAULT 'en' NOT NULL,
  blb_data BLOB SUB_TYPE TEXT,   /* Somewhere to store the value of the tag  */
  dtm_created TIMESTAMP DEFAULT 'now' NOT NULL,
  dtm_edited TIMESTAMP,
  int_createdby INTEGER,
  int_editedby INTEGER,
    PRIMARY KEY(int_versionid),
    FOREIGN KEY(int_pageid) REFERENCES tbl_page(int_pageid),
    FOREIGN KEY(int_tagid) REFERENCES tbl_tags(int_tagid)
);
CREATE GENERATOR GEN_TBL_PAGETAGS;
CREATE DESC INDEX DESC_PAGETAG_DTMVERSION on tbl_pagetags(dtm_version);


