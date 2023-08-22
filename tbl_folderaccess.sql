
/* =================================================
 *
 * Entity Name: 'tbl_folderaccess.sql'
 * Description:
 *
 *
 * $Id: tbl_folderaccess.sql,v 1.1 2007/11/05 07:12:25 nweeks Exp $
 *
 * $Log: tbl_folderaccess.sql,v $
 * Revision 1.1  2007/11/05 07:12:25  nweeks
 * Initial revision
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_folderaccess.sql...' from rdb$database;


CREATE TABLE tbl_folderaccess (
  int_folderid INTEGER NOT NULL,
  int_roleid INTEGER NOT NULL,
  ibl_view INTEGER,	/* Can this role even view the contents of this folder */
  ibl_download INTEGER,  /* Download access */
  ibl_upload INTEGER,  ?8 Upload Access */
    PRIMARY KEY(int_folderid),
    FOREIGN KEY(int_roleid) REFERENCES tbl_role(int_roleid)
);
