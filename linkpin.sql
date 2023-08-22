
/* ---------------------
 * Copyright (c) Nigel Weeks
 *
 * nigel.weeks@karbonindustries.com ; nigel.weeks@gmail.com
 *
 * This file contains concepts behind the
 * LinkPin architecture of self-evolving
 * data-described applications
 *
 * 
 * ---------------------
 */


/* -------------
 * This is the global source for pull-down menus
 *
 * (A cut down version of KarbonIndustries'
 *  tlkp_ListChoices architecture)
 * -------------
 */

select 'Creating tlkp_choices...' as Notice from rdb$database;

commit; 

CREATE TABLE tlkp_choices (
  int_choiceid BIGINT NOT NULL,
  str_referrer VARCHAR(32) NOT NULL,
  int_order INTEGER,
  str_value VARCHAR(64),
    PRIMARY KEY(int_choiceid),
    UNIQUE (str_referrer,str_value)
);
CREATE GENERATOR gen_tlkp_choices;

commit;

/* --------------------------
 * ChainLink table
 *
 * === !! WARNING  WARNING !! ===
 *
 * By navigating past this point, you agree that concepts herein will not appear
 * in the GUI for the UTAS CRH501 unit - they are conceptual ideas, and have not
 * been implemented
 * === !!  END OF WARNING  !! ===
 *
 * Hierarchical templating for data self-evolution
 * Application is described by the data, not the other way around
 * ChainLinks can be connected into any part of a chain, and sequences can be copied 
 * into LinkIn for reuse.
 *
 * Linkages could be:
 * Paramedic->CPG->Airway->OPA->Adjunct Contra-indications
 * Clinic->General Practitioner->Scheduled Booking->Booking Category
 * Hospital->Ward->Observation->Blood Glucose (Patient Telemetry)
 * --------------------------
 */

select 'Creating tbl_chainlink...' as Notice from rdb$database;
CREATE TABLE tbl_chainlink (
  int_linkid BIGINT NOT NULL,
  int_childof BIGINT,
  str_linkname VARCHAR(64) NOT NULL,
  int_order INTEGER default 0 NOT NULL,
  lkp_linktype BIGINT, /* What kind of link is this? */
  str_linkdata VARCHAR(512),
  blb_linkdata BLOB sub_type text,  /* This link may contain PHP code for execution */
    PRIMARY KEY(int_linkid),
    FOREIGN KEY(int_childof) REFERENCES tbl_chainlink(int_linkid),
    FOREIGN KEY(lkp_linktype) references tlkp_choices (int_choiceid)
);
CREATE GENERATOR gen_tbl_chainlink;


insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_LINKTYPE', '1', 'SYS:AppRoot');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_LINKTYPE', '2', 'SYS:AppModule');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_LINKTYPE', '3', 'SYS:App');

insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_LINKTYPE', '70', 'CPG:Status');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_LINKTYPE', '71', 'CPG:Stop');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_LINKTYPE', '72', 'CPG:Assess');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_LINKTYPE', '73', 'CPG:Consider');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_LINKTYPE', '73', 'CPG:Action');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_LINKTYPE', '73', 'CPG:ICP Action');

/* ---------------------
 * LinkPin Table
 * 
 * Here we connect any chain link to any other chain link
 * LinkPin hierarchies can be copied into this table similar to a template style
 *
 * Data can be stored about a contact at any point in any chain
 * Blood pressure can be stored with a Paramedic Assessment, GP visit, Ward round
 * Trending on any telemetry value can be done over any time frame
 *
 * Live Telemetry screens can query these for live updates on:
 *  - Patient vitals in Ambulance while enroute to Emergency Dept.
 *  - Ward screens to monitor if telemetry goes out of normal bounds (ala PatienTrak)
 *  - Notify ChainLinks to send pagers/emails/sms where needed
 * ---------------------
 */

select 'Creating tbl_linkpin...' as Notice from rdb$database;
CREATE TABLE tbl_linkpin (
  int_pinid BIGINT NOT NULL,
  int_fromlinkid BIGINT NOT NULL,
  int_deftolinkid BIGINT,    /* Default next link */
  int_lowtolinkid BIGINT,    /* Low Condition Link */
  int_hightolinkid BIGINT,   /* High Condition Link */
    PRIMARY KEY(int_pinid),
    foreign key(int_fromlinkid) references tbl_chainlink (int_linkid),
    foreign key(int_deftolinkid) references tbl_chainlink (int_linkid),
    foreign key(int_lowtolinkid) references tbl_chainlink (int_linkid),
    foreign key(int_hightolinkid) references tbl_chainlink (int_linkid)
);
CREATE GENERATOR gen_tbl_linkpin;


CREATE GENERATOR gen_tbl_contactdata;
CREATE DESC INDEX dind_cdata_timestamp ON tbl_contactdata (dtm_timestamp);
CREATE ASC INDEX ind_cdata_timestamp ON tbl_contactdata (dtm_timestamp);
commit;

show table;

