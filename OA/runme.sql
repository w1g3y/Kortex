/* This file is the build script for OpenAspect.

Simply pull this into isql, using a command similar to the following, and it'll build all the tables, relationships, generators, and constraints for you.


FreeBSD, Linux, etc
-------------------
`isql -u sysdba -p masterkey < runme.sql |& more`
(the |& more is so you can watch the action, screen by screen)

Windows
-------
`isql -u sysdba -p masterkey < runme.sql`

*/

/* Change the location of the OpenAspect database here */

connect "localhost:/var/db/firebird/oa.fdb";
--connect "203.26.213.102:c:/data/oa.fdb";
--connect "203.26.213.13:d:/data/asset.fdb";

commit;
select 'Database Connect ok' from rdb$database;

/* Comment this out if you don't want to delete the existing database */
DROP DATABASE;

commit;

create database "localhost:/var/db/firebird/oa.fdb";
--create database "203.26.213.13:/var/db/firebird/oa.fdb";

commit;

/* Start pulling in sources, and building the database */

select '*****  BUILD: Pulling in User Support' from rdb$database;
in moduser.sql;

select '*****  BUILD: Pulling in Asset Management Module (Also pulls in Inventory)' from rdb$database;
in modasset.sql;

select '*****  BUILD: Pulling in Logistics Module ' from rdb$database;
in modlogistics.sql;

select '*****  BUILD: Pulling in Media Production module' from rdb$database;
in modpub.sql;

select '*****  BUILD: Pulling in Digital Assets Management module' from rdb$database;
in gmoddasset.sql;


select '*****  BUILD: Pulling in gCustomer Relationship Management(CRM)' from rdb$database;
in modcrm.sql;


select '*****  BUILD: Pulling in gEvent Management Module' from rdb$database;
in modevent.sql;

select '*****  BUILD: Pulling in gHuman Resource Management(HRM)' from rdb$database;
in modhrm.sql;


select '*****  BUILD: Pulling in gPlanner Module' from rdb$database;
in modplanner.sql;


select '*****  BUILD: Pulling in gFinance Module' from rdb$database;
in modfinance.sql;


select '*****  BUILD: Pulling in gKnowledge Base Module' from rdb$database;
in modknowbase.sql;

select '*****  BUILD: Pulling in gMessaging Module' from rdb$database;
in modmsg.sql;

select '*****  BUILD: Pulling in gManufacturing Module' from rdb$database;
in modmanuf.sql;

select '*****  BUILD: Pulling in gReporting Module' from rdb$database;
in modreport.sql;

select '*****  BUILD: Pulling in gUser Portal Module' from rdb$database;
in modportal.sql;


select '*****  BUILD: Loading Stored Procedures' from rdb$database;
in load_procedures.sql;


select '*****  Build Complete. Thanks for using OpenAspect' from rdb$database;




