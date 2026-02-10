#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187147 pageextension52187147 extends "Service Quotes" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
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
        modify("Notify Customer")
        {
            ApplicationArea = Basic;
        }
        modify("Service Order Type")
        {
            ApplicationArea = Basic;
        }
        modify("Contract No.")
        {
            ApplicationArea = Basic;
        }
        modify("Response Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Method Code")
        {
            ApplicationArea = Basic;
        }
        modify("Warning Status")
        {
            ApplicationArea = Basic;
        }
        modify("Allocated Hours")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Finishing Date")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Date"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Time"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 9)".


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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Notify Customer"(Control 1102601001)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Order Type"(Control 1102601003)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract No."(Control 1102601013)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Date"(Control 1102601015)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 1102601017)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Terms Code"(Control 1102601019)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 1102601021)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Discount %"(Control 1102601023)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Method Code"(Control 1102601025)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warning Status"(Control 1102601027)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allocated Hours"(Control 1102601029)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 1102601031)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finishing Date"(Control 1102601033)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902018507(Control 1902018507)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900316107(Control 1900316107)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Dimensions")
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Customer Card")
        {
            ApplicationArea = Basic;
        }
        modify("Service Document Lo&g")
        {
            ApplicationArea = Basic;
        }
        modify("Make &Order")
        {
            ApplicationArea = Basic;
        }
        modify("&Print")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Dimensions"(Action 1102601005)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1102601007)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 1102601009)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer Card"(Action 1102601010)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Document Lo&g"(Action 1102601012)".



        //Unsupported feature: Code Modification on ""Make &Order"(Action 50).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.UPDATE;
            CODEUNIT.RUN(CODEUNIT::"Serv-Quote to Order (Yes/No)",Rec);
            CurrPage.UPDATE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.UPDATE;
            CreateServiceOrder.RUN(Rec);
            CurrPage.UPDATE;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Make &Order"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 51)".

        addafter("&Dimensions")
        {
            separator(Action1102601006)
            {
            }
        }
        addafter("Co&mments")
        {
            separator(Action1102601008)
            {
                Caption = '';
            }
        }
        addafter("Customer Card")
        {
            separator(Action1102601011)
            {
                Caption = '';
            }
        }
    }

    var
        DimMgt: Codeunit DimensionManagement;
        CreateServiceOrder: Codeunit "Serv-Quote to Order (Yes/No)";


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetSecurityFilterOnRespCenter;

        CopyCustomerFilter;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SetSecurityFilterOnRespCenter;
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (DataCaptionFields).


    //Unsupported feature: Property Deletion (UsageCategory).

}
