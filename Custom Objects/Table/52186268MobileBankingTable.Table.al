table 52186268 "Mobile Banking Table"
{
    DrillDownPageID = "Mobile Banking App List";
    LookupPageID = "Mobile Banking App List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    BankingNoSetup.Get;
                    NoSeriesMgt.TestManual(BankingNoSetup."Mobile Banking No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account No"; Code[20])
        {
            TableRelation = "Savings Accounts"."No." WHERE("Product Category" = FILTER("FOSA Account"));

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
                SavAcc: Record "Savings Accounts";
            begin
                SavingsAccounts.get("Account No");
                SavingsAccounts.CalcFields("Balance (LCY)");
                if SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.") < TransCharges."Charge Amount" then
                    Error('There is no enough balance in the account for the Repin application');

                SavAcc.Reset();
                SavAcc.SetRange("No.", Rec."Account No");
                if SavAcc.FindFirst() then begin
                    "Customer ID" := SavAcc."Member No.";
                    rec."Account Name" := SavAcc.Name;
                    rec."ATM Linked" := true;
                    rec.Address := SavAcc.City;
                    rec."Phone No." := SavAcc."Phone No.";
                end;
            end;
        }
        field(3; "Branch Code"; Code[20])
        {
            Editable = false;
        }
        field(5; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(6; Address; Text[35])
        {
            Editable = false;
        }
        field(7; "Customer ID"; Code[11])
        {
            Editable = false;
        }
        field(8; "Relation Indicator"; Option)
        {
            OptionCaption = 'Primary,Suplimentary';
            OptionMembers = Primary,Suplimentary;
        }
        field(10; "Request Type"; Option)
        {
            OptionCaption = 'New,Replacement,Re-Pin';
            OptionMembers = New,Replacement,"Re-Pin",Supplementary;
        }
        field(11; "Application Date"; Date)
        {
            Editable = false;
        }

        field(13; "Date Issued"; Date)
        {
            Editable = false;
        }
        field(14; Limit; Decimal)
        {
        }
        field(15; "Terms Read and Understood"; Boolean)
        {
        }
        field(16; "Card Issued"; Boolean)
        {
            Editable = false;
        }
        field(17; "Form No"; Code[30])
        {
        }
        field(18; "Sent To External File"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(19; "Card Status"; Option)
        {
            Editable = false;
            OptionMembers = Pending,Active,Frozen;
        }
        field(20; "Date Activated"; Date)
        {
            Editable = false;
        }
        field(21; "Date Frozen"; Date)
        {
            Editable = false;
        }
        field(22; "Replacement For Card No"; Code[20])
        {
        }
        field(23; "Phone No."; Code[20])
        {
        }
        field(24; "No. Series"; Code[10])
        {
            Editable = false;
        }
        field(25; Collected; Boolean)
        {
            Editable = false;
        }
        field(26; "Application Approved"; Boolean)
        {
            Editable = false;
        }
        field(27; "Date Collected"; Date)
        {
            Editable = false;
        }
        field(28; "Card Issued By"; Code[50])
        {
            Editable = false;
        }
        field(29; "Approval Date"; Date)
        {
            Editable = false;
        }
        field(30; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(31; "Card Expiry Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Card Expiry Date" < Today then Error('This card has already expired');
            end;
        }
        field(32; "Posted By."; Code[80])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(33; "Responsibility Center"; Code[10])
        {
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(34; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(35; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(36; "Card Issued Date"; Date)
        {
            Editable = false;
        }
        field(37; "RePIN Issued Date"; Date)
        {
            Editable = false;
        }
        field(38; "RePIN Issued By"; Code[50])
        {
            Editable = false;
        }
        field(39; "Linked Date"; Date)
        {
            Editable = false;
        }
        field(40; "ATM Linked"; Boolean)
        {
            Editable = false;
        }
        field(41; "ATM Charges Applied"; Boolean)
        {
        }
        field(42; "ATM Charged Date"; Date)
        {
        }
        field(43; "RePIN Issued"; Boolean)
        {
            Editable = false;
        }
        field(44; "Linked By"; Code[50])
        {
            Editable = false;
        }
        field(45; "Delinked By"; Code[50])
        {
            Editable = false;
        }
        field(46; "ATM Delinked"; Boolean)
        {
            Editable = false;
        }
        field(47; "ATM Delinked Date"; Date)
        {
            Editable = false;
        }

        field(49; "ATM Linking Statistics"; Integer)
        {
            CalcFormula = Count("ATM Linking  Statistics" WHERE("Account No." = FIELD("Account No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Sales Agent"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(51; "Captured By"; Code[50])
        {
            Editable = false;
        }
        field(52; "Capture Date"; Date)
        {
            Editable = false;
        }
        field(53; "Approved  By"; Code[50])
        {
            Editable = false;
        }

        // field(54; "ATM No."; Code[20])
        // {
        //     TableRelation = "ATM Inventory"."Card Number" WHERE("Account No." = FIELD("Account No"), Status = filter(Linked));
        //     trigger OnValidate()
        //     var
        //         ATMInventory: Record "ATM Inventory";
        //         ATMLink: Record "ATM Linking Applications";
        //     begin
        //         // "Card No" := Rec."ATM No.";
        //         if ATMInventory.Get("ATM No.") then begin
        //             "Card Expiry Date" := ATMInventory."Expiry Date";
        //         end;

        //         ATMLink.Reset();
        //         ATMLink.SetRange("Account No", rec."Account No");
        //         ATMLink.SetRange("ATM Linked", true);
        //         if ATMLink.FindFirst() then begin
        //             // rec."Card Type" := ATMLink."Card Type";
        //             // rec."Account Type" := ATMLink."Account Type";
        //             rec."Account Name" := ATMLink."Account Name";
        //             rec."Customer ID" := ATMLink."Customer ID";
        //             rec."Responsibility Center" := ATMLink."Responsibility Center";
        //             rec."Shortcut Dimension 1 Code" := ATMLink."Shortcut Dimension 1 Code";
        //             rec."Shortcut Dimension 2 Code" := ATMLink."Shortcut Dimension 2 Code";
        //             "Application Date" := ATMLink."Application Date";
        //             rec."Card Status" := ATMLink."Card Status"::Active;
        //             rec."Card Expiry Date" := ATMLink."Card Expiry Date";
        //             rec."ATM Linked" := true;
        //             rec.Collected := ATMLink.Collected;
        //             rec."Date Collected" := ATMLink."Date Collected";
        //             rec.Address := ATMLink.Address;
        //             rec."Phone No." := ATMLink."Phone No.";
        //             rec."Capture Date" := ATMLink."Capture Date";
        //             rec."Captured By" := ATMLink."Captured By";
        //             rec."Linked Date" := ATMLink."Linked Date";
        //             rec."Date Issued" := ATMLink."Date Issued";
        //             rec."Card Issued" := ATMLink."Card Issued";
        //         end;

        //     end;
        // }
        field(55; "RePIN Processed"; Boolean)
        {

        }
        field(56; "RePIN Requested"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            BankingNoSetup.Get();
            BankingNoSetup.TestField(BankingNoSetup."Mobile Banking No.");
            NoSeriesMgt.InitSeries(BankingNoSetup."Mobile Banking No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");
        UserSetup.TestField("Responsibility Centre");

        "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        "Responsibility Center" := UserSetup."Responsibility Centre";

        "Capture Date" := Today;
        "Captured By" := UserId;
    end;

    var
        GeneralSetUp: Record "General Set-Up";
        BankingNoSetup: Record "Banking No Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SavingsAccounts: Record "Savings Accounts";
        Members: Record Members;
        SavingsAccountss: Record "Savings Accounts";
        TChargeAmount: Decimal;
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        Trans: Record "Cashier Transactions";
        GenSetup: Record "General Set-Up";
        AccountTypes: Record "Product Factory";
        TransType: Record "Transaction Types";
        Account: Record "Savings Accounts";
        AvailableBalance: Decimal;
        MinBalance: Decimal;
        ProdType: Record "Product Factory";
        ErrRejectCard: Label 'This account do not have minimum balance of %1 to apply for ATM Card.';
        ATMCardTypes: Record "ATM Card Types";
        UserSetup: Record "User Setup";
        ATMApplications: Record "ATM Linking Applications";
        ATMApp: Record "ATM Applications";
        SavingsACC: Record "Savings Accounts";
        SendSMS: Codeunit SendSms;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit";
        Txt004: Label 'Dear Member, Your Sacco Link ATM Card is ready for collection. Kindly visit your branch with Original copy of ID.';
        ATMCount: Integer;
        ATMLinkingApplications: Record "ATM Linking Applications";
        TransCharges: Record "Transaction Charges";
}

