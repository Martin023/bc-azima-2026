#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185911 pageextension52185911 extends "Sales Prepayment Percentages"
{
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
        modify(CodeFilterCtrl)
        {
            ApplicationArea = Basic;
        }
        modify(StartingDateFilter)
        {
            ApplicationArea = Basic;
        }
        modify("Sales Type")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Code")
        {
            ApplicationArea = Basic;
            Editable = "Sales CodeEditable";
        }
        modify("Item No.")
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
        modify("Prepayment %")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SalesTypeFilter(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesCodeFilterCtrl(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CodeFilterCtrl(Control 24)".


        //Unsupported feature: Code Insertion (VariableCollection) on "StartingDateFilter(Control 20).OnValidate".

        //trigger (Variable: ApplicationMgt)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "StartingDateFilter(Control 20).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "StartingDateFilter(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Type"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prepayment %"(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    var

        "Sales CodeEditable": Boolean;


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


    //Unsupported feature: Code Modification on "SetEditable(PROCEDURE 3)".

    //procedure SetEditable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesCodeEditable := "Sales Type" <> "Sales Type"::"All Customers";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Sales CodeEditable" := "Sales Type" <> "Sales Type"::"All Customers";
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetRecFilters(PROCEDURE 5)".


    //Unsupported feature: Property Insertion (Length) on "Caption(PROCEDURE 6).ReturnValue".


    //Unsupported feature: Property Insertion (Length) on "Caption(PROCEDURE 6).ItemNoCaption(Variable 1001)".


    //Unsupported feature: Property Insertion (Length) on "Caption(PROCEDURE 6).SalesCodeCaption(Variable 1000)".

}
