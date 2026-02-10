#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186609 pageextension52186609 extends "Service Lines"
{
    layout
    {
        modify(SelectionFilter)
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Line Description")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Nonstock)
        {
            ApplicationArea = Basic;
        }
        modify("Substitution Available")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Description 2")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify(Control134)
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Reserved Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Price")
        {
            ApplicationArea = Basic;
        }
        modify("Line Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount Type")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Ship")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Shipped")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Invoice")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Invoiced")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Consume")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Consumed")
        {
            ApplicationArea = Basic;
        }
        modify("Job Remaining Qty.")
        {
            ApplicationArea = Basic;
        }
        modify("Job Remaining Total Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Job Remaining Total Cost (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Job Remaining Line Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
        {
            ApplicationArea = Basic;
        }
        modify("Fault Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Fault Area Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Fault Area Code"(Control 20)".

        }
        modify("Symptom Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Symptom Code"(Control 60)".

        }
        modify("Fault Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Fault Code"(Control 76)".

        }
        modify("Resolution Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Resolution Code"(Control 119)".

        }
        modify("Serv. Price Adjmt. Gr. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Invoice Disc.")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Exclude Warranty")
        {
            ApplicationArea = Basic;
        }
        modify("Exclude Contract Discount")
        {
            ApplicationArea = Basic;
        }
        modify(Warranty)
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Disc. %")
        {
            ApplicationArea = Basic;
        }
        modify("Contract No.")
        {
            ApplicationArea = Basic;
        }
        modify("Contract Disc. %")
        {
            ApplicationArea = Basic;
        }
        modify("VAT %")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Base Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Including VAT")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Planned Delivery Date")
        {
            ApplicationArea = Basic;
        }
        modify("Needed by Date")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Job Task No.")
        {
            ApplicationArea = Basic;
        }
        modify("Job Planning Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Job Line Type")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[3]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[4]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[5]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[6]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[7]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[8]")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SelectionFilter(Control 107)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Line No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Serial No."(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Line Description"(Control 22)".


        //Unsupported feature: Code Modification on "Type(Control 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        NoOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TypeOnAfterValidate;
        NoOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 138)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 131)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Substitution Available"(Control 140)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Description 2"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control134(Control 134)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Quantity"(Control 143)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 126)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Type"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Ship"(Control 101)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Shipped"(Control 136)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Invoice"(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Invoiced"(Control 145)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Consume"(Control 124)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Consumed"(Control 130)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Remaining Qty."(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Remaining Total Cost"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Remaining Total Cost (LCY)"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Remaining Line Amount"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Reason Code"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Area Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Symptom Code"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Code"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resolution Code"(Control 119)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serv. Price Adjmt. Gr. Code"(Control 121)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exclude Warranty"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exclude Contract Discount"(Control 117)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Warranty(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Disc. %"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract No."(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract Disc. %"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT %"(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Base Amount"(Control 105)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Including VAT"(Control 103)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Group"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Planned Delivery Date"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Needed by Date"(Control 159)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 174)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Task No."(Control 176)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Planning Line No."(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Type"(Control 178)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 74)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1904739907(Control 1904739907)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Service Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("&Warranty Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("&Job Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("&Customer Card")
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("S&hipments")
        {
            ApplicationArea = Basic;
        }
        modify(Invoices)
        {
            ApplicationArea = Basic;
        }
        modify("Warehouse Shipment Lines")
        {
            Caption = 'Whse. Shipment Lines';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Warehouse Shipment Lines"(Action 21)".

        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Event")
        {
            ApplicationArea = Basic;
        }
        modify(Period)
        {
            ApplicationArea = Basic;
        }
        modify(Variant)
        {
            ApplicationArea = Basic;
        }
        modify(Location)
        {
            ApplicationArea = Basic;
        }
        modify("BOM Level")
        {
            ApplicationArea = Basic;
        }
        modify(ReservationEntries)
        {
            ApplicationArea = Basic;
        }
        modify(ItemTrackingLines)
        {
            ApplicationArea = Basic;
        }
        modify(SelectItemSubstitution)
        {

            //Unsupported feature: Property Modification (Name) on "SelectItemSubstitution(Action 17)".

            ApplicationArea = Basic;
        }
        modify("&Fault/Resol. Codes Relationships")
        {
            ApplicationArea = Basic;
        }
        modify("Order &Promising")
        {
            ApplicationArea = Basic;
        }
        modify("Insert &Ext. Texts")
        {
            ApplicationArea = Basic;
        }
        modify("Insert &Starting Fee")
        {
            ApplicationArea = Basic;
        }
        modify("Insert &Travel Fee")
        {
            ApplicationArea = Basic;
        }
        modify("S&plit Resource Line")
        {
            ApplicationArea = Basic;
        }
        modify(Reserve)
        {
            ApplicationArea = Basic;
        }
        modify("Order &Tracking")
        {
            ApplicationArea = Basic;
        }
        modify("Ca&talog Items")
        {
            Caption = 'Nonstoc&k Items';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Ca&talog Items"(Action 27)".

        }
        modify("&Create Lines from Time Sheets")
        {
            ApplicationArea = Basic;
        }
        modify("Get Price")
        {
            ApplicationArea = Basic;
        }
        modify("Adjust Service Price")
        {
            ApplicationArea = Basic;
        }
        modify("Undo Price Adjustment")
        {
            ApplicationArea = Basic;
        }
        modify("Get Li&ne Discount")
        {
            ApplicationArea = Basic;
        }
        modify("Calculate Invoice Discount")
        {
            ApplicationArea = Basic;
        }
        modify(Post)
        {
            ApplicationArea = Basic;
        }
        modify(Preview)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Ledger E&ntries"(Action 152)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Warranty Ledger Entries"(Action 153)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Job Ledger Entries"(Action 154)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Customer Card"(Action 158)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 162)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&hipments"(Action 163)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Invoices(Action 164)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse Shipment Lines"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 116)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 111)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 112)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 113)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReservationEntries(Action 115)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingLines(Action 26)".



        //Unsupported feature: Code Modification on "SelectItemSubstitution(Action 17).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        ShowItemSub;
        CurrPage.UPDATE(TRUE);
        IF (Reserve = Reserve::Always) AND ("No." <> xRec."No.") THEN BEGIN
          AutoReserve;
          CurrPage.UPDATE(FALSE);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowItemSub;
        CurrPage.UPDATE(TRUE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SelectItemSubstitution(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Fault/Resol. Codes Relationships"(Action 133)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order &Promising"(Action 185)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert &Ext. Texts"(Action 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert &Starting Fee"(Action 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert &Travel Fee"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&plit Resource Line"(Action 99)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reserve(Action 114)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order &Tracking"(Action 183)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ca&talog Items"(Action 27)".



        //Unsupported feature: Code Modification on ""&Create Lines from Time Sheets"(Action 9).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ConfirmManagement.ConfirmProcess(Text012,TRUE) THEN BEGIN
          ServHeader.GET("Document Type","Document No.");
          TimeSheetMgt.CreateServDocLinesFromTS(ServHeader);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF CONFIRM(Text012,TRUE) THEN BEGIN
        #2..4
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Create Lines from Time Sheets"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Price"(Action 172)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjust Service Price"(Action 96)".



        //Unsupported feature: Code Modification on ""Undo Price Adjustment"(Action 44).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ConfirmManagement.ConfirmProcess(Text011,TRUE) THEN BEGIN
          ServPriceMgmt.CheckServItemGrCode(Rec);
          ServPriceMgmt.ResetAdjustedLines(Rec);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF CONFIRM(Text011,FALSE) THEN BEGIN
        #2..4
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Undo Price Adjustment"(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Li&ne Discount"(Action 173)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calculate Invoice Discount"(Action 147)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Preview(Action 29)".

        addafter("&Job Ledger Entries")
        {
            separator(Action157)
            {
                Caption = '';
            }
        }
        addafter("&Customer Card")
        {
            separator(Action161)
            {
                Caption = '';
            }
        }
        addafter(Dimensions)
        {
            separator(Action128)
            {
                Caption = '';
            }
        }
        addafter(ItemTrackingLines)
        {
            separator(Action129)
            {
                Caption = '';
            }
        }
        addafter("&Fault/Resol. Codes Relationships")
        {
            separator(Action184)
            {
            }
        }
        addafter(Reserve)
        {
            separator(Action182)
            {
            }
        }
        addafter("&Create Lines from Time Sheets")
        {
            separator(Action181)
            {
            }
        }
        addafter("Adjust Service Price")
        {
            separator(Action150)
            {
            }
        }
        addafter("Calculate Invoice Discount")
        {
            separator(Action95)
            {
                Caption = '';
            }
        }
    }

    var

        "Fault Area CodeVisible": Boolean;

        "Symptom CodeVisible": Boolean;

        "Fault CodeVisible": Boolean;

        "Resolution CodeVisible": Boolean;

        IPItemEnable: Boolean;

        IPItemButtonEnable: Boolean;

        IPItemCommentPBEnable: Boolean;

        IPAvailabilityEnable: Boolean;

        IPAvailabilityTextboxEnable: Boolean;

        IPSubstitEnable: Boolean;

        IPSubstitTextboxEnable: Boolean;

        IPSalesPriceEnable: Boolean;

        IPSalesPriceTextboxEnable: Boolean;

        IPSalesLineDiscEnable: Boolean;

        IPSalesLineDiscTextboxEnable: Boolean;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(SelectionFilter);
    SelectionFilter := SelectionFilter::"Lines per Selected Service Item";
    SetSelectionFilter;

    ServMgtSetup.GET;
    CASE ServMgtSetup."Fault Reporting Level" OF
      ServMgtSetup."Fault Reporting Level"::None:
        BEGIN
          FaultAreaCodeVisible := FALSE;
          SymptomCodeVisible := FALSE;
          FaultCodeVisible := FALSE;
          ResolutionCodeVisible := FALSE;
        END;
      ServMgtSetup."Fault Reporting Level"::Fault:
        BEGIN
          FaultAreaCodeVisible := FALSE;
          SymptomCodeVisible := FALSE;
          FaultCodeVisible := TRUE;
          ResolutionCodeVisible := TRUE;
        END;
      ServMgtSetup."Fault Reporting Level"::"Fault+Symptom":
        BEGIN
          FaultAreaCodeVisible := FALSE;
          SymptomCodeVisible := TRUE;
          FaultCodeVisible := TRUE;
          ResolutionCodeVisible := TRUE;
        END;
      ServMgtSetup."Fault Reporting Level"::"Fault+Symptom+Area (IRIS)":
        BEGIN
          FaultAreaCodeVisible := TRUE;
          SymptomCodeVisible := TRUE;
          FaultCodeVisible := TRUE;
          ResolutionCodeVisible := TRUE;
        END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
          "Fault Area CodeVisible" := FALSE;
          "Symptom CodeVisible" := FALSE;
          "Fault CodeVisible" := FALSE;
          "Resolution CodeVisible" := FALSE;
    #13..15
          "Fault Area CodeVisible" := FALSE;
          "Symptom CodeVisible" := FALSE;
          "Fault CodeVisible" := TRUE;
          "Resolution CodeVisible" := TRUE;
    #20..22
          "Fault Area CodeVisible" := FALSE;
          "Symptom CodeVisible" := TRUE;
          "Fault CodeVisible" := TRUE;
          "Resolution CodeVisible" := TRUE;
    #27..29
          "Fault Area CodeVisible" := TRUE;
          "Symptom CodeVisible" := TRUE;
          "Fault CodeVisible" := TRUE;
          "Resolution CodeVisible" := TRUE;
        END;
    END;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "CalcInvDisc(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "Initialize(PROCEDURE 5)".


    //Unsupported feature: Property Deletion (Attributes) on "SetSelectionFilter(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "SetSelectionFilter(PROCEDURE 2)".

    //procedure SetSelectionFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSetSelectionFilter(SelectionFilter);
    CASE SelectionFilter OF
      SelectionFilter::"All Service Lines":
        SETRANGE("Service Item Line No.");
    #5..7
        SETRANGE("Service Item Line No.",0);
    END;
    CurrPage.UPDATE(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #2..10
    */
    //end;


    //Unsupported feature: Code Modification on "InsertExtendedText(PROCEDURE 7)".

    //procedure InsertExtendedText();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeInsertExtendedText(Rec);

    IF TransferExtendedText.ServCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
      AddExtendedText := TRUE;
      CurrPage.SAVERECORD;
      AddExtendedText := FALSE;
      TransferExtendedText.InsertServExtText(Rec);
    END;
    IF TransferExtendedText.MakeUpdate THEN
      CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF TransferExtendedText.ServCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
      CurrPage.SAVERECORD;
    #7..10
    */
    //end;

    local procedure InfopaneEnable(Value: Boolean)
    begin
        IPItemEnable := Value;
        IPItemButtonEnable := Value;
        IPItemCommentPBEnable := Value;
        IPAvailabilityEnable := Value;
        IPAvailabilityTextboxEnable := Value;
        IPSubstitEnable := Value;
        IPSubstitTextboxEnable := Value;
        IPSalesPriceEnable := Value;
        IPSalesPriceTextboxEnable := Value;
        IPSalesLineDiscEnable := Value;
        IPSalesLineDiscTextboxEnable := Value;
    end;

    local procedure TypeOnAfterValidate()
    begin
        InfopaneEnable((Rec.Type = Rec.Type::Item) and (Rec."No." <> ''));
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        InfopaneEnable((Rec.Type = Rec.Type::Item) and (Rec."No." <> ''));

        if (Rec.Reserve = Rec.Reserve::Always) and
           (Rec."Outstanding Qty. (Base)" <> 0) and
           (Rec."No." <> xRec."No.")
        then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
            CurrPage.Update(false);
        end;
    end;

    local procedure LocationCodeOnAfterValidate()
    begin
        if (Rec.Reserve = Rec.Reserve::Always) and
           (Rec."Outstanding Qty. (Base)" <> 0) and
           (Rec."Location Code" <> xRec."Location Code")
        then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
        end;
        CurrPage.Update(true);
    end;

    local procedure QuantityOnAfterValidate()
    var
        UpdateIsDone: Boolean;
    begin
        if Rec.Type = Rec.Type::Item then
            case Rec.Reserve of
                Rec.Reserve::Always:
                    begin
                        CurrPage.SaveRecord;
                        Rec.AutoReserve;
                        CurrPage.Update(false);
                        UpdateIsDone := true;
                    end;
                Rec.Reserve::Optional:
                    if (Rec.Quantity < xRec.Quantity) and (xRec.Quantity > 0) then begin
                        CurrPage.SaveRecord;
                        CurrPage.Update(false);
                        UpdateIsDone := true;
                    end;
            end;

        if (Rec.Type = Rec.Type::Item) and
           ((Rec.Quantity <> xRec.Quantity) or (Rec."Line No." = 0)) and
           not UpdateIsDone
        then
            CurrPage.Update(true);
    end;

    local procedure PostingDateOnAfterValidate()
    begin
        if (Rec.Reserve = Rec.Reserve::Always) and
           (Rec."Outstanding Qty. (Base)" <> 0) and
           (Rec."Posting Date" <> xRec."Posting Date")
        then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
            CurrPage.Update(false);
        end;
    end;

    local procedure SelectionFilterOnAfterValidate()
    begin
        CurrPage.Update;
        SetSelectionFilter;
    end;
}
