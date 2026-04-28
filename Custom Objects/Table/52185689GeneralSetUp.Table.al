table 52185689 "General Set-Up"
{
    DrillDownPageId = "General Setup";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(3; "Max. Member Age"; DateFormula)
        {
        }
        field(4; "Registration Fee"; Decimal)
        {
        }
        field(5; "Min. Member Age"; DateFormula)
        {
        }
        field(6; "Rejoining Fees Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(7; "Days for Checkoff"; DateFormula)
        {
        }
        field(8; "Guarantors Multiplier"; Decimal)
        {
        }
        field(9; "Excise Duty G/L"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(10; "Rejoining Fee"; Decimal)
        {
        }
        field(11; "Excise Duty (%)"; Decimal)
        {
        }
        field(12; "Max Loans To Guarantee"; Integer)
        {
        }
        field(13; "Bill Account"; Code[20])
        {
            TableRelation = "G/L Account"."No." WHERE("Direct Posting" = CONST(true));
        }
        field(14; "Funeral Expense Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(15; "Funeral Amount"; Decimal)
        {
        }
        field(16; "Unloged Claims Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(17; "Insurance Name"; Text[30])
        {
        }
        field(18; "Withdrawal Notice period"; DateFormula)
        {
        }
        field(19; Reference; Text[30])
        {
            Description = 'Use to define Client Code for Electronic Find transfer';
        }
        field(20; "Withdrawal Fee"; Decimal)
        {
        }
        field(21; "Boosting Maturity"; DateFormula)
        {
        }
        field(22; "Boosting Shares %"; Decimal)
        {
        }
        field(23; "Share Boost GL"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(24; "Charge Type"; Code[10])
        {
        }
        field(25; "Max Minor Loans To Guarantee"; Integer)
        {
        }
        field(26; "Max Major Loans To Guarantee"; Integer)
        {
        }
        field(29; "Transaction Type [Statement]"; Code[20])
        {
            TableRelation = "Transaction Types" WHERE(Type = FILTER(Statement));
        }
        field(30; "External STO Account No."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(31; "Withdrawal Fee Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(32; "Self Guarantee %"; Decimal)
        {
        }
        field(33; "Maximum Discounting %"; Decimal)
        {
        }
        field(34; "Special Charge on Loans GL"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(35; "BBF Claim %"; Decimal)
        {
        }
        field(37; "Enforce Picture & Signature"; Option)
        {
            Description = 'Enforce Picture & Signature';
            OptionCaption = ' ,Picture,Signature,Both';
            OptionMembers = " ",Picture,Signature,Both;
        }
        field(38; "Allowed Loan Categories"; Enum "Loan Sasra categories")
        {
            // OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            // OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(39; "Benevolent Claim Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(40; "Maximum Valuation Period"; DateFormula)
        {
        }
        field(41; "Maximum ATM Limit"; Decimal)
        {
        }
        field(42; "Dividend Payable Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(99; "Dividend Expense Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(43; "Withholding Tax Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(44; "Min. Delegates deposit"; Decimal)
        {
        }
        field(45; "Min.Delegate Membership Period"; DateFormula)
        {
        }
        field(46; "Min. Delegates Share Capital"; Decimal)
        {
        }
        field(47; "ATM Card No Characters"; Integer)
        {
        }
        field(48; "Self Deposits(As Guarantor)"; Boolean)
        {
        }
        field(49; "Max. Member Age - Disabled"; DateFormula)
        {
        }
        field(50; "BDE Loan Comission"; Decimal)
        {
        }
        field(51; "BDE Loan Above Target"; Decimal)
        {
        }
        field(52; "BDE ATM Comission"; Decimal)
        {
        }
        field(53; "BDE New Member Comission"; Decimal)
        {
        }
        field(54; "BDE Salary Account Commision"; Decimal)
        {
        }
        field(55; "Block Account for Ext.  Loan"; Boolean)
        {
        }
        field(56; "Withdrawal Notice Penalty"; Code[10])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = CONST("Member Withdrawal"));
        }
        field(57; "Requires Salary Processing"; Boolean)
        {
            Description = 'Delegates';
        }
        field(58; "Salary Period"; DateFormula)
        {
        }
        field(59; "Agency Posting Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Agency Posting Template"));
        }
        field(60; "Agency Posting Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(61; "Sacco Commission Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(62; "Vendor Commission Account"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(63; "Max Store Open Documents"; Integer)
        {
        }
        field(64; "EFT Dest Acc Length"; Integer)
        {
        }
        field(65; "Salary SMS Suffix"; Text[100])
        {
        }
        field(66; "Defaulter Notice Period"; DateFormula)
        {
        }
        field(67; "Dormant Account Activation Fee"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = FILTER("Account Activate"));
        }
        field(68; "Statement Limit Period"; Date)
        {
        }
        field(69; "Agency No Series"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(70; "Birthday Message"; Text[250])
        {
        }
        field(71; "Sink Fund Process Charge"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = CONST("BBF Payment"));
        }
        field(72; "Membership Anniversary"; Text[250])
        {
        }
        field(73; "Agency Control Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(74; "Agency Expense Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(75; "Disable Salary SMS"; Boolean)
        {
        }
        field(76; "Disable Loan SMS"; Boolean)
        {
        }
        field(77; "Div. Advance Rate"; Decimal)
        {
        }
        field(78; "Junior Birthday Message"; Text[250])
        {
        }
        field(79; "KMRC Rate"; Decimal)
        {
        }
        field(80; "Early Withdrawal %"; Decimal)
        {
        }
        field(81; "Early Withdrawal Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(82; "Mortgage Loan Vendor A/C"; Code[15])
        {
            TableRelation = Vendor."No.";
        }
        field(83; "Mortgage FOSA Min Balance"; Decimal)
        {
        }
        field(84; "Minimum No of Group Members"; Integer)
        {
        }
        field(85; "POS Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(86; "ATM Settlement Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(87; "VISA Settlement Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(88; "Max. Age Non-Common Bond"; DateFormula)
        {
        }
        field(89; "Control FOSA Posting"; Boolean)
        {
        }
        field(90; "PDF B64 Folder"; Text[50])
        {
        }
        field(91; "Password History Limit"; Integer)
        {
        }
        field(92; "Withholding %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(93; "Board Salaries Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }

        field(95; "Risk Claim G\L"; Code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(96; "Risk Vendor Payable Acc."; Code[20])
        {
            TableRelation = Vendor;
        }
        field(97; "Closure Verification Specimen"; Blob)
        {
            Subtype = Bitmap;
        }
        field(98; "Risk Account Closure Fee"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = FILTER("Account Closure"));
        }
        field(50050; "MBanking Posting Date"; Date)
        {
        }
        field(50051; "Sacco SMS Expense GL"; Code[20])
        {
        }
        field(50052; "Mobile Vendor Account"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(50053; "Vendor SMS Split Amount"; Decimal)
        {
        }
        field(50054; "Sacco SMS Income GL"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50055; "Bankers Cheque Limit"; Decimal)
        {
        }
        field(50056; "Shamba Loan Vendor A/C"; Code[20])
        {
        }
        field(50057; "Loan SMS Suffix"; Text[250])
        {
        }
        field(50058; "Minimum Leaf Limit"; Decimal)
        {
        }
        field(50059; "Sky Mobile Next Run Date"; Date)
        {
        }
        field(50060; "Allowed Loan Cat Billing"; Enum "Loan Sasra categories")
        {
        }
        field(50061; "Interest Posting Date"; Integer)
        {
        }
        field(50062; "Minimum Share Capital"; Decimal)
        {
        }
        field(50063; "Surety Notice Period"; DateFormula)
        {
        }

        field(50064; "AutoCompletion on approval"; Boolean)
        {
        }
        field(50065; "Max 1st Partial Withdrawal %"; Decimal)
        {
            Caption = 'Maximum 1st partial withdrawal %';

        }
        field(500666; "Loan Rejection Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50000; "Loan Categorization Code"; Code[20])
        {
            TableRelation = "Loan Categorization";
        }
        field(50001; "Checkoff Cuttoff Day"; Integer)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Checkoff Cuttoff Day" > 28 then Error('Checkoff cuttoff date cannot be greater than 28');
            end;
        }

        field(50002; "Closure Account Fee"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = FILTER("Account Closure"));
        }

        field(50003; "Max. Loan Grace Period"; DateFormula)
        {
        }

        field(50004; "BBF Max Date of Death"; DateFormula)
        {
        }
        field(50005; "Shares Price"; Decimal)
        {
        }
        field(50006; "Partial Account Fee"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = FILTER("Account Closure"));
        }
        field(50007; "Failed STO Fee"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = FILTER("Failed STO Fee"));
        }
        field(50008; "Release Doc Time"; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "AML Transaction Limit"; Decimal)
        {
        }
        field(50010; "ATM RePIN"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = FILTER("ATM RePIN"));
        }
        field(50011; "Mobile Banking PIN Reset"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = FILTER("MBanking PIN Reset"));
        }
        field(50012; "Excempt Charges Expiry Date"; Date)
        {
        }
        field(50013; "NCBA Account Type"; Enum "Gen. Journal Account Type")
        {
        }

        field(50014; "NCBA Account Name"; Text[50])
        {
        }

        field(50015; "NCBA Account No"; Code[30])
        {
            TableRelation = IF ("NCBA Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("NCBA Account Type" = CONST(Customer)) Customer WHERE("Account Type" = FILTER(Employer))
            ELSE
            IF ("NCBA Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("NCBA Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("NCBA Account Type" = CONST("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            begin

                if "NCBA Account Type" = "NCBA Account Type"::Customer then begin
                    cust.Reset;
                    cust.SetRange(cust."No.", "NCBA Account No");
                    if cust.Find('-') then begin
                        "NCBA Account Name" := cust.Name;
                    end;
                end;

                if "NCBA Account Type" = "NCBA Account Type"::"G/L Account" then begin
                    "GL Account".Reset;
                    "GL Account".SetRange("GL Account"."No.", "NCBA Account No");
                    if "GL Account".Find('-') then begin
                        "NCBA Account Name" := "GL Account".Name;
                    end;
                end;

                if "NCBA Account Type" = "NCBA Account Type"::"Bank Account" then begin
                    BANKACC.Reset;
                    BANKACC.SetRange(BANKACC."No.", "NCBA Account No");
                    if BANKACC.Find('-') then begin
                        "NCBA Account Name" := BANKACC.Name;

                    end;
                end;
            end;
        }

        field(50016; "NCBA Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = CONST("Salary Processing"));
        }
        field(89000; "Early Withdrawal Fee"; Code[100])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = FILTER("Account Closure"));
        }
        field(50017; "Maximum Amount to Guarantee"; Decimal)
        {
        }
        field(50018; "Sky Loan Interest Rate (%)"; Decimal)
        {
            Caption = 'Sky Loan Interest Rate (%)';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ("Sky Loan Interest Rate (%)" > 100) or ("Sky Loan Interest Rate (%)" < 0) then begin
                    Error('Percentage value must be above 0 and less than 100!');
                end;
            end;
        }
        field(50019; "FOSA Minimum"; Decimal)
        {
        }
        field(50020; "Share Transfer Fee"; Code[100])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = FILTER("Share Capital Transfer"));
        }
        field(50021; "Retirement Message"; Text[250])
        {
        }
        field(50022; "Dormancy SMS Period"; DateFormula)
        {
            Caption = 'Dormancy SMS Period';
        }
        field(50023; "Loan SMS Charge"; Text[250])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = FILTER("SMS Charge"));
        }
        field(50024; "Transfer Excise Duty (%)"; Decimal)
        {
            Caption = 'Transfers Excise Duty (%)';
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

    var
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
        cust: Record Customer;
}

