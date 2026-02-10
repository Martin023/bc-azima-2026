#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186759 pageextension52186759 extends "Item Tracking Lines"
{
    layout
    {
        modify(CurrentSourceCaption)
        {
            ApplicationArea = Basic;
        }
        modify("SourceQuantityArray[1]")
        {
            ApplicationArea = Basic;
        }
        modify(Handle1)
        {
            ApplicationArea = Basic;
        }
        modify(Invoice1)
        {
            ApplicationArea = Basic;
        }
        modify(Text020)
        {
            ApplicationArea = Basic;
        }
        modify("Quantity_ItemTracking")
        {
            ApplicationArea = Basic;
        }
        modify(Handle2)
        {
            ApplicationArea = Basic;
        }
        modify(Invoice2)
        {
            ApplicationArea = Basic;
        }
        // modify(Control88)
        // {
        //     ApplicationArea = Basic;
        // }
        modify(Quantity3)
        {
            ApplicationArea = Basic;
        }
        modify(Handle3)
        {
            ApplicationArea = Basic;
        }
        modify(Invoice3)
        {
            ApplicationArea = Basic;
        }
        modify("ItemTrackingCode.Code")
        {
            ApplicationArea = Basic;
        }
        modify("ItemTrackingCode.Description")
        {
            ApplicationArea = Basic;
        }
        modify(AvailabilitySerialNo)
        {
            ToolTip = 'Serial No. Availability';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "AvailabilitySerialNo(Control 61)".

            //OptionCaption = 'Bitmap45';
        }
        modify("Serial No.")
        {
            ApplicationArea = Basic;
            Editable = "Serial No.Editable";
        }
        modify("New Serial No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""New Serial No."(Control 10)".

            Editable = "New Serial No.Editable";
        }
        modify(AvailabilityLotNo)
        {
            ToolTip = 'Lot No. Availability';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "AvailabilityLotNo(Control 56)".

            // OptionCaption = 'Bitmap45';
        }
        modify("Lot No.")
        {
            ApplicationArea = Basic;
            Editable = "Lot No.Editable";
        }
        modify("New Lot No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""New Lot No."(Control 46)".

            Editable = "New Lot No.Editable";
        }
        // modify("Expiration Date")
        // {
        //     ApplicationArea = Basic;
        //     Editable = "Expiration DateEditable";
        // }
        modify("New Expiration Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""New Expiration Date"(Control 75)".

            Editable = "New Expiration DateEditable";
        }
        modify("Warranty Date")
        {
            ApplicationArea = Basic;
            Editable = "Warranty DateEditable";
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
            Editable = "Item No.Editable";
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
            Editable = "Variant CodeEditable";
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
            Editable = "Location CodeEditable";
        }
        modify("Quantity (Base)")
        {
            ApplicationArea = Basic;
            Editable = "Quantity (Base)Editable";
        }
        modify("Qty. to Handle (Base)")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Qty. to Handle (Base)"(Control 14)".

            Editable = "Qty. to Handle (Base)Editable";
        }
        modify("Qty. to Invoice (Base)")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Qty. to Invoice (Base)"(Control 16)".

            Editable = "Qty. to Invoice (Base)Editable";
        }
        modify("Quantity Handled (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Invoiced (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-from Item Entry")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ShowCaption) on "CurrentSourceCaption(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""SourceQuantityArray[1]"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Handle1(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Invoice1(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity_ItemTracking"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Handle2(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Invoice2(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity3(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Handle3(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Invoice3(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ItemTrackingCode.Code"(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ItemTrackingCode.Description"(Control 85)".


        //Unsupported feature: Code Modification on ""Serial No."(Control 22).OnAssistEdit".

        //trigger "(Control 22)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OnBeforeSerialNoAssistEdit(Rec,xRec);

        MaxQuantity := UndefinedQtyArray[1];

        "Bin Code" := ForBinCode;
        ItemTrackingDataCollection.AssistEditTrackingNo(Rec,
          (CurrentSignFactor * SourceQuantityArray[1] < 0) AND NOT
          InsertIsBlocked,CurrentSignFactor,0,MaxQuantity);
        "Bin Code" := '';
        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #3..5
        ItemTrackingDataCollection.AssistEditLotSerialNo(Rec,
        #7..10
        */
        //end;


        //Unsupported feature: Code Modification on ""Serial No."(Control 22).OnValidate".

        //trigger "(Control 22)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SerialNoOnAfterValidate;
        IF "Serial No." <> '' THEN BEGIN
          ItemTrackingDataCollection.FindLotNoBySNSilent(LotNo,Rec);
          VALIDATE("Lot No.",LotNo);
          CurrPage.UPDATE;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SerialNoOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Serial No."(Control 10)".



        //Unsupported feature: Code Modification on ""Lot No."(Control 24).OnAssistEdit".

        //trigger "(Control 24)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OnBeforeLotNoAssistEdit(Rec,xRec);

        MaxQuantity := UndefinedQtyArray[1];

        "Bin Code" := ForBinCode;
        ItemTrackingDataCollection.AssistEditTrackingNo(Rec,
          (CurrentSignFactor * SourceQuantityArray[1] < 0) AND NOT
          InsertIsBlocked,CurrentSignFactor,1,MaxQuantity);
        "Bin Code" := '';
        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #3..5
        ItemTrackingDataCollection.AssistEditLotSerialNo(Rec,
        #7..10
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Lot No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Lot No."(Control 46)".

        modify("Expiration Date")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Expiration Date"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Expiration Date"(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Date"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity (Base)"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Handle (Base)"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Invoice (Base)"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Handled (Base)"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Invoiced (Base)"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-from Item Entry"(Control 80)".

    }
    actions
    {
        modify("Reclass_SerialNoInfoCard")
        {

            //Unsupported feature: Property Modification (Name) on ""Reclass_SerialNoInfoCard"(Action 67)".

            ApplicationArea = Basic;
        }
        modify("Reclass_LotNoInfoCard")
        {

            //Unsupported feature: Property Modification (Name) on ""Reclass_LotNoInfoCard"(Action 68)".

            ApplicationArea = Basic;
        }
        modify(NewSerialNoInformation)
        {
            ApplicationArea = Basic;
        }
        modify(NewLotNoInformation)
        {
            ApplicationArea = Basic;
        }
        modify("Line_SerialNoInfoCard")
        {

            //Unsupported feature: Property Modification (Name) on ""Line_SerialNoInfoCard"(Action 73)".

            ApplicationArea = Basic;
        }
        modify("Line_LotNoInfoCard")
        {

            //Unsupported feature: Property Modification (Name) on ""Line_LotNoInfoCard"(Action 74)".

            ApplicationArea = Basic;
        }
        modify("Assign Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify("Assign Lot No.")
        {
            ApplicationArea = Basic;
        }
        modify("Create Customized SN")
        {
            ApplicationArea = Basic;
        }
        modify("Refresh Availability")
        {
            ApplicationArea = Basic;
        }
        modify("Assign &Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify("Assign &Lot No.")
        {
            ApplicationArea = Basic;
        }
        modify(CreateCustomizedSN)
        {
            ApplicationArea = Basic;
        }
        modify("Select Entries")
        {
            ApplicationArea = Basic;
        }
        modify(Action64)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclass_SerialNoInfoCard"(Action 67)".


        //Unsupported feature: Property Deletion (Promoted) on ""Reclass_SerialNoInfoCard"(Action 67)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Reclass_SerialNoInfoCard"(Action 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclass_LotNoInfoCard"(Action 68)".


        //Unsupported feature: Property Deletion (Promoted) on ""Reclass_LotNoInfoCard"(Action 68)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Reclass_LotNoInfoCard"(Action 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NewSerialNoInformation(Action 70)".


        //Unsupported feature: Property Deletion (Promoted) on "NewSerialNoInformation(Action 70)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "NewSerialNoInformation(Action 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NewLotNoInformation(Action 71)".


        //Unsupported feature: Property Deletion (Promoted) on "NewLotNoInformation(Action 71)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "NewLotNoInformation(Action 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line_SerialNoInfoCard"(Action 73)".


        //Unsupported feature: Property Deletion (Promoted) on ""Line_SerialNoInfoCard"(Action 73)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Line_SerialNoInfoCard"(Action 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line_LotNoInfoCard"(Action 74)".


        //Unsupported feature: Property Deletion (Promoted) on ""Line_LotNoInfoCard"(Action 74)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Line_LotNoInfoCard"(Action 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assign Serial No."(Action 51)".


        //Unsupported feature: Property Deletion (Promoted) on ""Assign Serial No."(Action 51)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Assign Serial No."(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assign Lot No."(Action 52)".


        //Unsupported feature: Property Deletion (Promoted) on ""Assign Lot No."(Action 52)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Assign Lot No."(Action 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Customized SN"(Action 77)".


        //Unsupported feature: Property Deletion (Promoted) on ""Create Customized SN"(Action 77)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Create Customized SN"(Action 77)".



        //Unsupported feature: Code Modification on ""Refresh Availability"(Action 79).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ItemTrackingDataCollection.RefreshTrackingAvailability(Rec,TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ItemTrackingDataCollection.RefreshLotSNAvailability(Rec,TRUE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Refresh Availability"(Action 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assign &Serial No."(Action 44)".


        //Unsupported feature: Property Deletion (Promoted) on ""Assign &Serial No."(Action 44)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Assign &Serial No."(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assign &Lot No."(Action 45)".


        //Unsupported feature: Property Deletion (Promoted) on ""Assign &Lot No."(Action 45)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Assign &Lot No."(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreateCustomizedSN(Action 57)".


        //Unsupported feature: Property Deletion (Promoted) on "CreateCustomizedSN(Action 57)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CreateCustomizedSN(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Select Entries"(Action 55)".



        //Unsupported feature: Code Modification on "Action64(Action 64).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ItemTrackingDataCollection.RefreshTrackingAvailability(Rec,TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ItemTrackingDataCollection.RefreshLotSNAvailability(Rec,TRUE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Action64(Action 64)".

    }


    //Unsupported feature: Property Modification (Id) on "NewLotNoInformation(Action 71).OnAction.LotNoInfoNew(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //NewLotNoInformation : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NewLotNoInformation : 1002;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "CurrentSourceRowID(Variable 1039)".

    //var
    //>>>> ORIGINAL VALUE:
    //CurrentSourceRowID : 250;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CurrentSourceRowID : 100;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "SecondSourceRowID(Variable 1040)".

    //var
    //>>>> ORIGINAL VALUE:
    //SecondSourceRowID : 250;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SecondSourceRowID : 100;
    //Variable type has not been exported.

    var
        CurrentFormIsOpen: Boolean;

    var
        SNAvailabilityActive: Boolean;
        LotAvailabilityActive: Boolean;

    var
        IsPick: Boolean;

    var

        "Item No.Editable": Boolean;

        "Variant CodeEditable": Boolean;

        "Location CodeEditable": Boolean;

    var

        "Qty. to Handle (Base)Visible": Boolean;

    var

        "Qty. to Invoice (Base)Visible": Boolean;

        "New Serial No.Visible": Boolean;

        "New Lot No.Visible": Boolean;

        "New Expiration DateVisible": Boolean;

    var

        "Qty. to Handle (Base)Editable": Boolean;

        "Qty. to Invoice (Base)Editable": Boolean;

        "Quantity (Base)Editable": Boolean;

        "Serial No.Editable": Boolean;

        "Lot No.Editable": Boolean;

    var

        "New Serial No.Editable": Boolean;

        "New Lot No.Editable": Boolean;

        "New Expiration DateEditable": Boolean;

        "Expiration DateEditable": Boolean;

        "Warranty DateEditable": Boolean;


    //Unsupported feature: Code Modification on "OnClosePage".

    //trigger OnClosePage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SkipWriteToDatabase := FALSE;
    OnBeforeClosePage(Rec,SkipWriteToDatabase);
    IF UpdateUndefinedQty AND NOT SkipWriteToDatabase THEN
      WriteToDatabase;
    IF FormRunMode = FormRunMode::"Drop Shipment" THEN
      CASE CurrentSourceType OF
        DATABASE::"Sales Line":
          SynchronizeLinkedSources(STRSUBSTNO(Text015,Text016));
        DATABASE::"Purchase Line":
          SynchronizeLinkedSources(STRSUBSTNO(Text015,Text017));
      END;

    IF (FormRunMode = FormRunMode::Transfer) OR IsOrderToOrderBindingToTransfer THEN
      SynchronizeLinkedSources('');
    SynchronizeWarehouseItemTracking;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF UpdateUndefinedQty THEN
    #4..11
    IF FormRunMode = FormRunMode::Transfer THEN
      SynchronizeLinkedSources('');
    */
    //end;


    //Unsupported feature: Code Modification on "OnDeleteRecord".

    //trigger OnDeleteRecord(): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeDeleteRecord(Rec);

    TrackingSpec."Item No." := "Item No.";
    TrackingSpec."Location Code" := "Location Code";
    TrackingSpec."Source Type" := "Source Type";
    #6..12

      IF NOT AlreadyDeleted THEN
        TempItemTrackLineDelete.INSERT;
      ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
        TempItemTrackLineDelete,CurrentSignFactor * SourceQuantityArray[1] < 0,CurrentSignFactor,2);
      IF TempItemTrackLineInsert.GET("Entry No.") THEN
        TempItemTrackLineInsert.DELETE;
    #20..22
    CalculateSums;

    EXIT(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..15
      ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
    #17..25
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WarrantyDateEditable := TRUE;
    ExpirationDateEditable := TRUE;
    NewExpirationDateEditable := TRUE;
    NewLotNoEditable := TRUE;
    NewSerialNoEditable := TRUE;
    DescriptionEditable := TRUE;
    LotNoEditable := TRUE;
    SerialNoEditable := TRUE;
    QuantityBaseEditable := TRUE;
    QtyToInvoiceBaseEditable := TRUE;
    QtyToHandleBaseEditable := TRUE;
    FunctionsDemandVisible := TRUE;
    FunctionsSupplyVisible := TRUE;
    ButtonLineVisible := TRUE;
    QtyToInvoiceBaseVisible := TRUE;
    Invoice3Visible := TRUE;
    Invoice2Visible := TRUE;
    Invoice1Visible := TRUE;
    QtyToHandleBaseVisible := TRUE;
    Handle3Visible := TRUE;
    Handle2Visible := TRUE;
    Handle1Visible := TRUE;
    LocationCodeEditable := TRUE;
    VariantCodeEditable := TRUE;
    ItemNoEditable := TRUE;
    InboundIsSet := FALSE;
    ApplFromItemEntryVisible := FALSE;
    ApplToItemEntryVisible := FALSE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Warranty DateEditable" := TRUE;
    "Expiration DateEditable" := TRUE;
    "New Expiration DateEditable" := TRUE;
    "New Lot No.Editable" := TRUE;
    "New Serial No.Editable" := TRUE;
    DescriptionEditable := TRUE;
    "Lot No.Editable" := TRUE;
    "Serial No.Editable" := TRUE;
    "Quantity (Base)Editable" := TRUE;
    "Qty. to Invoice (Base)Editable" := TRUE;
    "Qty. to Handle (Base)Editable" := TRUE;
    #12..14
    "Qty. to Invoice (Base)Visible" := TRUE;
    #16..18
    "Qty. to Handle (Base)Visible" := TRUE;
    #20..22
    "Location CodeEditable" := TRUE;
    "Variant CodeEditable" := TRUE;
    "Item No.Editable" := TRUE;
    #26..28
    */
    //end;


    //Unsupported feature: Code Modification on "OnInsertRecord".

    //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Entry No." <> 0 THEN
      EXIT(FALSE);
    "Entry No." := NextEntryNo;
    IF (NOT InsertIsBlocked) AND (NOT ZeroLineExists) THEN
      IF NOT TestTempSpecificationExists THEN BEGIN
        TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
        OnInsertRecordOnBeforeTempItemTrackLineInsert(TempItemTrackLineInsert,Rec);
        TempItemTrackLineInsert.INSERT;
        INSERT;
        ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
          TempItemTrackLineInsert,CurrentSignFactor * SourceQuantityArray[1] < 0,CurrentSignFactor,0);
      END;
    CalculateSums;

    EXIT(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
        TempItemTrackLineInsert.INSERT;
        INSERT;
        ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
    #11..15
    */
    //end;


    //Unsupported feature: Code Modification on "OnModifyRecord".

    //trigger OnModifyRecord(): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF InsertIsBlocked THEN
      IF (xRec."Lot No." <> "Lot No.") OR
         (xRec."Serial No." <> "Serial No.") OR
    #4..9

      IF (xRec."Lot No." <> "Lot No.") OR (xRec."Serial No." <> "Serial No.") THEN BEGIN
        xTempTrackingSpec := xRec;
        ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
          xTempTrackingSpec,CurrentSignFactor * SourceQuantityArray[1] < 0,CurrentSignFactor,2);
      END;

      IF TempItemTrackLineModify.GET("Entry No.") THEN
        TempItemTrackLineModify.DELETE;
      IF TempItemTrackLineInsert.GET("Entry No.") THEN BEGIN
        TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
        TempItemTrackLineInsert.MODIFY;
        ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
          TempItemTrackLineInsert,CurrentSignFactor * SourceQuantityArray[1] < 0,CurrentSignFactor,1);
      END ELSE BEGIN
        TempItemTrackLineModify.TRANSFERFIELDS(Rec);
        TempItemTrackLineModify.INSERT;
        ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
          TempItemTrackLineModify,CurrentSignFactor * SourceQuantityArray[1] < 0,CurrentSignFactor,1);
      END;
    END;
    CalculateSums;

    EXIT(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
        ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
    #14..21
        ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
    #23..26
        ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
    #28..33
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemNoEditable := FALSE;
    VariantCodeEditable := FALSE;
    LocationCodeEditable := FALSE;
    IF InboundIsSet THEN BEGIN
      ApplFromItemEntryVisible := Inbound;
      ApplToItemEntryVisible := NOT Inbound;
    END;

    UpdateUndefinedQtyArray;

    CurrentPageIsOpen := TRUE;

    NotifyWhenTrackingIsManagedByWhse;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Item No.Editable" := FALSE;
    "Variant CodeEditable" := FALSE;
    "Location CodeEditable" := FALSE;
    #4..10
    CurrentFormIsOpen := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT UpdateUndefinedQty THEN
      EXIT(CONFIRM(Text006));

    IF NOT ItemTrackingDataCollection.RefreshTrackingAvailability(Rec,FALSE) THEN BEGIN
      CurrPage.UPDATE;
      EXIT(CONFIRM(Text019,TRUE));
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    IF NOT ItemTrackingDataCollection.RefreshLotSNAvailability(Rec,FALSE) THEN BEGIN
    #5..7
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetFormRunMode(PROCEDURE 19)".


    //Unsupported feature: Property Deletion (Attributes) on "SetSourceSpec(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Name) on "SetSourceSpec(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "SetSourceSpec(PROCEDURE 1)".

    //procedure SetSourceSpec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSetSourceSpec(TrackingSpecification,ReservEntry);

    GetItem(TrackingSpecification."Item No.");
    ForBinCode := TrackingSpecification."Bin Code";
    SetFilters(TrackingSpecification);
    #6..24
    SetControls(Controls::Reclass,FormRunMode = FormRunMode::Reclass);

    IF FormRunMode = FormRunMode::"Combined Ship/Rcpt" THEN
      SetControls(Controls::Tracking,FALSE);
    IF ItemTrackingMgt.ItemTrkgIsManagedByWhse(
         TrackingSpecification."Source Type",
         TrackingSpecification."Source Subtype",
    #32..35
         TrackingSpecification."Item No.")
    THEN BEGIN
      SetControls(Controls::Quantity,FALSE);
      QtyToHandleBaseEditable := TRUE;
      DeleteIsBlocked := TRUE;
      ItemTrackingManagedByWhse := TRUE;
    END;

    ReservEntry."Source Type" := TrackingSpecification."Source Type";
    #45..61
    SourceQuantityArray[5] := TrackingSpecification."Quantity Invoiced (Base)";
    QtyPerUOM := TrackingSpecification."Qty. per Unit of Measure";

    ReservEntry.SetSourceFilter(
      TrackingSpecification."Source Type",TrackingSpecification."Source Subtype",
      TrackingSpecification."Source ID",TrackingSpecification."Source Ref. No.",TRUE);
    ReservEntry.SetSourceFilter2(
      TrackingSpecification."Source Batch Name",TrackingSpecification."Source Prod. Order Line");
    ReservEntry.SETRANGE("Untracked Surplus",FALSE);
    // Transfer Receipt gets special treatment:
    IF (TrackingSpecification."Source Type" = DATABASE::"Transfer Line") AND
       (FormRunMode <> FormRunMode::Transfer) AND
    #74..85

    TempReservEntry.COPYFILTERS(ReservEntry);

    TrackingSpecification.SetSourceFilter(
      TrackingSpecification."Source Type",TrackingSpecification."Source Subtype",
      TrackingSpecification."Source ID",TrackingSpecification."Source Ref. No.",TRUE);
    TrackingSpecification.SetSourceFilter2(
      TrackingSpecification."Source Batch Name",TrackingSpecification."Source Prod. Order Line");

    IF TrackingSpecification.FINDSET THEN
      REPEAT
    #97..145

    FunctionsDemandVisible := CurrentSignFactor * SourceQuantityArray[1] < 0;
    FunctionsSupplyVisible := NOT FunctionsDemandVisible;

    OnAfterSetSourceSpec(TrackingSpecification,Rec,AvailabilityDate,BlockCommit);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..27
      SetControls(Controls::LotSN,FALSE);
    #29..38
      "Qty. to Handle (Base)Editable" := TRUE;
      DeleteIsBlocked := TRUE;
    #42..64
    ReservEntry.SETCURRENTKEY(
      "Source ID","Source Ref. No.","Source Type","Source Subtype",
      "Source Batch Name","Source Prod. Order Line","Reservation Status");

    ReservEntry.SETRANGE("Source ID",TrackingSpecification."Source ID");
    ReservEntry.SETRANGE("Source Ref. No.",TrackingSpecification."Source Ref. No.");
    ReservEntry.SETRANGE("Source Type",TrackingSpecification."Source Type");
    ReservEntry.SETRANGE("Source Subtype",TrackingSpecification."Source Subtype");
    ReservEntry.SETRANGE("Source Batch Name",TrackingSpecification."Source Batch Name");
    ReservEntry.SETRANGE("Source Prod. Order Line",TrackingSpecification."Source Prod. Order Line");

    #71..88
    TrackingSpecification.SETCURRENTKEY(
      "Source ID","Source Type","Source Subtype",
      "Source Batch Name","Source Prod. Order Line","Source Ref. No.");

    TrackingSpecification.SETRANGE("Source ID",TrackingSpecification."Source ID");
    TrackingSpecification.SETRANGE("Source Type",TrackingSpecification."Source Type");
    TrackingSpecification.SETRANGE("Source Subtype",TrackingSpecification."Source Subtype");
    TrackingSpecification.SETRANGE("Source Batch Name",TrackingSpecification."Source Batch Name");
    TrackingSpecification.SETRANGE("Source Prod. Order Line",TrackingSpecification."Source Prod. Order Line");
    TrackingSpecification.SETRANGE("Source Ref. No.",TrackingSpecification."Source Ref. No.");
    #94..148
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetSecondSourceQuantity(PROCEDURE 1026)".



    //Unsupported feature: Code Modification on "SetSecondSourceQuantity(PROCEDURE 1026)".

    //procedure SetSecondSourceQuantity();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSetSecondSourceQuantity(SecondSourceQuantityArray);

    CASE SecondSourceQuantityArray[1] OF
      DATABASE::"Warehouse Receipt Line",DATABASE::"Warehouse Shipment Line":
        BEGIN
    #6..9
      ELSE
        EXIT;
    END;

    CalculateSums;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..12
    CalculateSums;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetSecondSourceRowID(PROCEDURE 32)".



    //Unsupported feature: Code Modification on "AddReservEntriesToTempRecSet(PROCEDURE 15)".

    //procedure AddReservEntriesToTempRecSet();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ReservEntry.FINDSET THEN
      REPEAT
        IF Color = 0 THEN BEGIN
          TempReservEntry := ReservEntry;
          TempReservEntry.INSERT;
        END;
        IF ReservEntry.TrackingExists THEN BEGIN
          AddTracking := TRUE;
          IF SecondSourceID = DATABASE::"Warehouse Shipment Line" THEN
            IF FromReservEntry.GET(ReservEntry."Entry No.",NOT ReservEntry.Positive) THEN
              AddTracking := (FromReservEntry."Source Type" = DATABASE::"Assembly Header") = IsAssembleToOrder
            ELSE
              AddTracking := NOT IsAssembleToOrder;

          IF AddTracking THEN BEGIN
            TempTrackingSpecification.TRANSFERFIELDS(ReservEntry);
            // Ensure uniqueness of Entry No. by making it negative:
            TempTrackingSpecification."Entry No." *= -1;
            IF SwapSign THEN
              TempTrackingSpecification."Quantity (Base)" *= -1;
            IF Color <> 0 THEN BEGIN
              TempTrackingSpecification."Quantity Handled (Base)" :=
                TempTrackingSpecification."Quantity (Base)";
              TempTrackingSpecification."Quantity Invoiced (Base)" :=
                TempTrackingSpecification."Quantity (Base)";
              TempTrackingSpecification."Qty. to Handle (Base)" := 0;
              TempTrackingSpecification."Qty. to Invoice (Base)" := 0;
            END;
            TempTrackingSpecification."Buffer Status" := Color;
            OnAddReservEntriesToTempRecSetOnBeforeInsert(TempTrackingSpecification,ReservEntry);
            TempTrackingSpecification.INSERT;
          END;
        END;
      UNTIL ReservEntry.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
          TempTrackingSpecification.TRANSFERFIELDS(ReservEntry);
          // Ensure uniqueness of Entry No. by making it negative:
          TempTrackingSpecification."Entry No." *= -1;
          IF SwapSign THEN
            TempTrackingSpecification."Quantity (Base)" *= -1;
          IF Color <> 0 THEN BEGIN
            TempTrackingSpecification."Quantity Handled (Base)" :=
              TempTrackingSpecification."Quantity (Base)";
            TempTrackingSpecification."Quantity Invoiced (Base)" :=
              TempTrackingSpecification."Quantity (Base)";
            TempTrackingSpecification."Qty. to Handle (Base)" := 0;
            TempTrackingSpecification."Qty. to Invoice (Base)" := 0;
          END;
          TempTrackingSpecification."Buffer Status" := Color;
          TempTrackingSpecification.INSERT;
        END;
      UNTIL ReservEntry.NEXT = 0;
    */
    //end;


    //Unsupported feature: Code Modification on "AddToGlobalRecordSet(PROCEDURE 17)".

    //procedure AddToGlobalRecordSet();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TempTrackingSpecification.SETCURRENTKEY("Lot No.","Serial No.");
    IF TempTrackingSpecification.FIND('-') THEN
      REPEAT
        TempTrackingSpecification.SetTrackingFilterFromSpec(TempTrackingSpecification);
        TempTrackingSpecification.CALCSUMS("Quantity (Base)","Qty. to Handle (Base)",
          "Qty. to Invoice (Base)","Quantity Handled (Base)","Quantity Invoiced (Base)");
        IF TempTrackingSpecification."Quantity (Base)" <> 0 THEN BEGIN
    #8..25
            "Buffer Status2" := "Buffer Status2"::"ExpDate blocked";
          END;

          OnBeforeAddToGlobalRecordSet(Rec,EntriesExist);
          INSERT;

          IF "Buffer Status" = 0 THEN BEGIN
    #33..35
        END;

        TempTrackingSpecification.FIND('+');
        TempTrackingSpecification.ClearTrackingFilter;
      UNTIL TempTrackingSpecification.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
        TempTrackingSpecification.SETRANGE("Lot No.",TempTrackingSpecification."Lot No.");
        TempTrackingSpecification.SETRANGE("Serial No.",TempTrackingSpecification."Serial No.");
    #5..28
    #30..38
        TempTrackingSpecification.SETRANGE("Lot No.");
        TempTrackingSpecification.SETRANGE("Serial No.");
      UNTIL TempTrackingSpecification.NEXT = 0;
    */
    //end;


    //Unsupported feature: Code Modification on "SetControls(PROCEDURE 13)".

    //procedure SetControls();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CASE Controls OF
      Controls::Handle:
        BEGIN
          Handle1Visible := SetAccess;
          Handle2Visible := SetAccess;
          Handle3Visible := SetAccess;
          QtyToHandleBaseVisible := SetAccess;
          QtyToHandleBaseEditable := SetAccess;
        END;
      Controls::Invoice:
        BEGIN
          Invoice1Visible := SetAccess;
          Invoice2Visible := SetAccess;
          Invoice3Visible := SetAccess;
          QtyToInvoiceBaseVisible := SetAccess;
          QtyToInvoiceBaseEditable := SetAccess;
        END;
      Controls::Quantity:
        BEGIN
          QuantityBaseEditable := SetAccess;
          SerialNoEditable := SetAccess;
          LotNoEditable := SetAccess;
          DescriptionEditable := SetAccess;
          InsertIsBlocked := TRUE;
        END;
      Controls::Reclass:
        BEGIN
          NewSerialNoVisible := SetAccess;
          NewSerialNoEditable := SetAccess;
          NewLotNoVisible := SetAccess;
          NewLotNoEditable := SetAccess;
          NewExpirationDateVisible := SetAccess;
          NewExpirationDateEditable := SetAccess;
          ButtonLineReclassVisible := SetAccess;
          ButtonLineVisible := NOT SetAccess;
        END;
      Controls::Tracking:
        BEGIN
          SerialNoEditable := SetAccess;
          LotNoEditable := SetAccess;
          ExpirationDateEditable := SetAccess;
          WarrantyDateEditable := SetAccess;
          InsertIsBlocked := SetAccess;
        END;
    END;

    OnAfterSetControls(ItemTrackingCode,Controls,SetAccess);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
          "Qty. to Handle (Base)Visible" := SetAccess;
          "Qty. to Handle (Base)Editable" := SetAccess;
    #9..14
          "Qty. to Invoice (Base)Visible" := SetAccess;
          "Qty. to Invoice (Base)Editable" := SetAccess;
    #17..19
          "Quantity (Base)Editable" := SetAccess;
          "Serial No.Editable" := SetAccess;
          "Lot No.Editable" := SetAccess;
    #23..27
          "New Serial No.Visible" := SetAccess;
          "New Serial No.Editable" := SetAccess;
          "New Lot No.Visible" := SetAccess;
          "New Lot No.Editable" := SetAccess;
          "New Expiration DateVisible" := SetAccess;
          "New Expiration DateEditable" := SetAccess;
    #34..36
      Controls::LotSN:
        BEGIN
          "Serial No.Editable" := SetAccess;
          "Lot No.Editable" := SetAccess;
          "Expiration DateEditable" := SetAccess;
          "Warranty DateEditable" := SetAccess;
    #43..45
    */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "CheckLine(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "UpdateUndefinedQty(PROCEDURE 5)".

    //procedure UpdateUndefinedQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeUpdateUndefinedQty(Rec,TotalItemTrackingLine,UndefinedQtyArray,SourceQuantityArray,ReturnValue,IsHandled);
    IF IsHandled THEN
      EXIT(ReturnValue);

    UpdateUndefinedQtyArray;
    IF ProdOrderLineHandling THEN // Avoid check for prod.journal lines
      EXIT(TRUE);
    EXIT(ABS(SourceQuantityArray[1]) >= ABS(TotalItemTrackingLine."Quantity (Base)"));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #6..9
    */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "EntriesAreIdentical(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "EntriesAreIdentical(PROCEDURE 8)".

    //procedure EntriesAreIdentical();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IdenticalArray[1] := (
                          (ReservEntry1."Entry No." = ReservEntry2."Entry No.") AND
                          (ReservEntry1."Item No." = ReservEntry2."Item No.") AND
    #4..35
                          (ReservEntry1."Warranty Date" = ReservEntry2."Warranty Date") AND
                          (ReservEntry1."New Expiration Date" = ReservEntry2."New Expiration Date"));

    OnAfterEntriesAreIdentical(ReservEntry1,ReservEntry2,IdenticalArray);
    EXIT(IdenticalArray[1] AND IdenticalArray[2]);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..38
    EXIT(IdenticalArray[1] AND IdenticalArray[2]);
    */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "QtyToHandleAndInvoiceChanged(PROCEDURE 14)".



    //Unsupported feature: Code Modification on "WriteToDatabase(PROCEDURE 10)".

    //procedure WriteToDatabase();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeWriteToDatabase(Rec,CurrentPageIsOpen);
    IF CurrentPageIsOpen THEN BEGIN
      TempReservEntry.LOCKTABLE;
      TempRecValid;

    #6..30
          REPEAT
            IF xTempItemTrackingLine.GET(TempItemTrackLineModify."Entry No.") THEN BEGIN
              // Process decreases before increases
              OnWriteToDatabaseOnBeforeRegisterDecrease(TempItemTrackLineModify);
              Decrease := (xTempItemTrackingLine."Quantity (Base)" > TempItemTrackLineModify."Quantity (Base)");
              IF ((ModifyLoop = 1) AND Decrease) OR ((ModifyLoop = 2) AND NOT Decrease) THEN BEGIN
                i := i + 1;
    #38..67
            Window.UPDATE(2,ROUND(i / NoOfLines * 10000,1));
          IF TempItemTrackLineModify.GET(TempItemTrackLineInsert."Entry No.") THEN
            TempItemTrackLineInsert.TRANSFERFIELDS(TempItemTrackLineModify);
          OnWriteToDatabaseOnBeforeRegisterInsert(TempItemTrackLineInsert);
          IF NOT RegisterChange(TempItemTrackLineInsert,TempItemTrackLineInsert,ChangeType::Insert,FALSE) THEN
            ERROR(Text005);
          IF (TempItemTrackLineInsert."Quantity (Base)" <> TempItemTrackLineInsert."Qty. to Handle (Base)") OR
    #75..97
      xTempItemTrackingLine.SETCURRENTKEY("Entry No.");
      IF xTempItemTrackingLine.FIND('-') THEN
        REPEAT
          SetTrackingFilterFromSpec(xTempItemTrackingLine);
          IF FIND('-') THEN BEGIN
            IF RegisterChange(xTempItemTrackingLine,Rec,ChangeType::Modify,FALSE) THEN BEGIN
              EntryNo := xTempItemTrackingLine."Entry No.";
    #105..127
        UNTIL NEXT = 0;
    END;

    UpdateOrderTrackingAndReestablishReservation;

    IF NOT BlockCommit THEN
      COMMIT;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF CurrentFormIsOpen THEN BEGIN
    #3..33
    #35..70
    #72..100
          SETRANGE("Lot No.",xTempItemTrackingLine."Lot No.");
          SETRANGE("Serial No.",xTempItemTrackingLine."Serial No.");
    #102..130
    UpdateOrderTracking;
    ReestablishReservations; // Late Binding
    #132..134
    */
    //end;


    //Unsupported feature: Code Modification on "RegisterChange(PROCEDURE 11)".

    //procedure RegisterChange();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OK := FALSE;

    IF ((CurrentSignFactor * NewTrackingSpecification."Qty. to Handle") < 0) AND
       (FormRunMode <> FormRunMode::"Drop Shipment")
    #5..11
        BEGIN
          IF (OldTrackingSpecification."Quantity (Base)" = 0) OR NOT OldTrackingSpecification.TrackingExists THEN
            EXIT(TRUE);
          TempReservEntry.SetTrackingFilter('','');
          OldTrackingSpecification."Quantity (Base)" :=
            CurrentSignFactor *
            ReservEngineMgt.AddItemTrackingToTempRecSet(
              TempReservEntry,NewTrackingSpecification,
              CurrentSignFactor * OldTrackingSpecification."Quantity (Base)",QtyToAddAsBlank,
              ItemTrackingCode."SN Specific Tracking",ItemTrackingCode."Lot Specific Tracking");
          TempReservEntry.ClearTrackingFilter;

          // Late Binding
          IF ReservEngineMgt.RetrieveLostReservQty(LostReservQty) THEN BEGIN
    #26..51
            OldTrackingSpecification."Quantity (Base)",
            OldTrackingSpecification."Serial No.",
            OldTrackingSpecification."Lot No.");

          OnAfterCreateReservEntryFor(OldTrackingSpecification,NewTrackingSpecification);

          CreateReservEntry.CreateEntry(OldTrackingSpecification."Item No.",
            OldTrackingSpecification."Variant Code",
            OldTrackingSpecification."Location Code",
            OldTrackingSpecification.Description,
            ExpectedReceiptDate,
            ShipmentDate,0,CurrentEntryStatus);
          CreateReservEntry.GetLastEntry(ReservEntry1);
          OnRegisterChangeOnAfterCreateReservEntry(ReservEntry1,NewTrackingSpecification,OldTrackingSpecification);

          IF Item."Order Tracking Policy" = Item."Order Tracking Policy"::"Tracking & Action Msg." THEN
            ReservEngineMgt.UpdateActionMessages(ReservEntry1);

          IF ModifySharedFields THEN BEGIN
            ReservEntry1.SetPointerFilter;
            ReservEntry1.SetTrackingFilterFromReservEntry(ReservEntry1);
            ReservEntry1.SETFILTER("Entry No.",'<>%1',ReservEntry1."Entry No.");
            ModifyFieldsWithinFilter(ReservEntry1,NewTrackingSpecification);
          END;
    #76..84
          IF EntriesAreIdentical(ReservEntry1,ReservEntry2,IdenticalArray) THEN
            EXIT(QtyToHandleAndInvoiceChanged(ReservEntry1,ReservEntry2));

          IF ABS(OldTrackingSpecification."Quantity (Base)") < ABS(NewTrackingSpecification."Quantity (Base)") THEN BEGIN
            // Item Tracking is added to any blank reservation entries:
            TempReservEntry.SetTrackingFilter('','');
            QtyToAdd :=
              CurrentSignFactor *
              ReservEngineMgt.AddItemTrackingToTempRecSet(
                TempReservEntry,NewTrackingSpecification,
                CurrentSignFactor * (NewTrackingSpecification."Quantity (Base)" -
                                     OldTrackingSpecification."Quantity (Base)"),QtyToAddAsBlank,
                ItemTrackingCode."SN Specific Tracking",ItemTrackingCode."Lot Specific Tracking");
            TempReservEntry.ClearTrackingFilter;

            // Late Binding
            IF ReservEngineMgt.RetrieveLostReservQty(LostReservQty) THEN BEGIN
    #102..107
            OldTrackingSpecification."Warranty Date" := NewTrackingSpecification."Warranty Date";
            OldTrackingSpecification."Expiration Date" := NewTrackingSpecification."Expiration Date";
            OldTrackingSpecification.Description := NewTrackingSpecification.Description;
            OnAfterCopyTrackingSpec(NewTrackingSpecification,OldTrackingSpecification);

            RegisterChange(OldTrackingSpecification,OldTrackingSpecification,
              ChangeType::Insert,NOT IdenticalArray[2]);
          END ELSE BEGIN
            TempReservEntry.SetTrackingFilterFromSpec(OldTrackingSpecification);
            OldTrackingSpecification.ClearTracking;
            OnAfterClearTrackingSpec(OldTrackingSpecification);
            QtyToAdd :=
              CurrentSignFactor *
              ReservEngineMgt.AddItemTrackingToTempRecSet(
                TempReservEntry,OldTrackingSpecification,
                CurrentSignFactor * (OldTrackingSpecification."Quantity (Base)" -
                                     NewTrackingSpecification."Quantity (Base)"),QtyToAddAsBlank,
                ItemTrackingCode."SN Specific Tracking",ItemTrackingCode."Lot Specific Tracking");
            TempReservEntry.ClearTrackingFilter;
            RegisterChange(NewTrackingSpecification,NewTrackingSpecification,
              ChangeType::PartDelete,NOT IdenticalArray[2]);
          END;
          OnRegisterChangeOnAfterModify(NewTrackingSpecification,OldTrackingSpecification);
          OK := TRUE;
        END;
      ChangeType::FullDelete,
      ChangeType::PartDelete:
        BEGIN
          ReservationMgt.SetItemTrackingHandling(1); // Allow deletion of Item Tracking
          ReservEntry1.TRANSFERFIELDS(OldTrackingSpecification);
          ReservEntry1.SetPointerFilter;
          ReservEntry1.SetTrackingFilterFromReservEntry(ReservEntry1);
          IF ChangeType = ChangeType::FullDelete THEN BEGIN
            TempReservEntry.SetTrackingFilterFromSpec(OldTrackingSpecification);
            OldTrackingSpecification.ClearTracking;
            OnAfterClearTrackingSpec(OldTrackingSpecification);
            QtyToAdd :=
              CurrentSignFactor *
              ReservEngineMgt.AddItemTrackingToTempRecSet(
                TempReservEntry,OldTrackingSpecification,
                CurrentSignFactor * OldTrackingSpecification."Quantity (Base)",QtyToAddAsBlank,
                ItemTrackingCode."SN Specific Tracking",ItemTrackingCode."Lot Specific Tracking");
            TempReservEntry.ClearTrackingFilter;
            ReservationMgt.DeleteReservEntries2(TRUE,0,ReservEntry1)
          END ELSE BEGIN
            ReservationMgt.DeleteReservEntries2(FALSE,ReservEntry1."Quantity (Base)" -
    #154..160
        END;
    END;
    SetQtyToHandleAndInvoice(NewTrackingSpecification);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    OK := FALSE;
    ReservEngineMgt.SetPick(IsPick);
    #2..14
          TempReservEntry.SETRANGE("Serial No.",'');
          TempReservEntry.SETRANGE("Lot No.",'');
    #16..21
          TempReservEntry.SETRANGE("Serial No.");
          TempReservEntry.SETRANGE("Lot No.");
    #23..54
    #58..64
    #67..70
            ReservationMgt.SetPointerFilter(ReservEntry1);
            ReservEntry1.SETRANGE("Lot No.",ReservEntry1."Lot No.");
            ReservEntry1.SETRANGE("Serial No.",ReservEntry1."Serial No.");
    #73..87
          IF ABS(OldTrackingSpecification."Quantity (Base)") < ABS(NewTrackingSpecification."Quantity (Base)") THEN
            BEGIN
            // Item Tracking is added to any blank reservation entries:
            TempReservEntry.SETRANGE("Serial No.",'');
            TempReservEntry.SETRANGE("Lot No.",'');
    #91..97
            TempReservEntry.SETRANGE("Serial No.");
            TempReservEntry.SETRANGE("Lot No.");
    #99..110
    #113..115
            TempReservEntry.SETRANGE("Serial No.",OldTrackingSpecification."Serial No.");
            TempReservEntry.SETRANGE("Lot No.",OldTrackingSpecification."Lot No.");
            OldTrackingSpecification."Serial No." := '';
            OldTrackingSpecification."Lot No." := '';
            OldTrackingSpecification."Warranty Date" := 0D;
            OldTrackingSpecification."Expiration Date" := 0D;
    #119..125
            TempReservEntry.SETRANGE("Serial No.");
            TempReservEntry.SETRANGE("Lot No.");
    #127..129
          OK := TRUE;
        END;
      ChangeType::FullDelete,ChangeType::PartDelete:
    #135..137
          ReservationMgt.SetPointerFilter(ReservEntry1);
          ReservEntry1.SETRANGE("Lot No.",ReservEntry1."Lot No.");
          ReservEntry1.SETRANGE("Serial No.",ReservEntry1."Serial No.");
          IF ChangeType = ChangeType::FullDelete THEN BEGIN
            TempReservEntry.SETRANGE("Serial No.",OldTrackingSpecification."Serial No.");
            TempReservEntry.SETRANGE("Lot No.",OldTrackingSpecification."Lot No.");
            OldTrackingSpecification."Serial No." := '';
            OldTrackingSpecification."Lot No." := '';
            OldTrackingSpecification."Warranty Date" := 0D;
            OldTrackingSpecification."Expiration Date" := 0D;
    #144..149
            TempReservEntry.SETRANGE("Serial No.");
            TempReservEntry.SETRANGE("Lot No.");
    #151..163
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "UpdateOrderTrackingAndReestablishReservation(PROCEDURE 26)".



    //Unsupported feature: Code Modification on "UpdateOrderTrackingAndReestablishReservation(PROCEDURE 26)".

    //procedure UpdateOrderTrackingAndReestablishReservation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    // Order Tracking
    IF ReservEngineMgt.CollectAffectedSurplusEntries(TempReservEntry) THEN BEGIN
      LateBindingMgt.SetOrderTrackingSurplusEntries(TempReservEntry);
      IF Item."Order Tracking Policy" <> Item."Order Tracking Policy"::None THEN
        ReservEngineMgt.UpdateOrderTracking(TempReservEntry);
    END;

    // Late Binding
    IF TempItemTrackLineReserv.FINDSET THEN
      REPEAT
        LateBindingMgt.ReserveItemTrackingLine2(TempItemTrackLineReserv,0,TempItemTrackLineReserv."Quantity (Base)");
        SetQtyToHandleAndInvoice(TempItemTrackLineReserv);
      UNTIL TempItemTrackLineReserv.NEXT = 0;
    TempItemTrackLineReserv.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT ReservEngineMgt.CollectAffectedSurplusEntries(TempReservEntry) THEN
      EXIT;
    IF Item."Order Tracking Policy" = Item."Order Tracking Policy"::None THEN
      EXIT;
    ReservEngineMgt.UpdateOrderTracking(TempReservEntry);
    */
    //end;


    //Unsupported feature: Code Modification on "ModifyFieldsWithinFilter(PROCEDURE 25)".

    //procedure ModifyFieldsWithinFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    // Used to ensure that field values that are common to a SN/Lot are copied to all entries.
    IF ReservEntry1.FIND('-') THEN
      REPEAT
    #4..6
        ReservEntry1."New Serial No." := TrackingSpecification."New Serial No.";
        ReservEntry1."New Lot No." := TrackingSpecification."New Lot No.";
        ReservEntry1."New Expiration Date" := TrackingSpecification."New Expiration Date";
        OnAfterMoveFields(TrackingSpecification,ReservEntry1);
        ReservEntry1.MODIFY;
      UNTIL ReservEntry1.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
        ReservEntry1.MODIFY;
      UNTIL ReservEntry1.NEXT = 0;
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ReservationMgt) (VariableCollection) on "SetQtyToHandleAndInvoice(PROCEDURE 7)".



    //Unsupported feature: Code Modification on "SetQtyToHandleAndInvoice(PROCEDURE 7)".

    //procedure SetQtyToHandleAndInvoice();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF IsCorrection THEN
      EXIT;

    TotalQtyToHandle := TrackingSpecification."Qty. to Handle (Base)" * CurrentSignFactor;
    TotalQtyToInvoice := TrackingSpecification."Qty. to Invoice (Base)" * CurrentSignFactor;

    ReservEntry1.TRANSFERFIELDS(TrackingSpecification);
    ReservEntry1.SetPointerFilter;
    ReservEntry1.SetTrackingFilterFromReservEntry(ReservEntry1);
    IF TrackingSpecification.TrackingExists THEN BEGIN
      ItemTrackingMgt.SetPointerFilter(TrackingSpecification);
      TrackingSpecification.SetTrackingFilterFromSpec(TrackingSpecification);
      IF TrackingSpecification.FIND('-') THEN
        REPEAT
          IF NOT TrackingSpecification.Correction THEN BEGIN
            QtyToInvoiceThisLine :=
              TrackingSpecification."Quantity Handled (Base)" - TrackingSpecification."Quantity Invoiced (Base)";
            IF ABS(QtyToInvoiceThisLine) > ABS(TotalQtyToInvoice) THEN
              QtyToInvoiceThisLine := TotalQtyToInvoice;
            IF TrackingSpecification."Qty. to Invoice (Base)" <> QtyToInvoiceThisLine THEN BEGIN
              TrackingSpecification."Qty. to Invoice (Base)" := QtyToInvoiceThisLine;
              OnSetQtyToHandleAndInvoiceOnBeforeTrackingSpecModify(TrackingSpecification);
              TrackingSpecification.MODIFY;
            END;
            TotalQtyToInvoice -= QtyToInvoiceThisLine;
          END;
        UNTIL (TrackingSpecification.NEXT = 0);
    END;

    IF TrackingSpecification."Lot No." <> '' THEN BEGIN
      IF (TrackingSpecification."Source Type" = DATABASE::"Transfer Line") AND
         (TrackingSpecification."Source Subtype" = 1) AND
         (TrackingSpecification."Source Prod. Order Line" <> 0) // Shipped
      THEN
        ReservEntry1.SETRANGE("Source Ref. No.");

      FOR ReservEntry1."Reservation Status" := ReservEntry1."Reservation Status"::Reservation TO
          ReservEntry1."Reservation Status"::Prospect
      DO BEGIN
        ReservEntry1.SETRANGE("Reservation Status",ReservEntry1."Reservation Status");
    #41..52
            THEN BEGIN
              ReservEntry1."Qty. to Handle (Base)" := QtyToHandleThisLine;
              ReservEntry1."Qty. to Invoice (Base)" := QtyToInvoiceThisLine;
              OnSetQtyToHandleAndInvoiceOnBeforeReservEntryModify(ReservEntry1,TrackingSpecification);
              ReservEntry1.MODIFY;
            END;
            TotalQtyToHandle -= QtyToHandleThisLine;
            TotalQtyToInvoice -= QtyToInvoiceThisLine;
          UNTIL (ReservEntry1.NEXT = 0);
      END
    END ELSE
      IF ReservEntry1.FIND('-') THEN
        IF (ReservEntry1."Qty. to Handle (Base)" <> TotalQtyToHandle) OR
           (ReservEntry1."Qty. to Invoice (Base)" <> TotalQtyToInvoice) AND NOT ReservEntry1.Correction
        THEN BEGIN
          ReservEntry1."Qty. to Handle (Base)" := TotalQtyToHandle;
          ReservEntry1."Qty. to Invoice (Base)" := TotalQtyToInvoice;
          OnSetQtyToHandleAndInvoiceOnBeforeReservEntryModify(ReservEntry1,TrackingSpecification);
          ReservEntry1.MODIFY;
        END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    ReservationMgt.SetPointerFilter(ReservEntry1);
    ReservEntry1.SETRANGE("Lot No.",ReservEntry1."Lot No.");
    ReservEntry1.SETRANGE("Serial No.",ReservEntry1."Serial No.");
    IF TrackingSpecification.TrackingExists THEN BEGIN
      ItemTrackingMgt.SetPointerFilter(TrackingSpecification);
      TrackingSpecification.SETRANGE("Lot No.",TrackingSpecification."Lot No.");
      TrackingSpecification.SETRANGE("Serial No.",TrackingSpecification."Serial No.");

    #13..19

            IF TrackingSpecification."Qty. to Invoice (Base)" <> QtyToInvoiceThisLine THEN BEGIN
              TrackingSpecification."Qty. to Invoice (Base)" := QtyToInvoiceThisLine;
              TrackingSpecification.MODIFY;
            END;

    #25..29
    IF TrackingSpecification."Lot No." <> '' THEN
      FOR ReservEntry1."Reservation Status" := ReservEntry1."Reservation Status"::Tracking TO
    #38..55
              ReservEntry1.MODIFY;
            END;

            TotalQtyToHandle -= QtyToHandleThisLine;
            TotalQtyToInvoice -= QtyToInvoiceThisLine;

          UNTIL (ReservEntry1.NEXT = 0);
      END
    ELSE
    #64..69
          ReservEntry1.MODIFY;
        END;
    */
    //end;


    //Unsupported feature: Code Modification on "CollectPostedTransferEntries(PROCEDURE 16)".

    //procedure CollectPostedTransferEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    // Used for collecting information about posted Transfer Shipments from the created Item Ledger Entries.
    IF TrackingSpecification."Source Type" <> DATABASE::"Transfer Line" THEN
      EXIT;
    #4..18
        TempTrackingSpecification := TrackingSpecification;
        TempTrackingSpecification."Entry No." := ItemLedgerEntry."Entry No.";
        TempTrackingSpecification."Item No." := ItemLedgerEntry."Item No.";
        TempTrackingSpecification.CopyTrackingFromItemLedgEntry(ItemLedgerEntry);
        TempTrackingSpecification."Quantity (Base)" := ItemLedgerEntry.Quantity;
        TempTrackingSpecification."Quantity Handled (Base)" := ItemLedgerEntry.Quantity;
        TempTrackingSpecification."Quantity Invoiced (Base)" := ItemLedgerEntry.Quantity;
        TempTrackingSpecification."Qty. per Unit of Measure" := ItemLedgerEntry."Qty. per Unit of Measure";
        TempTrackingSpecification.InitQtyToShip;
        OnBeforeCollectTempTrackingSpecificationInsert(TempTrackingSpecification,ItemLedgerEntry,TrackingSpecification);
        TempTrackingSpecification.INSERT;
      UNTIL ItemEntryRelation.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..21
        TempTrackingSpecification."Serial No." := ItemLedgerEntry."Serial No.";
        TempTrackingSpecification."Lot No." := ItemLedgerEntry."Lot No.";
    #23..27
        TempTrackingSpecification.INSERT;
      UNTIL ItemEntryRelation.NEXT = 0;
    */
    //end;


    //Unsupported feature: Code Modification on "CollectPostedAssemblyEntries(PROCEDURE 38)".

    //procedure CollectPostedAssemblyEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    // Used for collecting information about posted Assembly Lines from the created Item Ledger Entries.
    IF (TrackingSpecification."Source Type" <> DATABASE::"Assembly Line") AND
       (TrackingSpecification."Source Type" <> DATABASE::"Assembly Header")
    #4..17
        TempTrackingSpecification := TrackingSpecification;
        TempTrackingSpecification."Entry No." := ItemLedgerEntry."Entry No.";
        TempTrackingSpecification."Item No." := ItemLedgerEntry."Item No.";
        TempTrackingSpecification.CopyTrackingFromItemLedgEntry(ItemLedgerEntry);
        TempTrackingSpecification."Quantity (Base)" := ItemLedgerEntry.Quantity;
        TempTrackingSpecification."Quantity Handled (Base)" := ItemLedgerEntry.Quantity;
        TempTrackingSpecification."Quantity Invoiced (Base)" := ItemLedgerEntry.Quantity;
        TempTrackingSpecification."Qty. per Unit of Measure" := ItemLedgerEntry."Qty. per Unit of Measure";
        TempTrackingSpecification.InitQtyToShip;
        OnBeforeCollectTempTrackingSpecificationInsert(TempTrackingSpecification,ItemLedgerEntry,TrackingSpecification);
        TempTrackingSpecification.INSERT;
      UNTIL ItemEntryRelation.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..20
        TempTrackingSpecification."Serial No." := ItemLedgerEntry."Serial No.";
        TempTrackingSpecification."Lot No." := ItemLedgerEntry."Lot No.";
    #22..26
        TempTrackingSpecification.INSERT;
      UNTIL ItemEntryRelation.NEXT = 0;
    */
    //end;


    //Unsupported feature: Code Modification on "CollectPostedOutputEntries(PROCEDURE 30)".

    //procedure CollectPostedOutputEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    // Used for collecting information about posted prod. order output from the created Item Ledger Entries.
    IF TrackingSpecification."Source Type" <> DATABASE::"Prod. Order Line" THEN
      EXIT;
    #4..23
        TempTrackingSpecification := TrackingSpecification;
        TempTrackingSpecification."Entry No." := ItemLedgerEntry."Entry No.";
        TempTrackingSpecification."Item No." := ItemLedgerEntry."Item No.";
        TempTrackingSpecification.CopyTrackingFromItemLedgEntry(ItemLedgerEntry);
        TempTrackingSpecification."Quantity (Base)" := ItemLedgerEntry.Quantity;
        TempTrackingSpecification."Quantity Handled (Base)" := ItemLedgerEntry.Quantity;
        TempTrackingSpecification."Quantity Invoiced (Base)" := ItemLedgerEntry.Quantity;
        TempTrackingSpecification."Qty. per Unit of Measure" := ItemLedgerEntry."Qty. per Unit of Measure";
        TempTrackingSpecification.InitQtyToShip;
        OnBeforeCollectTempTrackingSpecificationInsert(TempTrackingSpecification,ItemLedgerEntry,TrackingSpecification);
        TempTrackingSpecification.INSERT;

        IF BackwardFlushing THEN BEGIN
    #37..39
        END;

      UNTIL ItemLedgerEntry.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..26
        TempTrackingSpecification."Serial No." := ItemLedgerEntry."Serial No.";
        TempTrackingSpecification."Lot No." := ItemLedgerEntry."Lot No.";
    #28..32
    #34..42
    */
    //end;


    //Unsupported feature: Code Modification on "ZeroLineExists(PROCEDURE 18)".

    //procedure ZeroLineExists();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Quantity (Base)" <> 0) OR TrackingExists THEN
      EXIT(FALSE);
    xTrackingSpec.COPY(Rec);
    RESET;
    SETRANGE("Quantity (Base)",0);
    SetTrackingFilter('','');
    OK := NOT ISEMPTY;
    COPY(xTrackingSpec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    SETRANGE("Serial No.",'');
    SETRANGE("Lot No.",'');
    OK := NOT ISEMPTY;
    COPY(xTrackingSpec);
    */
    //end;


    //Unsupported feature: Code Modification on "AssignSerialNoBatch(PROCEDURE 29)".

    //procedure AssignSerialNoBatch();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF QtyToCreate <= 0 THEN
      ERROR(Text009);
    IF QtyToCreate MOD 1 <> 0 THEN
    #4..6

    IF CreateLotNo THEN BEGIN
      TESTFIELD("Lot No.",'');
      AssignNewLotNo;
      OnAfterAssignNewTrackingNo(Rec,xRec,FIELDNO("Lot No."));
    END;

    Item.TESTFIELD("Serial Nos.");
    ItemTrackingDataCollection.SetSkipLot(TRUE);
    FOR i := 1 TO QtyToCreate DO BEGIN
      VALIDATE("Quantity Handled (Base)",0);
      VALIDATE("Quantity Invoiced (Base)",0);
      VALIDATE("Serial No.",NoSeriesMgt.GetNextNo(Item."Serial Nos.",WORKDATE,TRUE));
      OnAfterAssignNewTrackingNo(Rec,xRec,FIELDNO("Serial No."));
      VALIDATE("Quantity (Base)",QtySignFactor);
      "Entry No." := NextEntryNo;
      IF TestTempSpecificationExists THEN
        ERROR('');
      INSERT;

      OnAssignSerialNoBatchOnAfterInsert(Rec);

      TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
      TempItemTrackLineInsert.INSERT;
      IF i = QtyToCreate THEN
        ItemTrackingDataCollection.SetSkipLot(FALSE);
      ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
        TempItemTrackLineInsert,CurrentSignFactor * SourceQuantityArray[1] < 0,CurrentSignFactor,0);
    END;
    CalculateSums;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
      Item.TESTFIELD("Lot Nos.");
      VALIDATE("Lot No.",NoSeriesMgt.GetNextNo(Item."Lot Nos.",WORKDATE,TRUE));
    #12..19
    #21..25
    #29..32
      ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
    #34..36
    */
    //end;


    //Unsupported feature: Code Modification on "AssignLotNo(PROCEDURE 21)".

    //procedure AssignLotNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ZeroLineExists THEN
      DELETE;

    #4..9

    GetItem("Item No.");

    VALIDATE("Quantity Handled (Base)",0);
    VALIDATE("Quantity Invoiced (Base)",0);
    AssignNewLotNo;
    OnAfterAssignNewTrackingNo(Rec,xRec,FIELDNO("Lot No."));
    "Qty. per Unit of Measure" := QtyPerUOM;
    VALIDATE("Quantity (Base)",QtyToCreate);
    "Entry No." := NextEntryNo;
    TestTempSpecificationExists;
    INSERT;

    OnAssignLotNoOnAfterInsert(Rec);

    TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
    TempItemTrackLineInsert.INSERT;
    ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
      TempItemTrackLineInsert,CurrentSignFactor * SourceQuantityArray[1] < 0,CurrentSignFactor,0);
    CalculateSums;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
    Item.TESTFIELD("Lot Nos.");
    VALIDATE("Quantity Handled (Base)",0);
    VALIDATE("Quantity Invoiced (Base)",0);
    VALIDATE("Lot No.",NoSeriesMgt.GetNextNo(Item."Lot Nos.",WORKDATE,TRUE));
    #17..21
    TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
    TempItemTrackLineInsert.INSERT;
    ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
      TempItemTrackLineInsert,CurrentSignFactor * SourceQuantityArray[1] < 0,CurrentSignFactor,0);
    CalculateSums;
    */
    //end;


    //Unsupported feature: Code Modification on "CreateCustomizedSNBatch(PROCEDURE 28)".

    //procedure CreateCustomizedSNBatch();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TextManagement.EvaluateIncStr(CustomizedSN,CustomizedSN);
    NoSeriesMgt.TestManual(Item."Serial Nos.");

    #4..7

    IF CreateLotNo THEN BEGIN
      TESTFIELD("Lot No.",'');
      AssignNewLotNo;
      OnAfterAssignNewTrackingNo(Rec,xRec,FIELDNO("Lot No."));
    END;

    FOR i := 1 TO QtyToCreate DO BEGIN
      VALIDATE("Quantity Handled (Base)",0);
      VALIDATE("Quantity Invoiced (Base)",0);
      VALIDATE("Serial No.",CustomizedSN);
      OnAfterAssignNewTrackingNo(Rec,xRec,FIELDNO("Serial No."));
      VALIDATE("Quantity (Base)",QtySignFactor);
      "Entry No." := NextEntryNo;
      IF TestTempSpecificationExists THEN
        ERROR('');
      INSERT;
      TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
      TempItemTrackLineInsert.INSERT;
      ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
        TempItemTrackLineInsert,CurrentSignFactor * SourceQuantityArray[1] < 0,CurrentSignFactor,0);
      IF i < QtyToCreate THEN BEGIN
        Counter := Increment;
    #31..34
      END;
    END;
    CalculateSums;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
      Item.TESTFIELD("Lot Nos.");
      VALIDATE("Lot No.",NoSeriesMgt.GetNextNo(Item."Lot Nos.",WORKDATE,TRUE));
    #13..18
    #20..26
      ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
    #28..37
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: TempSpecification) (VariableCollection) on "TestTempSpecificationExists(PROCEDURE 23)".



    //Unsupported feature: Code Modification on "TestTempSpecificationExists(PROCEDURE 23)".

    //procedure TestTempSpecificationExists();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TrackingSpecification.COPY(Rec);
    SETCURRENTKEY("Lot No.","Serial No.");
    SETRANGE("Serial No.","Serial No.");
    IF "Serial No." = '' THEN
      SETRANGE("Lot No.","Lot No.");
    SETFILTER("Entry No.",'<>%1',"Entry No.");
    SETRANGE("Buffer Status",0);
    Exists := NOT ISEMPTY;
    COPY(TrackingSpecification);
    IF Exists AND CurrentPageIsOpen THEN
      IF "Serial No." = '' THEN
        MESSAGE(Text011,"Serial No.","Lot No.")
      ELSE
        MESSAGE(Text012,"Serial No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TempSpecification.COPY(Rec);
    #2..8
    COPY(TempSpecification);
    IF Exists AND CurrentFormIsOpen THEN
      IF "Serial No." = '' THEN
        MESSAGE(
          Text011,
          "Serial No.",
          "Lot No.")
      ELSE
        MESSAGE(
          Text012,
          "Serial No.");
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "RegisterItemTrackingLines(PROCEDURE 27)".



    //Unsupported feature: Code Modification on "RegisterItemTrackingLines(PROCEDURE 27)".

    //procedure RegisterItemTrackingLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SourceSpecification.TESTFIELD("Source Type"); // Check if source has been set.
    IF NOT CalledFromSynchWhseItemTrkg THEN
      TempTrackingSpecification.RESET;
    IF NOT TempTrackingSpecification.FIND('-') THEN
      EXIT;

    IsCorrection := SourceSpecification.Correction;
    ExcludePostedEntries := TRUE;
    SetSourceSpec(SourceSpecification,AvailabilityDate);
    RESET;
    SETCURRENTKEY("Lot No.","Serial No.");

    REPEAT
      SetTrackingFilterFromSpec(TempTrackingSpecification);
      IF FIND('-') THEN BEGIN
        IF IsCorrection THEN BEGIN
          "Quantity (Base)" += TempTrackingSpecification."Quantity (Base)";
          "Qty. to Handle (Base)" += TempTrackingSpecification."Qty. to Handle (Base)";
          "Qty. to Invoice (Base)" += TempTrackingSpecification."Qty. to Invoice (Base)";
        END ELSE
          VALIDATE("Quantity (Base)","Quantity (Base)" + TempTrackingSpecification."Quantity (Base)");
        MODIFY;
      END ELSE BEGIN
        TRANSFERFIELDS(SourceSpecification);
        "Serial No." := TempTrackingSpecification."Serial No.";
        "Lot No." := TempTrackingSpecification."Lot No.";
        "Warranty Date" := TempTrackingSpecification."Warranty Date";
        "Expiration Date" := TempTrackingSpecification."Expiration Date";
        IF FormRunMode = FormRunMode::Reclass THEN BEGIN
          "New Serial No." := TempTrackingSpecification."New Serial No.";
          "New Lot No." := TempTrackingSpecification."New Lot No.";
          "New Expiration Date" := TempTrackingSpecification."New Expiration Date"
        END;
        OnAfterCopyTrackingSpec(TempTrackingSpecification,Rec);
        VALIDATE("Quantity (Base)",TempTrackingSpecification."Quantity (Base)");
        "Entry No." := NextEntryNo;
        INSERT;
      END;
    UNTIL TempTrackingSpecification.NEXT = 0;
    OnAfterRegisterItemTrackingLines(SourceSpecification,TempTrackingSpecification,Rec,AvailabilityDate);

    RESET;
    IF FIND('-') THEN
      REPEAT
        CheckLine(Rec);
      UNTIL NEXT = 0;

    SetTrackingFilterFromSpec(SourceSpecification);

    CalculateSums;
    IF UpdateUndefinedQty THEN
      WriteToDatabase
    ELSE
      ERROR(Text014,TotalItemTrackingLine."Quantity (Base)",
        LOWERCASE(TempReservEntry.TextCaption),SourceQuantityArray[1]);

    // Copy to inbound part of transfer
    IF (FormRunMode = FormRunMode::Transfer) OR IsOrderToOrderBindingToTransfer THEN
      SynchronizeLinkedSources('');
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SourceSpecification.TESTFIELD("Source Type"); // Check if source has been set.
    IF NOT CalledFromSynchWhseItemTrkg THEN
      TempSpecification.RESET;
    IF NOT TempSpecification.FIND('-') THEN
    #5..8
    SetSource(SourceSpecification,AvailabilityDate);
    #10..13
      SETRANGE("Lot No.",TempSpecification."Lot No.");
      SETRANGE("Serial No.",TempSpecification."Serial No.");
      IF FIND('-') THEN BEGIN
        IF IsCorrection THEN BEGIN
          "Quantity (Base)" :=
            "Quantity (Base)" + TempSpecification."Quantity (Base)";
          "Qty. to Handle (Base)" :=
            "Qty. to Handle (Base)" + TempSpecification."Qty. to Handle (Base)";
          "Qty. to Invoice (Base)" :=
            "Qty. to Invoice (Base)" + TempSpecification."Qty. to Invoice (Base)";
        END ELSE
          VALIDATE("Quantity (Base)",
            "Quantity (Base)" + TempSpecification."Quantity (Base)");
    #22..24
        "Serial No." := TempSpecification."Serial No.";
        "Lot No." := TempSpecification."Lot No.";
        "Warranty Date" := TempSpecification."Warranty Date";
        "Expiration Date" := TempSpecification."Expiration Date";
        IF FormRunMode = FormRunMode::Reclass THEN BEGIN
          "New Serial No." := TempSpecification."New Serial No.";
          "New Lot No." := TempSpecification."New Lot No.";
          "New Expiration Date" := TempSpecification."New Expiration Date"
        END;
        VALIDATE("Quantity (Base)",TempSpecification."Quantity (Base)");
    #36..38
    UNTIL TempSpecification.NEXT = 0;
    #42..47
    SETRANGE("Lot No.",SourceSpecification."Lot No.");
    SETRANGE("Serial No.",SourceSpecification."Serial No.");
    #49..57
    IF FormRunMode = FormRunMode::Transfer THEN
      SynchronizeLinkedSources('');
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SynchronizeLinkedSources(PROCEDURE 31)".


    //Unsupported feature: Property Insertion (Local) on "SynchronizeLinkedSources(PROCEDURE 31)".



    //Unsupported feature: Code Modification on "SynchronizeLinkedSources(PROCEDURE 31)".

    //procedure SynchronizeLinkedSources();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CurrentSourceRowID = '' THEN
      EXIT(FALSE);
    IF SecondSourceRowID = '' THEN
      EXIT(FALSE);

    ItemTrackingMgt.SynchronizeItemTracking(CurrentSourceRowID,SecondSourceRowID,DialogText);

    OnAfterSynchronizeLinkedSources(FormRunMode,CurrentSourceType,CurrentSourceRowID,SecondSourceRowID);
    EXIT(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    EXIT(TRUE);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetBlockCommit(PROCEDURE 33)".


    //Unsupported feature: Property Deletion (Attributes) on "SetCalledFromSynchWhseItemTrkg(PROCEDURE 39)".



    //Unsupported feature: Code Modification on "SetCalledFromSynchWhseItemTrkg(PROCEDURE 39)".

    //procedure SetCalledFromSynchWhseItemTrkg();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CalledFromSynchWhseItemTrkg := CalledFromSynchWhseItemTrkg2;
    BlockCommit := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CalledFromSynchWhseItemTrkg := CalledFromSynchWhseItemTrkg2;
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateExpDateEditable(PROCEDURE 42)".

    //procedure UpdateExpDateEditable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ExpirationDateEditable :=
      NOT (("Buffer Status2" = "Buffer Status2"::"ExpDate blocked") OR (CurrentSignFactor < 0));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Expiration DateEditable" :=
      NOT (("Buffer Status2" = "Buffer Status2"::"ExpDate blocked") OR (CurrentSignFactor < 0));
    */
    //end;


    //Unsupported feature: Code Modification on "LookupAvailable(PROCEDURE 43)".

    //procedure LookupAvailable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Bin Code" := ForBinCode;
    ItemTrackingDataCollection.LookupTrackingAvailability(Rec,LookupMode);
    "Bin Code" := '';
    CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Bin Code" := ForBinCode;
    ItemTrackingDataCollection.LookupLotSerialNoAvailability(Rec,LookupMode);
    "Bin Code" := '';
    CurrPage.UPDATE;
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "TrackingAvailable(PROCEDURE 45)".



    //Unsupported feature: Code Modification on "TrackingAvailable(PROCEDURE 45)".

    //procedure TrackingAvailable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    EXIT(ItemTrackingDataCollection.TrackingAvailable(TrackingSpecification,LookupMode));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EXIT(ItemTrackingDataCollection.LotSNAvailable(TrackingSpecification,LookupMode));
    */
    //end;


    //Unsupported feature: Code Modification on "SelectEntries(PROCEDURE 36)".

    //procedure SelectEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    xTrackingSpec.COPYFILTERS(Rec);
    MaxQuantity := UndefinedQtyArray[1];
    IF MaxQuantity * CurrentSignFactor > 0 THEN
      MaxQuantity := 0;
    "Bin Code" := ForBinCode;
    ItemTrackingDataCollection.SelectMultipleTrackingNo(Rec,MaxQuantity,CurrentSignFactor);
    "Bin Code" := '';
    IF FINDSET THEN
      REPEAT
    #10..13
                TempItemTrackLineModify.DELETE;
              IF TempItemTrackLineInsert.GET("Entry No.") THEN BEGIN
                TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
                OnSelectEntriesOnAfterTransferFields(TempItemTrackLineInsert,Rec);
                TempItemTrackLineInsert.MODIFY;
              END ELSE BEGIN
                TempItemTrackLineModify.TRANSFERFIELDS(Rec);
                OnSelectEntriesOnAfterTransferFields(TempItemTrackLineModify,Rec);
                TempItemTrackLineModify.INSERT;
              END;
            END;
          "Buffer Status"::INSERT:
            BEGIN
              TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
              OnSelectEntriesOnAfterTransferFields(TempItemTrackLineInsert,Rec);
              TempItemTrackLineInsert.INSERT;
            END;
        END;
    #32..36
    UpdateUndefinedQtyArray;
    COPYFILTERS(xTrackingSpec);
    CurrPage.UPDATE(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    ItemTrackingDataCollection.SelectMultipleLotSerialNo(Rec,MaxQuantity,CurrentSignFactor);
    #7..16
    #18..20
    #22..27
    #29..39
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetInbound(PROCEDURE 48)".



    //Unsupported feature: Code Modification on "SerialNoOnAfterValidate(PROCEDURE 19074494)".

    //procedure SerialNoOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSerialNoOnAfterValidate(Rec);

    UpdateExpDateEditable;
    CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UpdateExpDateEditable;
    CurrPage.UPDATE;
    */
    //end;


    //Unsupported feature: Code Modification on "QuantityBaseOnValidate(PROCEDURE 19070694)".

    //procedure QuantityBaseOnValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckLine(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT CheckLine(Rec) THEN
      EXIT;
    */
    //end;


    //Unsupported feature: Code Modification on "GetHandleSource(PROCEDURE 37)".

    //procedure GetHandleSource();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH TrackingSpecification DO BEGIN
      IF ("Source Type" = DATABASE::"Item Journal Line") AND ("Source Subtype" = 6) THEN BEGIN // 6 => Prod.order line directly
        ProdOrderLineHandling := TRUE;
        EXIT(TRUE);  // Display Handle column for prod. orders
      END;

      // Prod. order line via inventory put-away
      IF "Source Type" = DATABASE::"Prod. Order Line" THEN BEGIN
        WhseActivLine.SetSourceFilter("Source Type","Source Subtype","Source ID","Source Prod. Order Line","Source Ref. No.",TRUE);
        WhseActivLine.SETRANGE("Activity Type",WhseActivLine."Activity Type"::"Invt. Put-away");
        IF NOT WhseActivLine.ISEMPTY THEN BEGIN
          ProdOrderLineHandling := TRUE;
          EXIT(TRUE);
        END;
      END;

      QtyToHandleColumnIsHidden :=
        ("Source Type" IN
         [DATABASE::"Item Ledger Entry",
          DATABASE::"Item Journal Line",
          DATABASE::"Job Journal Line",
          DATABASE::"Requisition Line"]) OR
        (("Source Type" IN [DATABASE::"Sales Line",DATABASE::"Purchase Line",DATABASE::"Service Line"]) AND
         ("Source Subtype" IN [0,2,3])) OR
        (("Source Type" = DATABASE::"Assembly Line") AND ("Source Subtype" = 0));
    END;
    OnAfterGetHandleSource(TrackingSpecification,QtyToHandleColumnIsHidden);
    EXIT(NOT QtyToHandleColumnIsHidden);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH TrackingSpecification DO BEGIN
      IF ("Source Type" = DATABASE::"Item Journal Line") AND ("Source Subtype" = 6) THEN BEGIN // 6 => Prod.order line
    #3..5
    #17..26
    EXIT(NOT QtyToHandleColumnIsHidden);
    */
    //end;


    //Unsupported feature: Code Modification on "GetInvoiceSource(PROCEDURE 50)".

    //procedure GetInvoiceSource();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH TrackingSpecification DO BEGIN
      QtyToInvoiceColumnIsHidden :=
        ("Source Type" IN
    #4..12
        (("Source Type" IN [DATABASE::"Sales Line",DATABASE::"Purchase Line",DATABASE::"Service Line"]) AND
         ("Source Subtype" IN [0,2,3,4]))
    END;
    OnAfterGetInvoiceSource(TrackingSpecification,QtyToInvoiceColumnIsHidden);
    EXIT(NOT QtyToInvoiceColumnIsHidden);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..15
    EXIT(NOT QtyToInvoiceColumnIsHidden);
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: IsPick2) (ParameterCollection) on "SetPick(PROCEDURE 34)".


    //Unsupported feature: Property Deletion (Local) on "NotifyWhenTrackingIsManagedByWhse(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Name) on "NotifyWhenTrackingIsManagedByWhse(PROCEDURE 34)".



    //Unsupported feature: Code Modification on "NotifyWhenTrackingIsManagedByWhse(PROCEDURE 34)".

    //procedure NotifyWhenTrackingIsManagedByWhse();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ItemTrackingManagedByWhse THEN BEGIN
      TrkgManagedByWhseNotification.ID := CREATEGUID;
      TrkgManagedByWhseNotification.MESSAGE(ItemTrkgManagedByWhseMsg);
      TrkgManagedByWhseNotification.SCOPE(NOTIFICATIONSCOPE::LocalScope);
      TrkgManagedByWhseNotification.SEND;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IsPick := IsPick2;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "OnAfterCreateReservEntryFor(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Name) on "OnAfterCreateReservEntryFor(PROCEDURE 35)".



    //Unsupported feature: Code Modification on "OnAfterCreateReservEntryFor(PROCEDURE 35)".

    //procedure OnAfterCreateReservEntryFor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Rec := NewTrackingSpecification;
    "Entry No." := NextEntryNo;
    IF (NOT InsertIsBlocked) AND (NOT ZeroLineExists) THEN
      IF NOT TestTempSpecificationExists THEN
        INSERT
      ELSE
        ModifyTrackingSpecification(NewTrackingSpecification);
    WriteToDatabase;
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: CrntTempTrackingSpec) (VariableCollection) on "ModifyTrackingSpecification(PROCEDURE 40)".


    //Unsupported feature: Property Deletion (Attributes) on "OnAfterGetHandleSource(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Name) on "OnAfterGetHandleSource(PROCEDURE 40)".



    //Unsupported feature: Code Modification on "OnAfterGetHandleSource(PROCEDURE 40)".

    //procedure OnAfterGetHandleSource();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CrntTempTrackingSpec.COPY(Rec);
    SETCURRENTKEY("Lot No.","Serial No.");
    SETRANGE("Lot No.",NewTrackingSpecification."Lot No.");
    SETRANGE("Serial No.",NewTrackingSpecification."Serial No.");
    SETFILTER("Entry No.",'<>%1',"Entry No.");
    SETRANGE("Buffer Status",0);
    IF FIND('-') THEN BEGIN
      VALIDATE("Quantity (Base)",
        "Quantity (Base)" + NewTrackingSpecification."Quantity (Base)");
      MODIFY;
    END;
    COPY(CrntTempTrackingSpec);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "OnRegisterChangeOnAfterCreateReservEntry(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Name) on "OnRegisterChangeOnAfterCreateReservEntry(PROCEDURE 44)".



    //Unsupported feature: Code Modification on "OnRegisterChangeOnAfterCreateReservEntry(PROCEDURE 44)".

    //procedure OnRegisterChangeOnAfterCreateReservEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF SNAvailabilityActive THEN
      LookupAvailable(0);
    IF LotAvailabilityActive THEN
      LookupAvailable(1);
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: LateBindingMgt) (VariableCollection) on "ReserveItemTrackingLine(PROCEDURE 46)".


    //Unsupported feature: Property Deletion (Attributes) on "OnSelectEntriesOnAfterTransferFields(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Name) on "OnSelectEntriesOnAfterTransferFields(PROCEDURE 46)".



    //Unsupported feature: Code Modification on "OnSelectEntriesOnAfterTransferFields(PROCEDURE 46)".

    //procedure OnSelectEntriesOnAfterTransferFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    LateBindingMgt.ReserveItemTrackingLine(Rec);
    */
    //end;

    local procedure ReestablishReservations()
    var
        LateBindingMgt: Codeunit "Late Binding Management";
    begin
        if TempItemTrackLineReserv.FindSet then
            repeat
            // LateBindingMgt.ReserveItemTrackingLine2(TempItemTrackLineReserv,0,TempItemTrackLineReserv."Quantity (Base)");
            // SetQtyToHandleAndInvoice(TempItemTrackLineReserv);
            until TempItemTrackLineReserv.Next = 0;
        TempItemTrackLineReserv.DeleteAll;
    end;

    //Unsupported feature: Property Modification (OptionString) on "SetSourceSpec(PROCEDURE 1).Controls(Variable 1003)".


    //Unsupported feature: Property Modification (Length) on "SetSecondSourceRowID(PROCEDURE 32).RowID(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "AddReservEntriesToTempRecSet(PROCEDURE 15).FromReservEntry(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "AddReservEntriesToTempRecSet(PROCEDURE 15).AddTracking(Variable 1005)".


    //Unsupported feature: Property Modification (OptionString) on "SetControls(PROCEDURE 13).Controls(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateUndefinedQty(PROCEDURE 5).IsHandled(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateUndefinedQty(PROCEDURE 5).ReturnValue(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateOrderTrackingAndReestablishReservation(PROCEDURE 26).LateBindingMgt(Variable 1001)".


    //Unsupported feature: Property Modification (Length) on "CreateCustomizedSN(PROCEDURE 22).CustomizedSN(Variable 1006)".


    //Unsupported feature: Property Modification (Length) on "CreateCustomizedSNBatch(PROCEDURE 28).CustomizedSN(Parameter 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "TestTempSpecificationExists(PROCEDURE 23).TrackingSpecification(Variable 1004)".


    //Unsupported feature: Property Modification (Name) on "RegisterItemTrackingLines(PROCEDURE 27).TempTrackingSpecification(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "GetHandleSource(PROCEDURE 37).WhseActivLine(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "NotifyWhenTrackingIsManagedByWhse(PROCEDURE 34).TrkgManagedByWhseNotification(Variable 1001)".


    //Unsupported feature: Property Deletion (AsVar) on "OnAfterCreateReservEntryFor(PROCEDURE 35).OldTrackingSpecification(Parameter 1000)".


    //Unsupported feature: Property Modification (Name) on "OnAfterCreateReservEntryFor(PROCEDURE 35).OldTrackingSpecification(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterCreateReservEntryFor(PROCEDURE 35).NewTrackingSpecification(Parameter 1001)".


    //Unsupported feature: Property Modification (Name) on "OnAfterGetHandleSource(PROCEDURE 40).TrackingSpecification(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterGetHandleSource(PROCEDURE 40).QtyToHandleColumnIsHidden(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnRegisterChangeOnAfterCreateReservEntry(PROCEDURE 44).ReservEntry(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnRegisterChangeOnAfterCreateReservEntry(PROCEDURE 44).TrackingSpecification(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnRegisterChangeOnAfterCreateReservEntry(PROCEDURE 44).OldTrackingSpecification(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnSelectEntriesOnAfterTransferFields(PROCEDURE 46).TempTrackingSpec(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnSelectEntriesOnAfterTransferFields(PROCEDURE 46).TrackingSpecification(Parameter 1001)".


    //Unsupported feature: Property Deletion (DelayedInsert).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
