/* ----
 *
 * tbl_processchain
 *
 * ----
 */


create table tbl_processchain (
  int_chainid BIGINT NOT NULL,
  str_chainname VARCHAR(64) not null,
  str_chaindesc VARCHAR(1024),
    PRIMARY KEY(int_chainid)
);
create generator gen_tbl_processchain;


create table tlkp_linktype (
  int_typeid BIGINT NOT NULL,
  str_typename VARCHAR(32) NOT NULL,
  str_imgref VARCHAR(64),
  str_css VARCHAR(256),
    PRIMARY KEY(int_typeid)
);
CREATE GENERATOR gen_tlkp_linktype;
commit;

insert into tlkp_linktype (int_typeid, str_typename, str_imgref, str_css) values (gen_id(gen_tlkp_linktype,1), 'Status','/img/status.jpg', 'style=\"background:#000000; color:#FFFFFF;\"');
insert into tlkp_linktype (int_typeid, str_typename, str_imgref, str_css) values (gen_id(gen_tlkp_linktype,1), 'Stop','/img/stop.jpg', 'style=\"background:#ed1c24; color:#FFFFFF;\"');
insert into tlkp_linktype (int_typeid, str_typename, str_imgref, str_css) values (gen_id(gen_tlkp_linktype,1), 'Assess','/img/assess.jpg', 'style=\"background:#f68b32; color:#FFFFFF;\"');
insert into tlkp_linktype (int_typeid, str_typename, str_imgref, str_css) values (gen_id(gen_tlkp_linktype,1), 'Consider','/img/consider.jpg', 'style=\"background:#f68b32; color:#FFFFFF;\"');
insert into tlkp_linktype (int_typeid, str_typename, str_imgref, str_css) values (gen_id(gen_tlkp_linktype,1), 'Action','/img/action.jpg', 'style=\"background:#8a9b3c; color:#FFFFFF;\"');
insert into tlkp_linktype (int_typeid, str_typename, str_imgref, str_css) values (gen_id(gen_tlkp_linktype,1), 'ICP Action','/img/icpaction.jpg', 'style=\"background:#00bddd; color:#FFFFFF;\"');



commit;
select * from tlkp_linktype;


create table tbl_processlink (
  int_linkid BIGINT NOT NULL,
  int_chainid BIGINT NOT NULL,
  int_childof BIGINT NOT NULL,
  str_inputcond VARCHAR(16), /* If input from last link matches this */
  str_linkname VARCHAR(256) NOT NULL,
  int_linktype BIGINT NOT NULL,
  str_content VARCHAR(1024),
    PRIMARY KEY(int_linkid),
    FOREIGN KEY (int_chainid) references tbl_processchain (int_chainid),
    FOREIGN KEY (int_childof) references tbl_processlink (int_linkid),
    FOREIGN KEY (int_linktype) references tlkp_linktype (int_typeid)
);
CREATE GENERATOR gen_tbl_processlink;

    
  
