table 52185444 "Loan Clearance Lines"
{
    Caption = 'Refund And Account Transfer';
    DrillDownPageID = "Loan Clearance Lines";
    LookupPageID = "Loan Clearance Lines";
    fields
    {

        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            NotBlank = false;
        }
        field(2; "Header No."; Code[50])
        {
        }
        field(3; "Member No."; Code[20])
        {
            TableRelation = Members."No.";
            trigger OnValidate()
            begin
                CalcFields(Name);
                "Source Account No." := '';
                "Loan No." := '';
                "Source Account Balance" := 0;
                "Interest Balance" := 0;
                "Principle Balance" := 0;
                "Total Balance" := 0;
            end;
        }
        field(4; Name; Text[100])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Members.Name where("No." = Field("Member No.")));
        }
        field(5; "Source Account Type"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID" WHERE("Product Class Type" = const(Savings));
            ValidateTableRelation = true;
            Editable = false;

            trigger OnValidate()
            begin
                
            end;
        }
        field(6; "Source Account Name"; Text[100])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Product Factory"."Product Description" where("Product ID" = Field("Source Account Type")));
        }
        field(7; "Source Account No."; Code[20])
        {
            TableRelation = "Savings Accounts"."No." WHERE("Member No." = field("Member No."));
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                SavingsAccounts: Record "Savings Accounts";
                ProductFactory: Record "Product Factory";
            begin
                "Loan No." := '';
                "Source Account Balance" := 0;
                "Interest Balance" := 0;
                "Principle Balance" := 0;
                "Total Balance" := 0;
                if "Source Account No." <> '' then
                    "Source Account Balance" := SavingsAccounts.GetAvailableBalance("Source Account No.");

                if SavingsAccounts.Get("Source Account No.") then begin
                    if ProductFactory.Get(SavingsAccounts."Product Type") then begin
                        "Source Account Type" := ProductFactory."Product ID";
                        CalcFields("Source Account Name");
                    end;
                end;
            end;
        }
        field(8; "Source Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(9; "Loan Product Type"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID" WHERE("Product Class Type" = const(Loan));
            ValidateTableRelation = true;

            trigger OnValidate()
            begin
               
            end;
        }
        field(10; "Loan Product Type Name"; Text[100])
        {

            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Product Factory"."Product Description" where("Product ID" = Field("Loan Product Type")));

        }

        field(11; "Loan No."; Code[20])
        {
            //TableRelation = Loans."Loan No.";
            TableRelation = Loans."Loan No." WHERE("Member No." = field("Member No."),"Total Balance" = filter(>0));

            trigger OnValidate()
            var
                Loans: Record Loans;
                RecoveryHeader: Record "Loan Recovery Header";
                ClearanceLines: Record "Loan Clearance Lines";
                TotalBal: Decimal;
                ProductFactory: Record "Product Factory";
            begin
                TestField("Source Account No.");

                if Loans.Get("Loan No.") then begin
                    "Loan Account" := Loans."Loan Account";
                    if ProductFactory.Get(Loans."Loan Product Type") then begin
                        "Loan Product Type" := ProductFactory."Product ID";
                        CalcFields("Loan Product Type Name");
                    end;
                end;
                if "Loan Account" = '' then Error('Loan must have a loan account');

                "Interest Balance" := 0;
                "Principle Balance" := 0;
                "Total Balance" := 0;

                RecoveryHeader.GetLoanBalances("Loan No.", "Interest Balance", "Principle Balance", "Total Balance");

                //Check dublicates
                ClearanceLines.Reset();
                ClearanceLines.SetRange("Header No.", Rec."Header No.");
                ClearanceLines.SetFilter("Entry No.", '<>%1', Rec."Entry No.");
                ClearanceLines.SetRange("Loan No.", Rec."Loan No.");
                if ClearanceLines.FindFirst() then
                    Error('This loan number %1 has already been filled in the lines', "Loan No.");

                ClearanceLines.Reset();
                ClearanceLines.SetRange("Header No.", Rec."Header No.");
                ClearanceLines.SetFilter("Entry No.", '<>%1', Rec."Entry No.");
                ClearanceLines.SetRange("Source Account No.", Rec."Source Account No.");
                if ClearanceLines.Find('-') then begin
                    repeat
                        TotalBal += ClearanceLines."Total Balance";
                    until ClearanceLines.Next() = 0;
                end;

                //CalculateLiabilities Against Assests
                if TotalBal + "Total Balance" > "Source Account Balance" then Error('Total liabilities KES %1 is greater than the account balance %2', TotalBal+"Total Balance", "Source Account Balance");

                
            end;
        }
        field(12; "Interest Balance"; Decimal)
        {
            Editable = false;
        }
        field(13; "Principle Balance"; Decimal)
        {
            Editable = false;
        }
        field(14; "Total Balance"; Decimal)
        {
            Editable = false;
        }
        field(15; "Loan Account"; code[100])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Header No.")
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
}

