/* mod_logistics - the Inventory, Storage, and Shipping module for
OpenAspect
(Every entity herein shall start with minv (minvstics is just too long)
Handles the storage of items, and handles the movement and shipping as well
Used for mod_assets to store parts for servicing

#
# $Id: modinventory.sql,v 1.2 2005/03/02 09:10:54 nweeks Exp nweeks $
#
# $Log: modinventory.sql,v $
# Revision 1.2  2005/03/02 09:10:54  nweeks
# The beginning of the Evolution Engine has been added.
#
# Revision 1.1  2004/12/23 05:32:39  nweeks
# Initial revision
# $Id: modinventory.sql,v 1.2 2005/03/02 09:10:54 nweeks Exp nweeks $
#
# $Log: modinventory.sql,v $
# Revision 1.2  2005/03/02 09:10:54  nweeks
# The beginning of the Evolution Engine has been added.
#
#
*/


/* Master lookup tables 
minv_tlkp_itemtype
minv_tlkp_whousetype
*/

/* Units of Measurement table */
select 'Measurement Units Lookup (minv_tlkp_measunit)' from rdb$database;
CREATE TABLE minv_tlkp_measunit (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_unit BIGINT NOT NULL,
  str_unit VARCHAR(30) NOT NULL,
    PRIMARY KEY (int_siteid, int_unit),
    UNIQUE (int_siteid, str_unit)
);
CREATE GENERATOR GEN_MINV_TLKP_MEASUNIT;
INSERT INTO minv_tlkp_measunit(int_siteid, int_unit, str_unit) VALUES (1,GEN_ID(GEN_MINV_TLKP_MEASUNIT,1),'Each');
INSERT INTO minv_tlkp_measunit(int_siteid, int_unit, str_unit) VALUES (1,GEN_ID(GEN_MINV_TLKP_MEASUNIT,1),'Kilogram');
INSERT INTO minv_tlkp_measunit(int_siteid, int_unit, str_unit) VALUES (1,GEN_ID(GEN_MINV_TLKP_MEASUNIT,1),'Litre');
INSERT INTO minv_tlkp_measunit(int_siteid, int_unit, str_unit) VALUES (1,GEN_ID(GEN_MINV_TLKP_MEASUNIT,1),'Tonne');
INSERT INTO minv_tlkp_measunit(int_siteid, int_unit, str_unit) VALUES (1,GEN_ID(GEN_MINV_TLKP_MEASUNIT,1),'Box');
INSERT INTO minv_tlkp_measunit(int_siteid, int_unit, str_unit) VALUES (1,GEN_ID(GEN_MINV_TLKP_MEASUNIT,1),'Crate');
INSERT INTO minv_tlkp_measunit(int_siteid, int_unit, str_unit) VALUES (1,GEN_ID(GEN_MINV_TLKP_MEASUNIT,1),'Pallet');
INSERT INTO minv_tlkp_measunit(int_siteid, int_unit, str_unit) VALUES (1,GEN_ID(GEN_MINV_TLKP_MEASUNIT,1),'Drum');
INSERT INTO minv_tlkp_measunit(int_siteid, int_unit, str_unit) VALUES (1,GEN_ID(GEN_MINV_TLKP_MEASUNIT,1),'Millilitre');
INSERT INTO minv_tlkp_measunit(int_siteid, int_unit, str_unit) VALUES (1,GEN_ID(GEN_MINV_TLKP_MEASUNIT,1),'Milligram');

/* The Item Type Lookup Table
The Type of Item that this is
*/
select 'Item Types Lookup (minv_tlkp_itemtype)' from rdb$database;
CREATE TABLE minv_tlkp_itemtype (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_type BIGINT NOT NULL,
  str_type VARCHAR(60) NOT NULL,
  str_desc VARCHAR(400),
    PRIMARY KEY(int_siteid, int_type),
    UNIQUE (int_siteid, str_type)
);
CREATE GENERATOR gen_minv_tlkp_itemtype;

/* The Warehouse Type Lookup Table
Type of Warehouse - Depot, Store, Secure, Tin Shed, etc
*/
select 'Warehouse Types Lookup (minv_tlkp_whousetype)' from rdb$database;
CREATE TABLE minv_tlkp_whousetype (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_type BIGINT NOT NULL,
  str_type VARCHAR(100) NOT NULL,
    PRIMARY KEY(int_siteid, int_type),
    UNIQUE (int_siteid, str_type)
);
CREATE GENERATOR gen_minv_tlkp_whousetype;

/* Evolution Chain
 * Enables stock items to grow(Plants,livestock)
 * into different stock items
 */
CREATE TABLE minv_evoluttype (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_type BIGINT NOT NULL,
  str_type VARCHAR(100) NOT NULL,
    PRIMARY KEY(int_siteid, int_type),
    UNIQUE(int_siteid, str_type)
);



/* ==================
The Base Tables 
minv_tbl_item
minv_tbl_warehouse
minv_tbl_vehicle
minv_tbl_consignment
minv_tbl_box
=================== */

/* The Item Table
This is the actual item we're managing
Not much stored here - it's linked from elsewhere
Manufactured items aren't stocked - they're submitted
for manufacturing as soon as ordered
*/
select 'Base Items (minv_tbl_item)' from rdb$database;
CREATE TABLE minv_tbl_item (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_itemid BIGINT NOT NULL,
  str_item VARCHAR(400) NOT NULL,
  int_type BIGINT,
  str_desc VARCHAR(4000),
  str_type VARCHAR(4), /* Types: buy,sell,inv */
  ibl_manuf INTEGER, /* Is this manufactured, or stockable */
    PRIMARY KEY(int_siteid,int_itemid),
    FOREIGN KEY(int_siteid, int_type)
      REFERENCES minv_tlkp_itemtype (int_siteid, int_type)
      ON UPDATE CASCADE
);
CREATE GENERATOR gen_minv_tbl_item;

/*
The Warehouse table
Store it's name, where is is, it's type, etc
*/
select 'Base Warehouse (minv_tbl_warehouse)' from rdb$database;
CREATE TABLE minv_tbl_warehouse (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_whouse BIGINT NOT NULL,
  int_whtype BIGINT NOT NULL,
  str_name VARCHAR(300) NOT NULL,
  str_address VARCHAR(100),
  str_postcode VARCHAR(8),
  str_city VARCHAR(50),
  str_state VARCHAR(50),
  str_country VARCHAR(50),
    PRIMARY KEY(int_siteid,int_whouse),
    FOREIGN KEY(int_siteid,int_whtype) 
      REFERENCES minv_tlkp_whousetype (int_siteid,int_type) 
      ON UPDATE CASCADE
);
CREATE GENERATOR gen_minv_tbl_warehouse;


/* ==================
The Link Tables
minv_tlnk_assetequiv
minv_tlnk_itemwarehouse
minv_tlnk_itembox
minv_tlnk_itemvehicle
minv_tlnk_consignbox
minv_tlnk_itemtransport
minv_tlnk_itemrent
================== */

/* 
Assets may have items in stock that can be swapped straight in
They may be exact, close, or need modification
Store that info here...
*/
select 'Item/Asset Equivalencies Table (minv_tlnk_assetequiv)' from rdb$database;
CREATE TABLE minv_tlnk_assetequiv (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_asset BIGINT NOT NULL, /* The asset we're doing equivs for */
  int_itemid BIGINT NOT NULL, /* These items are an equivalent */
  ibl_exact INTEGER, /* This is true if they're an exact match */
  ibl_matchsize INTEGER, /* Does the size match */
  ibl_matchoper INTEGER, /* Does it's operation match */
  str_note VARCHAR(300), /* Notes on the equivalency(brand, size, etc) */
    PRIMARY KEY(int_siteid, int_asset, int_itemid),
    FOREIGN KEY(int_siteid, int_itemid) 
      REFERENCES minv_tbl_item(int_siteid, int_itemid) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_asset) 
      REFERENCES mass_tbl_asset(int_siteid, int_asset) 
      ON UPDATE CASCADE
);

/* Warehouse Sections */
SELECT 'Warehouse Sections (minv_tlnk_warehousesecs)' from rdb$database;
CREATE TABLE minv_tlnk_warehousesecs (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_section BIGINT NOT NULL,
  str_section VARCHAR(40) NOT NULL,
    PRIMARY KEY(int_siteid, int_section),
    UNIQUE (int_siteid, str_section)
);
CREATE GENERATOR GEN_MINV_TLNK_WAREHOUSESECS;

/* Warehouse Rows */
SELECT 'Warehouse Rows (minv_tlnk_warehouserows)' from rdb$database;
CREATE TABLE minv_tlnk_warehouserows (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_row BIGINT NOT NULL,
  str_row VARCHAR(40) NOT NULL,
    PRIMARY KEY(int_siteid, int_row),
    UNIQUE (int_siteid, str_row)
);
CREATE GENERATOR GEN_MINV_TLNK_WAREHOUSEROWS;

/* Warehouse Shelves */
SELECT 'Warehouse Shelves (minv_tlnk_warehouseshelf)' from rdb$database;
CREATE TABLE minv_tlnk_warehouseshelf (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_shelf BIGINT NOT NULL,
  str_shelf VARCHAR(40) NOT NULL,
    PRIMARY KEY(int_siteid, int_shelf),
    UNIQUE (int_siteid, str_shelf)
);
CREATE GENERATOR GEN_MINV_TLNK_WAREHOUSESHELF;


/* Warehouse Locations
Store the sections, rows, shelves, etc
and keep in ID to match the location of the item
Also used for barcode: one code can give you the
warehouse:section:row:shelf and position of an item
*/
SELECT 'Warehouse Locations (Warehouse,Sec,Row,Shelf,Position) (minv_tlnk_warehouseloc)' from rdb$database;
CREATE TABLE minv_tlnk_warehouseloc (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_location BIGINT NOT NULL, /* The unique location ID */
  int_whouse BIGINT NOT NULL, /* Which warehouse is it */
  int_section BIGINT NOT NULL, /* Which section of the warehouse */
  int_row BIGINT NOT NULL, /* Which row of shelves in the warehouse */
  int_shelf BIGINT NOT NULL, /* Which shelf in the row */
  int_pos INTEGER NOT NULL, /* Which position along the shelf */
  str_note VARCHAR(20),
    PRIMARY KEY(int_siteid, int_location),
    UNIQUE (int_siteid, int_whouse, int_section, int_row, int_shelf, int_pos),
    FOREIGN KEY(int_siteid, int_whouse) 
      REFERENCES minv_tbl_warehouse (int_siteid, int_whouse) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_section) 
      REFERENCES minv_tlnk_warehousesecs (int_siteid, int_section) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_row) 
      REFERENCES minv_tlnk_warehouserows (int_siteid, int_row) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_shelf) 
      REFERENCES minv_tlnk_warehouseshelf (int_siteid, int_shelf) 
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MINV_TLNK_WAREHOUSELOC;
  


select 'Item Location in Warehouse (minv_tlnk_itemwarehouse)' from rdb$database;
CREATE TABLE minv_tlnk_itemwarehouse (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_itemid BIGINT NOT NULL,
  int_location BIGINT NOT NULL,
  str_unit VARCHAR(10), /* ea/box/dozen/tonne/etc */
  flt_instock NUMERIC(18,4),
  flt_onorder NUMERIC(18,4),
  flt_onhold NUMERIC(18,4),
  flt_backord NUMERIC(18,4),
    PRIMARY KEY(int_siteid,int_itemid, int_location),
    FOREIGN KEY(int_siteid, int_location) 
      REFERENCES minv_tlnk_warehouseloc(int_siteid, int_location) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_itemid) 
      REFERENCES minv_tbl_item(int_siteid, int_itemid) 
      ON UPDATE CASCADE
);


select 'Bill of Materials Parts (minv_tlnk_bomparts)' from rdb$database;
CREATE TABLE minv_tlnk_bomparts (
  int_siteid INTEGER NOT NULL,
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Stamp */
  int_itemid BIGINT NOT NULL,
  int_subitemid BIGINT NOT NULL,
  flt_subqty INTEGER,
    PRIMARY KEY(int_siteid, int_itemid, int_subitemid),
    FOREIGN KEY(int_siteid, int_itemid) 
      REFERENCES minv_tbl_item(int_siteid, int_itemid) 
      ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_subitemid) 
      REFERENCES minv_tbl_item(int_siteid, int_itemid) 
      ON UPDATE CASCADE
);
