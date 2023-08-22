
/* =================================================
 *
 * Entity Name: 'tbl_feature.sql'
 * Description:
 *
 *
 * $Id: tbl_feature.sql,v 1.2 2011/06/22 01:31:36 nweeks Exp $
 *
 * $Log: tbl_feature.sql,v $
 * Revision 1.2  2011/06/22 01:31:36  nweeks
 * Publication feature table
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_feature.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tbl_feature (
  int_featureid BIGINT NOT NULL,
  str_name VARCHAR(128) NOT NULL,
  int_featuretypeid INTEGER NOT NULL,
  dte_closing DATE,
  dte_press DATE,
  dte_release DATE,
  str_desc VARCHAR(512),
  str_notes VARCHAR(2048),
    PRIMARY KEY(int_featureid),
    FOREIGN KEY(INT_FEATURETYPEID) REFERENCES tlkp_featuretype(int_featuretypeid)
);
CREATE GENERATOR GEN_TBL_FEATURE;


