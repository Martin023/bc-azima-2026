#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186764 pageextension52186764 extends "Item Tracing"
{
    layout
    {
        modify(SerialNoFilter)
        {
            ApplicationArea = Basic;
        }
        modify(LotNoFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ItemNoFilter)
        {
            ApplicationArea = Basic;
        }
        modify(VariantFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ShowComponents)
        {
            ApplicationArea = Basic;
        }
        modify(TraceMethod)
        {
            ToolTip = 'Find the latest occurrence and investigate where these items came from.';
            ApplicationArea = Basic;
        }
        modify(Control35)
        {
            ToolTip = 'These are the settings that were used to generate the trace result.';
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Entry Type")
        {
            ApplicationArea = Basic;
        }
        modify("Serial No.")
        {
            ApplicationArea = Basic;
            StyleExpr = SerialNoEmphasize;
        }
        modify("Lot No.")
        {
            ApplicationArea = Basic;
            StyleExpr = LotNoEmphasize;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
            StyleExpr = ItemNoEmphasize;
        }
        modify("Item Description")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Source Type")
        {
            ApplicationArea = Basic;
        }
        modify("Source No.")
        {
            ApplicationArea = Basic;
        }
        modify("Source Name")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Created by")
        {
            ApplicationArea = Basic;
        }
        modify("Created on")
        {
            ApplicationArea = Basic;
        }
        modify("Already Traced")
        {
            ApplicationArea = Basic;
        }
        modify("Item Ledger Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Parent Item Ledger Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SerialNoFilter(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LotNoFilter(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemNoFilter(Control 1000000013)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VariantFilter(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowComponents(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 1000000015)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 1000000034)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lot No."(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 1000000030)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Description"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 1000000032)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 1000000043)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Type"(Control 1000000017)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Name"(Control 1000000003)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 1000000021)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Quantity"(Control 1000000019)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created by"(Control 1000000023)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created on"(Control 1000000025)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Already Traced"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Ledger Entry No."(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Parent Item Ledger Entry No."(Control 5)".

    }
    actions
    {
        modify(ShowDocument)
        {
            ApplicationArea = Basic;
        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify(LedgerEntries)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Promoted) on "LedgerEntries(Action 19)".


            //Unsupported feature: Property Modification (PromotedCategory) on "LedgerEntries(Action 19)".

        }
        modify(TraceOppositeFromLine)
        {
            ApplicationArea = Basic;
        }
        modify(SetFiltersWithLineValues)
        {
            ApplicationArea = Basic;
        }
        modify("Go to Already-Traced History")
        {
            ApplicationArea = Basic;
        }
        modify(NextTraceResult)
        {
            ApplicationArea = Basic;
        }
        modify(PreviousTraceResult)
        {
            ApplicationArea = Basic;
        }
        modify(Print)
        {
            ApplicationArea = Basic;
        }
        modify(Navigate)
        {
            ApplicationArea = Basic;
        }
        modify(Trace)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowDocument(Action 60)".


        //Unsupported feature: Property Deletion (Promoted) on "ShowDocument(Action 60)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ShowDocument(Action 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 17)".


        //Unsupported feature: Property Deletion (Promoted) on "Card(Action 17)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Card(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LedgerEntries(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TraceOppositeFromLine(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SetFiltersWithLineValues(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Go to Already-Traced History"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NextTraceResult(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PreviousTraceResult(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Navigate(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Trace(Action 20)".

    }

    //Unsupported feature: Property Modification (Data type) on "SerialNoFilter(Variable 1000000009)".

    //var
    //>>>> ORIGINAL VALUE:
    //SerialNoFilter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SerialNoFilter : Code;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "LotNoFilter(Variable 1006)".

    //var
    //>>>> ORIGINAL VALUE:
    //LotNoFilter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //LotNoFilter : Code;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "ItemNoFilter(Variable 1000000007)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemNoFilter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemNoFilter : Code;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "VariantFilter(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //VariantFilter : Text;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //VariantFilter : Code;
    //Variable type has not been exported.

    var

        SerialNoEmphasize: Text;

        LotNoEmphasize: Text;

        ItemNoEmphasize: Text;

    //Unsupported feature: Property Deletion (Attributes) on "FindRecords(PROCEDURE 1000000001)".


    //Unsupported feature: Property Deletion (Attributes) on "InitButtons(PROCEDURE 7)".


    //Unsupported feature: Property Deletion (Attributes) on "InitFilters(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "GetItemFilters(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Name) on "GetItemFilters(PROCEDURE 6)".


    //Unsupported feature: Property Insertion (Local) on "GetItemFilters(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "GetItemFilters(PROCEDURE 6)".

    //procedure GetItemFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TraceMethod2 := TraceMethod;
    ShowComponents2 := ShowComponents;
    SerialNoFilter2 := SerialNoFilter;
    LotNoFilter2 := LotNoFilter;
    ItemNoFilter2 := ItemNoFilter;
    VariantFilter2 := VariantFilter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Serial No." = SerialNoFilter THEN
      SerialNoEmphasize := 'Strong'
    ELSE
      SerialNoEmphasize := '';

    IF "Lot No." = LotNoFilter THEN
      LotNoEmphasize := 'Strong'
    ELSE
      LotNoEmphasize := '';

    IF "Item No." = ItemNoFilter THEN
      ItemNoEmphasize := 'Strong'
    ELSE
      ItemNoEmphasize := '';
    */
    //end;

    //Unsupported feature: Deletion (ParameterCollection) on "GetItemFilters(PROCEDURE 6).TraceMethod2(Parameter 1005)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetItemFilters(PROCEDURE 6).ShowComponents2(Parameter 1004)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetItemFilters(PROCEDURE 6).SerialNoFilter2(Parameter 1003)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetItemFilters(PROCEDURE 6).LotNoFilter2(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetItemFilters(PROCEDURE 6).ItemNoFilter2(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetItemFilters(PROCEDURE 6).VariantFilter2(Parameter 1000)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
