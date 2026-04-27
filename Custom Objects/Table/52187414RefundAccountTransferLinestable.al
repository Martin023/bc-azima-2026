table 52187414 "Refund,Account Transfer lines"
{
    Caption = 'Refund And Account Transfer';
    DrillDownPageID = "Refund,Account Transfer Lines";
    LookupPageID = "Refund,Account Transfer Lines";
    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            NotBlank = false;
        }
        field(2; "Account No."; Code[20])
        {
            TableRelation = "Savings Accounts"."No." WHERE("Member No." = field("Member No."), "Product Type" = field("Product Type"));
            ValidateTableRelation = true;

            trigger OnValidate()
            begin
                Acc.Reset;
                Acc.SetRange(Acc."No.", "Account No.");
                if Acc.Find('-') then begin
                    if "Staff No." = '' then
                        "Staff No." := Acc."Payroll/Staff No.";
                    Validate("Staff No.", Acc."Payroll/Staff No.");
                    "Member No." := Acc."Member No.";
                    Status := Acc.Status;
                    Blocked := Acc.Blocked;
                    Name := Acc.Name;
                    "ID No." := Acc."ID No.";
                end;

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
                Acc.Reset;
                Acc.SetRange(Acc."Payroll/Staff No.", "Staff No.");

                if Acc.Find('-') then begin
                    if "Account No." = '' then
                        "Account No." := Acc."No.";
                    "Member No." := Acc."Member No.";
                    Status := Acc.Status;
                    Blocked := Acc.Blocked;
                    Name := Acc.Name;
                    "Staff No." := Acc."Payroll/Staff No.";
                    "Product Type" := Acc."Product Type";
                end;
            end;
        }
        field(4; Name; Text[50])
        {

        }
        field(5; Amount; Decimal)
        {
            caption = 'Amount';
            trigger OnValidate()
            var
                Savacc: Record "Savings Accounts";
                Loans: Record Loans;
            begin
                if Amount <= 0 then Error('Transaction cannot be less than zero.');
                if Rec."Source Account" <> '' then
                    if Rec.Amount > Savacc.GetAvailableBalance(rec."Source Account") then
                        error('Amount Surpasses balance available in the source account');
                if Rec."Source Loan No." <> '' then begin
                    rec.TestField("Source Loan Transaction.");
                    if Loans.get("Source Loan No.") then begin
                        Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                        if -(Loans."Outstanding Balance" + Loans."Outstanding Interest") < Rec.Amount then
                            Message('The loan does not have excess to cover the amount');
                    end;
                end;
            end;
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
        field(12; Reversed; Boolean)
        {
        }
        field(13; "Account Name"; Text[50])
        {
        }
        field(14; "ID No."; Code[30])
        {
            Editable = true;
        }
        field(15; Closed; Boolean)
        {
        }
        field(16; "Blocked Accounts"; Boolean)
        {
            Editable = false;
        }
        field(17; "Refund Header No."; Code[50])
        {
        }
        field(18; "Employer Code"; Code[50])
        {
            Editable = false;

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
            TableRelation = Members."No.";
            trigger OnValidate()
            begin
                if Rec."Product Type" <> '' then
                    Rec.Validate(Rec."Product Type");
            end;
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
        field(29; "Product Type"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID";
            trigger OnValidate()
            begin
                "Account No." := '';
                Rec.TestField("Member No.");
                savingsAccounts.reset;
                savingsAccounts.SetRange(savingsAccounts."Member No.", Rec."Member No.");
                savingsAccounts.SetRange("Product Type", Rec."Product Type");
                if savingsAccounts.Find('-') then begin
                    Rec."Account No." := savingsAccounts."No.";
                    Rec.Validate("Account No.");
                end;// else
                    //   Error('Account not found');
            end;
        }
        field(30; "Upload Response"; Integer)
        {
            Editable = false;
        }
        field(31;"Destination Description"; Text[50])
        {
        }
        field(32; AccNo; Code[50])
        {
            TableRelation = "G/L Account"."No.";
        }

        field(33; "Source Account"; Code[20])
        {

            TableRelation = if ("Member No." = filter(<> '')) "Savings Accounts"."No." where("Member No." = field("Member No."), "Product Type" = filter('002|011'))
            else
            if ("Member No." = filter('')) "Savings Accounts"."No.";
            trigger OnValidate()
            begin
                Name := '';
                Amount := 0;
                "Destination Account" := '';
                "Loan No." := '';
                if savingsAccounts.get("Source Account") then
                    Name := savingsAccounts.Name;
            end;

        }

        field(34; "Destination Account"; Code[20])
        {
            // TableRelation = "Savings Accounts"."No.";
            TableRelation = if ("Member No." = filter(<> '')) "Savings Accounts"."No." where("Member No." = field("Member No."))
            else
            if ("Member No." = filter('')) "Savings Accounts"."No.";
            trigger OnValidate()
            begin
                "Account Name" := '';
                "Loan No." := '';
                if savingsAccounts.get("Destination Account") then
                    "Account Name" := savingsAccounts.Name;
            end;

        }

        field(35; "Loan No."; Code[20])
        {
            //TableRelation = Loans."Loan No.";
            TableRelation = if ("Member No." = filter(<> '')) Loans."Loan No." where("Member No." = field("Member No."))
            else
            if ("Member No." = filter('')) Loans."Loan No.";
            trigger OnValidate()
            begin
                if "Destination Account" <> '' then Error('Destination Account should not have a value.');
                if Amount > 0 then begin
                    if loans.get("Loan No.") then begin
                        Loans.CalcFields("Daily Interest", "Outstanding Balance", "Outstanding Interest");
                        if (loans."Daily Interest" + loans."Outstanding Balance" + loans."Outstanding Interest") < amount then
                            Error('This will lead to overpayment of loan: Total Loan balance is %1.', (loans."Daily Interest" + loans."Outstanding Balance" + loans."Outstanding Interest"));

                    end;
                end;
                if loans.get(Rec."Loan No.") then begin
                    loans.CalcFields("Daily Interest", "Outstanding Balance", "Outstanding Interest");
                    rec."Total Destination Loan Balance" := loans."Daily Interest" + loans."Outstanding Balance" + loans."Outstanding Interest";
                    Rec."Account Name" := Loans."Member Name";
                end
                else
                    Error('Loan not found in the loans table');
            end;
        }
        field(36; "Source Loan No."; Code[20])
        {
            TableRelation = Loans."Loan No.";
            trigger OnValidate()
            begin
                if "Source Account" <> '' then Error('Source Account should not have a value!.');
            end;

        }
        field(37; "Source Loan Transaction."; Enum "Transaction Types")
        {
            ValuesAllowed = " ", Loan, "Interest Due";
        }
        field(43; "Originating Unit"; Option)
        {
            OptionMembers = General,"Business Loans";
        }
        field(44; Validated; Boolean)
        {
        }
        field(45; "Non Validated Reason"; Text[250])
        {
        }

        // Added to avoid over payment of loan
        field(46; "Total Destination Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(47; "Recover Arrears"; Boolean)
        {

        }
        field(48; "Message"; Text[250])
        {

        }
        field(49;"Source Description"; Text[50])
        {
        }

    }

    keys
    {
        key(Key1; "Refund Header No.", "No.", "Member No.")
        {
            Clustered = true;
        }
    }


    fieldgroups
    {
    }

    var
        Acc: Record "Savings Accounts";

        SalaryHeader: Record "Salary Header";

        Refundlines: Record "Refund,Account Transfer lines";
        RefundHeader: Record "Refund,Account Transfer Header";
        savingsAccounts: Record "Savings Accounts";
        Loans: record Loans;
}

