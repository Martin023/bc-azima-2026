table 52185920 "Central Payment"
{
    Caption = 'Central Payment';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Load,Discharge';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,Load,Discharge;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(6; "Paid By"; Code[50])
        {
            Caption = 'Sender ID';
            Description = 'Cashier';
        }
        field(8; "Document Date"; Date)
        {
        }
        field(9; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Canceled,Rejected,Posted';
            OptionMembers = Open,Canceled,Rejected,Posted;
        }
        field(10; "Date Created"; DateTime)
        {
            Caption = 'Date-Time Sent for Approval';
        }
        field(11; "Last Date-Time Modified"; DateTime)
        {
            Caption = 'Last Date-Time Modified';
        }
        field(12; "Last Modified By ID"; Code[50])
        {
            Caption = 'Last Modified By ID';
        }
        field(13; Comment; Boolean)
        {
            CalcFormula = Exist("Approval Comment Line" WHERE("Table ID" = FIELD("Table ID"),
                                                               "Document Type" = FIELD("Document Type"),
                                                               "Document No." = FIELD("Document No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(15; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
        }
        field(17; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(19; "Responsibility Center"; Code[10])
        {
        }
        field(20; Payee; Code[100])
        {
        }
        field(21; "Date Paid"; Date)
        {
        }
        field(22; "Cheque No."; Code[20])
        {
        }
        field(23; "Cheque type"; Option)
        {
            OptionMembers = " ","Computer Check","Manual Check";
        }
        field(24; "Release Date"; Date)
        {
        }
        field(25; Approved; Boolean)
        {
        }
        field(26; DocumentPosted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Table ID", "Document Type", "Document No.")
        {
            Clustered = true;
        }
        key(Key2; Status)
        {
        }
        key(Key3; "Paid By")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Date Created" := CurrentDateTime;
    end;

    // [Scope('OnPrem')]
    procedure ShowDocument()
    var
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
        PaymentsHeader: Record "Payments Header";
        ImprestHeader: Record "Imprest Header";
        SRHeader: Record "Store Requistion Header";
        ImprestSurr: Record "Imprest Surrender Header";
        Interbank: Record "InterBank Transfers";
        StaffAdvance: Record "Staff Advance Header";
        StaffAdvanceSurr: Record "Staff Advance Surrender Header";
    begin
        case "Table ID" of
            DATABASE::"Sales Header":
                begin
                    if not SalesHeader.Get("Document Type", "Document No.") then
                        exit;
                    case "Document Type" of
                        "Document Type"::Quote:
                            PAGE.Run(PAGE::"Sales Quote", SalesHeader);
                        "Document Type"::Order:
                            PAGE.Run(PAGE::"Sales Order", SalesHeader);
                        "Document Type"::Invoice:
                            PAGE.Run(PAGE::"Sales Invoice", SalesHeader);
                        "Document Type"::"Credit Memo":
                            PAGE.Run(PAGE::"Sales Credit Memo", SalesHeader);
                        "Document Type"::"Blanket Order":
                            PAGE.Run(PAGE::"Blanket Sales Order", SalesHeader);
                        "Document Type"::"Return Order":
                            PAGE.Run(PAGE::"Sales Return Order", SalesHeader);
                    end;
                end;
            DATABASE::"Purchase Header":
                begin
                    if not PurchHeader.Get("Document Type", "Document No.") then
                        exit;
                    case "Document Type" of
                        "Document Type"::Quote:
                            PAGE.Run(PAGE::"Purchase Quote", PurchHeader);
                        "Document Type"::Order:
                            PAGE.Run(PAGE::"Purchase Order", PurchHeader);
                        "Document Type"::Invoice:
                            PAGE.Run(PAGE::"Purchase Invoice", PurchHeader);
                        "Document Type"::"Credit Memo":
                            PAGE.Run(PAGE::"Purchase Credit Memo", PurchHeader);
                        "Document Type"::"Blanket Order":
                            PAGE.Run(PAGE::"Blanket Purchase Order", PurchHeader);
                        "Document Type"::"Return Order":
                            PAGE.Run(PAGE::"Purchase Return Order", PurchHeader);
                    end;
                end;

            //Other Customized Documents

            //Payment Voucher and Petty Cash
            DATABASE::"Payments Header":
                begin
                    if not PaymentsHeader.Get("Document No.") then
                        exit;
                    case "Document Type" of
                        "Document Type"::"Payment Voucher":
                            PAGE.Run(PAGE::"Payment Header", PaymentsHeader);
                        "Document Type"::"Petty Cash":
                            PAGE.Run(PAGE::"Cash Payment Header", PaymentsHeader);
                    end;
                end;

            //Imprests
            // DATABASE::"Imprest Header":
            //     begin
            //         if not ImprestHeader.Get("Document No.") then
            //             exit;
            //         case "Document Type" of
            //             "Document Type"::Imprest:
            //                 PAGE.Run(PAGE::"Imprest Request Header", ImprestHeader);
            //         end;
            //     end;

            //staff advance
            DATABASE::"Staff Advance Header":
                begin
                    if not StaffAdvance.Get("Document No.") then
                        exit;
                    case "Document Type" of
                        "Document Type"::"Staff Advance":
                            PAGE.Run(PAGE::"Staff Advance Request", StaffAdvance);
                    end;
                end;

            //Staff Advance Surrender Header
            DATABASE::"Staff Advance Surrender Header":
                begin
                    if not StaffAdvanceSurr.Get("Document No.") then
                        exit;
                    case "Document Type" of
                        "Document Type"::AdvanceSurrender:
                            PAGE.Run(PAGE::"Staff Advance Surrender", StaffAdvanceSurr);
                    end;
                end;



            //Store Requisition
            DATABASE::"Store Requistion Header":
                begin
                    if not SRHeader.Get("Document No.") then
                        exit;
                    case "Document Type" of
                    // "Document Type"::Requisition:
                    // PAGE.Run(PAGE::"Store Requisition Header", SRHeader);
                    end;
                end;

        //Imprest Surrender
        // DATABASE::"Imprest Surrender Header":
        //     begin
        //         if not ImprestSurr.Get("Document No.") then
        //             exit;
        //         case "Document Type" of
        //             "Document Type"::ImprestSurrender:
        //                 PAGE.Run(PAGE::"Imprest Surrender", ImprestSurr);
        //         end;
        end;
        //Interbank Transfer
        //     DATABASE::"InterBank Transfers":
        //         begin
        //             if not Interbank.Get("Document No.") then
        //                 exit;
        //             case "Document Type" of
        //                 "Document Type"::Interbank:
        //                     PAGE.Run(PAGE::"Bank & Cash Transfer Request", Interbank);
        //             end;
        //         end;

        //     else
        //         exit;
        // end;
    end;
}

