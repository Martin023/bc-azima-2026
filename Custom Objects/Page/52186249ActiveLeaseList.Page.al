page 52186249 "Active Lease-List"
{
    //             RecordInvoice."Document Type":=RecordInvoice."Document Type"::Invoice;
    //             RecordInvoice."Document Date":=TODAY;
    //             RecordInvoice."Sell-to Customer No.":=RecordLease."Tenant No.";
    //             RecordInvoice."Posting Description":='Invoice for Lease No.:' + FORMAT(RecordLease."No.");
    //             RecordInvoice."Posting Date":=TODAY;
    //             RecordInvoice."Due Date":=TODAY;
    //             RecordInvoice."Document Date":=TODAY;
    //             RecordInvoice."Shipping No. Series":=RecordInvoiceNos."Posted Shipment Nos.";
    //             RecordInvoice."External Document No.":=RecordLease."No.";
    //             //validate the tenant number
    //             RecordInvoice.VALIDATE(RecordInvoice."Sell-to Customer No.");
    //             RecordInvoice."Shortcut Dimension 1 Code":=RecordLease."Dimension 1 Code";
    //             RecordInvoice.VALIDATE(RecordInvoice."Shortcut Dimension 1 Code");
    //             RecordInvoice."Shortcut Dimension 2 Code":=RecordLease."Dimension 2 Code";
    //             RecordInvoice.VALIDATE(RecordInvoice."Shortcut Dimension 2 Code");
    //             //insert the property and the lease number into the database
    //             RecordInvoice."Property No.":=RecordLease."Property No.";
    //             RecordInvoice."Lease No.":=RecordLease."No.";
    //             RecordInvoice."Source Document Type":=Source;

    CardPageID = "Lease-Active";
    Editable = true;
    PageType = List;
    SourceTable = Lease;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Tenant No."; Rec."Tenant No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Tenant Name"; Rec."Tenant Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Next Bill Date"; Rec."Next Bill Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Bill Date"; Rec."Last Bill Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Area square ft"; Rec."Area square ft")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Amount Excl. VAT"; Rec."Total Amount Excl. VAT")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Property Type"; Rec."Property Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Blocked; Rec.Blocked)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Property No."; Rec."Property No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("L.R. No."; Rec."L.R. No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Property Name"; Rec."Property Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Floor No."; Rec."Floor No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Floor Name"; Rec."Floor Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Type Description"; Rec."Unit Type Description")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Sub Type"; Rec."Unit Sub Type")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Sub Type Description"; Rec."Unit Sub Type Description")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Landlord No."; Rec."Landlord No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Landlord Name"; Rec."Landlord Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Letter Of Offer"; Rec."Letter Of Offer")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Lease Agreement Ref. No."; Rec."Lease Agreement Ref. No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Lease Commence Date"; Rec."Lease Commence Date")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Billing Frequency"; Rec."Billing Frequency")
                {
                    Editable = true;
                }
                field("Billing Frequency Value"; Rec."Billing Frequency Value")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Duration Type"; Rec."Duration Type")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Duration Value"; Rec."Duration Value")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    // trigger OnInit()
    // begin
    //     CurrPage.LookupMode := true;
    // end;

    var
        L: Record Lease;
        LL: Record "Lease Line";
        IntC: Integer;
        BL: Record "Lease Bill Lines";
        SaleHeader: Record "Sales Header";
        SaleLine: Record "Sales Line";
        SRSetup: Record "Sales & Receivables Setup";
        NextNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineNo: Integer;
        FType: Text[30];
        FValue: Integer;
}

