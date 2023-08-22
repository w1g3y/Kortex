connect "localhost:/var/db/firebird/build_complete.fdb";

commit;

drop database;

commit;

create database "localhost:/var/db/firebird/build_complete.fdb";

commit;

/* ----- Confirmed -----
 * These includes are
 * in correct build order
 */

in tlkp_choices.sql;
in tlkp_finapprovelevels.sql;
in tlkp_erpposition.sql;
in tlkp_locality.sql;
in tbl_contact.sql;
in tbl_account.sql;

/* ----- Foreign Keys -----
 * All foreign keys will be manageged
 * through a seperate include.
 * easier to get it building correctly.
 */
in foreign_keys.sql;


/* ----- Unsorted -----
 * These items are yet to be put into 
 * correct build order
 */

in tbl_campaign.sql;
in tbl_campscopegroups.sql;
in tbl_campscopelocality.sql;
in tbl_campscopetypes.sql;
in tbl_config.sql;
in tbl_contactchain.sql;
in tbl_contactreps.sql;
in tbl_costcode.sql;
in tbl_crontab.sql;
in tbl_feature.sql;
in tbl_fileaccess.sql;
in tbl_filefolder.sql;
in tbl_filerequest.sql;
in tbl_file.sql;
in tbl_folderaccess.sql;
in tbl_incident.sql;
in tbl_invitem.sql;
in tbl_invsiteitemqty.sql;
in tbl_invsite.sql;
in tbl_know.sql;
in tbl_mailaccount.sql;
in tbl_mailfile.sql;
in tbl_message.sql;
in tbl_package.sql;
in tbl_pagenote.sql;
in tbl_page.sql;
in tbl_pagetags.sql;
in tbl_pageviews.sql;
in tbl_processchain.sql;
in tbl_project.sql;
in tbl_projteam.sql;
in tbl_publication.sql;
in tbl_schedule.sql;
in tbl_section.sql;
in tbl_serviceitem.sql;
in tbl_systags.sql;
in tbl_tags.sql;
in tbl_taskevent.sql;
in tbl_task.sql;
in tbl_template.sql;
in tbl_templatetags.sql;
in tbl_timesheet.sql;
in tbl_transaction.sql;
in tbl_transext.sql;
in tbl_transposting.sql;
in tblx_contact.sql;
in tlkp_acctype.sql;
in tlkp_contactgroup.sql;
in tlkp_contacttype.sql;
in tlkp_erpskill.sql;
in tlkp_featuretype.sql;
in tlkp_filegroup.sql;
in tlkp_invcategory.sql;
in tlkp_invitemtag.sql;
in tlkp_invitemtype.sql;
in tlkp_invmanufmodel.sql;
in tlkp_invqty.sql;
in tlkp_invunit.sql;
in tlkp_listchoices.sql;
in tlkp_mailaccounttag.sql;
in tlkp_orderflagtype.sql;
in tlkp_ordertype.sql;
in tlkp_priority.sql;
in tlkp_pubtype.sql;
in tlkp_region.sql;
in tlkp_transtype.sql;
in tlkp_ttype.sql;
in tlnk_contactgroup.sql;
in tlnk_contactskill.sql;
in tlnk_contacttype.sql;
in tlnk_cont_camp_status.sql;
in tlnk_contfile.sql;
in tlnk_filegroup.sql;
in tlnk_incidentdata.sql;
in tlnk_invitemcat.sql;
in tlnk_invitemfile.sql;
in tlnk_invitemprice.sql;
in tlnk_invitemregion.sql;
in tlnk_invitemtagvals.sql;
in tlnk_mailaccountvalues.sql;
in tlnk_maildelay.sql;
in tlnk_puborders.sql;
in tlnk_taskalloc.sql;
in trg_transaction.sql;
