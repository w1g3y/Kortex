
/* =================================================
 *
 * Entity Name: 'tlkp_priority.sql'
 * Description:
 *
 *
 * $Id: tlkp_priority.sql,v 1.2 2008/07/01 03:22:37 nweeks Exp $
 *
 * $Log: tlkp_priority.sql,v $
 * Revision 1.2  2008/07/01 03:22:37  nweeks
 * Task Priority Table
 *
 * Revision 1.1  2007/08/31 07:01:18  nweeks
 * Initial revision
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_priority.sql...' from rdb$database;


CREATE TABLE tlkp_priority (
  int_priorityid INTEGER NOT NULL,
  str_priority VARCHAR(32) NOT NULL,
  int_order INTEGER NOT NULL,
  str_desc VARCHAR(200),
    PRIMARY KEY (int_priorityid),
    UNIQUE(str_priority)
);
CREATE GENERATOR GEN_TLKP_PRIORITY

INSERT INTO tbl_priority (int_priorityid, str_priority, int_order,str_desc) values (gen_id(gen_tlkp_priority,1),'Production Critical',0,'This wi
ll stop Production if not remedied');
INSERT INTO tbl_priority (int_priorityid, str_priority, int_order,str_desc) values (gen_id(gen_tlkp_priority,1),'Revenue Threat',10,'Income Reve
nue is threatened by this fault');
INSERT INTO tbl_priority (int_priorityid, str_priority, int_order,str_desc) values (gen_id(gen_tlkp_priority,1),'Department Productivity ',30,'T
his affects an entire department');
INSERT INTO tbl_priority (int_priorityid, str_priority, int_order,str_desc) values (gen_id(gen_tlkp_priority,1),'Personal Productivity',40,'This
 affects less than 3 people');
INSERT INTO tbl_priority (int_priorityid, str_priority, int_order,str_desc) values (gen_id(gen_tlkp_priority,1),'Important',60,'To be done next'
);
INSERT INTO tbl_priority (str_priority, int_order,str_desc) values (gen_id(gen_tlkp_priority,1),'Desired',80,'To be done soon');
INSERT INTO tbl_priority (str_priority, int_order,str_desc) values (gen_id(gen_tlkp_priority,1),'Planning',100,'If things are quiet');
INSERT INTO tbl_priority (str_priority, int_order,str_desc) values (gen_id(gen_tlkp_priority,1),'Lowest',200,'To be done wheneve
r');


