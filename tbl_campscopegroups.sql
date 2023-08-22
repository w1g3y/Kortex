
/* =================================================
 *
 * Entity Name: 'tbl_campscopegroups.sql'
 * Description:
 *
 *
 * $Id: tbl_campscopegroups.sql,v 1.2 2011/06/22 01:29:32 nweeks Exp $
 *
 * $Log: tbl_campscopegroups.sql,v $
 * Revision 1.2  2011/06/22 01:29:32  nweeks
 * unknown change
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_campscopegroups.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

/* Limit Campaigns to Contact Groups */
/* Limit Campaigns to Contact Groups */
CREATE TABLE tbl_campscopegroups (
  int_campaignid BIGINT NOT NULL,
  int_contactgroupid INTEGER NOT NULL,
    PRIMARY KEY(int_campaignid, int_contactgroupid),
    FOREIGN KEY(int_campaignid) REFERENCES tbl_campaign(int_campaignid),
    FOREIGN KEY(int_contactgroupid) REFERENCES tlkp_contactgroup(int_contactgroupid)
);

