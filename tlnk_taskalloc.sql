
/* =================================================
 *
 * Entity Name: 'tlnk_taskalloc.sql'
 * Description:
 *
 *
 * $Id: tlnk_taskalloc.sql,v 1.2 2011/06/22 01:33:25 nweeks Exp nweeks $
 *
 * $Log: tlnk_taskalloc.sql,v $
 * Revision 1.2  2011/06/22 01:33:25  nweeks
 * BigInt Upgrade
 *
 * Revision 1.1  2007/08/31 07:01:18  nweeks
 * Initial revision
 *
 *
 *
 * ================================================= 
 */

select 'Linking DNA tlnk_taskalloc.sql...' from rdb$database;

select 'Linking DNA tlnk_taskalloc ' from rdb$database;

CREATE TABLE tlnk_taskalloc (
  int_taskid BIGINT NOT NULL,
  int_userid BIGINT NOT NULL,
  dtm_alloc TIMESTAMP,
    PRIMARY KEY(int_taskid,int_userid),
    FOREIGN KEY(int_taskid) references tbl_task(int_taskid) ON UPDATE CASCADE,
    FOREIGN KEY(int_userid) references tbl_user(int_userid) ON UPDATE CASCADE
);


