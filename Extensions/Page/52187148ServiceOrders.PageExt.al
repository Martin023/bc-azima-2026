#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187148 pageextension52187148 extends "Service Orders" 
{

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""Service Orders"(Page 9318)".

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
        modify("Response Date")
        {
            ApplicationArea = Basic;
        }
        modify("Response Time")
        {
            ApplicationArea = Basic;
        }
        modify(Priority)
        {
            ApplicationArea = Basic;
        }
        modify("Release Status")
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
        modify("Shipping Advice")
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
        modify("Expected Finishing Date")
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
        modify("Service Time (Hours)")
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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Date"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Time"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Release Status"(Control 15)".


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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Order Type"(Control 1102601007)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract No."(Control 1102601020)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 1102601022)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Terms Code"(Control 1102601024)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 1102601026)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Discount %"(Control 1102601028)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Method Code"(Control 1102601030)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Advice"(Control 1102601032)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warning Status"(Control 1102601034)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allocated Hours"(Control 1102601036)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Finishing Date"(Control 1102601038)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 1102601040)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finishing Date"(Control 1102601042)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Time (Hours)"(Control 1102601044)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902018507(Control 1902018507)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900316107(Control 1900316107)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Customer Card")
        {
            ApplicationArea = Basic;
        }
        modify("&Dimensions")
        {
            ApplicationArea = Basic;
        }
        modify("Service Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Email &Queue")
        {
            Caption = 'E-Mail &Queue';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Email &Queue"(Action 1102601019)".

        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 1102601016)".

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

            //Unsupported feature: Property Modification (Name) on ""Warehouse Shipment Lines"(Action 3)".

        }
        modify("Service Document Lo&g")
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
        modify("Test Report")
        {
            ApplicationArea = Basic;
        }
        modify(Post)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Post(Action 52)".

        }
        modify(Preview)
        {
            ApplicationArea = Basic;
        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Post and &Print"(Action 53)".

        }
        modify(PostBatch)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "PostBatch(Action 54)".

        }
        modify("&Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 55)".

        }
        modify("Release to Ship")
        {
            ApplicationArea = Basic;
        }
        modify(Reopen)
        {
            ApplicationArea = Basic;
        }
        modify("Create Whse Shipment")
        {
            Caption = 'Create Whse. Shipment';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Customer Card"(Action 1102601009)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Dimensions"(Action 1102601010)".


        //Unsupported feature: Property Deletion (Promoted) on ""&Dimensions"(Action 1102601010)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""&Dimensions"(Action 1102601010)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""&Dimensions"(Action 1102601010)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Ledger E&ntries"(Action 1102601003)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Email &Queue"(Action 1102601019)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1102601012)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 1102601012)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 1102601012)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 1102601016)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 1102601016)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&hipments"(Action 1102601013)".


        //Unsupported feature: Property Deletion (Promoted) on ""S&hipments"(Action 1102601013)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""S&hipments"(Action 1102601013)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Invoices(Action 1102601014)".


        //Unsupported feature: Property Deletion (Promoted) on "Invoices(Action 1102601014)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Invoices(Action 1102601014)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse Shipment Lines"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Document Lo&g"(Action 1102601018)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Warranty Ledger Entries"(Action 1102601004)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Job Ledger Entries"(Action 1102601005)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report"(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Preview(Action 21)".


        //Unsupported feature: Property Deletion (Promoted) on "Preview(Action 21)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Preview(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 53)".



        //Unsupported feature: Code Modification on "PostBatch(Action 54).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CLEAR(ServHeader);
            ServHeader.COPYFILTERS(Rec);
            ServHeader.SETRANGE(Status,ServHeader.Status::Finished);
            REPORT.RUNMODAL(REPORT::"Batch Post Service Orders",TRUE,TRUE,ServHeader);
            CurrPage.UPDATE(FALSE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CLEAR(ServHeader);
            #3..5
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "PostBatch(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Release to Ship"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reopen(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Whse Shipment"(Action 8)".

        modify("Delete Invoiced Orders")
        {
            Visible = false;
        }
        addfirst("O&rder")
        {
            separator(Action1102601006)
            {
                Caption = '';
            }
        }
        addafter("&Dimensions")
        {
            separator(Action1102601011)
            {
                Caption = '';
            }
        }
        // addfirst(ActionGroup17)
        // {
        //     separator(Action1102601015)
        //     {
        //         Caption = '';
        //     }
        // }
        addafter(Statistics)
        {
            separator(Action1102601017)
            {
                Caption = '';
            }
        }
    }

    var
        DimMgt: Codeunit DimensionManagement;


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
