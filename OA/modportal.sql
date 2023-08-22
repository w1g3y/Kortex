/* This is the mod_portal system for
OpenAspect
Each user needs an initial screen for entering OA.
Here, we allow for customisation, favourites, etc.
*/

/* ------------
Lookup Tables
------------ */

/* ------------
Base Tables
Module Registration
Portal Layout
------------ */

/* Module Registration Table */
select 'Module Registration Table (mport_tbl_modreg)' from rdb$database;
CREATE TABLE mport_tbl_modreg (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'NOT' NOT NULL,
  int_modreg BIGINT NOT NULL,
  str_name VARCHAR(100) NOT NULL, /* The on-screen name */
  str_module VARCHAR(100), /* Asset/finance/crm/erp/etc */
  int_height INTEGER, /* Default height of module */
    PRIMARY KEY(int_siteid, int_modreg)
);
CREATE GENERATOR GEN_MPORT_TBL_MODREG;

/* Portal Layout */
select 'Portal Layout Table (mport_tbl_portlayout)' from rdb$database;
CREATE TABLE mport_tbl_portlayout (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'NOT' NOT NULL,
  int_uid BIGINT NOT NULL, /* The user this is for */
  int_modreg BIGINT NOT NULL, /* The module we're storing */
  int_column INTEGER, /* Which column in the portal */
  int_order INTEGER, /* The order in the column */
  int_height INTEGER, /* Override the default height for the module */
    PRIMARY KEY(int_siteid, int_uid, int_modreg),
    FOREIGN KEY(int_siteid, int_uid)
      REFERENCES moduser_tbl_user (int_siteid, int_uid)
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_modreg)
      REFERENCES mport_tbl_modreg (int_siteid, int_modreg)
      ON UPDATE CASCADE
);

