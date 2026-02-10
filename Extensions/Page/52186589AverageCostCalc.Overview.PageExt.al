#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186589 pageextension52186589 extends "Average Cost Calc. Overview"
{
    layout
    {
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("Valuation Date")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(AverageCostCntrl)
        {
            ApplicationArea = Basic;
        }
        modify("Cost is Adjusted")
        {
            ApplicationArea = Basic;
        }
        modify("Item Ledger Entry No.")
        {
            ApplicationArea = Basic;
            HideValue = "Item Ledger Entry No.HideValue";
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Entry Type")
        {
            ApplicationArea = Basic;
            HideValue = "Entry TypeHideValue";
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Document Line No.")
        {
            ApplicationArea = Basic;
            HideValue = "Document Line No.HideValue";
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Cost Amount (Expected)")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Amount (Actual)")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Valuation Date"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AverageCostCntrl(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost is Adjusted"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Ledger Entry No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Line No."(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Amount (Expected)"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Amount (Actual)"(Control 51)".

    }
    actions
    {

        //Unsupported feature: Property Modification (ActionContainerType) on "ActionContainer1900000003(Action 1900000003)".


        //Unsupported feature: Property Insertion (Level) on "ActionContainer1900000003(Action 1900000003)".

        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("&Value Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Applied E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Reservation Entries")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (ActionContainerType) on "ActionContainer1900000004(Action 1900000004)".


        //Unsupported feature: Property Insertion (Level) on "ActionContainer1900000004(Action 1900000004)".

        modify("&Navigate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Value Entries"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applied E&ntries"(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reservation Entries"(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 53)".

    }

    //Unsupported feature: Property Modification (Id) on "TypeIndent(Variable 9080)".

    //var
    //>>>> ORIGINAL VALUE:
    //TypeIndent : 9080;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TypeIndent : 19015277;
    //Variable type has not been exported.

    var

        "Item Ledger Entry No.HideValue": Boolean;

        "Entry TypeHideValue": Boolean;

        "Document Line No.HideValue": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentLineNoHideValue := FALSE;
    EntryTypeHideValue := FALSE;
    ItemLedgerEntryNoHideValue := FALSE;
    TypeIndent := 0;
    SetExpansionStatus;
    IF Type = Type::"Closing Entry" THEN BEGIN
    #7..11
    ItemLedgerEntryNoOnFormat;
    EntryTypeOnFormat;
    DocumentLineNoOnFormat;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Document Line No.HideValue" := FALSE;
    "Entry TypeHideValue" := FALSE;
    "Item Ledger Entry No.HideValue" := FALSE;
    #4..14
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetExpansionStatus(PROCEDURE 16)".


    //Unsupported feature: Property Deletion (Attributes) on "InitTempTable(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetRecFilters(PROCEDURE 5)".


    //Unsupported feature: Property Deletion (Attributes) on "SetItem(PROCEDURE 2)".


    local procedure RefreshTempTable(var TempAvgCostCalcOverview2: Record "Average Cost Calc. Overview"; var AvgCostCalcOverview: Record "Average Cost Calc. Overview")
    begin
        TempAvgCostCalcOverview2.Copy(Rec);

        begin
            Rec.Reset;
            if Rec.Find('-') then
                repeat
                    AvgCostCalcOverview := Rec;
                    if not AvgCostCalcOverview.Find or
                       ((Rec.Level = 0) and ((AvgCostCalcOverview.Next = 0) or (AvgCostCalcOverview.Level = 0)))
                    then begin
                        if Rec.Level = 0 then begin
                            AvgCostCalcOverview := Rec;
                            AvgCostCalcOverview.Find;
                            AvgCostCalcOverview.Delete(true);
                        end;
                        Rec.Delete;
                    end;
                until Rec.Next = 0;
        end;

        Rec.Copy(TempAvgCostCalcOverview2);
    end;

    local procedure TypeOnFormat()
    begin
        // if Rec.Type <> Rec.Type::"Closing Entry" then
        //   TypeIndent := 1;
    end;

    local procedure ItemLedgerEntryNoOnFormat()
    begin
        if Rec.Type = Rec.Type::"Closing Entry" then
            "Item Ledger Entry No.HideValue" := true;
    end;

    local procedure EntryTypeOnFormat()
    begin
        if Rec.Type = Rec.Type::"Closing Entry" then
            "Entry TypeHideValue" := true;
    end;

    local procedure DocumentLineNoOnFormat()
    begin
        if Rec.Type = Rec.Type::"Closing Entry" then
            "Document Line No.HideValue" := true;
    end;
}
