/* ========
Messaging Module (Molecule)
This is the email module for OpenAspect 
It stores all email accounts, whether pop3, imap, or smtp
It stores all messages, incoming, draft, and outgoing
It can use messages from mod_publish - pre-created 
pubications for emailling out
Development Logs
#
# $Log: modmsg.sql,v $
# Revision 1.3  2004/07/22 01:27:13  nigel
# Added the mail accounts table
#
# Revision 1.2  2004/07/22 01:20:57  nigel
# Added Account Type table
#
# Revision 1.1  2004/07/22 01:18:22  nigel
# Initial revision
#
#
======== */

/* ===========
Lookup Tables
=========== */

/* ===========
Account Type Lookup
=========== */
select 'Account Types Lookup Table' from rdb$database;
CREATE TABLE mmsg_tlkp_acctype (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL,
  int_acctype BIGINT NOT NULL,
  str_acctype VARCHAR(4) NOT NULL,
  str_desc VARCHAR(200),
    PRIMARY KEY(int_siteid, int_acctype),
    UNIQUE (int_siteid, str_acctype)
);
CREATE GENERATOR gen_mmsg_tlkp_acctype;


/* ===========
Base Tables
=========== */

/* ===========
Mail Accounts
=========== */
select 'Mail Accounts Table (mmsg_tbl_mailaccount)' from rdb$database;
CREATE TABLE mmsg_tbl_mailaccount (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL,
  int_account BIGINT NOT NULL,
  int_uid BIGINT NOT NULL,
  str_accname VARCHAR(100), /* Give this account a name */
  int_acctype BIGINT, /* References mmsg_tlkp_acctype */
  str_inhost VARCHAR(100),
  int_inhostssl INTEGER,
  int_inhostport INTEGER,
  str_inusername VARCHAR(200),
  str_inpassword VARCHAR(200),
  str_outhost VARCHAR(100),
  int_outhostssl INTEGER,
  int_outhostport INTEGER,
  str_outusername VARCHAR(200), /* Might be different to incoming... */
  str_outpassword VARCHAR(200),
    PRIMARY KEY(int_siteid, int_account, int_uid),
    FOREIGN KEY(int_siteid, int_acctype)
      REFERENCES mmsg_tlkp_acctype (int_siteid, int_acctype)
      ON UPDATE CASCADE
);
CREATE GENERATOR gen_mmsg_tbl_mailaccount;

/* INSERT INTO mmsg_tbl_mailaccount (int_siteid, int_account, int_uid, str_inhost, int_inhostport, str_inusername, str_inpassword) VALUES (1,gen_id(gen_mmsg_tbl_mailaccount,1),1,'203.26.213.13','143','nweeks','2DogTeeth');*/

/* ============
User Groups
============ */
select 'Molecule User Groups (mmsg_tbl_ugroups)' from rdb$database;
CREATE TABLE mmsg_tbl_ugroups (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL,
  int_gid BIGINT NOT NULL, /* Group ID */
  int_uid BIGINT NOT NULL, /* User ID */
  str_gname VARCHAR(60) NOT NULL,
    PRIMARY KEY(int_siteid, int_gid, int_uid),
    UNIQUE (int_siteid, str_gname)
);
CREATE GENERATOR GEN_MMSG_TBL_UGROUPS;
  


/* =============
Mail Folders
============= */
select 'Mail Folders' from rdb$database;
CREATE TABLE mmsg_tbl_mailfolders (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL,
  int_account BIGINT NOT NULL,
  int_uid BIGINT NOT NULL,
  int_childof BIGINT, /* Might be a child folder of another folder */
  str_fname VARCHAR(50) NOT NULL, /* The Folder Name */
  int_private INTEGER,
  int_group INTEGER,
  int_public INTEGER,
    PRIMARY KEY(int_siteid, int_account, int_uid, str_fname)
);


/* ================
Message Store
In the case of IMAP, this is a local copy
IMAP messages are left on the server.
When deleted from here, they're put in the trash, and
removed from the server.

================ */
select 'Mail Message Store' from rdb$database;
CREATE TABLE mmsg_tbl_messages (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP default 'now' NOT NULL,
  int_message BIGINT NOT NULL,
  int_uid BIGINT NOT NULL, /* Who owns this message? */
  int_account BIGINT NOT NULL, /* Which account does this belong inside? */
  str_subject VARCHAR(250), /* Not blobbed, so it's indexable */
  str_body BLOB SUB_TYPE TEXT, /* Could be any size, so we BLOB it */
  str_whole BLOB SUB_TYPE TEXT, /* The entire, unadulterated email */
    PRIMARY KEY(int_siteid, int_message, int_uid),
    FOREIGN KEY(int_siteid, int_account, int_uid) REFERENCES mmsg_tbl_mailaccount(int_siteid, int_account, int_uid)
);

CREATE GENERATOR GEN_MMSG_TBL_MESSAGES;
 
 
