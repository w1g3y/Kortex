
/* =================================================
 *
 * Entity Name: 'tbl_campscopelocality.sql'
 * Description:
 *
 *
 * $Id: tbl_campscopelocality.sql,v 1.2 2011/06/22 01:29:32 nweeks Exp $
 *
 * $Log: tbl_campscopelocality.sql,v $
 * Revision 1.2  2011/06/22 01:29:32  nweeks
 * unknown change
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_campscopelocality.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

/* Limit Campaigns to localities */
/* Limit Campaigns to localities */
CREATE TABLE tbl_campscopelocality (
  int_campaignid BIGINT NOT NULL,
  int_localityid INTEGER NOT NULL,
    PRIMARY KEY(int_campaignid, int_localityid),
    FOREIGN KEY(int_campaignid) REFERENCES tbl_campaign(int_campaignid),
    FOREIGN KEY(int_localityid) REFERENCES tlkp_locality(int_localityid)
);

