/* mod_user
User and permissions management for OpenAspect
all objects to be prefixed with 'muser'

#
# $Id: muser.sql,v 1.6 2003/10/27 22:24:51 nigel Exp nigel $
#
# $Log: muser.sql,v $
# Revision 1.6  2003/10/27 22:24:51  nigel
# Added support for user-configurable portal screen
#
# Revision 1.5  2003/09/30 00:44:02  nigel
# Updated license
#
# Revision 1.4  2003/09/17 23:14:57  nigel
# Updates to Copyright notice, and documentation
#
#
*/
/*
DROP INDEX MUSER_AIND_USER_EMAIL;
DROP INDEX MUSER_AIND_USER_HANDLE;
DROP INDEX MUSER_AIND_USER_password;
DROP INDEX MUSER_AIND_USER_country;
DROP INDEX MUSER_AIND_USER_authlevel;
DROP INDEX MUSER_AIND_USER_modlevel;
DROP GENERATOR MUSER_GEN_TBL_USER;
DROP TABLE MUSER_TBL_USER;
*/


/* muser_tlkp_role
Contains user roles for permission maintenance
*/
SELECT 'muser_tlkp_role' from rdb$database;
CREATE TABLE muser_tlkp_role (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_role INTEGER NOT NULL,
  str_role VARCHAR(20) NOT NULL,
    PRIMARY KEY(int_siteid,int_role),
    UNIQUE (int_siteid, str_role)
);

select 'muser_tbl_user' from rdb$database;
CREATE TABLE muser_tbl_user (
  int_siteid INTEGER default 1 NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_uid BIGINT NOT NULL,
  str_username VARCHAR(100) NOT NULL,
  str_email VARCHAR(100),
  str_handle VARCHAR(100),
  str_realname VARCHAR(100),
  str_altemail VARCHAR(100),
  str_password VARCHAR(40),
  str_privques VARCHAR(200), /* Backup question */
  str_privansw VARCHAR(200), /* Backup Answer */
  str_company VARCHAR(70),
  str_country VARCHAR(60),
  str_state VARCHAR(60),
  str_location VARCHAR(100),
  str_wphone VARCHAR(20),
  str_hphone VARCHAR(20),
  str_mphone VARCHAR(20),
  dtm_start DATE,
  dtm_dateone DATE, /* Miscellaneous fields */
  dtm_datetwo DATE,
  dtm_timeone TIME,
  dtm_timetwo TIME,
  str_miscone VARCHAR(200),
  str_misctwo VARCHAR(200),
  int_authlevel INTEGER DEFAULT 0, /* Authority level */
  int_modlevel INTEGER DEFAULT 0, /* Moderator Level */
  str_position VARCHAR(40), /* Job Desc */
  int_emplevel INTEGER, /* Employment Level */
  int_active INTEGER DEFAULT '0', /* Once registration is confirmed, goes 1 */
  str_colscheme VARCHAR(20), /* Color scheme this person uses */
  int_perpage INTEGER,	/* How many results per page */
  str_lang VARCHAR(20),	/* Default Lauguage */
  int_timeoffset INTEGER, /* GMT Time Offset(i.e. +10(Hobart) */
  str_currency VARCHAR(20), /* Currency Code */
    PRIMARY KEY (int_siteid,int_uid),
    UNIQUE (int_siteid, str_username)
);

INSERT INTO muser_tbl_user (int_siteid, int_uid, str_username, str_password)
values (1,'-1','admin','admin');

CREATE GENERATOR GEN_MUSER_TBL_USER;
CREATE ASC INDEX MUSER_AIND_USER_EMAIL ON muser_tbl_user (str_email);
CREATE ASC INDEX MUSER_AIND_USER_HANDLE ON muser_tbl_user (str_handle);
CREATE ASC INDEX MUSER_AIND_USER_password ON muser_tbl_user (str_password);
CREATE ASC INDEX MUSER_AIND_USER_country ON muser_tbl_user (str_country);
CREATE ASC INDEX MUSER_AIND_USER_authlevel ON muser_tbl_user (int_authlevel);
CREATE ASC INDEX MUSER_AIND_USER_modlevel ON muser_tbl_user (int_modlevel);


/* User to Role mapping
Users can be assigned to multiple roles, and a role can be performed 
by multiple users
*/
select 'muser_tlnk_userrole' from rdb$database;
CREATE TABLE muser_tlnk_userrole (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_uid BIGINT NOT NULL,
  int_role BIGINT NOT NULL,
    PRIMARY KEY(int_siteid, int_uid, int_role),
    FOREIGN KEY(int_siteid, int_uid)
      REFERENCES muser_tbl_user(int_siteid, int_uid)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_role)
      REFERENCES muser_tlkp_role(int_siteid, int_role)
      ON UPDATE CASCADE
);


/* muser_tlnk_roleperm
Contains a permissions code(mask) for the role, per screen/form
This mask is referenced by Interface, and Procedures
Sections of mask(8 flags):
res(128):res(64):res(32):Insert(16):Search(8):Get(4):Update(2):Delete(1)
*/
SELECT 'muser_tlnk_roleperm (Permissions masks for Roles)' from rdb$database;
CREATE TABLE muser_tlnk_roleperm (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_role INTEGER NOT NULL,
  str_form VARCHAR(32) NOT NULL, /* form code (table name) */
  int_mask INTEGER DEFAULT 12 NOT NULL, /* Default-read only(8+4=search+get) */
    PRIMARY KEY (int_siteid,int_role,str_form),
    FOREIGN KEY(int_siteid, int_role)
      REFERENCES muser_tlkp_role(int_siteid, int_role)
      ON UPDATE CASCADE
);


/* muser_tlnk_uportal
User Portal
Contains the structure of the application
portal for this user
Allows quick links to commonly used areas,
as well as customisability on a per-user basis.
REMEMBER: All text for links, etc, comes from mod_lingo, to allow for instant
translation into other languages. (Only the form code is stored here)
*/
SELECT 'muser_tlnk_uportal (User-customisable Portal)' FROM rdb$database;
CREATE TABLE muser_tlnk_uportal (
  int_siteid INTEGER NOT NULL, /* Replication Support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_uid BIGINT NOT NULL,
  int_menu INTEGER default 0 NOT NULL, /* This menu's ID */
  str_itemform VARCHAR(32) default '' NOT NULL, /* form code (table name)*/
  str_itemmode VARCHAR(10) default '' NOT NULL, /* New/Search/etc */
  int_itemmenu INTEGER default 0 NOT NULL, /* This link might be to another menu */ 
  int_order INTEGER,
    PRIMARY KEY(int_siteid,int_uid,int_menu,str_itemform,str_itemmode,int_itemmenu),
    FOREIGN KEY(int_siteid,int_uid) REFERENCES muser_tbl_user(int_siteid,int_uid)
      ON UPDATE CASCADE
);


