namespace AZIMA.AZIMA;

using Microsoft.Purchases.Document;

pageextension 52185428 "Purchase Quote EXT" extends "Purchase Quote"
{
    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""Purchase Quote"(Page 49)".

    layout
    {
        //  addlast(General)
        // {
        //     field("User ID";Rec."User ID")
        //     {



        //     }
        // }
        addafter(PurchLines)
        {
            part(QuoteVendorsPart; "Purchase Quote Vendors")
            {
                ApplicationArea = All;
                Caption = 'Quote Vendors';
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
            }
        }

        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                QuoteVendor: Record "Purchase Quote Vendor";
                Vend: Record Microsoft.Purchases.Vendor.Vendor;
            begin
                if Rec."Buy-from Vendor No." <> '' then begin
                    // Check if this vendor is already in the list for this quote
                    QuoteVendor.Reset();
                    QuoteVendor.SetRange("Document Type", Rec."Document Type");
                    QuoteVendor.SetRange("Document No.", Rec."No.");
                    QuoteVendor.SetRange("Vendor No.", Rec."Buy-from Vendor No.");

                    if not QuoteVendor.FindFirst() then begin
                        // Add vendor to the quote vendor list
                        QuoteVendor.Init();
                        QuoteVendor.Validate("Document Type", Rec."Document Type");
                        QuoteVendor.Validate("Document No.", Rec."No.");
                        QuoteVendor.Validate("Vendor No.", Rec."Buy-from Vendor No.");

                        if Vend.Get(Rec."Buy-from Vendor No.") then
                            QuoteVendor.Validate("Vendor Name", Vend.Name);

                        QuoteVendor.Insert();
                    end;
                end;

                // Default currency to KES if not set
                if Rec."Currency Code" = '' then
                    Rec.Validate("Currency Code", 'KES');
            end;
        }
        // modify("Buy-from Vendor Name")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Buy-from Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Buy-from Address"(Control 72)".

            ApplicationArea = Basic;
        }
        modify("Buy-from Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Buy-from Address 2"(Control 74)".

            ApplicationArea = Basic;
        }

        modify("Buy-from Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Buy-from Post Code"(Control 77)".

            ApplicationArea = Basic;
        }
        modify("Buy-from City")
        {

            //Unsupported feature: Property Modification (Level) on ""Buy-from City"(Control 76)".

            ApplicationArea = Basic;
        }
        modify("Buy-from Contact No.")
        {

            //Unsupported feature: Property Modification (Level) on ""Buy-from Contact No."(Control 139)".

            ApplicationArea = Basic;
        }
        modify("Buy-from Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Importance) on ""Due Date"(Control 34)".

        }
        modify("Order Date")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Archived Versions")
        {
            ApplicationArea = Basic;
        }
        modify("Requested Receipt Date")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Vendor Order No.")
        {
            ApplicationArea = Basic;
            visible = false;
            ShowMandatory = false;
        }
        modify("Vendor Shipment No.")
        {
            ApplicationArea = Basic;
            Visible = false;

            //Unsupported feature: Property Modification (SourceExpr) on ""Vendor Shipment No."(Control 16)".


            //Unsupported feature: Property Modification (Name) on ""Vendor Shipment No."(Control 16)".

        }
        modify("Purchaser Code")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Campaign No.")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Order Address Code")
        {
            ApplicationArea = Basic;
            Visible = false;
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

            //Unsupported feature: Property Modification (Importance) on "Status(Control 107)".

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

            //Unsupported feature: Property Modification (Importance) on ""Currency Code"(Control 102)".

        }
        modify("Expected Receipt Date")
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
        modify("Payment Terms Code")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Payment Method Code")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Transaction Type")
        {
            ApplicationArea = Basic;
            Visible = false;
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
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Reference")
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Creditor No.")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("On Hold")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Shipping and Payment")
        {
            Caption = 'Shipping';

            //Unsupported feature: Property Modification (Name) on ""Shipping and Payment"(Control 1906801201)".

        }


        // modify(Control20)
        // {

        //Unsupported feature: Property Modification (Level) on "Control20(Control 20)".


        //Unsupported feature: Property Modification (ControlType) on "Control20(Control 20)".


        //Unsupported feature: Property Modification (Name) on "Control20(Control 20)".


        //Unsupported feature: Property Insertion (SourceExpr) on "Control20(Control 20)".


        //     //Unsupported feature: Property Insertion (Importance) on "Control20(Control 20)".

        //     ApplicationArea = Basic;
        // }
        modify("Location Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Location Code"(Control 89)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Name")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Name"(Control 40)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Address")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Address"(Control 42)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Address 2"(Control 44)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Post Code"(Control 94)".

            ApplicationArea = Basic;
        }
        modify("Ship-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to City"(Control 46)".

            ApplicationArea = Basic;
        }
        modify("Ship-to Contact")
        {

            //Unsupported feature: Property Modification (Level) on ""Ship-to Contact"(Control 48)".

            ApplicationArea = Basic;
        }
        // modify("Pay-to Name")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Pay-to Name"(Control 22)".

        //     ApplicationArea = Basic;
        // }
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
        modify("Pay-to Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Pay-to Post Code"(Control 82)".

            ApplicationArea = Basic;
        }
        modify("Pay-to City")
        {

            //Unsupported feature: Property Modification (Level) on ""Pay-to City"(Control 28)".

            ApplicationArea = Basic;
        }
        modify("Pay-to Contact No.")
        {

            //Unsupported feature: Property Modification (Level) on ""Pay-to Contact No."(Control 141)".

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

        //Unsupported feature: Property Insertion (Visible) on "Control1904651607(Control 1904651607)".


        //Unsupported feature: Property Insertion (Visible) on "Control1903435607(Control 1903435607)".


        //Unsupported feature: Property Modification (Name) on "ApprovalFactBox(Control 1906354007)".


        //Unsupported feature: Property Insertion (SubPageLink) on "ApprovalFactBox(Control 1906354007)".


        //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Code Modification on ""Buy-from Vendor No."(Control 4).OnValidate".

        //trigger "(Control 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OnAfterValidateBuyFromVendorNo(Rec,xRec);
        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        BuyfromVendorNoOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Vendor No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor No."(Control 4)".


        //Unsupported feature: Property Deletion (NotBlank) on ""Buy-from Vendor No."(Control 4)".

        // modify("Buy-from Vendor Name")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Vendor Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor Name"(Control 6)".


        //Unsupported feature: Property Deletion (Importance) on ""Buy-from Vendor Name"(Control 6)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Buy-from Vendor Name"(Control 6)".

        modify("Buy-from")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Address"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Address"(Control 72)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Buy-from Address"(Control 72)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Address 2"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Address 2"(Control 74)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Buy-from Address 2"(Control 74)".

        modify(Control79)
        {
            Visible = false;
        }
        modify("Buy-from County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Post Code"(Control 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Post Code"(Control 77)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Buy-from Post Code"(Control 77)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from City"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from City"(Control 76)".


        //Unsupported feature: Property Deletion (Importance) on ""Buy-from City"(Control 76)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Buy-from City"(Control 76)".

        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Contact No."(Control 139)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Contact No."(Control 139)".


        //Unsupported feature: Property Deletion (Importance) on ""Buy-from Contact No."(Control 139)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Contact"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Contact"(Control 8)".


        //Unsupported feature: Property Deletion (Editable) on ""Buy-from Contact"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Date"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Archived Versions"(Control 136)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Requested Receipt Date"(Control 110)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Order No."(Control 14)".


        //Unsupported feature: Property Deletion (Importance) on ""Vendor Order No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Shipment No."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchaser Code"(Control 10)".


        //Unsupported feature: Property Deletion (Importance) on ""Purchaser Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 1102601000)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Order Address Code"(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Address Code"(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Responsibility Center"(Control 113)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned User ID"(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 107)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "PurchLines(Control 58)".


        //Unsupported feature: Property Deletion (Enabled) on "PurchLines(Control 58)".


        //Unsupported feature: Property Deletion (Editable) on "PurchLines(Control 58)".


        //Unsupported feature: Property Deletion (PartType) on "PurchLines(Control 58)".


        //Unsupported feature: Property Deletion (GroupType) on ""Invoice Details"(Control 1905885101)".



        //Unsupported feature: Code Modification on ""Currency Code"(Control 102).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CLEAR(ChangeExchangeRate);
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
        #1..4
          CurrPage.UPDATE;
        END;
        CLEAR(ChangeExchangeRate);
        */
        //end;


        //Unsupported feature: Code Modification on ""Currency Code"(Control 102).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prices Including VAT"(Control 116)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Group"(Control 150)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Terms Code"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Method Code"(Control 100)".


        //Unsupported feature: Property Deletion (Importance) on ""Payment Method Code"(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Type"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Discount %"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Discount Date"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Method Code"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Reference"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Creditor No."(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""On Hold"(Control 91)".


        //Unsupported feature: Property Deletion (GroupType) on ""Shipping and Payment"(Control 1906801201)".

        modify(Control45)
        {
            Visible = false;
        }


        //Unsupported feature: Code Insertion on ""Pay-to Vendor No."(Control 20)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        PaytoVendorNoOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (GroupType) on "Control20(Control 20)".

        modify(ShippingOptionWithLocation)
        {
            Visible = false;
        }
        // modify(ShippingOptionWithoutLocation)
        // {
        //     Visible = false;
        // }
        modify(Control57)
        {
            Visible = false;
        }
        modify(Control55)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 89)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Name"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 40)".


        //Unsupported feature: Property Deletion (Importance) on ""Ship-to Name"(Control 40)".


        //Unsupported feature: Property Deletion (Editable) on ""Ship-to Name"(Control 40)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address"(Control 42)".


        //Unsupported feature: Property Deletion (Importance) on ""Ship-to Address"(Control 42)".


        //Unsupported feature: Property Deletion (Editable) on ""Ship-to Address"(Control 42)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Ship-to Address"(Control 42)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address 2"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address 2"(Control 44)".


        //Unsupported feature: Property Deletion (Importance) on ""Ship-to Address 2"(Control 44)".


        //Unsupported feature: Property Deletion (Editable) on ""Ship-to Address 2"(Control 44)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Ship-to Address 2"(Control 44)".

        modify(Control90)
        {
            Visible = false;
        }
        modify("Ship-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Post Code"(Control 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 94)".


        //Unsupported feature: Property Deletion (Importance) on ""Ship-to Post Code"(Control 94)".


        //Unsupported feature: Property Deletion (Editable) on ""Ship-to Post Code"(Control 94)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Ship-to Post Code"(Control 94)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to City"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to City"(Control 46)".


        //Unsupported feature: Property Deletion (Importance) on ""Ship-to City"(Control 46)".


        //Unsupported feature: Property Deletion (Editable) on ""Ship-to City"(Control 46)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Ship-to City"(Control 46)".

        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Contact"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 48)".


        //Unsupported feature: Property Deletion (Importance) on ""Ship-to Contact"(Control 48)".


        //Unsupported feature: Property Deletion (Editable) on ""Ship-to Contact"(Control 48)".

        modify(Control51)
        {
            Visible = false;
        }
        modify(PayToOptions)
        {
            Visible = false;
        }
        modify(Control67)
        {
            Visible = false;
        }
        // modify("Pay-to Name")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Name"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Name"(Control 22)".


        //Unsupported feature: Property Deletion (Importance) on ""Pay-to Name"(Control 22)".


        //Unsupported feature: Property Deletion (Enabled) on ""Pay-to Name"(Control 22)".


        //Unsupported feature: Property Deletion (Editable) on ""Pay-to Name"(Control 22)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Address"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Address"(Control 24)".


        //Unsupported feature: Property Deletion (Enabled) on ""Pay-to Address"(Control 24)".


        //Unsupported feature: Property Deletion (Editable) on ""Pay-to Address"(Control 24)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Pay-to Address"(Control 24)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Address 2"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Address 2"(Control 26)".


        //Unsupported feature: Property Deletion (Enabled) on ""Pay-to Address 2"(Control 26)".


        //Unsupported feature: Property Deletion (Editable) on ""Pay-to Address 2"(Control 26)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Pay-to Address 2"(Control 26)".

        modify(Control84)
        {
            Visible = false;
        }
        modify("Pay-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Post Code"(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Post Code"(Control 82)".


        //Unsupported feature: Property Deletion (Enabled) on ""Pay-to Post Code"(Control 82)".


        //Unsupported feature: Property Deletion (Editable) on ""Pay-to Post Code"(Control 82)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Pay-to Post Code"(Control 82)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to City"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to City"(Control 28)".


        //Unsupported feature: Property Deletion (Importance) on ""Pay-to City"(Control 28)".


        //Unsupported feature: Property Deletion (Enabled) on ""Pay-to City"(Control 28)".


        //Unsupported feature: Property Deletion (Editable) on ""Pay-to City"(Control 28)".


        //Unsupported feature: Property Deletion (QuickEntry) on ""Pay-to City"(Control 28)".

        modify("Pay-to Country/Region Code")
        {
            Visible = false;
        }
        moveafter("Buy-from Vendor No."; "Buy-from Contact No.")
        moveafter("Buy-from Contact"; "No. of Archived Versions")
        moveafter("No. of Archived Versions"; "Order Date")
        moveafter("Document Date"; "Requested Receipt Date")
        moveafter("Pay-to Contact No."; "Pay-to Name")
        moveafter("Pay-to City"; "Pay-to Contact")
        moveafter("Pay-to Contact"; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 2 Code"; "Payment Terms Code")
        moveafter("Due Date"; "Payment Discount %")
        moveafter("Pmt. Discount Date"; "Payment Method Code")
        moveafter("Payment Method Code"; "Payment Reference")
        moveafter("On Hold"; "Prices Including VAT")
        moveafter("VAT Bus. Posting Group"; "Shipping and Payment")
        //moveafter(Shipping;"Ship-to Name")
        moveafter("Ship-to Contact"; "Location Code")
        moveafter("Location Code"; "Shipment Method Code")
        moveafter("Shipment Method Code"; "Expected Receipt Date")
        moveafter("Expected Receipt Date"; "Foreign Trade")
    }
    actions
    {

        modify(Vendor)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunPageLink) on "Vendor(Action 62)".

        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Approvals)
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

        //     //Unsupported feature: Property Insertion (RunObject) on "Comment(Action 15)".


        //Unsupported feature: Property Insertion (RunPageLink) on "Comment(Action 15)".

        //}
        modify(Print)
        {

            //Unsupported feature: Property Modification (Level) on "Print(Action 70)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Print(Action 70)".

        }
        modify(Release)
        {
            ApplicationArea = Basic;
        }
        modify(Reopen)
        {
            ApplicationArea = Basic;
        }
        modify(CalculateInvoiceDiscount)
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Get St&d. Vend. Purchase Codes")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify(CopyDocument)
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Archive Document")
        {
            ApplicationArea = Basic;
        }
        modify(IncomingDocCard)
        {
            ToolTip = '';
            ApplicationArea = Basic;
            Visible = false;
        }
        modify(SelectIncomingDoc)
        {
            ToolTip = '';
            ApplicationArea = Basic;
            Visible = false;
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
            Visible = false;
        }

        modify(SendApprovalRequest)
        {
            ApplicationArea = Basic;
        }
        modify(CancelApprovalRequest)
        {
            ApplicationArea = Basic;
            //Enabled = OpenApprovalEntriesExist;

            //Unsupported feature: Property Modification (Image) on "CancelApprovalRequest(Action 154)".

        }
        modify(MakeOrder)
        {

            //Unsupported feature: Property Modification (Name) on "MakeOrder(Action 69)".

            ApplicationArea = Basic;
        }

        // Add our actions right after the Print button
        addafter(Print)
        {
            action(SendRFQToVendors)
            {
                ApplicationArea = All;
                Caption = 'Send RFQ to Vendors';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    QuoteVendor: Record "Purchase Quote Vendor";
                    Vend: Record Microsoft.Purchases.Vendor.Vendor;
                    PurchHeader: Record "Purchase Header";
                    SubjectTxt: Text;
                    BodyTxt: Text;
                    InvalidEmailVendors: Text;
                    EmailAddress: Text;
                    SentCount: Integer;
                    FailedCount: Integer;
                    TotalCount: Integer;
                    MailManagement: Codeunit System.EMail."Mail Management";
                    IsValidEmail: Boolean;
                    FileName: Text;
                begin
                    PurchHeader := Rec;

                    // Check if the document is Approved or Released
                    if not (PurchHeader.Status in [PurchHeader.Status::Released]) then begin
                        Message('You can only send RFQs for Purchase Quotes that are Approved or Released.');
                        exit;
                    end;

                    if not Confirm('Send RFQ %1 to all listed vendors?', false, PurchHeader."No.") then
                        exit;

                    QuoteVendor.SetRange("Document Type", PurchHeader."Document Type");
                    QuoteVendor.SetRange("Document No.", PurchHeader."No.");

                    if QuoteVendor.FindSet() then begin
                        repeat
                            if Vend.Get(QuoteVendor."Vendor No.") then begin
                                TotalCount += 1;
                                EmailAddress := Vend."E-Mail";
                                IsValidEmail := (EmailAddress <> '') and MailManagement.CheckValidEmailAddress(EmailAddress);

                                if not IsValidEmail then begin
                                    if EmailAddress = '' then
                                        InvalidEmailVendors += StrSubstNo('%1 (Missing Email), ', Vend.Name)
                                    else
                                        InvalidEmailVendors += StrSubstNo('%1 (Invalid Email: %2), ', Vend.Name, EmailAddress);
                                    FailedCount += 1;
                                end else begin
                                    SubjectTxt := StrSubstNo('Request for Quotation %1', PurchHeader."No.");
                                    BodyTxt :=
                                        StrSubstNo(
                                            '<body style="font-family:Segoe UI,Arial;font-size:10pt;">Dear %1,<br><br>' +
                                            'Please find attached our Request for Quotation document.<br><br>' +
                                            'Regards,<br>%2</body>', Vend.Name, UserId());
                                    FileName := StrSubstNo('RFQ_%1.pdf', PurchHeader."No.");

                                    if TrySendRFQEmail(PurchHeader, EmailAddress, SubjectTxt, BodyTxt, FileName) then begin
                                        QuoteVendor."Email Sent" := true;
                                        QuoteVendor."Date Sent" := Today();
                                        QuoteVendor.Modify();
                                        SentCount += 1;
                                    end else begin
                                        InvalidEmailVendors += StrSubstNo('%1 (Send Failed: %2), ', Vend.Name, GetLastErrorText());
                                        FailedCount += 1;
                                        ClearLastError();
                                    end;
                                end;
                            end;
                        until QuoteVendor.Next() = 0;

                        if (InvalidEmailVendors <> '') and (StrLen(InvalidEmailVendors) >= 2) then
                            InvalidEmailVendors := CopyStr(InvalidEmailVendors, 1, StrLen(InvalidEmailVendors) - 2);

                        if FailedCount > 0 then
                            Message(
                                'RFQs sent: %1 of %2 vendors. %3 failed due to invalid/missing emails or send errors.%4',
                                SentCount, TotalCount, FailedCount, InvalidEmailVendors)
                        else
                            Message(
                                'RFQs sent successfully to all %1 vendors.',
                                TotalCount);
                    end else
                        Message('No vendors found for this Purchase Quote.');
                end;
            }

            action(ManageVendors)
            {
                ApplicationArea = All;
                Caption = 'Manage Vendors';
                Image = Vendor;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    QuoteVendorPage: Page "Purchase Quote Vendors";
                    QuoteVendor: Record "Purchase Quote Vendor";
                begin
                    QuoteVendor.SetRange("Document Type", Rec."Document Type");
                    QuoteVendor.SetRange("Document No.", Rec."No.");
                    QuoteVendorPage.SetTableView(QuoteVendor);
                    QuoteVendorPage.RunModal();
                end;
            }
        }


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 61)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Vendor(Action 62)".


        //Unsupported feature: Property Deletion (Promoted) on "Vendor(Action 62)".


        //Unsupported feature: Property Deletion (Enabled) on "Vendor(Action 62)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Vendor(Action 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 63)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 63)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 111)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 111)".


        //Unsupported feature: Property Deletion (Enabled) on "Dimensions(Action 111)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Dimensions(Action 111)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 111)".



        //Unsupported feature: Code Insertion (VariableCollection) on "Approvals(Action 37).OnAction".

        //trigger (Variable: ApprovalEntries)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Approvals(Action 37).OnAction".

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

        //Unsupported feature: Property Deletion (AccessByPermission) on "Approvals(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Approvals(Action 37)".


        //Unsupported feature: Property Deletion (Promoted) on "Approvals(Action 37)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Approvals(Action 37)".

        modify(DocAttach)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Approve(Action 21)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Approve(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reject(Action 18)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Reject(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Delegate(Action 17)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Delegate(Action 17)".

        // modify(Comment)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Action 15)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Comment(Action 15)".

        // modify(ActionGroup92)
        // {
        //     Visible = false;
        // }


        //Unsupported feature: Code Modification on "Print(Action 70).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
          LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        DocPrint.PrintPurchHeader(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DocPrint.PrintPurchHeader(Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 70)".

        modify(Send)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Release(Action 118)".


        //Unsupported feature: Property Deletion (Promoted) on "Release(Action 118)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Release(Action 118)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Release(Action 118)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Release(Action 118)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reopen(Action 119)".


        //Unsupported feature: Property Deletion (Promoted) on "Reopen(Action 119)".


        //Unsupported feature: Property Deletion (Enabled) on "Reopen(Action 119)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Reopen(Action 119)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Reopen(Action 119)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CalculateInvoiceDiscount(Action 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get St&d. Vend. Purchase Codes"(Action 143)".



        //Unsupported feature: Code Modification on "CopyDocument(Action 66).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "CopyDocument(Action 66)".


        //Unsupported feature: Property Deletion (Enabled) on "CopyDocument(Action 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Archive Document"(Action 138)".



        //Unsupported feature: Code Modification on "SelectIncomingDoc(Action 31).OnAction".

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


        //Unsupported feature: Code Modification on "RemoveIncomingDoc(Action 25).OnAction".

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


        //Unsupported feature: Code Modification on "SendApprovalRequest(Action 153).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF  ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) THEN
          ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF  ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(Rec) THEN
          ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SendApprovalRequest(Action 153)".


        //Unsupported feature: Property Deletion (Promoted) on "SendApprovalRequest(Action 153)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "SendApprovalRequest(Action 153)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "SendApprovalRequest(Action 153)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CancelApprovalRequest(Action 154)".


        //Unsupported feature: Property Deletion (Promoted) on "CancelApprovalRequest(Action 154)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CancelApprovalRequest(Action 154)".


        //Unsupported feature: Property Deletion (ToolTipML) on "MakeOrder(Action 69)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "MakeOrder(Action 69)".
    }

    var
    //ApprovalEntries: Page "Approval Entries";


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
    CalculateCurrentShippingAndPayToOption;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetControlAppearance;
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

    CalculateCurrentShippingAndPayToOption;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Responsibility Center" := UserMgt.GetPurchasesFilter;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
      FILTERGROUP(0);
    END;

    SETRANGE("Date Filter",0D,WORKDATE);

    ActivateFields;

    SetDocNoVisible;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    SetDocNoVisible;
    */
    //end;


    //Unsupported feature: Code Modification on "SetControlAppearance(PROCEDURE 5)".

    //procedure SetControlAppearance();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
    OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    HasIncomingDocument := "Incoming Document Entry No." <> 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
    OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    HasIncomingDocument := "Incoming Document Entry No." <> 0;
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

    [TryFunction]
    local procedure TrySendRFQEmail(PurchHeader: Record "Purchase Header"; EmailAddress: Text; SubjectTxt: Text; BodyTxt: Text; FileName: Text)
    var
        ReportSelections: Record Microsoft.Foundation.Reporting."Report Selections";
        EmailMsg: Codeunit System.Email."Email Message";
        Email: Codeunit System.Email."Email";
        TempBlob: Codeunit System.Utilities."Temp Blob";
        PurchHeaderRef: RecordRef;
        OutStr: OutStream;
        InStr: InStream;
    begin
        PurchHeader.SetRecFilter();

        // Use the same report configured for Purchase Quote email (Report Selections - Purchases)
        ReportSelections.SetRange(Usage, ReportSelections.Usage::"P.Quote");
        ReportSelections.SetFilter("Report ID", '<>0');
        if not ReportSelections.FindFirst() then
            Error('No report is set up in Report Selections - Purchases for Quote. Please configure one and try again.');

        TempBlob.CreateOutStream(OutStr);
        PurchHeaderRef.GetTable(PurchHeader);
        Report.SaveAs(ReportSelections."Report ID", '', ReportFormat::Pdf, OutStr, PurchHeaderRef);

        TempBlob.CreateInStream(InStr);

        EmailMsg.Create(EmailAddress, SubjectTxt, BodyTxt, true);
        EmailMsg.AddAttachment(FileName, 'application/pdf', InStr);
        Email.Send(EmailMsg, Enum::System.Email."Email Scenario"::Default);
    end;
}

