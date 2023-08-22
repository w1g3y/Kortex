/*
Manufacturing module for OpenAspect
#
# $Log$
#
*/
/* Considerations
Manufacturing involves using low-level inventory items, combined with employee and equipment resources, to produce higher-level inventory items.
Batches will have a qty, and a unit, e.g.: 100(each), 1(tonne), etc.
Amounts of inventory items are then linked to a batch, with qtys and units
Some of these items may have sub-items, and require pre-manufacturing
Resources will be booked for the batch through mod-erp, using both employee and equipment resources.
Costs of items involved will be booked to a BOM document using mod_finance
Logistics will be used if ingredients needs to be moved/transferred for processing.
*/

/* ============
Lookup Tables
============ */


/* ============
Base Tables
============ */

/* ===========
Link Tables
=========== */
