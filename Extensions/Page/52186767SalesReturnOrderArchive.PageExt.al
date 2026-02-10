#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186767 pageextension52186767 extends "Sales Return Order Archive"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Customer Name")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Sell-to Address"(Control 8)".

            ApplicationArea = Basic;
        }
        modify("Sell-to Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Sell-to Address 2"(Control 10)".

            ApplicationArea = Basic;
        }
        modify("Sell-to Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Sell-to Post Code"(Control 12)".

            Caption = 'Sell-to Post Code/City';
            ApplicationArea = Basic;
        }
        modify("Sell-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Sell-to City"(Control 121)".

            ApplicationArea = Basic;
        }
        modify("Sell-to Contact No.")
        {

            //Unsupported feature: Property Modification (Level) on ""Sell-to Contact No."(Control 132)".

            ApplicationArea = Basic;
        }
        modify("Sell-to Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Order Date")
        {
            ApplicationArea = Basic;
        }
        modify("External Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign No.")
        {
            ApplicationArea = Basic;
        }
        modify("Responsibility Center")
        {
            ApplicationArea = Basic;
        }
        modify("Assigned User ID")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Invoice Details")
        {
            Caption = 'Invoicing';

            //Unsupported feature: Property Modification (Name) on ""Invoice Details"(Control 1905885101)".

        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;
        }
        modify("Prices Including VAT")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction Type")
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
        modify("Applies-to Doc. Type")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Doc. No.")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to ID")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping and Billing")
        {
            Caption = 'Shipping';

            //Unsupported feature: Property Modification (Name) on ""Shipping and Billing"(Control 1906801201)".

        }
        modify("Ship-to Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Name"(Control 69)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Address"(Control 64)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Address 2"(Control 63)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Post Code"(Control 62)".

            Caption = 'Ship-to Post Code/City';
            ApplicationArea = Basic;
        }
        modify("Ship-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to City"(Control 61)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Contact")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Contact"(Control 60)".

            ApplicationArea = Basic;
        }
        // modify("Bill-to")
        // {

        //     //Unsupported feature: Property Modification (ControlType) on ""Bill-to"(Control 73)".


        //     //Unsupported feature: Property Modification (Name) on ""Bill-to"(Control 73)".


        //     //Unsupported feature: Property Insertion (SourceExpr) on ""Bill-to"(Control 73)".

        //     ApplicationArea = Basic;
        // }
        modify("Bill-to Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Name"(Control 38)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Address"(Control 40)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Address 2"(Control 42)".

            ApplicationArea = Basic;
        }
        modify("Bill-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to City"(Control 120)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Post Code"(Control 44)".

            Caption = 'Bill-to Post Code/City';
            ApplicationArea = Basic;
        }
        modify("Bill-to Contact No.")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Contact No."(Control 134)".

            ApplicationArea = Basic;
        }
        modify("Bill-to Contact")
        {

            //Unsupported feature: Property Modification (Level) on ""Bill-to Contact"(Control 46)".

            ApplicationArea = Basic;
        }
        modify("EU 3-Party Trade")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction Specification")
        {
            ApplicationArea = Basic;
        }
        modify("Transport Method")
        {
            ApplicationArea = Basic;
        }
        modify("Exit Point")
        {
            ApplicationArea = Basic;
        }
        modify("Area")
        {
            ApplicationArea = Basic;
        }
        modify("Version No.")
        {
            ApplicationArea = Basic;
        }
        modify("Archived By")
        {
            ApplicationArea = Basic;
        }
        modify("Date Archived")
        {
            ApplicationArea = Basic;
        }
        modify("Time Archived")
        {
            ApplicationArea = Basic;
        }
        modify("Interaction Exist")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (Importance) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Sell-to Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Sell-to Customer Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer Name"(Control 6)".


        //Unsupported feature: Property Deletion (Importance) on ""Sell-to Customer Name"(Control 6)".

        modify("Sell-to")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Sell-to Address"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Address"(Control 8)".


        //Unsupported feature: Property Deletion (Importance) on ""Sell-to Address"(Control 8)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Sell-to Address 2"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Address 2"(Control 10)".


        //Unsupported feature: Property Deletion (Importance) on ""Sell-to Address 2"(Control 10)".

        modify("Sell-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Post Code"(Control 12)".


        //Unsupported feature: Property Deletion (Importance) on ""Sell-to Post Code"(Control 12)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Sell-to City"(Control 121)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to City"(Control 121)".


        //Unsupported feature: Property Deletion (Importance) on ""Sell-to City"(Control 121)".

        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Sell-to Contact No."(Control 132)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Contact No."(Control 132)".


        //Unsupported feature: Property Deletion (Importance) on ""Sell-to Contact No."(Control 132)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Sell-to Contact"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Contact"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Responsibility Center"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned User ID"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 32)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "SalesLinesArchive(Control 122)".


        //Unsupported feature: Property Deletion (PartType) on "SalesLinesArchive(Control 122)".


        //Unsupported feature: Property Deletion (GroupType) on ""Invoice Details"(Control 1905885101)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 96)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prices Including VAT"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Group"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Type"(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. Type"(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. No."(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to ID"(Control 54)".


        //Unsupported feature: Property Deletion (GroupType) on ""Shipping and Billing"(Control 1906801201)".

        modify("Ship-to")
        {
            Visible = false;
        }
        modify("Ship-to Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Name"(Control 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 69)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address"(Control 64)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address 2"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address 2"(Control 63)".

        modify("Ship-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 62)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to City"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to City"(Control 61)".

        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Contact"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 60)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to"(Control 73)".


        //Unsupported feature: Property Deletion (GroupType) on ""Bill-to"(Control 73)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Name"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Name"(Control 38)".


        //Unsupported feature: Property Deletion (Importance) on ""Bill-to Name"(Control 38)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Address"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Address"(Control 40)".


        //Unsupported feature: Property Deletion (Importance) on ""Bill-to Address"(Control 40)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Address 2"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Address 2"(Control 42)".


        //Unsupported feature: Property Deletion (Importance) on ""Bill-to Address 2"(Control 42)".

        modify("Bill-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to City"(Control 120)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to City"(Control 120)".


        //Unsupported feature: Property Deletion (Importance) on ""Bill-to City"(Control 120)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Post Code"(Control 44)".


        //Unsupported feature: Property Deletion (Importance) on ""Bill-to Post Code"(Control 44)".

        modify("Bill-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Contact No."(Control 134)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Contact No."(Control 134)".


        //Unsupported feature: Property Deletion (Importance) on ""Bill-to Contact No."(Control 134)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Bill-to Contact"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Contact"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EU 3-Party Trade"(Control 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Specification"(Control 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transport Method"(Control 104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exit Point"(Control 106)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Area(Control 108)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Version No."(Control 110)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Archived By"(Control 112)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Archived"(Control 114)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Time Archived"(Control 116)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Exist"(Control 125)".

        // modify(Control23)
        // {
        //     Visible = false;
        // }
        modify(Control22)
        {
            Visible = false;
        }
        modify(Control21)
        {
            Visible = false;
        }
        addfirst("Invoice Details")
        {
            field("Bill-to Customer No."; Rec."Bill-to Customer No.")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter("Sell-to Customer No."; "Sell-to Contact No.")
        moveafter("Sell-to Contact"; "Posting Date")
        // moveafter(Invoicing;"Bill-to Contact No.")
        moveafter("Bill-to Contact No."; "Bill-to Name")
        moveafter("Bill-to Address 2"; "Bill-to Post Code")
        moveafter("Bill-to Post Code"; "Bill-to City")
        moveafter("Bill-to City"; "Bill-to Contact")
        moveafter("Bill-to Contact"; "Shortcut Dimension 1 Code")
        moveafter("Applies-to ID"; "Prices Including VAT")
        moveafter("VAT Bus. Posting Group"; "Shipping and Billing")
        //moveafter("Location Code";"Shipment Date")
        moveafter("Shipment Date"; "Foreign Trade")
        moveafter("Currency Code"; "EU 3-Party Trade")
    }
    actions
    {
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Print)
        {
            ApplicationArea = Basic;
        }
        modify(Restore)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 126)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 127)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 140)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 137)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Restore(Action 130)".

    }

    //Unsupported feature: Property Deletion (DeleteAllowed).

}
