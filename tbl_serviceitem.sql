
/* =================================================
 *
 * Entity Name: 'tbl_serviceitem.sql'
 * Description:
 *
 *
 * $Id: tbl_serviceitem.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tbl_serviceitem.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_serviceitem.sql...' from rdb$database;

/* ==============
 * Service Items
 * Advertising packages, etc
 *
 * ==============
 */

select 'Linking DNA tbl_serviceitem' from rdb$database;

CREATE TABLE tbl_serviceitem(
  int_servitemid INTEGER NOT NULL,
  str_name VARCHAR(128) NOT NULL,
  str_desc VARCHAR(512),
  flt_price NUMERIC(18,3),
    PRIMARY KEY(int_servitemid)
);

CREATE GENERATOR GEN_TBL_SERVICEITEM;

