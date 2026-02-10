#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186795 pageextension52186795 extends "Sales Prices"
{

    //Unsupported feature: Property Modification (PageType) on ""Sales Prices"(Page 7002)".

    layout
    {
        modify(SalesTypeFilter)
        {
            ApplicationArea = Basic;
        }
        modify(SalesCodeFilterCtrl)
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
        modify(CurrencyCodeFilterCtrl)
        {

            //Unsupported feature: Property Modification (Name) on "CurrencyCodeFilterCtrl(Control 38)".

            ApplicationArea = Basic;
        }
        modify("Sales Type")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Code")
        {
            ApplicationArea = Basic;
            Editable = SalesCodeEditable;
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
        modify("Unit Price")
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
        modify("Price Includes VAT")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Line Disc.")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Invoice Disc.")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (Visible) on "General(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesTypeFilter(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesCodeFilterCtrl(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemNoFilterCtrl(Control 10)".


        //Unsupported feature: Code Insertion (VariableCollection) on "StartingDateFilter(Control 34).OnValidate".

        //trigger (Variable: ApplicationMgt)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "StartingDateFilter(Control 34).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "StartingDateFilter(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrencyCodeFilterCtrl(Control 38)".

        modify(Filters)
        {
            Visible = false;
        }
        // modify(GetFilterDescription)
        // {
        //     Visible = false;
        // }


        //Unsupported feature: Code Modification on ""Sales Type"(Control 32).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SalesCodeControlEditable := SetSalesCodeEditable("Sales Type");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SalesCodeEditable := SetSalesCodeEditable("Sales Type");
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Type"(Control 32)".


        //Unsupported feature: Property Deletion (Editable) on ""Sales Type"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Minimum Quantity"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Price Includes VAT"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Line Disc."(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Gr. (Price)"(Control 46)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        // modify(Filtering)
        // {
        //     Visible = false;
        // }
        modify(SalesPricesFilter)
        {
            Visible = false;
        }
        modify(ClearFilter)
        {
            Visible = false;
        }
        // modify(CopyPrices)
        // {
        //     Visible = false;s
        // }
    }

    var
    //ApplicationMgt: Codeunit ApplicationManagement;

    var

        SalesCodeEditable: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesCodeControlEditable := SetSalesCodeEditable("Sales Type");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SalesCodeEditable := SetSalesCodeEditable("Sales Type");
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesCodeFilterCtrlEnable := TRUE;
    SalesCodeControlEditable := TRUE;
    IsLookupMode := CurrPage.LOOKUPMODE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SalesCodeFilterCtrlEnable := TRUE;
    SalesCodeEditable := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsOnMobile := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone;
    GetRecFilters;
    SetRecFilters;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetRecFilters;
    SetRecFilters;
    */
    //end;


    //Unsupported feature: Code Modification on "GetRecFilters(PROCEDURE 2)".

    //procedure GetRecFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GETFILTERS <> '' THEN
      UpdateBasicRecFilters;

    EVALUATE(StartingDateFilter,GETFILTER("Starting Date"));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF GETFILTERS <> '' THEN BEGIN
      IF GETFILTER("Sales Type") <> '' THEN
        SalesTypeFilter := GetSalesTypeFilter
      ELSE
        SalesTypeFilter := SalesTypeFilter::None;

      SalesCodeFilter := GETFILTER("Sales Code");
      ItemNoFilter := GETFILTER("Item No.");
      CurrencyCodeFilter := GETFILTER("Currency Code");
    END;

    EVALUATE(StartingDateFilter,GETFILTER("Starting Date"));
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetRecFilters(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "SetRecFilters(PROCEDURE 1)".

    //procedure SetRecFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesCodeFilterCtrlEnable := TRUE;

    IF SalesTypeFilter <> SalesTypeFilter::None THEN
    #4..40
    CheckFilters(DATABASE::Item,ItemNoFilter);
    CheckFilters(DATABASE::Currency,CurrencyCodeFilter);

    SetEditableFields;
    CurrPage.UPDATE(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..43
    CurrPage.UPDATE(FALSE);
    */
    //end;

    //Unsupported feature: Property Insertion (Length) on "GetCaption(PROCEDURE 3).ReturnValue".


    //Unsupported feature: Variable Insertion (Variable: ObjTransl) (VariableCollection) on "GetCaption(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: SourceTableName) (VariableCollection) on "GetCaption(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: SalesSrcTableName) (VariableCollection) on "GetCaption(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: Description) (VariableCollection) on "GetCaption(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "GetCaption(PROCEDURE 3)".

    //procedure GetCaption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF IsOnMobile THEN
      EXIT('');

    EXIT(GetFilterDescription);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetRecFilters;

    SourceTableName := '';
    IF ItemNoFilter <> '' THEN
      SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,27);

    SalesSrcTableName := '';
    CASE SalesTypeFilter OF
      SalesTypeFilter::Customer:
        BEGIN
          SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,18);
          Cust."No." := SalesCodeFilter;
          IF Cust.FIND THEN
            Description := Cust.Name;
        END;
      SalesTypeFilter::"Customer Price Group":
        BEGIN
          SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,6);
          CustPriceGr.Code := SalesCodeFilter;
          IF CustPriceGr.FIND THEN
            Description := CustPriceGr.Description;
        END;
      SalesTypeFilter::Campaign:
        BEGIN
          SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,5071);
          Campaign."No." := SalesCodeFilter;
          IF Campaign.FIND THEN
            Description := Campaign.Description;
        END;
      SalesTypeFilter::"All Customers":
        BEGIN
          SalesSrcTableName := Text000;
          Description := '';
        END;
    END;

    IF SalesSrcTableName = Text000 THEN
      EXIT(STRSUBSTNO('%1 %2 %3',SalesSrcTableName,SourceTableName,ItemNoFilter));
    EXIT(STRSUBSTNO('%1 %2 %3 %4 %5',SalesSrcTableName,SalesCodeFilter,Description,SourceTableName,ItemNoFilter));
    */
    //end;

    //Unsupported feature: Property Insertion (Length) on "CheckFilters(PROCEDURE 4).FilterTxt(Parameter 1001)".

}
