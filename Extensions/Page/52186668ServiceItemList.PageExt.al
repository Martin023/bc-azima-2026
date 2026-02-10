#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186668 pageextension52186668 extends "Service Item List" 
{
    Caption = 'Service Item List';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Item Description")
        {
            ApplicationArea = Basic;
        }
        modify("Serial No.")
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
        modify("Warranty Starting Date (Parts)")
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Ending Date (Parts)")
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Starting Date (Labor)")
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Ending Date (Labor)")
        {
            ApplicationArea = Basic;
        }
        modify("Search Description")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify(Priority)
        {
            ApplicationArea = Basic;
        }
        modify("Last Service Date")
        {
            ApplicationArea = Basic;
        }
        modify("Service Contracts")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Name")
        {
            ApplicationArea = Basic;
        }
        modify("Installation Date")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Description"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Starting Date (Parts)"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Ending Date (Parts)"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Starting Date (Labor)"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Ending Date (Labor)"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Search Description"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 1102601000)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 1102601002)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Service Date"(Control 1102601004)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Contracts"(Control 1102601006)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor No."(Control 1102601008)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Name"(Control 1102601010)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Installation Date"(Control 1102601012)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Com&ponent List")
        {
            ApplicationArea = Basic;
        }
        modify("&Dimensions-Single")
        {
            ApplicationArea = Basic;
        }
        modify("Dimensions-&Multiple")
        {
            ApplicationArea = Basic;
        }
        modify(Action59)
        {
            ApplicationArea = Basic;
        }
        modify("Tr&endscape")
        {
            ApplicationArea = Basic;
        }
        modify("Troubleshooting Setup")
        {
            ApplicationArea = Basic;
        }
        modify(Action3)
        {
            ApplicationArea = Basic;
        }
        modify("Resource Skills")
        {
            ApplicationArea = Basic;
        }
        modify("S&killed Resources")
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("&Item Lines")
        {
            ApplicationArea = Basic;
        }
        modify("&Service Lines")
        {
            ApplicationArea = Basic;
        }
        modify(Action67)
        {
            ApplicationArea = Basic;
        }
        modify(Action68)
        {
            ApplicationArea = Basic;
        }
        modify("Ser&vice Contracts")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Lo&g")
        {
            ApplicationArea = Basic;
        }
        modify("Service Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("&Warranty Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("New Item")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Label")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Resource usage")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Out of Warranty")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Com&ponent List"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Dimensions-Single"(Action 15)".


        //Unsupported feature: Code Modification on ""Dimensions-&Multiple"(Action 18).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ServiceItem);
            DefaultDimMultiple.SetMultiRecord(ServiceItem,FIELDNO("No."));
            DefaultDimMultiple.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ServiceItem);
            DefaultDimMultiple.SetMultiServiceItem(ServiceItem);
            DefaultDimMultiple.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-&Multiple"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action59(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Tr&endscape"(Action 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Troubleshooting Setup"(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action3(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Skills"(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&killed Resources"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Item Lines"(Action 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Service Lines"(Action 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action67(Action 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action68(Action 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ser&vice Contracts"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Lo&g"(Action 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Ledger E&ntries"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Warranty Ledger Entries"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Item"(Action 1900294905)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item"(Action 1904837406)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Label"(Action 1905919306)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Resource usage"(Action 1907713806)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Out of Warranty"(Action 1901646906)".

        addafter("Com&ponent List")
        {
            separator(Action27)
            {
            }
        }
        addafter(Dimensions)
        {
            separator(Action58)
            {
                Caption = '';
            }
        }
        addafter(Statistics)
        {
            separator(Action61)
            {
                Caption = '';
            }
        }
        addafter("S&killed Resources")
        {
            separator(Action56)
            {
                Caption = '';
            }
        }
        addafter("&Warranty Ledger Entries")
        {
            separator(Action30)
            {
                Caption = '';
            }
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
