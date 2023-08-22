
/* =================================================
 *
 * Entity Name: 'tbl_pageviews.sql'
 * Description:
 *
 *
 * $Id: tbl_pageviews.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_pageviews.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_pageviews.sql...' from rdb$database;

SELECT 'Linking DNA tbl_pageviews' from rdb$database;

/* =============
 * tbl_pageviews
 *
 * Stores views of a page
 * ===============
 */

CREATE TABLE tbl_pageviews (
  int_pageid INTEGER NOT NULL,
  dte_date DATE DEFAULT 'now' NOT NULL,
  int_count INTEGER NOT NULL
);

CREATE INDEX ind_pageview_pageid ON tbl_pageviews (int_pageid);
CREATE INDEX ind_pageview_date ON tbl_pageviews (dte_date);

 
