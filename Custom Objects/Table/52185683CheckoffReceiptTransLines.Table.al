table 52185683 "Checkoff  Receipt Trans Lines"
{
    DrillDownPageID = "Checkoff Receipt Trans Lines";
    LookupPageID = "Checkoff Receipt Trans Lines";

    fields
    {
        field(1; "Transaction No"; Code[20])
        {
            Editable = false;
        }
        field(2; "Member No"; Code[20])
        {
        }
        field(3; "Transaction Type"; enum "Transaction Types")
        {
            trigger OnValidate()
            var
                ErrorOnInvalidTransType: Label 'Transaction type -%1- is disabled on this document. Please contact your system administrator.';
            begin
                case "Transaction Type" of
                    "Transaction Type"::Loan:
                        begin
                            Error(ErrorOnInvalidTransType, "Transaction Type");
                        end;
                end;
            end;
        }
        field(4; "Loan No"; Code[20])
        {
            TableRelation = Loans WHERE("Member No." = FIELD("Member No"),
                                         Posted = CONST(true),
                                         "Loan Account" = FIELD("Account No"));

            trigger OnValidate()
            begin
                Loans.Reset;
                Loans.SetRange(Loans."Loan No.", "Loan No");
                if Loans.Find('-') then begin
                    Loans.CalcFields("Outstanding Balance", "Outstanding Bills");
                    "Outstanding Balance" := Loans."Outstanding Balance";
                    "Outstanding Bill" := Loans."Outstanding Bills";
                end;
            end;
        }
        field(5; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                if Amount < 0 then Error('Amount cannot be less than zero');

                AmountDifference := 0;
                AmountTotal := 0;

                //Control LOAN Repayment.
                case "Transaction Type" of
                    "Transaction Type"::Repayment:
                        begin
                            TestField("Loan No");
                            if Loans.Get("Loan No") then begin
                                Loans.CalcFields("Outstanding Balance", "Outstanding Bills");
                                if Amount > Loans."Outstanding Balance" then begin
                                    Error(ErrorMaxLoan, Format(Loans."Outstanding Balance"));
                                    Amount := Loans."Outstanding Balance";
                                    "Outstanding Balance" := Loans."Outstanding Balance";
                                    "Outstanding Bill" := Loans."Outstanding Bills";
                                end;
                            end;

                        end;
                end;

                //Control LOAN Interest.
                case "Transaction Type" of
                    "Transaction Type"::"Interest Paid":
                        begin
                            TestField("Loan No");
                            if Loans.Get("Loan No") then begin
                                Loans.CalcFields("Outstanding Interest");
                                if Amount > Loans."Outstanding Interest" then begin
                                    Error(ErrorMaxInterest, Format(Loans."Outstanding Interest"));
                                    Amount := Loans."Outstanding Interest";
                                end;
                            end;
                        end;
                end;

                //Control Savings Accounts.
                if savingsacc.Get("Account No") then begin

                    savingsacc.CalcFields(Balance);

                    //Control Registration Fee.
                    case savingsacc."Product Category" of
                        savingsacc."product category"::"Entrance Fee":
                            begin

                                MaxRegistration := 0;
                                MinRegistration := 0;
                                AmountDifference := 0;
                                AmountTotal := 0;

                                //Get the member details.
                                if members.Get(savingsacc."Member No.") then begin
                                    members.TestField(Members."Member Class");


                                end;

                            end;
                    end;


                    //Control Share capital
                    case savingsacc."Product Category" of
                        savingsacc."Product Category"::"Share Capital":
                            begin

                                MaxShares := 0;
                                MinShares := 0;
                                AmountDifference := 0;
                                AmountTotal := 0;

                                //Get the member details.
                                if members.Get(savingsacc."Member No.") then begin
                                    members.TestField(Members."Member Class");
                                    if memberCat.Get(Members."Member Class") then begin
                                        MaxShares := memberCat."Default Share Capital";
                                        MinShares := memberCat."Share Capital";
                                        AmountDifference := (MaxShares - savingsacc.Balance);
                                        AmountTotal := (Amount + savingsacc.Balance);
                                        //Check if maximum amount met.
                                        if AmountTotal > MaxShares then begin
                                            Error(ErrorMaxAmount, 'Share Capital', MaxShares, Format(savingsacc.Balance), Format(AmountDifference));
                                        end;
                                        //Check if MINIMUM amount met.
                                        /*IF AmountTotal < MinShares THEN BEGIN
                                          ERROR(ErrorMinAmount,'Share Capital',MinShares,FORMAT(savingsacc.Balance),FORMAT(AmountDifference));
                                        END;*/
                                    end;
                                end;

                            end;
                    end;

                    //Control Deposit Contribution.-----
                    /*CASE savingsacc."Product Category" OF savingsacc."Product Category"::"BOSA Deposits": BEGIN

                        MinDeposit:=0;
                        AmountDifference:=0;
                        AmountTotal:=0;

                        //Get the member details.
                        IF members.GET(savingsacc."Member No.") THEN BEGIN
                          members.TESTFIELD(Members."Member Class");
                          IF memberCat.GET(Members."Member Class") THEN BEGIN
                            MinDeposit := memberCat."Min Deposit Contribution";
                            AmountDifference := (MinDeposit - savingsacc.Balance);
                            AmountTotal := (Amount + savingsacc.Balance);
                            //Check if maximum amount met.
                            IF AmountTotal < MinDeposit THEN BEGIN
                              ERROR(ErrorMinAmount,'Deposit Contribution',MinDeposit,FORMAT(savingsacc.Balance),FORMAT(AmountDifference));
                            END;
                          END;
                        END;

                      END;
                    END;*/ //End Case: Deposit Contribution.

                    /*
                    //Control Registration Fee
                    MaxRegistration:=0;
                    AmountDifference:=0;
                    AmountTotal:=0;

                    savingsacc.RESET;
                    savingsacc.SETRANGE("No.","Account No");
                    savingsacc.SETRANGE(savingsacc."Product Category",savingsacc."product category"::"Entrance Fee");
                    //Get the savings account details.
                    IF savingsacc.FIND('-') THEN BEGIN
                      savingsacc.CALCFIELDS(savingsacc.Balance);
                      //Get the member details.
                      IF members.GET(savingsacc."Member No.") THEN BEGIN
                        members.TESTFIELD(Members."Member Class");
                        //Get the Member category details.
                        IF memberCat.GET(Members."Member Class") THEN BEGIN

                          MaxShares := memberCat."Share Capital";
                          AmountDifference := (MaxShares - savingsacc.Balance);
                          AmountTotal := (Amount + savingsacc.Balance);

                          IF AmountTotal > MaxShares THEN BEGIN
                            ERROR(ErrorMaxAmount,'Share Capital',MaxShares,FORMAT(savingsacc.Balance),FORMAT(AmountDifference));
                          END;

                        END;
                      END;
                    END;
                    */
                end;

            end;
        }
        field(6; "Transaction Date"; Date)
        {
        }
        field(7; "Account No"; Code[20])
        {
            TableRelation = IF (Type = CONST("Bank Account")) "Bank Account"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account" WHERE("Direct Posting" = CONST(true))
            ELSE
            IF (Type = CONST(Customer)) Customer WHERE("Account Type" = CONST(Employer));

            trigger OnValidate()
            begin
                savingsacc.Reset;
                savingsacc.SetRange("No.", "Account No");
                // savingsacc.SetFilter("Product Category", '%1', savingsacc."Product Category"::"15");
                if savingsacc.Find('-') then begin
                    "Account No" := '';
                    "Member No" := '';
                    "Product Type" := '';
                    Amount := 0;
                    Message('Receipting to a Dividend Account Not Allowed')

                end;

                if creditacc.Get("Account No") then
                    "Member No" := creditacc."Member No."
                else
                    if savingsacc.Get("Account No") then
                        "Member No" := savingsacc."Member No.";
                "Product Type" := savingsacc."Product Type";
            end;
        }
        field(8; Type; Option)
        {
            OptionCaption = ' ,Bank Account,G/L Account,Customer';
            OptionMembers = " ","Bank Account","G/L Account",Customer;
        }
        field(9; "Product Type"; Code[80])
        {
            Editable = false;
            TableRelation = "Product Factory"."Product ID";
        }
        field(10; "Line No"; Integer)
        {
        }
        field(11; "Months Prepaid"; Integer)
        {
        }
        field(12; "Outstanding Bill"; Decimal)
        {
        }
        field(13; "Outstanding Balance"; Decimal)
        {
        }
        field(14; "Receipt Description"; Text[50])
        {
        }
        field(15; "Document No"; Code[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Transaction No", "Account No", Amount, "Line No", "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        creditacc: Record "Credit Accounts";
        savingsacc: Record "Savings Accounts";
        ProductF: Record "Product Factory";
        Loans: Record Loans;
        members: Record Members;
        memberCat: Record "Member Classes";
        MaxShares: Decimal;
        MinShares: Decimal;
        MaxRegistration: Decimal;
        MinRegistration: Decimal;
        AmountDifference: Decimal;
        AmountTotal: Decimal;
        ErrorMaxAmount: Label '"Maximum %1 allowed  is %2, Member Balance is %3, Kindly enter %4 or less"';
        ErrorMinAmount: Label '"Minimum %1 allowed  is %2, Member Balance is %3, Kindly enter %4 or more"';
        ErrorMaxLoan: Label '"The Amount entered is more than the Loan Outstanding Balance of %1"';
        MemberNo: Text;
        BosaReceiptTransactions: Record "Checkoff  Receipt Transactions";
        BosaReceiptTransactionLines: Record "Checkoff  Receipt Trans Lines";
        SumAmounts: Decimal;
        MinDeposit: Decimal;
        ErrorMaxInterest: Label '"The Amount entered is more than the Loan Outstanding Interest of %1"';
        ErrorInsuranceSetup: Label 'This Insurance product has not been set up';
}

