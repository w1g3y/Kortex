
/* =================================================
 *
 * Entity Name: 'tlkp_invmanufmodel.sql'
 * Description:
 *
 *
 * $Id: tlkp_invmanufmodel.sql,v 1.3 2008/07/01 03:22:37 nweeks Exp $
 *
 * $Log: tlkp_invmanufmodel.sql,v $
 * Revision 1.3  2008/07/01 03:22:37  nweeks
 * General Checkin
 *
 * Revision 1.2  2007/07/19 14:06:37  nweeks
 * Further work
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_invmanufmodel.sql...' from rdb$database;

/* --------------
 * Inventory :: Manufacturer Lookup Table
 *
 * --------------
 */
select 'Linking DNA tlkp_invmanufacturer' from rdb$database;


CREATE TABLE tlkp_invmanufacturer (
  int_manufid INTEGER NOT NULL,
  str_name VARCHAR(64) NOT NULL,
  sdx_name VARCHAR(16), /* Soundex representation of name */
  str_desc VARCHAR(512),
    PRIMARY KEY(int_manufid)
);
CREATE GENERATOR GEN_TLKP_INVMANUFACTURER;



select 'Linking DNA tlkp_invmanufmodel' from rdb$database;

CREATE TABLE tlkp_invmanufmodel (
  int_modelid INTEGER NOT NULL,
  int_manufid INTEGER NOT NULL,
  str_model VARCHAR(64) NOT NULL,
  sdx_model VARCHAR(16), /* Soundex representation of model */
  str_xtra VARCHAR(32), /* The 'Astina' in Mazda : 323 : Astina */
  sdx_xtra VARCHAR(16), /* Soundex representation of xtra */
    PRIMARY KEY(int_modelid, int_manufid),
    FOREIGN KEY(int_manufid) REFERENCES tlkp_invmanufacturer(int_manufid)
);
CREATE GENERATOR GEN_TLKP_INVMANUFMODEL;

 
