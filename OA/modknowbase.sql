/* mod_knowbase
Knowledge Base module for OpenAspect
Articles will have several main sections:
Title
Introduction
Symptom(s)
Cause(s)
Workaround(s)
Resolution(s)
Reference(s)
Further Info(s)
Keywords(s)

Additionally, knowledgebase articles will also have links to software and systems:
Applies To:
Similar To KB Articles:
*/

/* =================

Lookup Tables

================= */

/* Applies to table
This will most likely be heavily used to provide multiple levels 
of heirarchy in the Knowledge Base
*/

SELECT '"Applies-to" Lookup Table' from rdb$database;
CREATE TABLE modkb_tlkp_applies (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_applies BIGINT NOT NULL,
  str_name VARCHAR(200) NOT NULL,
  str_description VARCHAR(500) NOT NULL,
  str_type VARCHAR(3), /* SFT:software, SYS:System, PRC:Procedure */
  int_level INTEGER DEFAULT 1 NOT NULL,
    PRIMARY KEY(int_siteid,int_applies)/*,
    UNIQUE (int_siteid,str_name,str_version)*/
);
CREATE GENERATOR gen_modkb_tlkp_applies;


/* Organisational Unit
Could be department/division/etc
Used so people in a department can browse all articles applicable to them
*/
SELECT 'Organisational Unit' from rdb$database;
CREATE TABLE modkb_tlkp_orgunit (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_orgunit BIGINT NOT NULL,
  str_orgunit VARCHAR(50) NOT NULL,
    PRIMARY KEY(int_siteid, int_orgunit),
    UNIQUE (int_siteid, str_orgunit)
);
CREATE GENERATOR gen_modkb_tlkp_orgunit;



/* =================

Base Tables

================= */

SELECT 'Base KB Article' from rdb$database;
CREATE TABLE modkb_tbl_article (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_article BIGINT NOT NULL,
  str_title VARCHAR(200) NOT NULL,
  str_intro VARCHAR(500),
  str_text VARCHAR(10000),
  int_cat1 BIGINT NOT NULL,
  int_cat2 BIGINT NOT NULL,
  int_cat3 BIGINT, /* The last two categories are optional */
  int_cat4 BIGINT, 
  int_order INTEGER,
    PRIMARY KEY(int_siteid, int_article),
    FOREIGN KEY(int_siteid, int_cat1)
      REFERENCES modkb_tlkp_applies (int_siteid, int_applies)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_cat2)
      REFERENCES modkb_tlkp_applies (int_siteid, int_applies)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_cat3)
      REFERENCES modkb_tlkp_applies (int_siteid, int_applies)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_cat4)
      REFERENCES modkb_tlkp_applies (int_siteid, int_applies)
      ON UPDATE CASCADE
);
CREATE GENERATOR gen_modkb_tbl_article;


/* =================

Link Tables
OrgUnit (for article)
Paragraphs linked to Articles
================= */

SELECT 'modkb_tlnk_orgunitkbart' from rdb$database;
CREATE TABLE modkb_tlnk_orgunitkbart (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_orgunit BIGINT NOT NULL,
  int_article BIGINT NOT NULL,
    PRIMARY KEY(int_siteid,int_orgunit,int_article),
    FOREIGN KEY(int_siteid, int_article)
      REFERENCES modkb_tbl_article (int_siteid, int_article)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_orgunit)
      REFERENCES modkb_tlkp_orgunit (int_siteid, int_orgunit)
      ON UPDATE CASCADE
);


SELECT 'modkb_tlnk_kbartparag' from rdb$database;
CREATE TABLE modkb_tlnk_kbartparag (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_parag BIGINT NOT NULL,
  int_article BIGINT NOT NULL,
  int_order INTEGER,
  str_heading VARCHAR(100),
  str_imgref VARCHAR(50),
    PRIMARY KEY(int_siteid,int_article,int_parag),
    FOREIGN KEY(int_siteid, int_article)
      REFERENCES modkb_tbl_article (int_siteid, int_article)
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MODKB_TLNK_KBARTPARAG;

