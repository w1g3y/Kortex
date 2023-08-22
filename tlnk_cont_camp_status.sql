
/* =================================================
 *
 * Entity Name: 'tlnk_cont_camp_status.sql'
 * Description:
 *
 *
 * $Id: tlnk_cont_camp_status.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlnk_cont_camp_status.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_cont_camp_status.sql...' from rdb$database;

select 'Linking DNA tbl_ ' from rdb$database;

CREATE TABLE tlnk_cont_camp_status (
  int_statusid INTEGER NOT NULL,
  int_campaignid INTEGER NOT NULL,
  int_contactid INTEGER NOT NULL,
  int_status INTEGER,   /* 0:uncalled, 1:calling, 2:accepted, -1:denied */
  str_notes VARCHAR(2048),
    PRIMARY KEY(int_statusid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact(int_contactid),
    FOREIGN KEY(int_campaignid) REFERENCES tbl_campaign(int_campaignid)
);
CREATE GENERATOR GEN_TLNK_CONT_CAMP_STATUS;



