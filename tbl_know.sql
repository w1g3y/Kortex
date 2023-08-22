
/* =================================================
 *
 * Entity Name: 'tbl_know.sql'
 * Description:
 *
 *
 * $Id: tbl_know.sql,v 1.2 2011/06/22 01:31:57 nweeks Exp $
 *
 * $Log: tbl_know.sql,v $
 * Revision 1.2  2011/06/22 01:31:57  nweeks
 * Knowledgebase system changes
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tbl_know.sql...' from rdb$database;

CREATE TABLE tbl_know (
  int_versionid BIGINT NOT NULL,
  int_knowid BIGINT NOT NULL,
  int_childof BIGINT, /* Is this a child of another entry? */
  str_keywords VARCHAR(500),
  int_order INTEGER default 0, /* Order of items in this section */
  str_name VARCHAR(100) NOT NULL,
  str_title VARCHAR(200),
  blb_data BLOB SUB_TYPE TEXT,
    PRIMARY KEY(int_versionid)
);
CREATE GENERATOR GEN_tbl_know;
CREATE GENERATOR GEN_tbl_knowvers;



