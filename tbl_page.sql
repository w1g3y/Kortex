
/* =================================================
 *
 * Entity Name: 'tbl_page.sql'
 * Description:
 *
 *
 * $Id: tbl_page.sql,v 1.2 2008/07/01 03:22:37 nweeks Exp $
 *
 * $Log: tbl_page.sql,v $
 * Revision 1.2  2008/07/01 03:22:37  nweeks
 * General Checkin
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_page.sql...' from rdb$database;

select 'Linking DNA tbl_page' from rdb$database;

/* --- Page --- 
 * The page itself.
 * No more than just a placeholder, and a choice of template.
 * Although the name/section combo is used by the renderer for page choice
 */
CREATE TABLE tbl_page (
  int_pageid INTEGER NOT NULL,
  int_childof INTEGER,		/* This page might have a parent (page 2,3,4 etc) */
  int_sectionid INTEGER NOT NULL,  /* Pages fall under a section */
  int_templateid INTEGER NOT NULL, /* Pages have a template */
  int_order INTEGER default 0 NOT NULL,
  bool_homepage INTEGER,	/* Connected to the home page menu */
  str_name VARCHAR(64) NOT NULL,    /* Give the page a name(good for nav strip) */
  str_intro VARCHAR(256),     /* Just in case the page needs an intro */
  dtm_created TIMESTAMP DEFAULT 'now' NOT NULL,
  dtm_edited TIMESTAMP DEFAULT 'now' NOT NULL,
  int_createdby INTEGER,
  int_editedby INTEGER,
  ibl_cacheable INTEGER default 1,
    PRIMARY KEY(int_pageid),
    UNIQUE (int_sectionid, str_name),
    FOREIGN KEY(int_sectionid) REFERENCES tbl_section (int_sectionid),
    FOREIGN KEY(int_templateid) REFERENCES tbl_template (int_templateid),
    FOREIGN KEY(int_childof) REFERENCES tbl_page(int_pageid)
);
CREATE GENERATOR GEN_TBL_PAGE;



