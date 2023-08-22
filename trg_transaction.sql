SET TERM ^ ;


CREATE OR ALTER TRIGGER TRG_TRANSACTION_TAX FOR tbl_transaction
active 
before insert or update 
position 0
AS 
  DECLARE VARIABLE flt_price NUMERIC(18,6);
  DECLARE VARIABLE flt_pretax NUMERIC(18,4);
  DECLARE VARIABLE flt_taxadj NUMERIC(18,4);
  DECLARE VARIABLE str_taxiefc VARCHAR(1);
BEGIN
  /* -----------------------
   * Handling Stock or Inventory items, and
   * adjusting price accordingly
   * -----------------------
   */


  if(NEW.str_taxiefc is not null)THEN
  BEGIN
    NEW.str_taxiefc = upper(NEW.str_taxiefc);
  END

 if(NEW.str_taxtype IS NOT NULL) THEN
  BEGIN
    NEW.str_taxtype = upper(NEW.str_taxtype);
  END

  if(NEW.flt_taxamt IS NULL)THEN
    NEW.flt_taxamt = 0;


  /* If it's an inventory item, get the matching price for it */
  if (NEW.int_INVITEMID != 0 AND NEW.INT_INVITEMID IS NOT NULL) THEN
  BEGIN
    /* Get the value of the item */
    select first 1 flt_price
    from tlnk_invitemprice
    WHERE int_itemid = NEW.int_invitemid
    AND dte_price <= 'now'
    AND (int_maxqty >= NEW.int_invitemid OR int_maxqty = 0)
    ORDER BY dte_price desc
    INTO :flt_price;

  END



  if(NEW.int_servitemid != 0 AND NEW.int_servitemid IS NOT NULL) THEN
  BEGIN
    /* A Service amount has been provided. Go get the amount */
    SELECT first 1 flt_price, str_taxiefc
    FROM tbl_serviceitem
    WHERE int_servitemid = NEW.int_servitemid
    INTO :flt_price, :str_taxiefc;

 /*
  * NEW.str_DESC = NEW.str_desc || ' %%ServItemPrice:$' || :flt_price || ', TaxIEFC: ' || :str_taxiefc || '.';
  */
   


    /* Service Items default to Tax Exclusive */
    if(:str_taxiefc IS NULL OR :str_taxiefc = '') THEN
    BEGIN
   /*   NEW.str_DESC = NEW.str_desc || '  TaxIEFC defaulted to E';*/
      str_taxiefc = 'E';
    END

    /* Allow NEW taxiefc's to override the one from serviceitem */
    /*
    if(NEW.str_taxiefc IS NULL OR NEW.str_taxiefc = '') THEN
    BEGIN
    END
    ELSE
    BEGIN
    END
    */

    /* The Service can change the inbound TaxIEFC, except for C  */
    if(:str_taxiefc IN ('I','E','F')) THEN
    BEGIN
      NEW.str_taxiefc = :str_taxiefc;
    END
    

    /* -------------------------
     * S E R V I C E   B O R D E R   C A S E S
     *
     * Service Items can have a Zero value,
     * But allow a value to be specified in tbl_transaction.flt_amount
     *
     * Stock Items have to have a value, and Qty is used to derive value
     *
     * -------------------------
     */


    /* Service Item, No set price, and a quantity */
    if(
      (NEW.int_servitemid != 0 
      AND NEW.int_servitemid IS NOT NULL)
    AND
      (:flt_price = 0 AND :flt_price IS NOT NULL)
    ) THEN
    BEGIN
      /* Zero-value Service Item detected.
       * Use flt_amount * int_qty to establish
       * Transaction amount
       */
      NEW.flt_amount = NEW.flt_amount * NEW.int_qty;
    END
  
  
  
    /* Service Item, Service Set Price, and Quantity */
    if(
      (NEW.int_servitemid != 0
      AND NEW.int_servitemid IS NOT NULL)
    AND
      (:flt_price != 0 AND :flt_price IS NOT NULL)
    ) THEN
    BEGIN
      /* Standard Service Item Price detected
       * Service Value * Qty
       */
      NEW.flt_amount = :flt_price * NEW.int_qty;
    END
  END /* End of Service Item Handling */

  /* Inventory Item, Inventory Price, and qty */
  if (NEW.int_INVITEMID != 0 
  AND NEW.INT_INVITEMID IS NOT NULL
  AND :flt_price IS NOT NULL
  ) THEN
  BEGIN
    /* Inventory Item Handler */
    NEW.flt_amount = :flt_price * NEW.int_qty;
  END



  /* ---------------------------
   * Tax Slicing
   *
   * This will be smarter, but for now,
   * We slice 10% off if it's GST Tax, and adjust amounts
   * ---------------------------
   */


  flt_pretax = NEW.flt_amount;

  if(upper(NEW.str_taxtype) = 'GST' AND NEW.str_taxiefc = 'E') THEN
  BEGIN
    NEW.flt_taxamt = (NEW.flt_amount / 10);
  END

  if(upper(NEW.str_taxtype) = 'GST' AND NEW.str_taxiefc = 'I') THEN
  BEGIN
    flt_taxadj = 0;
    NEW.flt_taxamt = (NEW.flt_amount / 11);
    NEW.flt_amount = (NEW.flt_amount - NEW.flt_taxamt); 
    while(NEW.flt_amount + NEW.flt_taxamt + :flt_taxadj < :flt_pretax) DO
    BEGIN 
      flt_taxadj = (:flt_taxadj + 0.0001);
    END
    if(:flt_taxadj > 0.0001) THEN
    BEGIN
      NEW.flt_taxamt = (NEW.flt_taxamt + :flt_taxadj);
      /* NEW.str_DESC = NEW.str_desc || ' (Tax Rounding: $' || :flt_taxadj || ')';*/
    END
    /* NEW.str_DESC = NEW.str_desc || '  %%IEFC changed to System Default of E'; */
    NEW.str_taxiefc = 'E';
  END



END ^

SET TERM ; ^

