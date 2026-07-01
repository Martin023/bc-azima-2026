table 52185784 "Salary Lines"
{
    DrillDownPageId = "Salary Lines";
    LookupPageId = "Salary Lines";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            NotBlank = false;
        }
        field(2; "Account No."; Code[20])
        {
            // TableRelation = "Savings Accounts"."No." where("Product Category" = filter("FOSA Account" | SAYE), "Loan Disbursement Account" = filter(true));
            TableRelation = "Savings Accounts"."No." where("Product Category" = filter("FOSA Account"), "Product Type" = const('191'));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if "Account No." = '' then begin
                    "Member No." := '';
                    Name := '';
                    Amount := 0;
                end;
            end;
        }
        field(3; "Staff No."; Code[20])
        {

            trigger OnValidate()
            begin
                if SalaryHeader.Get("Salary Header No.") then
                    SalaryHeader.TestField("Employer Code");
                Acc.Reset;
                Acc.SetRange(Acc."Payroll/Staff No.", "Staff No.");
                Acc.SetRange("Employer Code", SalaryHeader."Employer Code");
                Acc.SetRange("Product Category", Acc."Product Category"::"FOSA Account");
                if Acc.Find('-') then begin
                    if "Account No." = '' then
                        "Account No." := Acc."No.";
                    "Member No." := Acc."Member No.";
                    Status := Acc.Status;
                    Blocked := Acc.Blocked;
                    Name := Acc.Name;
                end;
            end;
        }
        field(4; Name; Text[50])
        {
            Editable = false;
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Account Not Found"; Boolean)
        {
            Editable = false;
        }
        field(7; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(8; Processed; Boolean)
        {
        }
        field(9; "Document No."; Code[20])
        {
        }
        field(10; Date; Date)
        {
        }
        field(11; "Multiple Salary"; Boolean)
        {
        }
        field(12; Reversed; Boolean)
        {
        }
        field(13; "Account Name"; Text[50])
        {
        }
        field(14; "ID No."; Code[30])
        {
            Editable = false;
        }
        field(15; Closed; Boolean)
        {
        }
        field(16; "Blocked Accounts"; Boolean)
        {
            Editable = false;
        }
        field(17; "Salary Header No."; Code[50])
        {
        }
        field(18; "Employer Code"; Code[50])
        {
            TableRelation = Customer."No." where("Account Type" = const("Employer Code"));
            trigger OnValidate()
            begin
                /*
               IF "Employer Code"<> SalProcessingHeader."Employer Code" THEN  BEGIN
               "Employer/ Staff Mismatch":=TRUE;
               MODIFY;
               END;
               */

            end;
        }
        field(19; "Employer/ Staff Mismatch"; Boolean)
        {
        }
        field(20; "Member No."; Code[20])
        {
        }
        field(21; Status; Enum "Savings Account Status")//Option)
        {
            Editable = true;
            // OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
            // OptionMembers = " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;

            trigger OnValidate()
            begin
                //IF (Status<>Status::New) OR (Status<>Status::Closed) THEN
                //Blocked:=Blocked::All;
            end;
        }
        field(22; Blocked; Option)
        {
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        field(23; Posted; Boolean)
        {
            Editable = false;
        }
        field(24; "Posted By"; Code[30])
        {
        }
        field(25; "Posting Date"; Date)
        {
            Editable = false;
        }
        field(26; "Posting Time"; Time)
        {
            Editable = false;
        }
        field(27; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,Blocked);
            end;
        }
        field(28; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Last Date Modified");
            end;
        }
        field(31; "Income Type"; Enum "Salary Income Types")
        {
            Caption = 'Income Type';
        }
        field(32; "Actual Date Posted"; Date)
        {

        }
        field(33; "Paid Within Month"; Boolean)
        {
            editable = false;
        }
        field(34; "Transaction Type"; code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = CONST("Salary Processing"));
        }


    }

    keys
    {
        key(Key1; "Salary Header No.", "No.")
        {
            Clustered = true;
        }

        // Secondary keys for non-primary fields
        key(IdxMemberNo; "Member No.")
        {
            Clustered = false;
        }

        key(IdxPosted; "Posted")
        {
            Clustered = false;
        }

        key(IdxPostingDate; "Posting Date")
        {
            Clustered = false;
        }

        key(IdxAccountNo; "Account No.")
        {
            Clustered = false;
        }

        key(IdxAmount; "Amount")
        {
            Clustered = false;
        }

        // Composite keys for efficient queries involving multiple fields
        key(IdxMemberNoPosted; "Member No.", "Posted")
        {
            Clustered = false;
        }

        key(IdxMemberNoPostingDate; "Member No.", "Posting Date")
        {
            Clustered = false;
        }

        key(IdxAccountNoPostingDate; "Account No.", "Posting Date")
        {
            Clustered = false;
        }

        key(IdxMemberNoAccountNo; "Member No.", "Account No.")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
    }

    var
        Acc: Record "Savings Accounts";
        SalaryHeader: Record "Salary Header";
}

