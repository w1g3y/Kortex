CONNECT "localhost:/var/db/firebird/ehealth_system.fdb";

commit;

select 'Dropping Database...' as Notice from rdb$database;
drop database;

commit;
select 'Creating new database on localhost...' as Notice from rdb$database;

create database "localhost:/var/db/firebird/ehealth_system.fdb";

commit;

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

insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_TITLE', '1', 'Mr');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_TITLE', '2', 'Mrs');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_TITLE', '3', 'Ms');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_TITLE', '4', 'Miss');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_TITLE', '5', 'M');

insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_GENDER', '1', 'Male');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_GENDER', '2', 'Female');

insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_ADDRTYPE', '1', 'Phone');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_ADDRTYPE', '2', 'Mobile');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_ADDRTYPE', '3', 'Postal');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_ADDRTYPE', '4', 'Residential');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_ADDRTYPE', '5', 'Email');

insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_PROFESSION', '1', 'Cardio-Thoracic Surgeon');

insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_MODULEID', '10', 'h|Home');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_MODULEID', '11', 't|Traffic');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_MODULEID', '20', 'c|Clients');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_MODULEID', '30', 'ca|Client Addresses');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_MODULEID', '40', 'b|Bookings');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_MODULEID', '50', 'bn|Booking Notes');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_MODULEID', '60', 's|Specialists');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_MODULEID', '70', 'r|Reports');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_MODULEID', '80', 'auth|Admin');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_MODULEID', '90', 'ch|Choices');


insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_ROLEID', '1', 'Guest');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_ROLEID', '2', 'Secretary');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_ROLEID', '3', 'Clinic');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_ROLEID', '4', 'Specialist');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_ROLEID', '5', 'SysAdmin');

insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_FACILITY', '1', 'Midtown CHC');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_FACILITY', '2', 'Mobile Physio');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_FACILITY', '3', 'Hopetoun University Hospital');

insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_STATUS', '1', 'Pending');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_STATUS', '2', 'Waiting');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_STATUS', '3', 'In Consult');
insert into tlkp_choices (int_choiceid,str_referrer,int_order,str_value) values (gen_id(gen_tlkp_choices,1), 'LKP_STATUS', '4', 'Consult Complete');



select 'Creating tbl_contact...' as Notice from rdb$database;

commit;

CREATE TABLE tbl_contact (
  int_contactid BIGINT NOT NULL,
  str_ihi VARCHAR(64), /* Individual Health Identifier (eHealth System) */
  str_surname VARCHAR(64) NOT NULL,
  str_givennames VARCHAR(64) NOT NULL,
  lkp_title BIGINT,
  lkp_gender BIGINT,
  str_notes VARCHAR(512),
  str_username VARCHAR(32),
  sha256_password varchar(40),
    PRIMARY KEY(int_contactid),
    unique(str_surname, str_givennames, lkp_title),
    foreign key(lkp_title) REFERENCES tlkp_choices (int_choiceid),
    foreign key(lkp_gender) REFERENCES tlkp_choices (int_choiceid)
);
CREATE GENERATOR gen_tbl_contact;


commit;

commit;

INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,2),'Anderson','Lesley');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,2),'Bright','Melody');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,2),'Cane','Candy');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Churchill','William');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Crud','Kevin');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Crud','Kevin');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Day','James');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Doombery','John');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Fiddings','Lara');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Fox','William');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Fuller','Margaret');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Gay','John');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Hanson','Felicia');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Hanson','Ivor');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Jager','Michelle');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Joonberry','Jolie');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Kay','Nicole');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Lange','Lawrence');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Light','Tiffany');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Longton','Lanie');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Mansing','Mindy');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Melbourne','Scott');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Mendelson','Florence');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Millwood','Jenny');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Mitchelton','Maeve');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Mixton','Bruce');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Norris','Charles');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Pitson','Bradley');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Richmond','Bryan');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'Time','Mark');
INSERT INTO tbl_contact (int_contactid, str_surname, str_givennames) VALUES (gen_id(gen_tbl_contact,1),'White','Pearle');

commit;

select * from tbl_contact;

/* -------------------------
 * This table manages the
 * authorisation for the application
 * i.e. who can do what
 *
 * -------------------------
 */

CREATE TABLE tbl_appauth (
  int_authid BIGINT NOT NULL,
  lkp_roleid BIGINT NOT NULL,
  lkp_moduleid BIGINT NOT NULL,
  ibl_module INTEGER,
  ibl_search INTEGER,
  ibl_get INTEGER,
  ibl_insert INTEGER,
  ibl_update INTEGER,
  ibl_delete INTEGER,
  ibl_report INTEGER,
    PRIMARY KEY(int_authid),
    UNIQUE(lkp_roleid, lkp_moduleid),
    foreign key(lkp_roleid) REFERENCES tlkp_choices (int_choiceid),
    foreign key(lkp_moduleid) REFERENCES tlkp_choices (int_choiceid)
);
CREATE GENERATOR gen_tbl_appauth;


/* --------------
 * Traditional Tables for Uni
 * - we need to build tables that Uni is expecting
 *   the old style relational, 3rd normal form stuff
 *   So we'll bash that out, and then get on with the good stuff
 * --------------
 */

/* ----------------------
 * ContactAddresses Table
 * ----------------------
 */
select 'Creating tbl_contactaddresses...' as Notice from rdb$database;

CREATE TABLE tbl_ContactAddresses (
  int_addressid BIGINT NOT NULL,
  int_contactid BIGINT NOT NULL,
  lkp_addrtype BIGINT NOT NULL, /* Phone,Address,Email */
  str_addressdata VARCHAR(64) NOT NULL,
  lkp_city BIGINT,
  lkp_state BIGINT,
  str_postcode VARCHAR(4),
  str_notes BLOB SUB_TYPE TEXT,
  ibl_outdated INTEGER,
    PRIMARY KEY(int_addressid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact (int_contactid),
    FOREIGN KEY(lkp_addrtype) REFERENCES tlkp_choices (int_choiceid),
    FOREIGN KEY(lkp_city) REFERENCES tlkp_choices (int_choiceid),
    FOREIGN KEY(lkp_state) REFERENCES tlkp_choices (int_choiceid)
);
CREATE GENERATOR gen_tbl_contactaddresses;


/* --------------
 * Resource Table
 * --------------
 */
select 'Creating tbl_resource...' as Notice from rdb$database;
CREATE TABLE tbl_resource (
  int_resourceid BIGINT NOT NULL,
  str_name VARCHAR(32) NOT NULL,
  lkp_profession BIGINT, /* Type of service provided by Specialist */
  lkp_facility BIGINT, /* Where this specialist resides */
  str_notes BLOB SUB_TYPE TEXT,
    PRIMARY KEY(int_resourceid),
    FOREIGN KEY(lkp_profession) references tlkp_choices (int_choiceid),
    FOREIGN KEY(lkp_facility) references tlkp_choices (int_choiceid)
);
CREATE GENERATOR gen_tbl_resource;

commit;

insert into tbl_resource (int_resourceid, str_name) values (gen_id(gen_tbl_resource,1),'Dr Bob Bobbington');
insert into tbl_resource (int_resourceid, str_name) values (gen_id(gen_tbl_resource,1),'Dr Christine Miller');
insert into tbl_resource (int_resourceid, str_name) values (gen_id(gen_tbl_resource,1),'Jill Nightingale');

commit;

commit;



/* ----------------------
 * ResourceBookings Table
 * ----------------------
 */
select 'Creating tbl_resourcebookings...' as Notice from rdb$database;
CREATE TABLE tbl_resourcebookings (
  int_bookingid BIGINT NOT NULL,
  int_resourceid BIGINT NOT NULL,
  int_contactid BIGINT NOT NULL,
  dte_date DATE NOT NULL,
  tme_time TIME NOT NULL,
  int_duration INTEGER NOT NULL,
  str_notes BLOB SUB_TYPE TEXT,
  lkp_status BIGINT, 
  ibl_paid INTEGER,
    PRIMARY KEY(int_bookingid),
    FOREIGN KEY(int_resourceid) REFERENCES tbl_resource (int_resourceid),
    FOREIGN KEY(int_contactid) REFERENCES tbl_contact (int_contactid),
    FOREIGN KEY(lkp_status) references tlkp_choices (int_choiceid)
);
CREATE GENERATOR gen_tbl_resourcebookings;

commit;


/* ----------------------
 * BookingNotes Table
 * ----------------------
 */
select 'Creating tbl_bookingnotes...' as Notice from rdb$database;
CREATE TABLE tbl_bookingnotes (
  int_noteid BIGINT NOT NULL,
  int_bookingid BIGINT NOT NULL,
  dte_note DATE DEFAULT 'now' NOT NULL,
  blb_note BLOB SUB_TYPE TEXT,
    PRIMARY KEY(int_noteid),
    FOREIGN KEY(int_bookingid) REFERENCES tbl_resourcebookings(int_bookingid)
);
CREATE GENERATOR GEN_TBL_BOOKINGNOTES;

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
  str_linktype VARCHAR(8) NOT NULL,
  str_linkdata VARCHAR(512),
  blb_linkdata BLOB sub_type text,
    PRIMARY KEY(int_linkid),
    FOREIGN KEY(int_childof) REFERENCES tbl_chainlink(int_linkid)
);
CREATE GENERATOR gen_tbl_chainlink;

/* ---------------------
 * LinkPin Table
 * 
 * Here we connect any chain link to any other chain link
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
  int_deftolinkid BIGINT,
  int_lowtolinkid BIGINT,
  int_hightolinkid BIGINT,
    PRIMARY KEY(int_pinid),
    foreign key(int_fromlinkid) references tbl_chainlink (int_linkid),
    foreign key(int_deftolinkid) references tbl_chainlink (int_linkid),
    foreign key(int_lowtolinkid) references tbl_chainlink (int_linkid),
    foreign key(int_hightolinkid) references tbl_chainlink (int_linkid)
);
CREATE GENERATOR gen_tbl_linkpin;


select 'Creating tbl_contactdata...' as Notice from rdb$database;
CREATE TABLE tbl_contactdata (
  int_cdataid BIGINT NOT NULL,
  int_contactid BIGINT NOT NULL,
  int_linkid BIGINT NOT NULL,  /* Destination side of LinkPin */
  int_pinid BIGINT NOT NULL,
  dtm_timestamp TIMESTAMP default 'now' NOT NULL,
  int_data BIGINT, /* Which pin this data may be attached to */
  str256_data VARCHAR(256),
  blb_data blob sub_type text,
    PRIMARY KEY(int_cdataid),
    FOREIGN KEY(int_contactid) references tbl_contact(int_contactid),
    FOREIGN KEY(int_pinid) references tbl_linkpin(int_pinid),
    FOREIGN KEY(int_linkid) references tbl_chainlink(int_linkid)
);
CREATE GENERATOR gen_tbl_contactdata;
CREATE DESC INDEX dind_cdata_timestamp ON tbl_contactdata (dtm_timestamp);
CREATE ASC INDEX ind_cdata_timestamp ON tbl_contactdata (dtm_timestamp);
commit;

show table;
show database;
show indexes;

