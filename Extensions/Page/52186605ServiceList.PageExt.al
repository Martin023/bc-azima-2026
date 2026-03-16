#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186605 pageextension52186605 extends "Service List"
{
    layout
    {
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Order Date")
        {
            ApplicationArea = Basic;
        }
        modify("Order Time")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Response Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Response Date"(Control 16)".

        }
        modify("Response Time")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Response Time"(Control 18)".

        }
        modify(Priority)
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
        modify("Assigned User ID")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Date"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Time"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Date"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Time"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 23)".


        //Unsupported feature: Code Insertion on ""Shortcut Dimension 1 Code"(Control 121)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        DimMgt.LookupDimValueCodeNoUpdate(1);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 121)".



        //Unsupported feature: Code Insertion on ""Shortcut Dimension 2 Code"(Control 119)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        DimMgt.LookupDimValueCodeNoUpdate(2);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 119)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned User ID"(Control 31)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        // modify(Card)
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 29)".

    }

    var
        DimMgt: Codeunit DimensionManagement;

        "Response DateVisible": Boolean;

        "Response TimeVisible": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ResponseTimeVisible := TRUE;
    ResponseDateVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Response TimeVisible" := TRUE;
    "Response DateVisible" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Document Type" = "Document Type"::Order THEN BEGIN
      ResponseDateVisible := TRUE;
      ResponseTimeVisible := TRUE;
    END ELSE BEGIN
      ResponseDateVisible := FALSE;
      ResponseTimeVisible := FALSE;
    END;

    CopyCustomerFilter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Document Type" = "Document Type"::Order THEN BEGIN
      "Response DateVisible" := TRUE;
      "Response TimeVisible" := TRUE;
    END ELSE BEGIN
      "Response DateVisible" := FALSE;
      "Response TimeVisible" := FALSE;
    END;
    */
    //end;
}
