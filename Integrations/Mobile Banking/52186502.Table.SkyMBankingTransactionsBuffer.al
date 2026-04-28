table 52186502 "Sky M-Banking Trans. Buffer"
{
    DataClassification = AccountData;
    LookupPageId = "Sky M-Banking Trans. Buffer";
    DrillDownPageId = "Sky M-Banking Trans. Buffer";

    DataCaptionFields = "Originator ID", "Transaction Type";
    fields
    {
        field(1; "No."; BigInteger)
        {
            AutoIncrement = True;
            Editable = false;
        }

        field(2; "Originator ID"; Text[150])
        {
            Caption = 'Originator ID';
            Editable = false;
        }

        field(3; "PESA Type"; Text[100])
        {
            Caption = 'PESA Type';
            Editable = false;
        }

        field(4; "Action"; Text[100])
        {
            Caption = 'Action';
            Editable = false;
        }

        field(5; "Command"; Text[100])
        {
            Caption = 'Command';
            Editable = false;
        }

        field(6; "Sensitivity"; Text[100])
        {
            Caption = 'Sensitivity';
            Editable = false;
        }

        field(7; "Charge"; Decimal)
        {
            Caption = 'Charge';
            Editable = false;
        }
        field(8; "Identifier Type"; Text[100])
        {
            Caption = 'Identifier Type';
            Editable = false;
        }
        field(9; "Identifier"; Text[100])
        {
            Caption = 'Identifier';
            Editable = false;
        }
        field(10; "Initiator Identifier Type"; Text[100])
        {
            Caption = 'Transaction Initiator Identifier Type';
            Editable = false;
        }

        field(11; "Initiator Identifier"; Text[100])
        {
            Caption = 'Transaction Initiator Identifier';
            Editable = false;
        }
        field(12; "Initiator Account"; Text[100])
        {
            Caption = 'Transaction Initiator Account';
            Editable = false;
        }
        field(13; "Initiator Name"; Text[250])
        {
            Caption = 'Transaction Initiator Name';
            Editable = false;
        }
        field(14; "Initiator Reference"; Text[100])
        {
            Caption = 'Transaction Initiator Reference';
            Editable = false;
        }
        field(15; "Initiator Other Details"; Text[2000])
        {
            Caption = 'Transaction Initiator Other Details';
            Editable = false;
        }
        field(16; "Source Identifier Type"; Text[100])
        {
            Caption = 'Transaction Source Identifier Type';
            Editable = false;
        }

        field(17; "Source Identifier"; Text[100])
        {
            Caption = 'Transaction Source Identifier';
            Editable = false;
        }
        field(18; "Source Account"; Text[100])
        {
            Caption = 'Transaction Source Account';
            Editable = false;
        }
        field(19; "Source Name"; Text[250])
        {
            Caption = 'Transaction Source Name';
            Editable = false;
        }
        field(20; "Source Reference"; Text[100])
        {
            Caption = 'Transaction Source Reference';
            Editable = false;
        }
        field(21; "Source Other Details"; Text[2000])
        {
            Caption = 'Transaction Source Other Details';
            Editable = false;
        }
        field(22; "Sender Identifier Type"; Text[100])
        {
            Caption = 'Transaction Sender Identifier Type';
            Editable = false;
        }

        field(23; "Sender Identifier"; Text[100])
        {
            Caption = 'Transaction Sender Identifier';
            Editable = false;
        }
        field(24; "Sender Account"; Text[100])
        {
            Caption = 'Transaction Sender Account';
            Editable = false;
        }
        field(25; "Sender Name"; Text[250])
        {
            Caption = 'Transaction Sender Name';
            Editable = false;
        }
        field(26; "Sender Reference"; Text[100])
        {
            Caption = 'Transaction Sender Reference';
            Editable = false;
        }
        field(27; "Sender Other Details"; Text[2000])
        {
            Caption = 'Transaction Sender Other Details';
            Editable = false;
        }
        field(28; "Receiver Identifier Type"; Text[100])
        {
            Caption = 'Transaction Receiver Identifier Type';
            Editable = false;
        }

        field(29; "Receiver Identifier"; Text[100])
        {
            Caption = 'Transaction Receiver Identifier';
            Editable = false;
        }
        field(30; "Receiver Account"; Text[100])
        {
            Caption = 'Transaction Receiver Account';
            Editable = false;
        }
        field(31; "Receiver Name"; Text[250])
        {
            Caption = 'Transaction Receiver Name';
            Editable = false;
        }
        field(32; "Receiver Reference"; Text[100])
        {
            Caption = 'Transaction Receiver Reference';
            Editable = false;
        }
        field(33; "Receiver Other Details"; Text[2000])
        {
            Caption = 'Transaction Receiver Other Details';
            Editable = false;
        }
        field(34; "Beneficiary Identifier Type"; Text[100])
        {
            Caption = 'Transaction Beneficiary Identifier Type';
            Editable = false;
        }

        field(35; "Beneficiary Identifier"; Text[100])
        {
            Caption = 'Transaction Beneficiary Identifier';
            Editable = false;
        }
        field(36; "Beneficiary Account"; Text[100])
        {
            Caption = 'Transaction Beneficiary Account';
            Editable = false;
        }
        field(37; "Beneficiary Name"; Text[250])
        {
            Caption = 'Transaction Beneficiary Name';
            Editable = false;
        }
        field(38; "Beneficiary Reference"; Text[100])
        {
            Caption = 'Transaction Beneficiary Reference';
            Editable = false;
        }
        field(39; "Beneficiary Other Details"; Text[2000])
        {
            Caption = 'Transaction Beneficiary Other Details';
            Editable = false;
        }
        field(40; "Transaction Amount"; Decimal)
        {
            Caption = 'Transaction Amount';
            Editable = false;
        }
        field(41; "Transaction Description"; Text[2000])
        {
            Caption = 'Transaction Description';
            Editable = false;
        }
        field(42; "Transaction Category"; Text[100])
        {
            Caption = 'Transaction Category';
            Editable = false;
        }
        field(43; "Transaction Source Reference"; Text[100])
        {
            Caption = 'Transaction Source Reference';
            Editable = false;
        }
        field(44; "Request Application"; Text[100])
        {
            Caption = 'Request Application';
            Editable = false;
        }
        field(45; "Source Application"; Text[100])
        {
            Caption = 'Source Application';
            Editable = false;
        }
        field(46; "Transaction Date Time"; DateTime)
        {
            Caption = 'Transaction Date Time';
            Editable = false;
        }
        field(47; "API Request ID"; Text[100])
        {
            Caption = 'API Request ID';
            Editable = false;
        }

        //
        field(50; "Transaction ID"; Text[100])
        {
            Caption = 'Transaction ID';
            Editable = false;
        }
        // field(51; "Product ID"; Text[100])
        // {
        //     Caption = 'Product ID';
        // }

        field(52; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(53; "Posted By"; code[50])
        {
            Caption = 'Posted by';
            Editable = false;
        }
        field(54; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = false;
        }
        field(55; "Posting Time"; Time)
        {
            Caption = 'Posting Time';
            Editable = false;
        }

        // field(56; Reversed; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        //     Editable = false;
        // }
        // field(57; "Reversed By"; Text[100])
        // {
        //     DataClassification = ToBeClassified;
        //     Editable = false;
        // }
        // field(58; "Reversed Date"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Editable = false;
        // }
        // field(59; "Reversed Time"; Time)
        // {
        //     DataClassification = ToBeClassified;
        //     Editable = false;
        // }

        field(65; "Transaction Type"; enum "Sky M-Banking Trans Types")
        {
            Caption = 'Transaction Type';
            Editable = false;
        }
        // field(66; "Failed Transaction"; Boolean)
        // {
        //     Caption = 'Failed Transaction';
        //     Description = 'Handles requests that were never successful';
        // }
        // field(67; "Failed Reason"; Text[250])
        // {
        //     Caption = 'Failed Reason';
        //     Description = 'Reason for the failure';
        // }
        field(68; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            Description = 'Date when the transaction was initiated';
            Editable = false;
        }
        field(60; "Transaction Time"; Time)
        {
            Caption = 'Transaction Time';
            Description = 'Time when the transaction was initiated';
            Editable = false;
        }
        field(61; "Needs Change"; Boolean)
        {
            Caption = 'Needs Change';
            Description = 'Needs to be checked for changes';
            // Editable = false;
        }
        field(62; "Needs Change Reason"; Text[250])
        {
            Caption = 'Change Reason';
            Description = 'Reason for the change';
            Editable = false;
        }
        field(63; "Loan No."; Code[50])
        {
            Caption = 'Loan No.';
            Description = 'Loan Number';
            TableRelation = Loans."Loan No.";

            trigger OnValidate()
            var
                Loan: Record Loans;
            begin
                if Loan.Get(Rec."Loan No.") then begin
                    "Loan Account" := Loan."Loan Account";

                    "Changed By" := UserId;
                    "Changed Date" := Today;
                    "Changed Time" := Time;
                    "Change Type" := "Change Type"::Post;
                end;
            end;
        }
        field(64; "Loan Account"; code[50])
        {
            Caption = 'Loan Account';
            Description = 'Loan Account';
            Editable = false;
        }
        field(69; "Savings Account"; code[100])
        {
            Caption = 'Savings Account';
            Description = 'Savings Account';
            TableRelation = "Savings Accounts"."No." where(Blocked = const(" "));

            trigger OnValidate()
            var
                theSavingsAccount: Record "Savings Accounts";
                theSavingsAccountProduct: Record "Product Factory";
            begin
                if theSavingsAccount.Get("Savings Account") then begin
                    if theSavingsAccountProduct.Get(theSavingsAccount."Product Type") then begin
                        if theSavingsAccountProduct."Product Category" = theSavingsAccountProduct."Product Category"::"Fixed Deposit" then begin
                            Error('Deposits to fixed deposit category accounts through mobile channel is NOT allowed!');
                        end;
                    end;

                    if theSavingsAccount.Status = theSavingsAccount.Status::Closed then begin
                        Error('Selected account %1 is at status %2', theSavingsAccount."No.", theSavingsAccount.Status);
                    end;
                end;

                "Changed By" := UserId;
                "Changed Date" := Today;
                "Changed Time" := Time;
                "Change Type" := "Change Type"::Post;
            end;
        }
        field(71; "Destination Account"; code[100])
        {
            Caption = 'Destination Account';
            Description = 'Destination Account';
            Editable = false;
            TableRelation = "Savings Accounts"."No.";
        }
        field(70; "Transaction Status"; Option)
        {
            Caption = 'Transaction Status';
            OptionMembers = " ","CONFIRMED","REVERSE_CONFIRMED";
            Editable = false;
        }
        field(72; "Changed By"; code[50])
        {
            Caption = 'Changed by';
            Editable = false;
        }

        field(73; "Changed Date"; Date)
        {
            Caption = 'Changed Date';
            Editable = false;
        }
        field(74; "Changed Time"; Time)
        {
            Caption = 'Changed Time';
            Editable = false;
        }
        field(75; "Signed Amount"; Decimal)
        {
            Caption = 'Signed Amount';
            Editable = false;
        }
        field(76; "Change Type"; Option)
        {
            Caption = 'Change Type';
            OptionMembers = "Post","Reverse";
            Editable = false;
        }
        field(100; "Try Posting Count"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(101; "Total Charges"; Decimal)
        {
            Caption = 'Total Charges';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Unique1; "Originator ID")
        {
            Unique = true;
            Clustered = false;
        }
        key(Unique2; "Transaction ID")
        {
            Unique = true;
            Clustered = false;
        }
        key(Key1; "Transaction Date Time", "Transaction Date", "Transaction Time")
        {
            Clustered = false;
        }
        key(Key2; Posted, "Savings Account")
        {
            Clustered = false;
            SumIndexFields = "Signed Amount";
        }
        key(Key3; "Savings Account", "Transaction Date", "Transaction Type")
        {
            Clustered = false;
            SumIndexFields = "Signed Amount";
        }

        // Secondary keys for non-primary fields
        key(IdxPosted; "Posted")
        {
            Clustered = false;
        }

        key(IdxNeedsChange; "Needs Change")
        {
            Clustered = false;
        }

        key(IdxTransactionStatus; "Transaction Status")
        {
            Clustered = false;
        }

        key(IdxTransactionType; "Transaction Type")
        {
            Clustered = false;
        }

        key(IdxTryPostingCount; "Try Posting Count")
        {
            Clustered = false;
        }

        key(IdxSavingsAccount; "Savings Account")
        {
            Clustered = false;
        }

        key(IdxSourceAccount; "Source Account")
        {
            Clustered = false;
        }

        key(IdxLoanNo; "Loan No.")
        {
            Clustered = false;
        }

        // Composite keys for efficient queries involving multiple fields
        key(IdxTransactionStatusType; "Transaction Status", "Transaction Type")
        {
            Clustered = false;
        }

        key(IdxOriginatorIDPosted; "Originator ID", "Posted")
        {
            Clustered = false;
        }

        key(IdxLoanNoPosted; "Loan No.", "Posted")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        GlobalFunctions: Codeunit "Global Functions";
    begin
        CalculateSignedAmount();

        if "Originator ID" = '' then begin
            "Originator ID" := GlobalFunctions.CleanGuid;
        end;
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
        Error('Deletion is NOT allowed on this table');
    end;

    trigger OnRename()
    begin

    end;

    local procedure CalculateSignedAmount()
    var
        SkyMbankingTransactions: Codeunit "Sky M-Banking Transactions";
        TotalCharge: Decimal;
        NullMember: Record Members;
        SavAccount: Record "Savings Accounts";
    begin
        "Signed Amount" := "Transaction Amount";

        // Charges if any
        TotalCharge := 0;

        case "Transaction Type" of
            "Transaction Type"::"Mpesa Withdrawal":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'MPESA_WITHDRAWAL',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::Airtime:
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'AIRTIME_PURCHASE',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Utility Payment":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'BILL_PAYMENT',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Bank Transfer":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'BANK_TRANSFER',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Account Transfer":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'IFT_ACCOUNT_TO_ACCOUNT',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Kesasa Account Transfer":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'IFT_ACCOUNT_TO_ACCOUNT',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Mpesa Deposit":
                TotalCharge := -SkyMbankingTransactions.GetTransChargesPreview(
                    'DEPOSIT',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Account Balance Enquiry":
                begin
                    SavAccount.Reset;

                    SavAccount.SetRange("No.", "Savings Account");
                    SavAccount.SetLoadFields("Member No.");
                    if SavAccount.FindFirst then begin
                        NullMember.Reset;
                        NullMember.SetRange("No.", SavAccount."Member No.");
                        NullMember.SetLoadFields("No.");
                        if NullMember.FindFirst then begin
                            TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                                'SINGLE_ACCOUNT_BALANCE_ENQUIRY',
                                "Transaction Amount",
                                "Savings Account",
                                NullMember,
                                ''
                            ).Get(1);
                        end;
                    end;
                end;
            "Transaction Type"::"Account Mini-Statement":
                begin
                    SavAccount.Reset;

                    SavAccount.SetRange("No.", "Savings Account");
                    SavAccount.SetLoadFields("Member No.");
                    if SavAccount.FindFirst then begin
                        NullMember.Reset;
                        NullMember.SetRange("No.", SavAccount."Member No.");
                        NullMember.SetLoadFields("No.");
                        if NullMember.FindFirst then begin
                            TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                                'ACCOUNT_MINI_STATEMENT',
                                "Transaction Amount",
                                "Savings Account",
                                NullMember,
                                ''
                            ).Get(1);
                        end;
                    end;
                end;
            "Transaction Type"::"Account Full-Statement":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'ACCOUNT_FULL_STATEMENT',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Loan Balance Enquiry":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'LOAN_BALANCE_ENQUIRY',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Loan Mini-Statement":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'LOAN_MINI_STATEMENT',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Loan Full-Statement":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'LOAN_FULL_STATEMENT',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Loan Application":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'LOAN_APPLICATION',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Pay Loan From Account":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'IFT_LOAN_REPAYMENT',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Loan Limit Check":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'CHECK_LOAN_LIMIT',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Guarantorship Ability Enquiry":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'GUARANTORSHIP_ABILITY_ENQUIRY',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Coop B2B Deposit":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'COOP_DEPOSIT_B2B',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);

            "Transaction Type"::"Coop P2F Deposit":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'COOP_DEPOSIT_P2F',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    ''
                ).Get(1);
            "Transaction Type"::"Till Payment":
                TotalCharge := SkyMbankingTransactions.GetTransChargesPreview(
                    'TILL_PAYMENT',
                    "Transaction Amount",
                    "Savings Account",
                    NullMember,
                    "Receiver Identifier"
                ).Get(1);
            else
        end;

        "Signed Amount" += TotalCharge;
        "Total Charges" := TotalCharge;

        case "Transaction Type" of
            "Transaction Type"::"Mpesa Deposit", "Transaction Type"::"Coop B2B Deposit", "Transaction Type"::"Coop P2F Deposit":
                "Signed Amount" := 0;
        end;
    end;

}