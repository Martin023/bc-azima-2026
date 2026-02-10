table 52186243 "Board Payroll Deductions"
{
    //DrillDownPageId = 
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Deduction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Savings,Loans';
            OptionMembers = ,Savings,Loans;
            trigger OnValidate()
            var
                myInt: Integer;
                BoardTr: Record "Board members";
            begin
                BoardTr.Reset();
                BoardTr.SetRange("No.", Rec."Document No");
                if BoardTr.FindFirst() then begin
                    Rec."Member No" := BoardTr."Member No.";
                    Rec."member Name" := BoardTr."Member Name";
                end;
            end;
        }
        field(2; "Member No"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(7; "Related No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Deduction Type" = const(Loans)) Loans where("Member No." = field("Member No"), "Outstanding Balance" = filter(> 0)) else
            if ("Deduction Type" = const(Savings)) "Savings Accounts" where("Member No." = field("Member No"));
            trigger OnValidate()
            var
                myInt: Integer;
                BoardTrans: Record "PR Board Transactions";
                LoansRec: Record Loans;
            begin
                if "Deduction Type" = "Deduction Type"::Loans then begin
                    LoansRec.Reset();
                    LoansRec.SetRange("Member No.", Rec."Member No");
                    if LoansRec.FindFirst() then begin
                        Rec."Amount LCY" := LoansRec.Repayment;
                    end;
                end;

            end;
        }
        field(8; "Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(487; "Earnings & Deductions"; Decimal)
        {
            FieldClass = FlowField;
            calcformula = sum("PR Board Transactions".Amount where("No." = field("Document No")));
        }
        field(488; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
    }
    keys
    {
        key(Key1; "Document No", "Member No", "Related No.", "Entry No")
        {
            Clustered = true;
        }
        key(Key4; "Amount LCY")
        {
            SumIndexFields = "Amount LCY";
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}