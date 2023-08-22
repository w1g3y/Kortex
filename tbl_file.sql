
/* =================================================
 *
 * Entity Name: 'tbl_file.sql'
 * Description:
 *
 *
 * $Id: tbl_file.sql,v 1.3 2011/06/22 01:31:57 nweeks Exp $
 *
 * $Log: tbl_file.sql,v $
 * Revision 1.3  2011/06/22 01:31:57  nweeks
 * made changes to global file repo
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

select 'Linking DNA tbl_file.sql...' from rdb$database;

select 'Linking DNA tbl_file ' from rdb$database;

CREATE TABLE tbl_file (
  int_fileid BIGINT NOT NULL, 
  str_filetype VARCHAR(16) default 'JPEG Image' NOT NULL,
  str_filename VARCHAR(128),
  str_ext VARCHAR(8),	/* Extension of the file */
  str_name VARCHAR(256),
  str_notes VARCHAR(2048),
  int_modtime INTEGER,
  str_md5 VARCHAR(40),
  str_sha256 VARCHAR(64),
  str_usedby VARCHAR(16),  /* MailFile, WebFile, etc */
  int_userid BIGINT,	/* Refer's to tbl_user */
  int_order INTEGER default 0 NOT NULL,
  int_accessed INTEGER default 0,
    PRIMARY KEY(int_fileid)
);
CREATE GENERATOR GEN_TBL_FILE;
CREATE INDEX IND_FILE_MD5 on tbl_file(str_md5);
CREATE INDEX IND_FILE_SHA256 on tbl_file(str_sha256);
CREATE INDEX IND_FILE_FILENAME on tbl_file(str_filename);
CREATE INDEX IND_FILE_EXT on tbl_file(str_ext);

alter table tbl_file add constraint fk_file_contact FOREIGN KEY (int_userid) references tbl_contact (int_contactid);
