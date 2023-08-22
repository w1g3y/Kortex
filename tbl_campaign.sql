
/* =================================================
 *
 * Entity Name: 'tbl_campaign.sql'
 * Description:
 *
 *
 * $Id: tbl_campaign.sql,v 1.2 2011/06/22 01:29:32 nweeks Exp $
 *
 * $Log: tbl_campaign.sql,v $
 * Revision 1.2  2011/06/22 01:29:32  nweeks
 * unknown change
 *
 * Revision 1.1  2007/05/21 06:35:52  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_campaign.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tbl_campaign (
  int_campaignid BIGINT NOT NULL,
  str_name VARCHAR(64) NOT NULL,
  str_desc VARCHAR(512),
  str_notes VARCHAR(2048),
  int_featureid INTEGER,
  int_eventid INTEGER,
  int_pubid INTEGER,
    PRIMARY KEY(int_campaignid),
    FOREIGN KEY(int_featureid) REFERENCES tbl_feature(int_featureid)
);
CREATE GENERATOR GEN_TBL_CAMPAIGN;

