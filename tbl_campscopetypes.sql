
/* =================================================
 *
 * Entity Name: 'tbl_campscopetypes.sql'
 * Description:
 *
 *
 * $Id: tbl_campscopetypes.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_campscopetypes.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_campscopetypes.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

/* Limit Campaigns to Contact Types */
/* Limit Campaigns to Contact Types */
CREATE TABLE tbl_campscopetypes (
  int_campaignid INTEGER NOT NULL,
  int_contacttypeid INTEGER NOT NULL,
    PRIMARY KEY(int_campaignid, int_contacttypeid),
    FOREIGN KEY(int_campaignid) REFERENCES tbl_campaign(int_campaignid),
    FOREIGN KEY(int_contacttypeid) REFERENCES tlkp_contacttype(int_contacttypeid)
);
  


