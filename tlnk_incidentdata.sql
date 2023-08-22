
/* =================================================
 *
 * Entity Name: 'tlnk_incidentdata.sql'
 * Description:
 *
 *
 * $Id: tlnk_incidentdata.sql,v 1.3 2012/11/29 23:51:51 nweeks Exp nweeks $
 *
 * $Log: tlnk_incidentdata.sql,v $
 * Revision 1.3  2012/11/29 23:51:51  nweeks
 * Fixed inline documentation
 *
 * Revision 1.2  2012/11/29 23:46:34  nweeks
 * Added tracking, and fixed foreign keys
 *
 * Revision 1.1  2012/11/29 23:44:09  nweeks
 * Initial revision
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_incidentdata.sql...' from rdb$database;

CREATE TABLE tlnk_incidentdata (
  int_incidentid INTEGER NOT NULL,
  int_listid INTEGER NOT NULL,
  str_value VARCHAR(128),
  str_extra1 VARCHAR(1024),
  str_extra2 VARCHAR(1024),
  blb_value BLOB SUB-TYPE TEXT,
  dtm_added DATETIME default 'now' NOT NULL,
    PRIMARY KEY(int_incidentid,int_listid),
    FOREIGN KEY(int_incidentid) REFERENCES tbl_incident(int_incidentid),
    FOREIGN KEY(int_listid) REFERENCES tlkp_listitems(int_listid)
);

