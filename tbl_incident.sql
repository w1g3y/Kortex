
/* =================================================
 *
 * Entity Name: 'tbl_incident.sql'
 * Description:
 *
 *
 * $Id: tbl_incident.sql,v 1.3 2012/11/29 23:33:07 nweeks Exp nweeks $
 *
 * $Log: tbl_incident.sql,v $
 * Revision 1.3  2012/11/29 23:33:07  nweeks
 * Added tracking and auditing info into Incidents
 *
 * Revision 1.2  2012/11/29 22:57:50  nweeks
 * Fixed generator name
 *
 * Revision 1.1  2011/06/22 01:31:57  nweeks
 * Initial revision
 *
 * Revision 1.3  2008/09/09 01:04:34  nweeks
 * *** empty log message ***
 *
 * Revision 1.2  2008/07/01 03:22:37  nweeks
 * General Checkin
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_incident.sql...' from rdb$database;

/* --------------
 * Management :: Incident Table
 *
 * 
 * --------------
 */

select 'Linking DNA tbl_incident' from rdb$database;

CREATE TABLE tbl_incident (
  int_incidentid INTEGER NOT NULL,
  int_personid BIGINT NOT NULL,  /* Who the incident involved */
  int_supervisorid BIGINT NOT NULL,
  int_witness1id BIGINT,
  int_witness2id BIGINT,
  int_witness3id BIGINT,
  int_witness4id BIGINT,
  int_typeid INTEGER NOT NULL,
  dte_incident DATE NOT NULL,
  tme_incident TIME,
  dte_reported DATEi not null default 'now',
  tme_reported TIME,
  dte_firstaid DATE,
  int_locationid INTEGER, 
  int_departmentid INTEGER,
  itn_shiftid INTEGER,
  int_empstatusid INTEGER,
  int_riskid INTEGER,
  dte_investigated DATE,
  dte_notified DATE,
  dtm_closed DATE,
  str_name VARCHAR(64) NOT NULL,
  str_desc VARCHAR(512),
  
    PRIMARY KEY(int_itemid),
    FOREIGN KEY(int_ownerid) REFERENCES tbl_user(int_userid)
);
CREATE GENERATOR GEN_TBL_INCIDENT;



 
