table 52185897 "Payments Header Delegates"
{
    DrillDownPageID = "Payment Voucher Delegate  List";
    LookupPageID = "Payment Voucher Delegate  List";

    fields
    {
        field(1; "Transaction No."; Code[20])
        {
        }
        field(2; Amount; Decimal)
        {
        }
        field(3; "Cheque No."; Code[20])
        {
        }
        field(4; "Cheque Date"; Date)
        {
        }
        field(5; Posted; Boolean)
        {
        }
        field(6; "Bank No."; Code[10])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(7; "User ID"; Code[50])
        {
        }
        field(8; "Allocated Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line Delegate".Amount WHERE("Document No" = FIELD("Transaction No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Transaction Date"; Date)
        {
        }
        field(10; "Transaction Time"; Time)
        {
        }
        field(11; "No. Series"; Code[10])
        {
        }
        field(12; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Pending,Pending Approval,Approved,Posted,Cancelled';
            OptionMembers = Pending,"Pending Approval",Approved,Posted,Cancelled;
        }
        field(13; "Posted By"; Code[50])
        {
        }
        field(14; "File Location"; Text[30])
        {
        }
        field(15; Remarks; Text[50])
        {
        }
        field(67; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Letter of Credit",mpesa,"Custom 4","Custom 5";
        }
        field(68; "Payment Type"; Option)
        {
            OptionMembers = Board,Staff;
        }
        field(69; "Responsibility Center"; Code[10])
        {
            Editable = true;
            TableRelation = "Responsibility Center";
        }
        field(70; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(71; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(72; "Transaction Code"; Code[30])
        {
            TableRelation = "Transaction Types".Code WHERE(Code = CONST('ALLPROFEE'));
        }
        field(73; "Gross Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line Staff".Amount WHERE("Document No" = FIELD("Transaction No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(74; "WTax Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line Staff"."W/Tax Amount" WHERE("Document No" = FIELD("Transaction No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(75; "Net Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line Staff"."Net Amount" WHERE("Document No" = FIELD("Transaction No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Transaction No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        if Posted then
            Error('Cannot modify a posted transaction');
    end;

    trigger OnInsert()
    begin

        if "Transaction No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Delegate  PVs Nos.");
            "Transaction No." := NoSeriesMgt.GetNextNo(NoSetup."Delegate  PVs Nos.");   
            // NoSeriesMgt.InitSeries(NoSetup."Delegate  PVs Nos.", xRec."No. Series", 0D, "Transaction No.", "No. Series");
        end;

        "Transaction Date" := Today;
        "User ID" := UserId;
        "Transaction Time" := Time;
        UserSetup.Get(UserId);
        //BEGIN
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");
        UserSetup.TestField("Responsibility Centre");

        "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        "Responsibility Center" := UserSetup."Responsibility Centre";
    end;

    trigger OnModify()
    begin

        if Posted then
            Error('Cannot modify a posted transaction');
    end;

    var
        Cust: Record Members;
        NoSetup: Record "Cash Office Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        BOSARcpt: Record "Receipts and Payment Types";
        GLAcct: Record "G/L Account";
        UserSetup: Record "User Setup";
}

