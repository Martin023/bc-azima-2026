table 52185853 "BBF Claim Lines"
{
    LookupPageID = "Next of KIN";

    fields
    {
        field(1; "Header No."; Code[30])
        {
        }
        field(2; "Product Code"; Code[20])
        {
            TableRelation = "Product Factory";
            trigger OnValidate()
            var
            begin
                CalcFields("Product Name", "Product Category");
            end;
        }
        field(3; "Product Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Product Description" where("Product ID" = field("Product Code")));
        }
        field(4; "Outstanding Interest"; Decimal)
        {

        }
        field(5; "Outstanding Balance"; Decimal)
        {
        }
        field(6; "Total Balance"; Decimal)
        {

        }
        field(7; "Amount Allocated"; Decimal)
        {
            MinValue = 0;
            Editable = false;
            trigger OnValidate()
            var
                SinkReport: Record "SinkFund Report Information";
                AmtAllocatedErr: Label 'Ensure that the amount allocated does not exceed the total balance!';
                BBFClaimLines: Record "BBF Claim Lines";
                TotalAmountAllocated: Decimal;
                TotalAmtAllocatedErr: Label 'The total amount allocated cannot exceed the receipt amount!';
            begin
                TestField("Product Class Type", "Product Class Type"::Loan);
                // SinkReport.Get("Header No.");
                if "Amount Allocated" > "Total Balance" then
                    Error(AmtAllocatedErr);

                BBFClaimLines.Reset();
                BBFClaimLines.SetRange("Header No.", "Header No.");
                BBFClaimLines.CalcSums("Amount Allocated");

                TotalAmountAllocated := (BBFClaimLines."Amount Allocated" + "Amount Allocated") - xRec."Amount Allocated";

                if SinkReport.Get("Header No.") then begin
                    if TotalAmountAllocated > SinkReport."Available Beneficiary Amount" then
                        Error(TotalAmtAllocatedErr);

                    SinkReport.UpdateAvailableBeneficiaryAmount();
                end;
            end;

        }
        field(8; "Product Class Type"; Option)
        {
            Description = 'Whether Loan Accounts or Operational accounts';
            OptionCaption = ' ,Loan,Savings';
            OptionMembers = " ",Loan,Savings;
        }
        field(9; "Account No"; Code[30])
        {
            TableRelation = if ("Product Class Type" = filter(Loan)) "Credit Accounts"."No." where("Product Type" = field("Product Code"))
            else
            if ("Product Class Type" = filter(Savings)) "Savings Accounts"."No." where("Product Type" = field("Product Code"));
        }
        field(10; "Loan No."; Code[30])
        {

        }
        field(11; "Product Category"; Enum "Product Categories")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Product Category" where("Product ID" = field("Product Code")));
        }


    }

    keys
    {
        key(Key1; "Header No.", "Product Code", "Loan No.")
        {
            Clustered = true;
        }
    }

    var
        NOK: Record "Next of KIN";
        TotalA: Decimal;
        NOK1: Record "Next of KIN";
        AccountM: Record Members;
        Loan: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        KinDetails: Record "Next of KIN";
        AccountF: Record "Savings Accounts";
        BHeader: Record "Payments Header";
        ErrorOnDelMod: Label 'You cannot DELETE or MODIFY a Document whose status is %1';
        Err0001: Label 'Amount Paid cannot be more than claimed';

    [Scope('OnPrem')]
    procedure FieldLength(VarVariant: Text; FldLength: Integer): Text
    var
        FieldLengthError: Label 'Field cannot be more than %1 Characters.';
    begin
        if StrLen(VarVariant) > FldLength then
            Error(FieldLengthError, FldLength);
    end;

    internal procedure UpdateLineBufferAmount()
    begin
        case "Product Class Type" of
            "Product Class Type"::Loan:
                begin
                    Loan.Reset();
                    Loan.SetRange("Loan No.", "Loan No.");
                    Loan.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest", "Total Balance");
                    if Loan.FindSet() then
                        repeat
                            "Outstanding Balance" := Loan."Outstanding Balance";
                            "Outstanding Interest" := Loan."Outstanding Interest";
                            "Total Balance" := Loan."Total Balance";
                            "Amount Allocated" := Loan."Total Balance";
                            Modify();
                        until Loan.Next() = 0;
                end;
            "Product Class Type"::Savings:
                begin
                    if SavingsAccounts.Get("Account No") then begin
                        "Total Balance" := SavingsAccounts.GetAvailableBalance("Account No");
                        "Amount Allocated" := "Total Balance";
                        Modify();
                    end;
                end;
        end;
    end;
}

