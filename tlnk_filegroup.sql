
/* =================================================
 *
 * Entity Name: 'tlnk_filegroup.sql'
 * Description:
 *
 *
 * $Id: tlnk_filegroup.sql,v 1.1 2007/05/21 06:38:24 nweeks Exp $
 *
 * $Log: tlnk_filegroup.sql,v $
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_filegroup.sql...' from rdb$database;

select 'Linking DNA tlnk_filegroup ' from rdb$database;

CREATE TABLE tlnk_filegroup (
  int_groupid INTEGER NOT NULL,
  int_fileid INTEGER not null,
    PRIMARY KEY(int_groupid, int_fileid),
    FOREIGN KEY (int_groupid) REFERENCES tlkp_filegroup (int_groupid),
    FOREIGN KEY (int_fileid) REFERENCES tbl_file (int_fileid)
);


