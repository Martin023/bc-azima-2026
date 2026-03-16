table 52185997 "Agent Applications.."
{

    fields
    {
        field(1; "Agent Code"; Code[30])
        {
            Editable = false;
        }
        field(2; "Date Entered"; Date)
        {
        }
        field(3; "Time Entered"; Time)
        {
        }
        field(4; "Entered By"; Code[30])
        {
        }
        field(5; "Document Serial No"; Text[50])
        {
        }
        field(6; "Document Date"; Date)
        {
        }
        field(7; "Customer ID No"; Code[50])
        {
        }
        field(8; Name; Text[200])
        {
        }
        field(9; "Mobile No"; Text[50])
        {
        }
        field(11; "Approval Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;

            trigger OnValidate()
            begin
                if "Approval Status" = "Approval Status"::Approved then begin
                    "Date 1st Approval" := Today;
                    "Date Approved" := Today;
                    "Time Approved" := Time;
                    "Approved By" := UserId;
                end else
                    if "Approval Status" = "Approval Status"::Rejected then begin
                        "Date Rejected" := Today;
                        "Time Rejected" := Time;
                        "Rejected By" := UserId;
                    end;
            end;
        }
        field(12; Comments; Text[200])
        {
        }
        field(13; "Rejection Reason"; Text[30])
        {
        }
        field(14; "Date Approved"; Date)
        {
            Editable = false;
        }
        field(15; "Time Approved"; Time)
        {
            Editable = false;
        }
        field(16; "Approved By"; Code[30])
        {
            Editable = false;
        }
        field(17; "Date Rejected"; Date)
        {
            Editable = false;
        }
        field(18; "Time Rejected"; Time)
        {
            Editable = false;
        }
        field(19; "Rejected By"; Code[30])
        {
            Editable = false;
        }
        field(20; "Sent To Server"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(21; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(22; "1st Approval By"; Code[30])
        {
        }
        field(23; "Date 1st Approval"; Date)
        {
            Editable = false;
        }
        field(24; "Time First Approval"; Time)
        {
            Editable = false;
        }
        field(25; "Withdrawal Limit Code"; Code[20])
        {
            TableRelation = "M-SACCO Withdrawal Limits".Code;

            trigger OnValidate()
            begin
                WithdrawLimit.Reset;
                WithdrawLimit.SetRange(WithdrawLimit.Code, "Withdrawal Limit Code");
                if WithdrawLimit.Find('-') then begin
                    WithdrawLimit.TestField(WithdrawLimit."Limit Amount");
                    "Withdrawal Limit Amount" := WithdrawLimit."Limit Amount";
                end;
            end;
        }
        field(26; "Withdrawal Limit Amount"; Decimal)
        {
        }
        field(27; Account; Code[30])
        {
            TableRelation = "Savings Accounts"."No.";

            trigger OnValidate()
            begin
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."No.", Account);
                if SavingsAccounts.Find('-') then begin
                    "Customer ID No" := SavingsAccounts."ID No.";
                    Name := SavingsAccounts.Name;
                    "Mobile No" := SavingsAccounts."Transactional Mobile No";
                    "Date of Birth" := SavingsAccounts."Date of Birth";
                    "Comm Account" := SavingsAccounts."No.";
                    Modify;
                end;
            end;
        }
        field(28; "Name of the Proposed Agent"; Text[200])
        {
        }
        field(29; "Date of Birth"; Date)
        {
        }
        field(30; "Type of Business"; Text[200])
        {
        }
        field(31; "Place of Business"; Text[50])
        {
        }
        field(32; "Business/Work Experience"; Text[100])
        {
        }
        field(33; "Name of Banker"; Text[50])
        {
        }
        field(34; "PIN(KRA)"; Code[30])
        {
        }
        field(35; Branch; Boolean)
        {
        }
        field(36; NewApps; Integer)
        {
        }
        field(37; "Comm Account"; Code[30])
        {
            Editable = false;
            TableRelation = "Savings Accounts"."No.";

            trigger OnValidate()
            begin
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."No.", Account);
                /*
                IF SavingsAccounts.FIND ('-') THEN BEGIN
                "Customer ID No":=SavingsAccounts."ID No.";
                Name:=SavingsAccounts.Name;
                "Mobile No":=SavingsAccounts."Phone No.";
                "Date of Birth":=SavingsAccounts."Date of Birth";
                MODIFY;
                END;
                */

            end;
        }
        field(38; "Internal Agent"; Boolean)
        {
        }
        field(39; "Agent No"; Code[30])
        {
        }
        field(40; "Document No"; Code[30])
        {
        }
        field(41; "Date Sent"; Date)
        {
        }
        field(42; "Time Sent"; Time)
        {
        }
        field(43; Status; Option)
        {
            OptionMembers = "New PIN Sent";
        }
    }

    keys
    {
        key(Key1; "Agent Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "Approval Status" <> "Approval Status"::Open then begin
            Error(Text001);
        end;
    end;

    trigger OnInsert()
    begin
        if "Agent Code" = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."Account Closure");
            "Agent Code" := NoSeriesMgt.GetNextNo(NoSetup."Account Closure");
            // NoSeriesMgt.InitSeries(NoSetup."Account Closure", xRec."No. Series", 0D, "Agent Code", "No. Series");
        end;


        "Entered By" := UserId;
        "Date Entered" := Today;
        "Time Entered" := Time;
    end;

    trigger OnModify()
    begin
        if "Approval Status" <> "Approval Status"::Open then begin
            Error(Text000);
        end;
    end;

    var
        NoSetup: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        WithdrawLimit: Record "M-SACCO Withdrawal Limits";
        MPESAAppDetails: Record "M-SACCO Applications";
        SavingsAccounts: Record "Savings Accounts";
        Text000: Label 'Only Open agent applications can be modified';
        Text001: Label 'Deletion of agent applications is not allowed';
}

