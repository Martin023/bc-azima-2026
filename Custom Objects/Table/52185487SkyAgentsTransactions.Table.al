table 52185487 "Sky Agents Transactions"
{
    DrillDownPageID = "Agent Transactions";
    LookupPageId = "Agent Transactions";

    fields
    {
        field(1; "Transaction ID"; Code[20])
        {
        }
        field(3; "Transaction Date"; Date)
        {
        }
        field(4; "Transaction Time"; Time)
        {
        }
        field(5; "Agent Code"; Code[30])
        {
        }
        field(8; "Member Account"; Code[20])
        {
        }
        field(9; "Agent Commision Account"; Code[30])
        {
        }
        field(10; "Member No"; Code[30])
        {
            TableRelation = Members."No.";
        }
        field(11; "Vendor Commission"; Decimal)
        {
        }
        field(13; "Sacco Fee"; Decimal)
        {
        }
        field(15; Description; Text[50])
        {
        }
        field(17; Amount; Decimal)
        {
        }
        field(18; Posted; Boolean)
        {
        }
        field(19; "Date Posted"; Date)
        {
        }
        field(20; "Time Posted"; Time)
        {
        }
        field(21; "Posted By"; Code[50])
        {
        }
        field(22; Reversed; Boolean)
        {
        }
        field(23; "Date Reversed"; Date)
        {
        }
        field(24; "Time Reversed"; Time)
        {
        }
        field(25; "Reversed By"; Code[50])
        {
        }
        field(26; "Reversal ID"; Code[20])
        {
        }
        field(27; "Transaction Type"; Option)
        {
            OptionMembers = "None",Registration,Withdrawal,Deposit,LoanRepayment,Transfer,Sharedeposit,Schoolfeespayment,Balance,Ministatment,Paybill," Memberactivation",MemberRegistration,InternalAgentTransfer;
        }
        field(28; "Transaction Name"; Text[50])
        {
        }
        field(32; "Session ID"; Code[20])
        {
        }
        field(33; "Loan No."; Code[20])
        {
            TableRelation = Loans."Loan No.";
        }
        field(34; Keyword; Code[20])
        {
        }
        field(35; "Mobile No."; Code[20])
        {
        }
        field(36; "Statement Max Rows"; Integer)
        {
        }
        field(37; "Statement Start Date"; Date)
        {
        }
        field(38; "Statement End Date"; Date)
        {
        }
        field(39; "Account to Check"; Code[20])
        {
        }
        field(40; "Entry No."; Guid)
        {
        }
        field(41; "Client Name"; Text[200])
        {
        }
        field(42; "Paybill Member ID"; Code[20])
        {
        }
        field(43; "Needs Change"; Boolean)
        {
        }
        field(44; "Changed By"; Code[50])
        {
        }
        field(45; "Date Changed"; Date)
        {
        }
        field(46; "Interest Paid"; Decimal)
        {
        }
        field(47; "Principal Paid"; Decimal)
        {
        }
        field(48; "Agent Account Number"; Code[30])
        {
        }
        field(49; "Debit Account Type"; Text[30])
        {
        }
        field(50050; MobileApp; Boolean)
        {
        }
        field(50051; "Manually Inserted"; Boolean)
        {
        }
        field(50052; "Inserted By"; Code[50])
        {
        }
        field(50053; "Date Inserted"; Date)
        {
        }
        field(50054; "Old Transaction Date"; Date)
        {
        }
        field(50055; "Agent From Account"; Code[30])
        {
        }
        field(50056; "Agent To Account"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    [Scope('OnPrem')]
    procedure GetChargeAmount("Code": Code[20]; ChargeAmt: Decimal; ChargeAcc: Code[20]; TransAmount: Decimal)
    var
        TransactionTypes: Record "Transaction Types";
        TransCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
    begin

        ChargeAmt := 0;
        ChargeAcc := '';

        TransactionTypes.Reset;
        TransactionTypes.SetRange(Type, TransactionTypes.Type::"Member Withdrawal");
        if TransactionTypes.Find('-') then begin
            TransCharges.Reset;
            TransCharges.SetRange("Transaction Type", TransactionTypes.Code);
            if TransCharges.Find('-') then begin
                ChargeAcc := TransCharges."G/L Account";

                if TransCharges."Charge Type" = TransCharges."Charge Type"::"Flat Amount" then begin
                    ChargeAmt := TransCharges."Charge Amount";
                end;
                if TransCharges."Charge Type" = TransCharges."Charge Type"::"% of Amount" then begin
                    ChargeAmt := Round(TransCharges."Percentage of Amount" / 100 * TransAmount);
                end;
                if TransCharges."Charge Type" = TransCharges."Charge Type"::Staggered then begin

                    TariffDetails.Reset;
                    TariffDetails.SetRange(TariffDetails.Code, TransCharges."Staggered Charge Code");
                    if TariffDetails.Find('-') then begin
                        repeat
                            if (TransAmount >= TariffDetails."Lower Limit") and (TransAmount <= TariffDetails."Upper Limit") then begin
                                if TariffDetails."Use Percentage" = true then begin
                                    ChargeAmt := TransAmount * TariffDetails.Percentage * 0.01;
                                end
                                else begin
                                    ChargeAmt := TariffDetails."Charge Amount";
                                end;
                            end
                        until TariffDetails.Next = 0;
                    end;

                end;



            end;
        end;
    end;
}

