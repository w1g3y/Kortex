
/* =================================================
 *
 * Entity Name: 'tlkp_invitemtype.sql'
 * Description:
 *
 *
 * $Id: tlkp_invitemtype.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlkp_invitemtype.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_invitemtype.sql...' from rdb$database;

/* --------------
 * Inventory :: Item Types (Bike, Part, etc)
 *
 * --------------
 */
select 'Linking DNA tlkp_invitemtype' from rdb$database;


CREATE TABLE tlkp_invitemtype (
  int_typeid INTEGER NOT NULL,
  str_type VARCHAR(32),
  str_desc VARCHAR(128),
    PRIMARY KEY(int_typeid)
);
CREATE GENERATOR GEN_TLKP_INVITEMTYPE;
