table 52187078 "System Reversal"
{
    ReplicateData = false;
    LookupPageId = "System Reversal List";
    DrillDownPageId = "System Reversal List";
    fields
    {
        field(1; "No."; Code[30])
        {
            Editable = false;
        }
        field(2; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
        }

        field(3; "Select From"; Option)
        {
            OptionMembers = "G/L Entry","Customer Ledger Entry","Vendor Ledger Entry","Savings Ledger Entry","Credit Ledger Entry";
        }
        field(4; "Entry No."; Integer)
        {
            TableRelation = if ("Select From" = const("G/L Entry")) "G/L Entry"."Entry No." where(Reversed = const(false)) else
            if ("Select From" = const("Customer Ledger Entry")) "Cust. Ledger Entry"."Entry No." where(Reversed = const(false)) else
            if ("Select From" = const("Vendor Ledger Entry")) "Vendor Ledger Entry"."Entry No." where(Reversed = const(false)) else
            if ("Select From" = const("Savings Ledger Entry")) "Savings Ledger Entry"."Entry No." where(Reversed = const(false)) else
            if ("Select From" = const("Credit Ledger Entry")) "Credit Ledger Entry"."Entry No." where(Reversed = const(false));

            trigger OnValidate()
            var
                myInt: Integer;
                GLEntry: Record "G/L Entry";
                CustEntry: Record "Cust. Ledger Entry";
                VendEntry: Record "Vendor Ledger Entry";
                SavingsEntry: Record "Savings Ledger Entry";
                CreditEntry: Record "Credit Ledger Entry";
                GlRegister: Record "G/L Register";
                Loansrec: Record Loans;
                BankledgerEntry: Record "Bank Account Ledger Entry";
            begin
                "Transaction Description" := '';
                "Document No" := '';
                rec."Member No" := '';
                rec."Member Name" := '';
                GLEntry.reset;
                GLEntry.SetRange("Entry No.", Rec."Entry No.");
                if GLEntry.Find('-') then begin
                    "Transaction Description" := GLEntry.Description;
                    rec."Document No" := GLEntry."Document No.";
                end;
                Loansrec.Reset();
                Loansrec.SetRange(Loansrec."Loan No.", Rec."Document No");
                if Loansrec.FindFirst() then begin
                    rec."Member No" := Loansrec."Member No.";
                    Rec."Member Name" := Loansrec."Member Name";
                end;
                GlRegister.Reset;
                if GlRegister.Find('-') then begin
                    repeat
                        if ("Entry No." >= GlRegister."From Entry No.") and ("Entry No." <= GlRegister."To Entry No.") then begin

                            "Transaction Number" := GlRegister."No.";
                            BankledgerEntry.Reset;
                            BankledgerEntry.SetRange("Entry No.", GlRegister."From Entry No.", GlRegister."To Entry No.");
                            if BankledgerEntry.FindFirst then begin
                                if not BankLedgerEntry.Open then
                                    Error('Reversal is not permitted because the related bank account ledger entry has already been reconciled.');
                            end;
                        end;
                    until GlRegister.Next = 0;
                end;
            end;

        }
        field(5; "Transaction Number"; Integer)
        {

        }
        field(6; "G/L Register No"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = "G/L Register";
        }
        field(7; "Reversal Date"; Date)
        {
        }

        field(8; "From Entry No"; Integer)
        {
        }

        field(9; "To Entry No"; Integer)
        {

        }
        field(10; Comments; Text[250])
        {
            Caption = 'Comments';
        }

        field(11; "Approved by User ID"; Code[50])
        {
            Caption = 'Approved by User ID';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
        }
        field(12; "Created by User ID"; Code[50])
        {
            Caption = 'Created by User ID';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
        }

        field(13; Status; enum "Workflow Status Main Flags")
        {
            Editable = false;
        }
        field(14; Reversed; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Entry".Reversed where("Entry No." = field("Entry No.")));
            Editable = false;
        }

        field(25; "Reversed by"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Entry"."User ID" where("Entry No." = field("Entry No."), Reversed = const(true)));
            Editable = false;
        }
        field(15; "Creation Date"; Date)
        {
            Editable = false;
        }
        field(16; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(18; "Transaction Date"; Date)
        {
            Editable = false;
        }
        field(19; "Document No"; Code[20])
        {
            Editable = false;
        }
        field(20; "Transaction Description"; Text[50])
        {
            Editable = false;
        }
        field(21; "Approved date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Member No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(70; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

    end;

    trigger OnInsert()
    begin
        if "No." = '' then
            "No." := NoSeriesMgt.GetNextNo('EDITS');
        // NoSeriesMgt.InitSeries('EDITS', xRec."No. Series", 0D, "No.", "No. Series");

        "Created by User ID" := UserId;
        "Created By" := UserId;
        "Creation Date" := today;
        //"Transaction Date" := Today;
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst then begin
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";

        end;
    end;

    trigger OnRename()
    begin
    end;

    var
        ConfigValidateMgt: Codeunit "Config. Validate Management";
        ConfigMgt: Codeunit "Config. Management";
        ConfigPackageMgt: Codeunit "Config. Package Management";
        Text001: Label 'You cannot use system table %1 in the package.';
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        SystemEditsCodeunit: Codeunit "System Editss";
        CreditNoSeries: Record "Credit Nos. Series";
        RegisterNo: Integer;
        FromEntry: Integer;
        ToEntry: Integer;
        GlRegister: Record "G/L Register";
        UserSetup: Record "User Setup";
}

