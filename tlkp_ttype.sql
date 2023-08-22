
/* =================================================
 *
 * Entity Name: 'tlkp_ttype.sql'
 * Description:
 *
 *
 * $Id: tlkp_ttype.sql,v 1.1 2008/07/01 03:22:37 nweeks Exp $
 *
 * $Log: tlkp_ttype.sql,v $
 * Revision 1.1  2008/07/01 03:22:37  nweeks
 * Initial revision
 *
 * Revision 1.1  2007/09/02 08:15:50  nweeks
 * Initial revision
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_ttype.sql...' from rdb$database;


CREATE TABLE tlkp_ttype (
  int_ttypeid INTEGER NOT NULL,
  str_ttype VARCHAR(64),
  str_desc VARCHAR(256),
    PRIMARY KEY(int_ttypeid),
    UNIQUE(str_ttype)
);
CREATE GENERATOR GEN_TLKP_TTYPE;
INSERT INTO tlkp_ttype (int_ttypeid,str_ttype) VALUES (gen_id(gen_tlkp_ttype,1),'Item Sale');
INSERT INTO tlkp_ttype (int_ttypeid,str_ttype) VALUES (gen_id(gen_tlkp_ttype,1),'Item Sale Hold');
INSERT INTO tlkp_ttype (int_ttypeid,str_ttype) VALUES (gen_id(gen_tlkp_ttype,1),'Item Sale Return');
INSERT INTO tlkp_ttype (int_ttypeid,str_ttype) VALUES (gen_id(gen_tlkp_ttype,1),'Item Purchase');
INSERT INTO tlkp_ttype (int_ttypeid,str_ttype) VALUES (gen_id(gen_tlkp_ttype,1),'Item Purchase Return');
INSERT INTO tlkp_ttype (int_ttypeid,str_ttype) VALUES (gen_id(gen_tlkp_ttype,1),'Service Sale');
INSERT INTO tlkp_ttype (int_ttypeid,str_ttype) VALUES (gen_id(gen_tlkp_ttype,1),'Service Purchase');
