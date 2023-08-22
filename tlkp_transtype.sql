
/* =================================================
 *
 * Entity Name: 'tlkp_transtype.sql'
 * Description:
 *
 *
 * $Id: tlkp_transtype.sql,v 1.3 2008/07/01 03:22:37 nweeks Exp $
 *
 * $Log: tlkp_transtype.sql,v $
 * Revision 1.3  2008/07/01 03:22:37  nweeks
 * Transaction Type Table
 *
 * Revision 1.2  2007/08/31 06:28:51  nweeks
 * Changed to text-based transtype
 *
 * Revision 1.1  2007/05/21 06:38:24  nweeks
 * Initial revision
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlkp_transtype.sql...' from rdb$database;

/* --------------
 * Commerce : Transaction Type
 *
 * --------------
 */

select 'Linking DNA tlkp_transtype' from rdb$database;


CREATE TABLE tlkp_transtype (
  str_ttype VARCHAR(16) NOT NULL,
  str_desc VARCHAR(128),
    PRIMARY KEY(str_ttype)
);



 
