#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186800 pageextension52186800 extends "Purchase Line Discounts" 
{
    layout
    {
        modify(VendNoFilterCtrl)
        {
            ApplicationArea = Basic;
        }
        modify(ItemNoFilterCtrl)
        {
            ApplicationArea = Basic;
        }
        modify(StartingDateFilter)
        {
            ApplicationArea = Basic;
        }
        modify("Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Minimum Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Ending Date")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "VendNoFilterCtrl(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemNoFilterCtrl(Control 32)".


        //Unsupported feature: Code Insertion (VariableCollection) on "StartingDateFilter(Control 30).OnValidate".

        //trigger (Variable: ApplicationMgt)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "StartingDateFilter(Control 30).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TextManagement.MakeDateFilter(StartingDateFilter);
            StartingDateFilterOnAfterValid;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ApplicationMgt.MakeDateFilter(StartingDateFilter) = 0 THEN;
            StartingDateFilterOnAfterValid;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "StartingDateFilter(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Minimum Quantity"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 14)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }

    var
        //ApplicationMgt: Codeunit ApplicationManagement;

    //Unsupported feature: Property Deletion (Attributes) on "SetRecFilters(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "SetRecFilters(PROCEDURE 1)".

    //procedure SetRecFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF VendNoFilter <> '' THEN
          SETFILTER("Vendor No.",VendNoFilter)
        ELSE
        #4..7
        ELSE
          SETRANGE("Starting Date");

        IF ItemNoFilter <> '' THEN
          SETFILTER("Item No.",ItemNoFilter)
        ELSE
          SETRANGE("Item No.");

        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10
        IF ItemNoFilter <> '' THEN BEGIN
          SETFILTER("Item No.",ItemNoFilter);
        END ELSE
        #14..16
        */
    //end;

    //Unsupported feature: Property Modification (Length) on "GetCaption(PROCEDURE 3).SourceTableName(Variable 1002)".

}
