table 52185998 "Update Agent Application"
{

    fields
    {
        field(1; "Agent Code"; Code[30])
        {
            Editable = false;
            TableRelation = "Agent Applications" WHERE("Sent To Server" = CONST(Yes),
                                                        "Approval Status" = CONST(Approved));

            trigger OnValidate()
            begin
                AgApp.Get("Agent Code");

                Rec.TransferFields(AgApp);
            end;
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
        field(11; "Approval Status"; Enum "Approval Status")
        {
            // OptionCaption = 'Open,Pending,Approved,Rejected';
            // OptionMembers = Open,Pending,Approved,Rejected;

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
            Editable = true;
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
        field(44; "Teller Account"; Code[20])
        {
            TableRelation = "Bank Account"."No." WHERE("Bank Type" = CONST(Cashier));
        }
        field(45; "Device ID"; Text[200])
        {
        }
        field(46; "Is Admin"; Boolean)
        {
        }
        field(47; "Last Updated By"; Code[50])
        {
            Editable = false;
        }
        field(48; "Last Updated On"; DateTime)
        {
            Editable = false;
        }
        field(50000; "Update No"; Code[10])
        {
            Description = 'Add New fields not in agent application in 50000 series';

            trigger OnValidate()
            begin
                if xRec."Update No" <> Rec."Update No" then begin
                    NoSetup.Get;
                    NoSeriesMgt.TestManual(NoSetup."Agency Update Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(50001; Updated; Boolean)
        {
            Description = 'Add New fields not in agent application in 50000 series';
            Editable = false;
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
    var
        AgApp: Record "Agent Applications";
        ErrOpen: Label 'An open application %1 still exists. Please utilize it before proceeding.';
    begin
        AgUpdate.Reset;
        AgUpdate.SetRange("Approval Status", AgUpdate."Approval Status"::Open);
        if AgUpdate.FindLast then
            Error(ErrOpen, AgUpdate, "Update No");

        NoSetup.Get;
        NoSetup.TestField("Agency Update Nos.");
        RandomizeNoSeriesIncrementNo(NoSetup."Agency Update Nos.");
        if "Update No" = '' then begin
            "Update No" := NoSeriesMgt.GetNextNo(NoSetup."Agency Update Nos.");
            // NoSeriesMgt.InitSeries(NoSetup."Agency Update Nos.", xRec."No. Series", 0D, "Update No", "No. Series");
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
        GeneralSetUp: Record "General Set-Up";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        WithdrawLimit: Record "M-SACCO Withdrawal Limits";
        MPESAAppDetails: Record "M-SACCO Applications";
        SavingsAccounts: Record "Savings Accounts";
        Text000: Label 'Only Open agent applications can be modified';
        Text001: Label 'Deletion of agent applications is not allowed';
        AgApp: Record "Agent Applications";
        NoSetup: Record "Banking No Setup";
        AgUpdate: Record "Update Agent Application";
        adt: DateTime;

    local procedure RandomizeNoSeriesIncrementNo(AgencyNoSeries: Code[10])
    var
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
        PadStrInt: Integer;
    begin
        NoSeries.Get(AgencyNoSeries);
        NoSeriesLine.Reset;
        NoSeriesLine.SetRange("Series Code", NoSeries.Code);
        if NoSeriesLine.FindFirst then
            repeat
                NoSeriesLine."Increment-by No." := GetRandomNumber(1000, 2000);
                // PadStrInt := GetPadstrInt(NoSeriesLine."Starting No.");
                NoSeriesLine."Last No. Used" := PadStr(NoSeriesLine."Last No. Used", PadStrInt) + Format(GetRandomNumber(1000, 2000) * Random(4));
                NoSeriesLine.Modify;
            until NoSeriesLine.Next = 0;
    end;

    local procedure GetRandomNumber(StartingNo: Integer; EndingNo: Integer): Integer
    var
        RandomNo: Integer;
        CanExit: Boolean;
    begin
        CanExit := false;
        repeat
            Randomize();
            RandomNo := Random(2000);
            CanExit := (RandomNo >= StartingNo) and (RandomNo <= EndingNo);
        until CanExit;
        exit(RandomNo);
    end;

    // local procedure GetPadstrInt(): Integer
    // var
    //     Txt: Text;
    //     no: Integer;
    //     output: Integer;
    // begin
    //     foreach Txt in StringInput do begin
    //         if not Evaluate(no, Txt) then
    //             output += 1;
    //     end;

    //     exit(output);
    // end;

    // [Scope('OnPrem')]
    procedure UpdateFields()
    begin
        Rec."Approval Status" := Rec."Approval Status"::Open;
        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UserId;
        "Document Date" := Today;
        "Rejection Reason" := '';
        "Rejected By" := '';
        "Date Approved" := 0D;
        "Time Approved" := 0T;
        "Approved By" := '';
        "Date Rejected" := 0D;
        "Time Rejected" := 0T;
        "Rejected By" := '';
        "1st Approval By" := '';
        "Date 1st Approval" := 0D;
        "Time First Approval" := 0T;
        "Last Updated By" := '';
        "Last Updated On" := adt;
    end;

    // [Scope('OnPrem')]
    procedure FinalizeChanges()
    var
        AApp: Record "Agent Applications";
        AgUpdated: Label '%1 successfully updated';
    begin
        AApp.Get("Agent Code");

        if AApp."Mobile No" <> "Mobile No" then
            AApp."Mobile No" := "Mobile No";
        if AApp."Name of the Proposed Agent" <> "Name of the Proposed Agent" then
            AApp."Name of the Proposed Agent" := "Name of the Proposed Agent";
        if AApp."Type of Business" <> "Type of Business" then
            AApp."Type of Business" := "Type of Business";
        if AApp."Place of Business" <> "Place of Business" then
            AApp."Place of Business" := "Place of Business";
        if AApp."Business/Work Experience" <> "Business/Work Experience" then
            AApp."Business/Work Experience" := "Business/Work Experience";
        if AApp."Name of Banker" <> "Name of Banker" then
            AApp."Name of Banker" := "Name of Banker";
        if AApp."PIN(KRA)" <> "PIN(KRA)" then
            AApp."PIN(KRA)" := "PIN(KRA)";
        if AApp."Withdrawal Limit Code" <> "Withdrawal Limit Code" then
            AApp."Withdrawal Limit Code" := "Withdrawal Limit Code";
        if AApp."Withdrawal Limit Amount" <> "Withdrawal Limit Amount" then
            AApp."Withdrawal Limit Amount" := "Withdrawal Limit Amount";
        if AApp.Comments <> Comments then
            AApp.Comments := Comments;
        if AApp."Device ID" <> "Device ID" then
            AApp."Device ID" := "Device ID";

        if AApp."Is Admin" <> "Is Admin" then
            AApp."Is Admin" := "Is Admin";

        AApp."Sent To Server" := AApp."Sent To Server"::No;
        AApp."Last Updated By" := UserId;
        AApp."Last Update On" := CurrentDateTime;

        Updated := true;
        "Last Updated By" := UserId;
        "Last Updated On" := CurrentDateTime;
        Rec.Modify;
        AApp.Modify;
        Message(AgUpdated, "Name of the Proposed Agent");
    end;
}

