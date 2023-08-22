
/* =================================================
 *
 * Entity Name: 'tbl_contact.sql'
 * Description:
 *
 *
 * $Id: tbl_contact.sql,v 1.3 2011/06/22 01:29:32 nweeks Exp $
 *
 * $Log: tbl_contact.sql,v $
 * Revision 1.3  2011/06/22 01:29:32  nweeks
 * unknown change
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

select 'Linking DNA tbl_contact.sql...' from rdb$database;

/* ----- Contact todo -----
 * We need to inherit the features from the ehealth module to
 * add the flixible contact addressing
 */


CREATE TABLE tbl_contact (
  int_contactid BIGINT NOT NULL,
  str_companyname VARCHAR(128),
  str_title VARCHAR(32),
  str_firstname VARCHAR(32),
  str_middlename VARCHAR(32),
  str_surname VARCHAR(32),
  str_flatnumber VARCHAR(16),
  str_streetnumber VARCHAR(16),
  str_streetname VARCHAR(64),
  str_streetxtra VARCHAR(64),
  str_address VARCHAR(256),
  str_suburb VARCHAR(32),
  str_state VARCHAR(16),
  str_postcode VARCHAR(16),
  str_area_code VARCHAR(14),
  str_ac_phone VARCHAR(14),
  str_phone VARCHAR(16),
  dtm_verified TIMESTAMP,
  dtm_deverified TIMESTAMP,
  int_locality INTEGER,
  str_username varchar(32),
  str_password varchar(32),
  int_positionid BIGINT,
    PRIMARY KEY(int_contactid)
);
CREATE GENERATOR gen_tbl_contact;

alter table tbl_contact add constraint fk_contact_locality foreign key(int_localityid) references tlkp_locality(int_localityid);
alter table tbl_contact add constraint fk_contact_position foreign key(int_positionid) references tlkp_erpposition(int_positionid);

