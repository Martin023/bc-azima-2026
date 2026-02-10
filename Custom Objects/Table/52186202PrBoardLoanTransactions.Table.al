table 52186202 "PrBoard Loan Transactions"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "prBoard Deductions" WHERE(Loan = CONST(true));

            trigger OnValidate()
            begin
                if Deductions.Get(Code) then begin
                    Name := Deductions.Description;
                    "Maximum limit" := Deductions."Maximum Amount";
                    "Repayment Grace period" := Deductions."Grace period";
                    "Repayment Period" := Deductions."Repayment Period";
                end;
                if EmpRec.Get(Employee) then
                    "Debtor Code" := EmpRec."Debtor Code";
            end;
        }
        field(2; Name; Text[30])
        {
        }
        field(3; Employee; Code[20])
        {
            TableRelation = "Board members";
        }
        field(4; "Maximum limit"; Decimal)
        {
        }
        field(5; "Loan Amount"; Decimal)
        {
        }
        field(6; "Repayment Grace period"; DateFormula)
        {
        }
        field(7; "Repayment Period"; DateFormula)
        {
        }
        field(8; "Outstanding Amount"; Decimal)
        {
        }
        // field(9; "Amount Paid"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(10; "Period Repayments"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Period Repayments" <> 0 then begin
                    "No. of Repayments Period" := Round("Loan Amount" / "Period Repayments", 1);

                end;
            end;
        }
        field(11; "Repayment Begin Date"; Date)
        {
        }
        field(12; "Repayment End Date"; Date)
        {
        }
        field(13; "Loan Date"; Date)
        {

            trigger OnValidate()
            begin
                "Repayment Begin Date" := CalcDate("Repayment Grace period", "Loan Date");
                "Repayment End Date" := CalcDate("Repayment Period", "Repayment Begin Date");
            end;
        }
        field(14; "No. of Repayments Period"; Integer)
        {
            InitValue = 1;

            trigger OnValidate()
            begin
                if "No. of Repayments Period" <> 0 then
                    "Period Repayments" := "Loan Amount" / "No. of Repayments Period";
                "Period Repayments" := Round("Period Repayments", 1, '>');
            end;
        }
        field(15; "Interest Rate"; Decimal)
        {
        }
        field(16; "Opening Balance"; Decimal)
        {
        }
        field(17; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;

        }
        field(18; "Interest Type"; Option)
        {
            OptionMembers = " ",Amortized,Compound,Simple,"Simple Reducing Balance";

            trigger OnValidate()
            begin
                TestField("Loan Amount");
                TestField("Interest Rate");
                TestField("No. of Repayments Period");
                TestField("Outstanding Amount");

                if "Interest Type" = "Interest Type"::Amortized then begin
                    //EMI
                    if "Interest Type" = "Interest Type"::Amortized then begin
                        Rate := (("Interest Rate" / 12) / 100);
                        Power1 := Power((1 + Rate), "No. of Repayments Period");
                        EMI := ("Loan Amount" * Rate) * (Power1 / (Power1 - 1));
                        "Remaining Months" := "No. of Repayments Period" - 1;
                    end;
                    //EMI

                end;
            end;
        }
        // field(19; "Interest Repaid to Date"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        // field(20; "Cumm. Period Repayments"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(21; "Bal Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(22; "Bal Account No"; Code[10])
        {
            TableRelation = IF ("Bal Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal Account Type" = CONST("Bank Account")) "Bank Account";
        }
        field(23; "Interest Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(24; "Debt Updated"; Boolean)
        {
        }
        field(25; "Debtor Code"; Code[10])
        {
            TableRelation = Customer;
        }
        field(26; "External Interest Rate"; Decimal)
        {
        }
        // field(27; "Cumm. Period Repayments1"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(28; "Original Loan Amount"; Decimal)
        {
        }
        field(29; "HELB LOAN"; Boolean)
        {
        }
        field(30; EMI; Decimal)
        {
        }
        field(31; "Remaining Months"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Deductions: Record "prBoard Deductions";
        EmpRec: Record "Board members";
        Rate: Decimal;
        Power1: Decimal;
}

