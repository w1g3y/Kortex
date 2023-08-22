
/* =================================================
 *
 * Entity Name: 'tlkp_erpposition.sql'
 * Description:
 *
 *
 * $Id: tlkp_erpposition.sql,v 1.1 2008/07/01 03:07:42 nweeks Exp $
 *
 * $Log: tlkp_erpposition.sql,v $
 * Revision 1.1  2008/07/01 03:07:42  nweeks
 * Initial revision
 *
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_erpposition.sql...' from rdb$database;


CREATE TABLE tlkp_erpposition (
  int_positionid BIGINT NOT NULL,
  str_positionname VARCHAR(64),
  int_approveid BIGINT,
  str_desc VARCHAR(256),
  int_childof BIGINT,
  int_order INTEGER,
    PRIMARY KEY(int_positionid),
    UNIQUE(int_positionid, int_childof),
    FOREIGN KEY(int_childof) references tlkp_erpposition(int_positionid)
);
CREATE GENERATOR GEN_TLKP_erpposition;
alter table tlkp_erpposition add constraint fk_approvelev foreign key (int_approveid) references  tlkp_finapprovelevels(int_approveid);

