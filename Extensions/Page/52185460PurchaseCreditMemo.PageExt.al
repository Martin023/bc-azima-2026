#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185460 pageextension52185460 extends "Purchase Credit Memo"
{

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""Purchase Credit Memo"(Page 52)".

    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Importance) on ""No."(Control 2)".

        }
        // modify("Buy-from Vendor No.")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""Buy-from Vendor No."(Control 22)".


        //     //Unsupported feature: Property Modification (Name) on ""Buy-from Vendor No."(Control 22)".

        // }
        // modify("Buy-from Vendor Name")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Buy-from")
        // {

        //     //Unsupported feature: Property Modification (ControlType) on ""Buy-from"(Control 4)".


        //     //Unsupported feature: Property Modification (Name) on ""Buy-from"(Control 4)".


        //     //Unsupported feature: Property Insertion (SourceExpr) on ""Buy-from"(Control 4)".


        //     //Unsupported feature: Property Insertion (Importance) on ""Buy-from"(Control 4)".

        //     ShowMandatory = true;
        //     ApplicationArea = Basic;
        // }
        modify("Buy-from Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Buy-from Address"(Control 63)".

            ApplicationArea = Basic;
        }
        modify("Buy-from Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Buy-from Address 2"(Control 65)".

            ApplicationArea = Basic;
        }
        modify("Buy-from City")
        {

            //Unsupported feature: Property Modification (Level) on ""Buy-from City"(Control 67)".

            ApplicationArea = Basic;
        }
        modify("Buy-from Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Buy-from Post Code"(Control 68)".

            ApplicationArea = Basic;
        }
        modify("Buy-from Contact No.")
        {

            //Unsupported feature: Property Modification (Level) on ""Buy-from Contact No."(Control 123)".

            ApplicationArea = Basic;
        }
        modify("Buy-from Contact")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Importance) on ""Buy-from Contact"(Control 8)".

        }
        // modify("Posting Date")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Importance) on ""Posting Date"(Control 12)".

        // }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Expected Receipt Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Importance) on ""Expected Receipt Date"(Control 96)".

        }
        modify("Vendor Authorization No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Importance) on ""Vendor Authorization No."(Control 115)".

        }
        modify("Incoming Document Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Cr. Memo No.")
        {
            ApplicationArea = Basic;
        }
        modify("Purchaser Code")
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
        modify("Job Queue Status")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Importance) on "Status(Control 101)".

            Editable = false;
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
        modify("Prices Including VAT")
        {
            ApplicationArea = Basic;
        }
        // modify("VAT Bus. Posting Group")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Payment Terms Code")
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
        modify("Payment Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Pmt. Discount Date")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Importance) on ""Location Code"(Control 80)".

        }
        modify("Shipping and Payment")
        {
            Caption = 'Shipping';

            //Unsupported feature: Property Modification (Name) on ""Shipping and Payment"(Control 1906801201)".

        }
        modify("Order Address Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Order Address Code"(Control 72)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (QuickEntry) on ""Order Address Code"(Control 72)".

        }
        modify("Ship-to Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Name"(Control 32)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Address"(Control 34)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Address 2"(Control 36)".

            ApplicationArea = Basic;
        }
        modify("Ship-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to City"(Control 38)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Post Code"(Control 83)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Contact")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Contact"(Control 40)".

            ApplicationArea = Basic;
        }
        modify("Pay-to Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Pay-to Name"(Control 20)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Pay-to Name"(Control 20)".


            //Unsupported feature: Property Modification (Name) on ""Pay-to Name"(Control 20)".

        }
        modify("Pay-to Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Pay-to Address"(Control 24)".

            ApplicationArea = Basic;
        }
        modify("Pay-to Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Pay-to Address 2"(Control 26)".

            ApplicationArea = Basic;
        }
        modify("Pay-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Pay-to City"(Control 28)".

            ApplicationArea = Basic;
        }
        modify("Pay-to Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Pay-to Post Code"(Control 73)".

            ApplicationArea = Basic;
        }
        modify("Pay-to Contact No.")
        {

            //Unsupported feature: Property Modification (Level) on ""Pay-to Contact No."(Control 125)".

            ApplicationArea = Basic;
        }
        modify("Pay-to Contact")
        {

            //Unsupported feature: Property Modification (Level) on ""Pay-to Contact"(Control 30)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Importance) on ""Pay-to Contact"(Control 30)".

        }
        modify("Transaction Specification")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction Type")
        {
            ApplicationArea = Basic;
        }
        modify("Transport Method")
        {
            ApplicationArea = Basic;
        }
        modify("Entry Point")
        {
            ApplicationArea = Basic;
        }
        modify("Area")
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

        //Unsupported feature: Property Modification (Name) on "ApprovalFactBox(Control 1906354007)".


        //Unsupported feature: Property Insertion (SubPageLink) on "ApprovalFactBox(Control 1906354007)".


        //Unsupported feature: Property Insertion (Visible) on "Control1904651607(Control 1904651607)".


        //Unsupported feature: Property Insertion (Visible) on "Control1903435607(Control 1903435607)".


        //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".

        // modify("Buy-from Vendor No.")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Vendor No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor No."(Control 22)".


        //Unsupported feature: Property Deletion (NotBlank) on ""Buy-from Vendor No."(Control 22)".


        //Unsupported feature: Property Deletion (Importance) on ""Buy-from Vendor No."(Control 22)".

        // modify("Buy-from Vendor Name")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Vendor Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor Name"(Control 6)".


        //Unsupported feature: Property Deletion (Importance) on ""Buy-from Vendor Name"(Control 6)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Buy-from Vendor Name"(Control 6)".

        modify("Posting Description")
        {
            Visible = false;
        }

        //Unsupported feature: Code Insertion on ""Buy-from Vendor No."(Control 4)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        BuyfromVendorNoOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from"(Control 4)".


        //Unsupported feature: Property Deletion (GroupType) on ""Buy-from"(Control 4)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Address"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Address"(Control 63)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Buy-from Address"(Control 63)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Address 2"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Address 2"(Control 65)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Buy-from Address 2"(Control 65)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from City"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from City"(Control 67)".


        //Unsupported feature: Property Deletion (Importance) on ""Buy-from City"(Control 67)".

        modify(Control88)
        {
            Visible = false;
        }
        modify("Buy-from County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Post Code"(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Post Code"(Control 68)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Buy-from Post Code"(Control 68)".

        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Contact No."(Control 123)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Contact No."(Control 123)".


        //Unsupported feature: Property Deletion (Importance) on ""Buy-from Contact No."(Control 123)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Contact"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Contact"(Control 8)".


        //Unsupported feature: Property Deletion (Editable) on ""Buy-from Contact"(Control 8)".

        // modify("Posting Date")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 39)".


        //Unsupported feature: Property Deletion (Importance) on ""Document Date"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 96)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Authorization No."(Control 115)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Incoming Document Entry No."(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Cr. Memo No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchaser Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 1102601000)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Responsibility Center"(Control 107)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned User ID"(Control 56)".


        //Unsupported feature: Property Deletion (Importance) on ""Assigned User ID"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Queue Status"(Control 7)".


        //Unsupported feature: Property Deletion (Visible) on ""Job Queue Status"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 101)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "PurchLines(Control 46)".


        //Unsupported feature: Property Deletion (Enabled) on "PurchLines(Control 46)".


        //Unsupported feature: Property Deletion (Editable) on "PurchLines(Control 46)".


        //Unsupported feature: Property Deletion (GroupType) on ""Invoice Details"(Control 1905885101)".



        //Unsupported feature: Code Modification on ""Currency Code"(Control 91).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CLEAR(ChangeExchangeRate);
        IF "Posting Date" <> 0D THEN
          ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date")
        ELSE
          ChangeExchangeRate.SetParameter("Currency Code","Currency Factor",WORKDATE);
        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
          VALIDATE("Currency Factor",ChangeExchangeRate.GetParameter);
          SaveInvoiceDiscountAmount;
        END;
        CLEAR(ChangeExchangeRate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
          CurrPage.UPDATE;
        END;
        CLEAR(ChangeExchangeRate);
        */
        //end;


        //Unsupported feature: Code Modification on ""Currency Code"(Control 91).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0,Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.UPDATE;
        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0,Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 91)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prices Including VAT"(Control 110)".

        // modify("VAT Bus. Posting Group")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Group"(Control 141)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Terms Code"(Control 16)".

        modify("Payment Method Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Discount %"(Control 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Discount Date"(Control 139)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 80)".


        //Unsupported feature: Property Deletion (GroupType) on ""Shipping and Payment"(Control 1906801201)".

        modify(Control71)
        {
            Visible = false;
        }
        modify(ShipToOptions)
        {
            Visible = false;
        }
        modify(Control69)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Address Code"(Control 72)".

        modify("Ship-to")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Name"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 32)".


        //Unsupported feature: Property Deletion (Importance) on ""Ship-to Name"(Control 32)".


        //Unsupported feature: Property Deletion (Editable) on ""Ship-to Name"(Control 32)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address"(Control 34)".


        //Unsupported feature: Property Deletion (Importance) on ""Ship-to Address"(Control 34)".


        //Unsupported feature: Property Deletion (Editable) on ""Ship-to Address"(Control 34)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Ship-to Address"(Control 34)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address 2"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address 2"(Control 36)".


        //Unsupported feature: Property Deletion (Importance) on ""Ship-to Address 2"(Control 36)".


        //Unsupported feature: Property Deletion (Editable) on ""Ship-to Address 2"(Control 36)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Ship-to Address 2"(Control 36)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to City"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to City"(Control 38)".


        //Unsupported feature: Property Deletion (Importance) on ""Ship-to City"(Control 38)".


        //Unsupported feature: Property Deletion (Editable) on ""Ship-to City"(Control 38)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Ship-to City"(Control 38)".

        modify(Control86)
        {
            Visible = false;
        }
        modify("Ship-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Post Code"(Control 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 83)".


        //Unsupported feature: Property Deletion (Importance) on ""Ship-to Post Code"(Control 83)".


        //Unsupported feature: Property Deletion (Editable) on ""Ship-to Post Code"(Control 83)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Ship-to Post Code"(Control 83)".

        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Contact"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 40)".


        //Unsupported feature: Property Deletion (Importance) on ""Ship-to Contact"(Control 40)".


        //Unsupported feature: Property Deletion (Editable) on ""Ship-to Contact"(Control 40)".

        modify("Pay-to")
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on ""Pay-to Name"(Control 20).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF GETFILTER("Pay-to Vendor No.") = xRec."Pay-to Vendor No." THEN
          IF "Pay-to Vendor No." <> xRec."Pay-to Vendor No." THEN
            SETRANGE("Pay-to Vendor No.");

        CurrPage.SAVERECORD;
        IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
          PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0,Rec);

        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PaytoVendorNoOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Name"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Name"(Control 20)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Address"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Address"(Control 24)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Pay-to Address"(Control 24)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Address 2"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Address 2"(Control 26)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Pay-to Address 2"(Control 26)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to City"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to City"(Control 28)".


        //Unsupported feature: Property Deletion (Importance) on ""Pay-to City"(Control 28)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Pay-to City"(Control 28)".

        modify(Control84)
        {
            Visible = false;
        }
        modify("Pay-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Post Code"(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Post Code"(Control 73)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Pay-to Post Code"(Control 73)".

        modify("Pay-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Contact No."(Control 125)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Contact No."(Control 125)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Contact"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Contact"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Specification"(Control 89)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Type"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transport Method"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Point"(Control 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Area(Control 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. Type"(Control 135)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. No."(Control 137)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to ID"(Control 133)".

        modify("Attached Documents")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control15(Control 15)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "ApprovalFactBox(Control 1906354007)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901138007(Control 1901138007)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1904651607(Control 1904651607)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1903435607(Control 1903435607)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1906949207(Control 1906949207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "IncomingDocAttachFactBox(Control 29)".


        //Unsupported feature: Property Deletion (Visible) on "IncomingDocAttachFactBox(Control 29)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control5(Control 5)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "WorkflowStatus(Control 45)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        moveafter("No."; "Buy-from")
        moveafter("Buy-from Vendor No."; "Buy-from Contact No.")
        moveafter("Buy-from Contact No."; "Buy-from Vendor Name")
        moveafter("Buy-from Vendor Name"; "Buy-from Address")
        moveafter("Buy-from Address 2"; "Buy-from Post Code")
        moveafter("Buy-from Post Code"; "Buy-from City")
        moveafter("Buy-from City"; "Buy-from Contact")
        moveafter("Document Date"; "Vendor Authorization No.")
        moveafter("Vendor Cr. Memo No."; "Order Address Code")
        moveafter("Order Address Code"; "Purchaser Code")
        // moveafter(Invoicing; "Pay-to Name")
        // moveafter("Pay-to Vendor No."; "Pay-to Contact No.")
        moveafter("Pay-to Name"; "Pay-to Address")
        moveafter("Pay-to Address 2"; "Pay-to Post Code")
        moveafter("Pay-to Post Code"; "Pay-to City")
        moveafter("Pay-to City"; "Pay-to Contact")
        moveafter("Pay-to Contact"; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 2 Code"; "Payment Terms Code")
        moveafter("Due Date"; "Payment Discount %")
        moveafter("Pmt. Discount Date"; "Prices Including VAT")
        moveafter("VAT Bus. Posting Group"; "Shipping and Payment")
        //moveafter(Shipping; "Ship-to Name")
        moveafter("Ship-to Address 2"; "Ship-to Post Code")
        moveafter("Ship-to Post Code"; "Ship-to City")
        moveafter("Ship-to City"; "Ship-to Contact")
        moveafter("Ship-to Contact"; "Location Code")
        moveafter("Expected Receipt Date"; "Foreign Trade")
        moveafter("Currency Code"; "Transaction Type")
    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 49)".

        }
        modify(Vendor)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunPageLink) on "Vendor(Action 50)".

        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Approvals)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Approve)
        {
            ApplicationArea = Basic;
        }
        modify(Reject)
        {
            ApplicationArea = Basic;
        }
        modify(Delegate)
        {
            ApplicationArea = Basic;
        }
        // modify(Comment)
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (RunObject) on "Comment(Action 17)".


        //     //Unsupported feature: Property Insertion (RunPageLink) on "Comment(Action 17)".

        // }
        modify(Release)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Release(Action 112)".

        }
        modify(Reopen)
        {
            ApplicationArea = Basic;
        }
        modify("Get St&d. Vend. Purchase Codes")
        {
            ApplicationArea = Basic;
        }
        modify(CalculateInvoiceDiscount)
        {
            ApplicationArea = Basic;
        }
        modify(ApplyEntries)
        {
            ApplicationArea = Basic;
        }
        modify(GetPostedDocumentLinesToReverse)
        {
            ApplicationArea = Basic;
        }
        modify("Copy Document")
        {
            ApplicationArea = Basic;
        }
        modify("Move Negative Lines")
        {
            ApplicationArea = Basic;
        }
        modify(IncomingDocCard)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify(SelectIncomingDoc)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify(IncomingDocAttachFile)
        {
            ToolTip = '';
            ApplicationArea = Basic;
            //Enabled = not HasIncomingDocument;
        }
        modify(RemoveIncomingDoc)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify(SendApprovalRequest)
        {
            ApplicationArea = Basic;
            //Enabled = not OpenApprovalEntriesExist;
        }
        modify(CancelApprovalRequest)
        {
            ApplicationArea = Basic;
            //Enabled = OpenApprovalEntriesExist;

            //Unsupported feature: Property Modification (Image) on "CancelApprovalRequest(Action 147)".

        }
        // modify(Flow)
        // {

        //     //Unsupported feature: Property Modification (ActionType) on "Flow(Action 61)".

        //     Caption = 'Post &Batch';

        //     //Unsupported feature: Property Modification (Image) on "Flow(Action 61)".


        //     //Unsupported feature: Property Modification (Name) on "Flow(Action 61)".


        //     //Unsupported feature: Property Insertion (Ellipsis) on "Flow(Action 61)".

        //     ApplicationArea = Basic;
        // }
        modify(Post)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Post(Action 59)".

        }
        modify(Preview)
        {
            ApplicationArea = Basic;
        }
        modify(TestReport)
        {
            ApplicationArea = Basic;
        }
        modify(PostAndPrint)
        {

            //Unsupported feature: Property Modification (Name) on "PostAndPrint(Action 60)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "PostAndPrint(Action 60)".

        }
        modify("Remove From Job Queue")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 49)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Vendor(Action 50)".


        //Unsupported feature: Property Deletion (Promoted) on "Vendor(Action 50)".


        //Unsupported feature: Property Deletion (Enabled) on "Vendor(Action 50)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Vendor(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 105)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 105)".


        //Unsupported feature: Property Deletion (Enabled) on "Dimensions(Action 105)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Dimensions(Action 105)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 105)".



        //Unsupported feature: Code Insertion (VariableCollection) on "Approvals(Action 43).OnAction".

        //trigger (Variable: ApprovalEntries)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Approvals(Action 43).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID,DATABASE::"Purchase Header","Document Type","No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ApprovalEntries.Setfilters(DATABASE::"Purchase Header","Document Type","No.");
        ApprovalEntries.RUN;
        */
        //end;

        //Unsupported feature: Property Deletion (AccessByPermission) on "Approvals(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Approvals(Action 43)".


        //Unsupported feature: Property Deletion (Promoted) on "Approvals(Action 43)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Approvals(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 51)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 51)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 51)".

        modify(DocAttach)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Approve(Action 25)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Approve(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reject(Action 19)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Reject(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Delegate(Action 21)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Delegate(Action 21)".

        // modify(Comment)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Action 17)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Comment(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Release(Action 112)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Release(Action 112)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Release(Action 112)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reopen(Action 113)".


        //Unsupported feature: Property Deletion (Promoted) on "Reopen(Action 113)".


        //Unsupported feature: Property Deletion (Enabled) on "Reopen(Action 113)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Reopen(Action 113)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Reopen(Action 113)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get St&d. Vend. Purchase Codes"(Action 127)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CalculateInvoiceDiscount(Action 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyEntries(Action 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetPostedDocumentLinesToReverse(Action 143)".



        //Unsupported feature: Code Modification on ""Copy Document"(Action 54).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CopyPurchDoc.SetPurchHeader(Rec);
        CopyPurchDoc.RUNMODAL;
        CLEAR(CopyPurchDoc);
        IF GET("Document Type","No.") THEN;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Document"(Action 54)".


        //Unsupported feature: Property Deletion (Enabled) on ""Copy Document"(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Move Negative Lines"(Action 114)".



        //Unsupported feature: Code Modification on "SelectIncomingDoc(Action 33).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Incoming Document Entry No.",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No.",RECORDID));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Incoming Document Entry No.",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No."));
        */
        //end;


        //Unsupported feature: Code Modification on "RemoveIncomingDoc(Action 41).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF IncomingDocument.GET("Incoming Document Entry No.") THEN
          IncomingDocument.RemoveLinkToRelatedRecord;
        "Incoming Document Entry No." := 0;
        MODIFY(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        "Incoming Document Entry No." := 0;
        */
        //end;


        //Unsupported feature: Code Modification on "SendApprovalRequest(Action 146).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) THEN
          ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(Rec) THEN
          ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SendApprovalRequest(Action 146)".


        //Unsupported feature: Property Deletion (Promoted) on "SendApprovalRequest(Action 146)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "SendApprovalRequest(Action 146)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "SendApprovalRequest(Action 146)".



        //Unsupported feature: Code Modification on "CancelApprovalRequest(Action 147).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
        WorkflowWebhookMgt.FindAndCancel(RECORDID);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CancelApprovalRequest(Action 147)".


        //Unsupported feature: Property Deletion (Promoted) on "CancelApprovalRequest(Action 147)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CancelApprovalRequest(Action 147)".



        //Unsupported feature: Code Insertion on ""Post &Batch"(Action 61)".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //begin
        /*
        REPORT.RUNMODAL(REPORT::"Batch Post Purch. Credit Memos",TRUE,TRUE,Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;
        // modify(CreateFlow)
        // {
        //     Visible = false;
        // }
        // modify(SeeFlows)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Preview(Action 27)".


        //Unsupported feature: Property Deletion (Promoted) on "Preview(Action 27)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Preview(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TestReport(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PostAndPrint(Action 60)".


        //Unsupported feature: Property Deletion (Visible) on "PostAndPrint(Action 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remove From Job Queue"(Action 3)".

        moveafter(Action144; "P&osting")
    }

    var
    //ApprovalEntries: Page "Approval Entries";


    //Unsupported feature: Property Modification (Subtype) on "UserMgt(Variable 1004)".

    //var
    //>>>> ORIGINAL VALUE:
    //UserMgt : "User Setup Management";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UserMgt : 52185486;
    //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetControlAppearance;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CalculateCurrentShippingOption;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetControlAppearance;
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    JobQueueUsed := PurchasesPayablesSetup.JobQueueActive;
    SetExtDocNoMandatoryCondition;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetExtDocNoMandatoryCondition;
    */
    //end;


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Responsibility Center" := UserMgt.GetPurchasesFilter;

    IF (NOT DocNoVisible) AND ("No." = '') THEN
      SetBuyFromVendorFromFilter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Responsibility Center" := UserMgt.GetPurchasesFilter;
     //Add dimensions if set by default here
     "Shortcut Dimension 1 Code":=UserMgt.GetSetDimensions(USERID,1);
     VALIDATE("Shortcut Dimension 1 Code");
     "Shortcut Dimension 2 Code":=UserMgt.GetSetDimensions(USERID,2);
     VALIDATE("Shortcut Dimension 2 Code");
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetDocNoVisible;
    IsOfficeAddin := OfficeMgt.IsAvailable;
    IsSaaS := PermissionManager.SoftwareAsAService;

    IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
      FILTERGROUP(0);
    END;
    IF ("No." <> '') AND ("Buy-from Vendor No." = '') THEN
      DocumentIsPosted := (NOT GET("Document Type","No."));

    SETRANGE("Date Filter",0D,WORKDATE);

    ActivateFields;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetDocNoVisible;
    #4..9
    */
    //end;


    //Unsupported feature: Code Modification on "Post(PROCEDURE 4)".

    //procedure Post();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
      LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

    SendToPosting(PostingCodeunitID);

    IsScheduledPosting := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
    DocumentIsPosted := (NOT PurchaseHeader.GET("Document Type","No.")) OR IsScheduledPosting;

    IF IsScheduledPosting THEN
      CurrPage.CLOSE;
    CurrPage.UPDATE(FALSE);

    IF PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" THEN
      EXIT;

    IF IsOfficeAddin THEN BEGIN
      PurchCrMemoHdr.SETRANGE("Pre-Assigned No.","No.");
      IF PurchCrMemoHdr.FINDFIRST THEN
        PAGE.RUN(PAGE::"Posted Purchase Credit Memo",PurchCrMemoHdr);
    END ELSE
      IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
        ShowPostedConfirmationMessage;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SendToPosting(PostingCodeunitID);
    IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
      CurrPage.CLOSE;
    CurrPage.UPDATE(FALSE);
    */
    //end;


    //Unsupported feature: Code Modification on "SetControlAppearance(PROCEDURE 5)".

    //procedure SetControlAppearance();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
    HasIncomingDocument := "Incoming Document Entry No." <> 0;
    SetExtDocNoMandatoryCondition;

    OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
    OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);

    CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);

    WorkflowWebhookMgt.GetCanRequestAndCanCancel(RECORDID,CanRequestApprovalForFlow,CanCancelApprovalForFlow);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    */
    //end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        if Rec.GetFilter(Rec."Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                Rec.SetRange(Rec."Buy-from Vendor No.");
        CurrPage.Update;
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    //Unsupported feature: Deletion (VariableCollection) on "Post(PROCEDURE 4).PurchaseHeader(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "Post(PROCEDURE 4).PurchCrMemoHdr(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "Post(PROCEDURE 4).ApplicationAreaMgmtFacade(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "Post(PROCEDURE 4).InstructionMgt(Variable 1004)".


    //Unsupported feature: Deletion (VariableCollection) on "Post(PROCEDURE 4).IsScheduledPosting(Variable 1005)".


    //Unsupported feature: Deletion (VariableCollection) on "SetControlAppearance(PROCEDURE 5).WorkflowWebhookMgt(Variable 1000)".

}
