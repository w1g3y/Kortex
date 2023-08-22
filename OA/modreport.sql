/* 
This is the reporting module for OpenAspect
Basically, it performs the following:
Stores a pre-built query in the database.
Runs 1 or more of these queries to form a report
Uses a simple gui for building each query

By detecting if it's a dependency, or a dependant, we should be about to use the correct join types automatically...here's hoping!
*/

/* =============
Lookup Tables 
============= */
/* Report Types */
select 'Report Types (mrep_tlkp_reptype)' from rdb$database;
CREATE TABLE mrep_tlkp_reptype (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP default 'now' NOT NULL,
  int_type BIGINT NOT NULL,
  str_type VARCHAR(200) NOT NULL,
    PRIMARY KEY(int_siteid, int_type),
    UNIQUE (str_type)
);
CREATE GENERATOR GEN_MREP_TBL_REPTYPE;


/* ==============
Report Table
============== */
select 'Report Storage (mrep_tbl_report)' from rdb$database;
CREATE TABLE mrep_tbl_report (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP default 'now' NOT NULL,
  int_report BIGINT NOT NULL,
  str_name VARCHAR(30) NOT NULL,
  int_authlevel INTEGER,
    PRIMARY KEY(int_siteid, int_report),
    UNIQUE (int_siteid, str_name)
);
CREATE GENERATOR GEN_MREP_TBL_REPORT;


/* =========================
Queries that make the report
========================= */
select 'Report Queries (mrep_tbl_query)' from rdb$database;
CREATE TABLE mrep_tbl_query (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP default 'now' NOT NULL,
  int_query BIGINT NOT NULL,
  int_connection INTEGER, /* In case we support multiple database queries */
  str_name VARCHAR(100) NOT NULL,
  str_sql VARCHAR(5000) NOT NULL,
  str_notes VARCHAR(1000),
    PRIMARY KEY(int_siteid, int_query),
    UNIQUE (int_siteid, str_name)
);
CREATE GENERATOR GEN_MREP_TBL_QUERY;

/* ==================
 * Query Parameters
 * ==================
 */
CREATE TABLE mrep_tbl_queryparams (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP default 'now' NOT NULL,
  int_param INTEGER NOT NULL,
  int_query BIGINT NOT NULL,
  str_label VARCHAR(30) NOT NULL,
  str_type VARCHAR(15) default 'text' NOT NULL, /* text,date,time,number,money */
    PRIMARY KEY(int_siteid, int_param),
    FOREIGN KEY(int_siteid, int_query) REFERENCES mrep_tbl_query(int_siteid, int_query)
);
CREATE GENERATOR GEN_MREP_TBL_QUERYPARAMS;


/* ========================
 * Bindings
 * - stores relationships, both enforced and non-enforced
 * between tables
 * ========================
 */
CREATE TABLE mrep_tbl_bindings (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP default 'now' NOT NULL,
  int_binding BIGINT NOT NULL,
  str_ptable CHAR(32) NOT NULL,
  str_pfield CHAR(32) NOT NULL,
  str_ctable CHAR(32) NOT NULL,
  str_cfield CHAR(32) NOT NULL,
    PRIMARY KEY(int_siteid, int_binding)
);
CREATE GENERATOR GEN_MREP_TBL_BINDINGS;


/* ===========================
Link the queries together to
make the report
=========================== */

select 'Report Query Linker (mrep_tlnk_rquery)' from rdb$database;
CREATE TABLE mrep_tlnk_rquery (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP default 'now' NOT NULL,
  int_report BIGINT NOT NULL,
  int_query BIGINT NOT NULL,
  int_order INTEGER,
  str_pfield VARCHAR(31), /* Parent Field */
  str_field VARCHAR(31),  /* This field to bind on */
    PRIMARY KEY(int_siteid, int_report, int_query)
);


  
