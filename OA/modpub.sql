/* MOD_PUBLISH
This is the publication/content management system for OpenAspect

#
# $Id: modpub.sql,v 1.5 2004/07/11 23:16:01 nigel Exp nigel $ 
#
# $Log: modpub.sql,v $
# Revision 1.5  2004/07/11 23:16:01  nigel
# Rolled out the new boolean type (ibl_)
#
# Revision 1.4  2004/07/02 03:50:21  nigel
# More work on this - not sure how to continue
#
# Revision 1.3  2004/05/18 01:29:19  nigel
# Completed renaming
#
# Revision 1.2  2004/05/18 01:26:15  nigel
# Added RCS comments
#
#
*/

/* ---------------

Lookup Tables

--------------- */




/* ---------------

Base Tables
Publication
Edition
Page
Layouts
Article
Paragraphs, Positioning + Components(formatting + text)

--------------- */

/* Publications Table
 If the company produces mailouts, brochures, magazines, newspapers, etc
 Put details about them here
 Note:
   We have three interval settings to handle things like:
     10th of every month 
       ( str_interval1: DayOfMonth;  int_interval1: 10; )
     2nd Tuesday of every month  
       ( str_interval1: DayOfWeek;   int_interval1: 1(Tuesday); )
       ( str_inverval2: WeekOfMonth; int_interval2: 2(Second Week);)
     4th Wednesday of every 3rd month  
       ( str_interval1: DayOfWeek;   int_interval1: 3(Wednesday);)
       ( str_interval2: WeekOfMonth; int_interval2: 4(Fourth Week);)
       ( str_interval3: Monthly;     int_interval3: 3(Every 3 Months);)
  Publication dates are then calculated from the dtm_start date
*/
select 'Base Publication Table (modpub_tbl_publication)' from rdb$database;
CREATE TABLE modpub_tbl_publication (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_pubid BIGINT NOT NULL,
  str_name VARCHAR(100) NOT NULL,
  str_desc VARCHAR(1000),
  dtm_start DATE,
  str_interval1 VARCHAR(30), /* DayOfMonth,DayOfWeek,WeekOfMonth,Monthly,MonthOfYear */
  int_interval1 INTEGER,     
  str_interval2 VARCHAR(30), /* DayOfMonth,DayOfWeek,WeekOfMonth,Monthly,MonthOfYear */
  int_interval2 INTEGER,   
  str_interval3 VARCHAR(30), /* DayOfMonth,DayOfWeek,WeekOfMonth,Monthly,MonthOfYear */
  int_interval3 INTEGER,   
  str_note VARCHAR(10000),
  /* Lots more stuff to go in here... */
    PRIMARY KEY(int_siteid, int_pubid),
    UNIQUE (int_siteid, str_name)
);
CREATE GENERATOR GEN_MODPUB_TBL_PUBLICATION;


/* Publication Press Runs */
select 'Publication PressRuns table (modpub_tbl_pubpressrun)' from rdb$database;
CREATE TABLE modpub_tbl_pubpressrun (
  int_siteid INTEGER NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_pressrunid BIGINT NOT NULL,
  int_pubid BIGINT NOT NULL,
  dtm_dpress DATE, /* Time this edition is required at the printer */
  dtm_tpress TIME, /* Time this edition is required at the printer */
  dtm_drelease DATE, /* Time this edition should be printed, and on sale */
  dtm_trelease TIME, /* Time this edition should be printed, and on sale */
  str_name VARCHAR(50), /* Name of the edition, if needed */
  str_desc VARCHAR(1000), /* Give it a description of needed */
    PRIMARY KEY(int_siteid, int_pressrunid, int_pubid),
    FOREIGN KEY(int_siteid, int_pubid)
      REFERENCES modpub_tbl_publication (int_siteid, int_pubid)
      ON UPDATE CASCADE
);
CREATE GENERATOR GEN_MODPUB_TBL_PUBPRESSRUN;

/* Publication Subscriptions */
 










/* ----------------------
 * Content Management Section
 * - if you use OA to actually build your publication
 * ----------------------
 */

/* Page Table
A page is stored as it's own entity, and can be re-linked into multiple articles(full page ad re-use, etc)
*/
select 'Base Page Table (modpub_tbl_page)' from rdb$database;
CREATE TABLE modpub_tbl_page (
  int_siteid INTEGER default 1 NOT NULL, /* Replication support */
  dtm_rstamp TIMESTAMP DEFAULT 'now' NOT NULL, /* Replication Support */
  int_pageid BIGINT NOT NULL,
  int_system INTEGER DEFAULT 0, /* Is this page used for templating */
  str_orient VARCHAR(1) DEFAULT 'P' NOT NULL, /* Landscape/Portrait */
  int_width NUMERIC(18,2), /* The horizontal pixel count */
  int_height NUMERIC(18,2), /* The vertical pixel count down */
  str_desc VARCHAR(200),
  int_pageno INTEGER, /* In the publication, what page is this? */
    PRIMARY KEY(int_siteid, int_pageid)
);
CREATE GENERATOR GEN_MODPUB_TBL_PAGE;

INSERT INTO modpub_tbl_page (int_siteid, int_pageid, int_width, int_height, int_pageno) VALUES (1,gen_id(gen_modpub_tbl_page,1),300,400,1);

/* I've redesigned publisher to use a simpler, more flexible approach.
 * Instead of cells, and pre-defined layouts, it's objects that can have child objects
 * nested inside them.
 * All objects are rendered to an image form, and a recursive renderer combines them onto
 * the final page
 */

/* tbl_element
 * Elements are the self-contained object on the page.
 * Capable of text and images, with size, shadowing, transparency, and pagination
 */
CREATE TABLE modpub_tbl_object (
  int_siteid INTEGER default 1 NOT NULL,
  int_objectid BIGINT NOT NULL,
  int_pageid BIGINT NOT NULL,
  int_order INTEGER default 0 NOT NULL,
  int_system INTEGER DEFAULT 0 NOT NULL, /* System object can't be changed */
  str_ident VARCHAR(50), /* The object name */
  int_uid BIGINT NOT NULL, /* Who owns this object */
  int_opacity INTEGER, /* Opacity of the child object */
  int_rotation INTEGER, /* Rotation of the child object */
  str_text BLOB SUB_TYPE TEXT,
    PRIMARY KEY(int_siteid,int_objectid),
    FOREIGN KEY(int_siteid, int_uid) REFERENCES moduser_tbl_user(int_siteid, int_uid) ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_childof) REFERENCES modpub_tbl_object(int_site,int_objectid),
    FOREIGN KEY(int_siteid, int_page) REFERENCES modpub_tbl_page(int_site,int_pageid)
);
CREATE GENERATOR GEN_MODPUB_TBL_OBJECTID;

INSERT INTO modpub_tbl_object(int_siteid, int_objectid, int_uid) VALUES (1,1,-1);
INSERT INTO modpub_tbl_object(int_siteid, int_objectid, int_uid) VALUES (1,2,-1);
INSERT INTO modpub_tbl_object(int_siteid, int_objectid, int_uid) VALUES (1,3,-1);

CREATE TABLE modpub_tbl_objpropmas (
  int_siteid INTEGER default 1 NOT NULL,
  str_propid VARCHAR(40) NOT NULL, /* Options are sorted by this, thusly the _A_ in the name */
  str_name VARCHAR(100) NOT NULL,
  int_order INTEGER,
  str_desc VARCHAR(200),
  str_type VARCHAR(10), /* RGB:RGB colour,INT:Integer,NUM:Numeric,TXT:text */
  int_lolimit INTEGER, /* Low bound of the value */
  int_hilimit INTEGER, /* High bound of the value */
    PRIMARY KEY(int_siteid, str_propid),
    UNIQUE (int_siteid, str_name)
);

INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('OBJ_Top','Top',10,'Distance from top of page(0-1)','FLT');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('OBJ_Left','Left',20,'Distance from left of page(0-1)','FLT');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('OBJ_Width','Width',30,'Width of Page (0-1)','FLT');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('OBJ_Height','Height',40,'Height of Page (0-1)','FLT');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('OBJ_Opacity','Component Opacity',50,'Opacity of the whole object(0-100)','INT');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('OBJ_Rotation','Rotation',60,'Rotation of the whole object (0-360)','FLT');


INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('BG_DAssetID','Background Image',100,'Image from Digital Assets for the Background','INT');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('BG_Opacity','Background Opacity',110,'Set the transparency of the background image','INT');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('BG_Colour1','Background Primary Colour',120,'Primary Background Colour','RGB');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('BG_Colour2','Background Final Colour',130,'Final Background Colour (for Blends/Gradients)','RGB');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('BG_BlendDir','Blend/Gradient Direction',140,'Where the blend starts','INT');


INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('TXT_Font','Text Font',200,'Font for the Text','TXT');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('TXT_FontSize','Text Size',210,'Font size for the Text','INT');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('TXT_ForeColour','Text Foreground Colour',220,'Colour of Foreground text','RGB');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('TXT_ShadowColour','Text Shadow Colour',230,'Colour of Shadow behind Text','RGB');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('TXT_ShadowDist','Shadow Distance',240,'Distance of shadow from text(0 turns off)','INT');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('TXT_ShadowDir','Shadow Direction',250,'Direction of shadow from text','INT');


INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('IMG_DAssetID','Foreground Image',300,'Image from Digital Assets for the Foreground','INT');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('IMG_Opacity','Foreground Image Opacity',310,'Set the transparency of the image','INT');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('IMG_ShadowColour','Image Shadow Colour',320,'Colour of the Image Shadow','RGB');
INSERT INTO modpub_tbl_objpropmas (str_propid,str_name,int_order,str_desc,str_type) VALUES ('IMG_ShadowDist','Image Shadow Distance',330,'Distance of shadow from Image','INT');


/* Object Property Values 
*/
CREATE TABLE modpub_tbl_objpropvals (
  int_siteid INTEGER default 1 NOT NULL,
  int_objectid BIGINT NOT NULL,
  str_propid VARCHAR(40) NOT NULL,
  str_value VARCHAR(100) NOT NULL,
  str_text VARCHAR(10000), /* Large field for storing large amounts of text */
    PRIMARY KEY(int_siteid, int_objectid,str_propid),
    FOREIGN KEY(int_siteid, int_objectid) REFERENCES modpub_tbl_object(int_siteid, int_objectid) ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, str_propid) REFERENCES modpub_tbl_objpropmas(int_siteid, str_propid) ON UPDATE CASCADE
);
  


/* tlnk_objlink
 * This table links the objects either to parent object, or to a page
 * This stores the top x,y of the object, and the bottom right x,y for sizing
 * Also, it stores rotation information if the child object is to be on an angle
 */
 
CREATE TABLE modpub_tlnk_objlink (
  int_siteid INTEGER default 1 NOT NULL,
  int_objectid BIGINT NOT NULL,
  int_uid BIGINT NOT NULL, /* Who owns this object link */
  int_pobjectid BIGINT, /* The Parent object */
  int_pageid BIGINT, /* The Page this sits on(only required for base object) */
    PRIMARY KEY(int_objectid),
    FOREIGN KEY(int_siteid, int_objectid) REFERENCES modpub_tbl_object (int_siteid, int_objectid) ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_pobjectid) REFERENCES modpub_tbl_object (int_siteid, int_objectid) ON UPDATE CASCADE,
    FOREIGN KEY(int_siteid, int_pageid) REFERENCES modpub_tbl_page (int_siteid, int_pageid) ON UPDATE CASCADE
);


  
