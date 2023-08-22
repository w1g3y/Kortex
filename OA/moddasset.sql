/* This is the schema for the Digital Assets Management system
203.26.213.13:/u1/db/dam.fdb

*/

CREATE TABLE mdas_tlkp_keyword (
  int_siteid INTEGER DEFAULT 1 NOT NULL,
  int_keyword NUMERIC(18,0) NOT NULL,
  str_keyword VARCHAR(40) NOT NULL,
    PRIMARY KEY(int_siteid, int_keyword),
    UNIQUE (int_siteid, str_keyword)
);
CREATE GENERATOR GEN_mdas_TLKP_KEYWORD;

CREATE TABLE mdas_tlkp_category (
  int_siteid INTEGER DEFAULT 1 NOT NULL,
  int_categ NUMERIC(18,0) NOT NULL,
  str_categ VARCHAR(40) NOT NULL,
  int_count INTEGER,
    PRIMARY KEY(int_siteid, int_categ),
    UNIQUE (int_siteid, str_categ)
);
CREATE GENERATOR GEN_mdas_TLKP_category;



CREATE TABLE mdas_tbl_digasset (
  int_siteid INTEGER DEFAULT 1 NOT NULL,
  int_digasset NUMERIC(18,0) NOT NULL,
  int_refdigasset NUMERIC(18,0), /* Point to the original copy */
  str_filename VARCHAR(100) NOT NULL,
  int_modified INTEGER, /* The timestamp of last modification */
  int_filesize INTEGER, /* The filesize of the original */
  str_md5 VARCHAR(40),
  str_mime VARCHAR(30), /* Mime type goes here */
  int_preview INTEGER, /* Have Preview images been created? */
  int_secure INTEGER DEFAULT 0, /* 0:all,1:restricted,2:denied */
  int_aduse INTEGER DEFAULT 0, /* Can this image be used for ads? */
  int_internet INTEGER DEFAULT 0, /* Can this image be sold on internet */
  int_archived INTEGER default 0, /* 0:needs thumbnail/copying, 1:ok */
  int_orwidth INTEGER,
  int_orheight INTEGER,
  str_path1 VARCHAR(100),
  str_path2 VARCHAR(100),
  str_path3 VARCHAR(100),
  str_path4 VARCHAR(100),
  str_desc VARCHAR(200),
    PRIMARY KEY(int_siteid, int_digasset)
);
CREATE GENERATOR GEN_mdas_TBL_DIGASSET;
set generator gen_mdas_tbl_digasset to 1000;

CREATE ASC INDEX IND_DIGASSET_md5 ON mdas_tbl_digasset (str_md5);
CREATE ASC INDEX IND_DIGASSET_file ON mdas_tbl_digasset (str_filename);
CREATE ASC INDEX IND_DIGASSET_path1 ON mdas_tbl_digasset (str_path1);
CREATE ASC INDEX IND_DIGASSET_path2 ON mdas_tbl_digasset (str_path2);
CREATE ASC INDEX IND_DIGASSET_path3 ON mdas_tbl_digasset (str_path3);
CREATE ASC INDEX IND_DIGASSET_path4 ON mdas_tbl_digasset (str_path4);
CREATE ASC INDEX IND_DIGASSET_mod ON mdas_tbl_digasset (int_modified);

CREATE TABLE mdas_tbl_dathumbstat (
  int_siteid INTEGER DEFAULT 1 NOT NULL,
  int_digasset NUMERIC(18,0) NOT NULL,
  int_longedge INTEGER NOT NULL,
  int_status INTEGER, /* 0:ok, 1:Pending, 2:Missing */
  int_copied INTEGER, /* non-image copied(+zipped) 0:false, 1:true */
    PRIMARY KEY(int_siteid, int_digasset, int_longedge)
);
CREATE INDEX IND_MDAS_TBL_DATHUMBSTAT_LONG;
 


CREATE TABLE mdas_tlnk_dakeywords (
  int_siteid INTEGER DEFAULT 1 NOT NULL,
  int_digasset NUMERIC(18,0) NOT NULL,
  int_keyword NUMERIC(18,0) NOT NULL,
    PRIMARY KEY(int_siteid, int_digasset,int_keyword),
    FOREIGN KEY(int_siteid, int_digasset) REFERENCES mdas_tbl_digasset(int_siteid, int_digasset) ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_keyword) REFERENCES mdas_tlkp_keyword(int_siteid, int_keyword) ON UPDATE CASCADE
);

CREATE TABLE mdas_tlnk_dacategory (
  int_siteid INTEGER DEFAULT 1 NOT NULL,
  int_digasset NUMERIC(18,0) NOT NULL,
  int_categ NUMERIC(18,0) NOT NULL,
    PRIMARY KEY(int_siteid, int_digasset,int_categ),
    FOREIGN KEY(int_siteid, int_digasset) REFERENCES mdas_tbl_digasset(int_siteid, int_digasset) ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_categ) REFERENCES mdas_tlkp_category(int_siteid, int_categ) ON UPDATE CASCADE
);

