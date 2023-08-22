
/* =================================================
 *
 * Entity Name: 'tlkp_acctype.sql'
 * Description:
 *
 *
 * $Id: tlkp_acctype.sql,v 1.1 2008/07/01 03:22:37 nweeks Exp $
 *
 * $Log: tlkp_acctype.sql,v $
 * Revision 1.1  2008/07/01 03:22:37  nweeks
 * Initial revision
 *
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_acctype.sql...' from rdb$database;


CREATE TABLE tlkp_acctype (
  int_acctypeid INTEGER NOT NULL,
  str_acctype VARCHAR(64),
  str_desc VARCHAR(256),
  int_order INTEGER,
    PRIMARY KEY(int_acctypeid),
    UNIQUE(str_acctype)
);
CREATE GENERATOR GEN_TLKP_ACCTYPE;
INSERT INTO tlkp_acctype (int_acctypeid,str_acctype,int_order) VALUES (gen_id(gen_tlkp_acctype,1),'Asset',10);
INSERT INTO tlkp_acctype (int_acctypeid,str_acctype,int_order) VALUES (gen_id(gen_tlkp_acctype,1),'Liability',20);
INSERT INTO tlkp_acctype (int_acctypeid,str_acctype,int_order) VALUES (gen_id(gen_tlkp_acctype,1),'Income',30);
INSERT INTO tlkp_acctype (int_acctypeid,str_acctype,int_order) VALUES (gen_id(gen_tlkp_acctype,1),'Expense',40);
INSERT INTO tlkp_acctype (int_acctypeid,str_acctype,int_order) VALUES (gen_id(gen_tlkp_acctype,1),'Header - non posting account',50);
INSERT INTO tlkp_acctype (int_acctypeid,str_acctype,int_order) VALUES (gen_id(gen_tlkp_acctype,1),'Sandbox Point - non posting account',60);
