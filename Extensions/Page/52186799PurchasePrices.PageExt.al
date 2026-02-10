#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186799 pageextension52186799 extends "Purchase Prices" 
{
    layout
    {
        modify(VendNoFilterCtrl)
        {
            ApplicationArea = Basic;
        }
        modify(ItemNoFIlterCtrl)
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
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
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
        modify("Direct Unit Cost")
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


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemNoFIlterCtrl(Control 32)".


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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Minimum Quantity"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Unit Cost"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 14)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        // modify(ActionContainer3)
        // {
        //     Visible = false;
        // }
        modify(CopyPrices)
        {
            Visible = false;
        }
    }

    var
        //ApplicationMgt: Codeunit ApplicationManagement;


    //Unsupported feature: Property Modification (Data type) on "VendNoFilter(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //VendNoFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //VendNoFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "ItemNoFilter(Variable 1001)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemNoFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemNoFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetRecFilters;
        SetRecFilters;
        IsLookupMode := CurrPage.LOOKUPMODE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetRecFilters;
        SetRecFilters;
        */
    //end;

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
          SETRANGE("Vendor No.");

        IF StartingDateFilter <> '' THEN
          SETFILTER("Starting Date",StartingDateFilter)
        ELSE
          SETRANGE("Starting Date");

        IF ItemNoFilter <> '' THEN
          SETFILTER("Item No.",ItemNoFilter)
        ELSE
          SETRANGE("Item No.");

        CheckFilters(DATABASE::Vendor,VendNoFilter);
        CheckFilters(DATABASE::Item,ItemNoFilter);

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
          SETRANGE("Item No.");

        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Insertion (Length) on "GetCaption(PROCEDURE 3).ReturnValue".



    //Unsupported feature: Code Modification on "GetCaption(PROCEDURE 3)".

    //procedure GetCaption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetRecFilters;

        IF ItemNoFilter <> '' THEN
          SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,27)
        ELSE
          SourceTableName := '';

        IF Vend.GET(COPYSTR(VendNoFilter,1,MAXSTRLEN(Vend."No."))) THEN
          Description := Vend.Name;

        EXIT(STRSUBSTNO('%1 %2 %3 %4 ',VendNoFilter,Description,SourceTableName,ItemNoFilter));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        Vend."No." := VendNoFilter;
        IF Vend.FIND THEN
        #9..11
        */
    //end;


    //Unsupported feature: Code Modification on "VendNoFilterOnAfterValidate(PROCEDURE 19075608)".

    //procedure VendNoFilterOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Item.GET("Item No.") THEN
          CurrPage.SAVERECORD;
        SetRecFilters;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CurrPage.SAVERECORD;
        SetRecFilters;
        */
    //end;

    //Unsupported feature: Property Modification (Length) on "GetCaption(PROCEDURE 3).SourceTableName(Variable 1002)".


    //Unsupported feature: Property Modification (Length) on "GetCaption(PROCEDURE 3).Description(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "VendNoFilterOnAfterValidate(PROCEDURE 19075608).Item(Variable 1000)".

}
