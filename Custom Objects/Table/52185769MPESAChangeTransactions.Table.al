table 52185769 "M-PESA Change Transactions"
{
    DrillDownPageID = "Mpesa Changes List";
    LookupPageID = "Mpesa Changes List";

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Initiated By"; Code[50])
        {
        }
        field(4; "MPESA Receipt No"; Code[20])
        {
            TableRelation = "Sky Transactions"."Entry No." WHERE(Posted = CONST(false),
                                                                  "Needs Change" = CONST(true),
                                                                  "Transaction Type" = CONST(Paybill));

            trigger OnValidate()
            begin
                MPESATrans.Reset;
                MPESATrans.SetRange(MPESATrans."Entry No.", "MPESA Receipt No");
                if MPESATrans.Find('-') then begin
                    "Account No" := MPESATrans."Member Account";
                end;
            end;
        }
        field(5; "Account No"; Code[30])
        {
        }
        field(6; "New Account No"; Code[30])
        {
            TableRelation = IF ("Destination Type" = CONST(SAVINGS)) "Savings Accounts"."No."
            ELSE
            IF ("Destination Type" = CONST(LOANS)) "Savings Accounts"."No.";
        }
        field(7; Comments; Text[100])
        {
        }
        field(8; "Approved By"; Code[50])
        {
        }
        field(9; "Date Approved"; Date)
        {
        }
        field(10; "Time Approved"; Time)
        {
        }
        field(11; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12; Changed; Boolean)
        {
        }
        field(13; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(14; "Send For Approval By"; Code[50])
        {
        }
        field(15; "Date Sent For Approval"; Date)
        {
        }
        field(16; "Time Sent For Approval"; Time)
        {
        }
        field(17; "Reasons for rejection"; Text[200])
        {
        }
        field(19; "Transaction Type"; Option)
        {
            OptionMembers = "Deposit Contribution","Share Capital","Loan Repayment","FOSA Deposit";

            trigger OnValidate()
            begin

                Error(Format("Transaction Type"));

                if "Transaction Type" = TransactionOptions::"Deposit Contribution" then begin
                    Keyword := 'D';

                end
                else
                    if "Transaction Type" = TransactionOptions::"FOSA Deposit" then begin
                        Keyword := 'F';
                    end
                    else
                        if "Transaction Type" = "Transaction Type"::"Share Capital" then begin

                            Keyword := 'S';
                        end
                        else
                            if "Transaction Type" = "Transaction Type"::"Loan Repayment" then begin


                            end;
            end;
        }
        field(20; "Destination Type"; Option)
        {
            OptionCaption = 'SAVINGS,LOANS';
            OptionMembers = SAVINGS,LOANS;
        }
        field(21; Keyword; Code[20])
        {
        }
        field(22; "App Status"; Option)
        {
            OptionCaption = 'Pending,First Approval,Changed,Rejected';
            OptionMembers = Pending,"First Approval",Changed,Rejected;
        }
        field(23; "Responsibility Centre"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(24; Activity; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Status <> Status::Open then begin
            Error('You cannot delete the MPESA transaction because it has already been sent for first approval.');
        end;
    end;

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."M-SACCO Change Nos");
            No := NoSeriesMgt.GetNextNo(NoSetup."M-SACCO Change Nos");
            // NoSeriesMgt.InitSeries(NoSetup."M-SACCO Change Nos", xRec."No. Series", 0D, No, "No. Series");
        end;

        if UserSetUp.Get(UserId) then begin
            "Initiated By" := UserId;
            "Transaction Date" := Today;
            Activity := UserSetUp."Global Dimension 1 Code"
        end;
    end;

    var
        NoSetup: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        MPESATrans: Record "Sky Transactions";
        BOSAAcct: Record "Savings Accounts";
        TransactionOptions: Option "Deposit Contribution","Share Capital","Loan Repayment","FOSA Deposit";
        UserSetUp: Record "User Setup";
}

