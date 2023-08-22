/* =================================================
 *
 * Entity Name: 'tlkp_choices.sql'
 * Description: Provides grouped and Ordered options for select
 *   menus and application choices
 *
 *
 * $Id: tlkp_choices.sql,v 1.3 2012/11/29 23:41:21 nweeks Exp nweeks $
 *
 * $Log: tlkp_choices.sql,v $
 * Revision 1.3  2012/11/29 23:41:21  nweeks
 * This is the ListChoices, replacing the Tag system.
 *
 * Revision 1.2  2012/02/17 05:28:04  nweeks
 * Fixed line before Primary Key
 *
 * Revision 1.1  2012/02/17 05:24:34  nweeks
 * Initial revision
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_choices.sql...' from rdb$database;


CREATE TABLE tlkp_choices (
  int_choiceid BIGINT NOT NULL,
  str_referrer VARCHAR(32) NOT NULL,
  int_order INTEGER,
  str_value VARCHAR(64),
  str_note VARCHAR(64),
  str_data1 VARCHAR(64),
    PRIMARY KEY(int_choiceid),
    UNIQUE (str_referrer,str_value)
);
CREATE GENERATOR gen_tlkp_choices;

