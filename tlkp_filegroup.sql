
/* =================================================
 *
 * Entity Name: 'tlkp_filegroup.sql'
 * Description:
 *
 *
 * $Id: tlkp_filegroup.sql,v 1.2 2008/07/01 03:22:37 nweeks Exp $
 *
 * $Log: tlkp_filegroup.sql,v $
 * Revision 1.2  2008/07/01 03:22:37  nweeks
 * File Group Master list - the names of the groups. Files are linked to groups in the tlnk_
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_filegroup.sql...' from rdb$database;

select 'Linking DNA tlkp_filegroup ' from rdb$database;

CREATE TABLE tlkp_filegroup (
  int_groupid INTEGER NOT NULL,
  int_childof INTEGER,
  str_name VARCHAR(128),
  str_desc VARCHAR(512),
  int_order INTEGER default 0 NOT NULL,
    PRIMARY KEY(int_groupid),
    UNIQUE(str_name)
);
CREATE GENERATOR GEN_TLKP_FILEGROUP;


