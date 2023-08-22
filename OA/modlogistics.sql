/* mod_logistics - the Inventory, Storage, and Shipping module for
OpenAspect
(Every entity herein shall start with mlogi (mlogistics is just too long)
Handles the storage of items, and handles the movement and shipping as well
Used for mod_assets to store parts for servicing

#
# $Id: modlogistics.sql,v 1.18 2005/10/07 02:46:43 nweeks Exp nweeks $
#
# $Log: modlogistics.sql,v $
# Revision 1.18  2005/10/07 02:46:43  nweeks
# Added better consignment addressing
#
# Revision 1.17  2004/12/23 05:32:23  nweeks
# Broke out Inventory into it's own module
#
# Revision 1.16  2004/07/11 23:07:18  nigel
# rolled out new boolean type (ibl_)
#
# Revision 1.15  2004/06/28 23:36:09  nigel
# Fixed some pkey widths so generators can now hook on
#
# Revision 1.14  2004/06/28 23:24:25  nigel
# Added missing generators
#
# Revision 1.13  2004/04/20 03:14:41  nigel
# Fixed shipping methods into framework
#
# Revision 1.12  2004/04/20 02:02:11  nigel
# Fixed uniques on some fields...needed to be unique to each site,
# not unique to all sites...
#
# Revision 1.11  2004/01/14 03:51:01  nigel
# Relations added
#
# Revision 1.10  2004/01/06 22:09:25  nigel
# Fixed build comments
#
# Revision 1.9  2003/10/09 23:31:56  nigel
# Syntax is now correct
#
# Revision 1.8  2003/10/09 23:27:15  nigel
# Updated structure system of warehouses - yet to try for syntax correctness
#
# Revision 1.7  2003/09/30 00:42:02  nigel
# Updated license
#
# Revision 1.6  2003/09/18 01:45:57  nigel
# Fixed asset/item equivalency table
#
# Revision 1.5  2003/09/17 23:11:36  nigel
# Added Copright notice
#
# Revision 1.4  2003/06/18 03:15:43  nigel
# SHortened Prefix
#
# Revision 1.3  2003/06/10 02:18:09  nigel
# Fixed a Foreign Key Declaration
#
# Revision 1.2  2003/06/10 01:36:24  nigel
# BIGINT conversion
# Better In-Line Documentation
#
#
*/


/* Master lookup tables 
mlogi_tlkp_shipmeth
mlogi_tlkp_boxtype
mlogi_tlkp_chargetype
mlogi_tlkp_renttype
*/

/* The Shipping Method Lookup Table
Car,Van,Ship,Train,Carrier Pigeon
*/
select 'Shipping Methods Lookup(mlogi_tlkp_shipmeth)' from rdb$database;
CREATE TABLE mlogi_tlkp_shipmeth (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_method BIGINT NOT NULL,
  str_method VARCHAR(100) NOT NULL,
    PRIMARY KEY(int_siteid, int_method),
    UNIQUE (int_siteid, str_method)
);
CREATE GENERATOR gen_mlogi_tlkp_shipmeth;

/* The Box Type for shipping/storage
Box 1: Cardboard, 300x400x700, etc
*/
select 'Box Types Lookup (mlogi_tlkp_boxtype)' from rdb$database;
CREATE TABLE mlogi_tlkp_boxtype (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_type BIGINT NOT NULL,
  str_type VARCHAR(60),
  int_width integer,
  str_wunit VARCHAR(2), /* Unit of Dimension */
  int_height INTEGER,
  str_hunit VARCHAR(2), /* Unit of Dimension */
  int_depth INTEGER,
  str_dunit VARCHAR(2), /* Unit of Dimension */
  int_kilo INTEGER, /* Kilo Rating */
  int_palette INTEGER, /*0:No Integrated Pallet, 1:Integrated Pallet (For strengthening) */
    PRIMARY KEY(int_siteid,int_type)
);
CREATE GENERATOR gen_mlogi_tlkp_boxtype;

/* The Charges Type Lookup Table
Moving freight costs money
Set up charges, so we can hook up to freight channels further on
TODO: Think about how we'll do charging, depending on distance, etc
*/
select 'Freight Charges Lookup (mlogi_tlkp_chargetype)' from rdb$database;
CREATE TABLE mlogi_tlkp_chargetype (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_type BIGINT NOT NULL,
  str_type VARCHAR(50) NOT NULL,
  flt_price NUMERIC(18,2),
  flt_percentage NUMERIC(18,2),
  str_unit VARCHAR(10), /* Tonne, Kilo, Each */
    PRIMARY KEY(int_siteid,int_type),
    UNIQUE (int_siteid, str_type)
);
CREATE GENERATOR gen_mlogi_tlkp_chargetype;

/*
mlogi_tlkp_renttype
TODO: THink about how this will hook into mod_finance...
Assets/Stock Items canbe rented/loaned out
Here we keep the kind of rental/loan
*/
select 'Rent Types Lookup (mlogi_tlkp_renttype)' from rdb$database;
CREATE TABLE mlogi_tlkp_renttype (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_type BIGINT NOT NULL,
  str_type VARCHAR(30) NOT NULL,
  str_desc VARCHAR(300),
    PRIMARY KEY(int_siteid, int_type),
    UNIQUE (int_siteid, str_type)
);
CREATE GENERATOR gen_mlogi_tlkp_renttype;


/* ==================
The Base Tables 
mlogi_tbl_vehicle
mlogi_tbl_delivrun
mlogi_tbl_consignment
mlogi_tbl_box
=================== */

select 'Logistics Items (mlogi_tbl_item)' from rdb$database;
CREATE TABLE mlogi_tbl_item (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_itemid BIGINT NOT NULL,
  str_item VARCHAR(400) NOT NULL,
  int_refno BIGINT, /* Might Reference: Publication Item, Inventory Item, Service Part, etc */
  int_reftype BIGINT,
  str_desc VARCHAR(4000),
    PRIMARY KEY(int_siteid,int_itemid)
);
CREATE GENERATOR gen_mlogi_tbl_item;



select 'Base Vehicle (mlogi_tbl_vehicle)' from rdb$database;
CREATE TABLE mlogi_tbl_vehicle (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_vehicle BIGINT NOT NULL,
  str_name VARCHAR(30),
  str_owner VARCHAR(100),
  str_rego VARCHAR(10),
  str_state VARCHAR(50),
  str_country VARCHAR(50),
    PRIMARY KEY(int_siteid,int_vehicle)
);
CREATE GENERATOR gen_mlogi_tbl_vehicle;


select 'Delivery Run (mlogi_tbl_delivrun)' from rdb$database;
CREATE TABLE mlogi_tbl_delivrun (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_delivrun BIGINT NOT NULL,
  str_delivrun VARCHAR(50) NOT NULL, /* Give this run a name */
  str_notes VARCHAR(10000), /* Notes about the run */
    PRIMARY KEY(int_siteid, int_delivrun),
    UNIQUE (int_siteid, str_delivrun)
);
CREATE GENERATOR GEN_MLOGI_TBL_DELIVRUN;



/* -----------
 * This table gets populated from:
 *  - Publication Subscriptions
 *  - Inventory freight movements
 *  - Other sources
 * -----------
 */

select 'Consignment/Delivery Drops (mlogi_tbl_consignment)' from rdb$database;
CREATE TABLE mlogi_tbl_consignment (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_consid BIGINT NOT NULL,
  str_sender VARCHAR(200) NOT NULL,
  str_saddress VARCHAR(200), /* If not one of the above types */
  str_ssuburb VARCHAR(50),
  str_scity VARCHAR(50),
  str_sstate VARCHAR(50),
  str_scountry VARCHAR(100),
  str_spostcode VARCHAR(10),
  str_receiver VARCHAR(200) NOT NULL,
  str_raddress VARCHAR(200), /* If not one of the above types */
  str_rsuburb VARCHAR(50),
  str_rcity VARCHAR(50),
  str_rstate VARCHAR(50),
  str_rcountry VARCHAR(100),
  str_rpostcode VARCHAR(10),
  ibl_delivered INTEGER, /* Delivered to address */
  ibl_depotheld INTEGER, /* Being held at depot */
  ibl_complete INTEGER,
  dtm_complete TIMESTAMP,
  str_connotes VARCHAR(5000),
    PRIMARY KEY(int_siteid,int_consid)
);
CREATE GENERATOR gen_mlogi_tbl_consignment;

select 'Base Box Table (mlogi_tbl_box)' from rdb$database;
CREATE TABLE mlogi_tbl_box (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_boxid BIGINT NOT NULL,
  int_type BIGINT NOT NULL,
  flt_width NUMERIC(18,2),
  flt_height NUMERIC(18,2),
  flt_length NUMERIC(18,2),
  flt_kilo NUMERIC(18,2),
  str_material VARCHAR(5), /* cbrd,wood,steel,styro */
  str_stack VARCHAR(10), /* top,upper,lower,bottom */
    PRIMARY KEY(int_siteid, int_boxid),
    FOREIGN KEY(int_siteid, int_type)
      REFERENCES mlogi_tlkp_boxtype (int_siteid, int_type)
      ON UPDATE CASCADE

);
CREATE GENERATOR GEN_MLOGI_TBL_BOX;


/* ==================
The Link Tables
mlogi_tlnk_itembox
mlogi_tlnk_itemvehicle
mlogi_tlnk_consignbox
mlogi_tlnk_itemtransport
mlogi_tlnk_itemrent
================== */


/* Freight item to box allocations
*/
select 'Item to Box Allocations for Freight (mlogi_tlnk_itembox)' from rdb$database;
CREATE TABLE mlogi_tlnk_itembox (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_boxid BIGINT NOT NULL,
  int_itemid BIGINT NOT NULL,
  flt_qty NUMERIC(18,4),
  ibl_padded INTEGER,
  ibl_sealed INTEGER,
  ibl_fragile INTEGER,
  ibl_heavy INTEGER,
  flt_kilo NUMERIC(18,2),
    PRIMARY KEY(int_siteid,int_boxid, int_itemid),
    FOREIGN KEY(int_siteid, int_boxid) 
      REFERENCES mlogi_tbl_box(int_siteid, int_boxid) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_itemid) 
      REFERENCES mlogi_tbl_item(int_siteid, int_itemid) 
      ON UPDATE CASCADE
);

select 'Box to Vehicle allocations for Freight (mlogi_tlnk_boxvehicle)' from rdb$database;
CREATE TABLE mlogi_tlnk_boxvehicle (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_boxid BIGINT NOT NULL,
  int_vehicle BIGINT NOT NULL,
  int_method BIGINT, /* Shipping Method */
  str_deck VARCHAR(10),
  str_section VARCHAR(10),
  str_container VARCHAR(10),
  str_shelf VARCHAR(10),
  str_pos VARCHAR(10),
    PRIMARY KEY(int_siteid, int_boxid, int_vehicle),
    FOREIGN KEY(int_siteid, int_boxid) 
      REFERENCES mlogi_tbl_box(int_siteid, int_boxid) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_vehicle) 
      REFERENCES mlogi_tbl_vehicle(int_siteid, int_vehicle) 
      ON UPDATE CASCADE,
    FOREIGN KEY (int_siteid, int_method)
      REFERENCES mlogi_tlkp_shipmeth (int_siteid, int_method)
      ON UPDATE CASCADE
); 
 
select 'Box to Consignment link (mlogi_tlnk_consignbox)' from rdb$database;
CREATE TABLE mlogi_tlnk_consignbox (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_consid BIGINT NOT NULL,
  int_boxid BIGINT NOT NULL,
    PRIMARY KEY(int_siteid, int_consid, int_boxid),
    FOREIGN KEY(int_siteid, int_consid) 
      REFERENCES mlogi_tbl_consignment(int_siteid, int_consid) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_boxid) 
      REFERENCES mlogi_tbl_box(int_siteid, int_boxid) 
      ON UPDATE CASCADE
);

select 'Movement Tracking for a Box (mlogi_tlnk_boxmove)' from rdb$database;
CREATE TABLE mlogi_tlnk_boxmove (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_boxid BIGINT NOT NULL, /* Which box of the cons */
  dtm_date DATE default 'now' NOT NULL,
  dtm_time TIME default 'now' NOT NULL,
  ibl_invehicle BIGINT, /* Loaded onto vehicle */
  ibl_exvehicle BIGINT, /* Unloaded from vehicle */
  ibl_inwhouse BIGINT, /* Arrived at warehouse */
  ibl_exwhouse BIGINT, /* Left from warehouse */
    PRIMARY KEY(int_siteid, int_boxid, dtm_date, dtm_time),
    FOREIGN KEY(int_siteid, int_boxid) 
      REFERENCES mlogi_tbl_box (int_siteid, int_boxid) 
      ON UPDATE CASCADE
);
