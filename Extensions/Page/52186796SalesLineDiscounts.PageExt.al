#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186796 pageextension52186796 extends "Sales Line Discounts"
{

    //Unsupported feature: Property Modification (PageType) on ""Sales Line Discounts"(Page 7004)".

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
        modify(StartingDateFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ItemTypeFilter)
        {
            ApplicationArea = Basic;
        }
        modify(CodeFilterCtrl)
        {
            ApplicationArea = Basic;
        }
        modify(SalesCodeFilterCtrl2)
        {
            ApplicationArea = Basic;
        }
        // modify(SalesType)
        // {

        //     //Unsupported feature: Property Modification (Name) on "SalesType(Control 32)".

        //     ApplicationArea = Basic;
        // }
        modify(SalesCode)
        {

            //Unsupported feature: Property Modification (Name) on "SalesCode(Control 18)".

            ApplicationArea = Basic;
            Editable = "Sales CodeEditable";
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("Code")
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

        //Unsupported feature: Property Deletion (Visible) on "General(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesTypeFilter(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesCodeFilterCtrl(Control 26)".


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


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTypeFilter(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CodeFilterCtrl(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesCodeFilterCtrl2(Control 16)".

        modify(Filters)
        {
            Visible = false;
        }
        // modify(GetFilterDescription)
        // {
        //     Visible = false;
        // }
        // modify(SalesType)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "SalesType(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesCode(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Minimum Quantity"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 2)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        // modify(Filtering)
        // {
        //     Visible = false;
        // }
        modify(SalesLineDiscountsFilter)
        {
            Visible = false;
        }
        modify(ClearFilter)
        {
            Visible = false;
        }
    }

    var
    //ApplicationMgt: Codeunit ApplicationManagement;

    var

        "Sales CodeEditable": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetEditableFields;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Sales CodeEditable" := "Sales Type" <> "Sales Type"::"All Customers";
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CodeFilterCtrlEnable := TRUE;
    SalesCodeFilterCtrlEnable := TRUE;
    SalesCodeEditable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CodeFilterCtrlEnable := TRUE;
    SalesCodeFilterCtrlEnable := TRUE;
    "Sales CodeEditable" := TRUE;
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

      IF GETFILTER(Type) <> '' THEN
        ItemTypeFilter := GetTypeFilter
      ELSE
        ItemTypeFilter := ItemTypeFilter::None;

      SalesCodeFilter := GETFILTER("Sales Code");
      CodeFilter := GETFILTER(Code);
      CurrencyCodeFilter := GETFILTER("Currency Code");
      EVALUATE(StartingDateFilter,GETFILTER("Starting Date"));
    END;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetRecFilters(PROCEDURE 1)".


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
    "Sales CodeEditable" := "Sales Type" <> "Sales Type"::"All Customers";

    SourceTableName := '';
    CASE ItemTypeFilter OF
      ItemTypeFilter::Item:
        BEGIN
          SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,27);
          Item.SETFILTER("No.",CodeFilter);
          IF NOT Item.FINDFIRST THEN
            CLEAR(Item);
        END;
      ItemTypeFilter::"Item Discount Group":
        BEGIN
          SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,341);
          ItemDiscGr.SETFILTER(Code,CodeFilter);
          IF NOT ItemDiscGr.FINDFIRST THEN
            CLEAR(ItemDiscGr);
        END;
    END;

    SalesSrcTableName := '';
    CASE SalesTypeFilter OF
      SalesTypeFilter::Customer:
        BEGIN
          SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,18);
          Cust.SETFILTER("No.",SalesCodeFilter);
          IF Cust.FINDFIRST THEN
            Description := Cust.Name;
        END;
      SalesTypeFilter::"Customer Discount Group":
        BEGIN
          SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,340);
          CustDiscGr.SETFILTER(Code,SalesCodeFilter);
          IF CustDiscGr.FINDFIRST THEN
            Description := CustDiscGr.Description;
        END;
      SalesTypeFilter::Campaign:
        BEGIN
          SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,5071);
          Campaign.SETFILTER("No.",SalesCodeFilter);
          IF Campaign.FINDFIRST THEN
            Description := Campaign.Description;
        END;
      SalesTypeFilter::"All Customers":
        BEGIN
          SalesSrcTableName := Text000;
          Description := '';
        END;
    END;

    IF SalesSrcTableName = Text000 THEN
      EXIT(STRSUBSTNO('%1 %2 %3 %4 %5',SalesSrcTableName,SalesCodeFilter,Description,SourceTableName,CodeFilter));
    EXIT(STRSUBSTNO('%1 %2 %3 %4 %5',SalesSrcTableName,SalesCodeFilter,Description,SourceTableName,CodeFilter));
    */
    //end;

    //Unsupported feature: Property Deletion (ShowFilter).

}
