table 52185428 Resignation
{

    fields
    {
        field(3; "Ln No"; Code[20])
        {
        }
        field(5; Updated; Boolean)
        {
        }
        field(6; "STO Effective Date"; Option)
        {
            OptionCaption = ' ,03rd,05th,10th,15th,20th,25th,28th';
            OptionMembers = " ","03rd","05th","10th","15th","20th","25th","28th";
        }
        field(7; "BNK Code"; Code[10])
        {
            TableRelation = "Bank Code Structure";
        }
        field(8; "Account No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Ln No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Loans.Reset;
        Loans.SetRange("Loan No.", Rec."Ln No");
        if Loans.FindFirst then begin
            Loans."External STO Effective Date" := Rec."STO Effective Date";
            Loans."Client Bank Code" := "BNK Code";
            Loans."Client Account No" := "Account No";
            Loans."Recovery Mode" := Loans."Recovery Mode"::"External STO";




            Loans.Modify;
            Updated := true;
        end;
    end;

    var
        emp: Record "HR Employees";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Accounts: Record "Savings Accounts";
        Loans: Record Loans;
}

