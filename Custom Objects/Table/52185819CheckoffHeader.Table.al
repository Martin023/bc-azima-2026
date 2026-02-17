table 52185819 "Checkoff Header"
{
    DrillDownPageID = "Checkoff Header List";
    LookupPageID = "Checkoff Header List";

    fields
    {
        field(1; "No."; Code[20])
        {
            //OptimizeForTextSearch = true;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Checkoff No.");
                    "No. Series" := '';
                    "Account Type" := "Account Type"::Customer;
                end;
            end;


        }
        field(2; "No. Series"; Code[10])
        {
        }
        field(3; "Date Entered"; Date)
        {
        }
        field(4; "Time Entered"; Time)
        {
        }
        field(5; "Entered By"; Code[50])
        {
        }
        field(6; "Posting Date"; Date)
        {
        }
        field(7; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Savings,Credit';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;
        }
        field(8; "Account No."; Code[20])
        {
            TableRelation = IF ("Account Type" = FILTER(Customer)) Customer."No." where("Account Type" = CONST("Employer"))
            ELSE
            IF ("Account Type" = FILTER("Bank Account")) "Bank Account"."No.";

            trigger OnValidate()
            begin
                "Posting Period" := 0D;
                "Document No." := '';
                Description := '';
                if Customer.Get("Account No.") then begin
                    "Account Name" := Customer.Name;
                    if Customer.Blocked <> Customer.Blocked::" " then
                        Error('Account %1 is blocked, activate before proceeding.', Customer."No.");
                end else
                    "Account Name" := '';

                // if "Posting Period" <> 0D then begin
                //     Validate("Posting Period");
                //     Validate(Type);
                // end;

                //Validate("Employer Code", "Account No.");
                UserSetup.Get(UserId);
                "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            end;
        }
        field(9; "Account Name"; Text[100])
        {
        }
        field(10; "Document No."; Code[20])
        {
            Editable = true;
        }
        field(11; Amount; Decimal)
        {
            Caption = 'Buffer Amount';
            CalcFormula = Sum("Checkoff Buffer".Amount WHERE("Checkoff No" = FIELD("No.")));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(12; "Scheduled Amount"; Decimal)
        {
            CalcFormula = Sum("Checkoff Lines".Amount WHERE("Checkoff Header" = FIELD("No.")));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
            Editable = false;
        }
        field(13; "Employer Code"; Code[20])
        {
            TableRelation = Customer where("Account Type" = const(Employer));

            trigger OnValidate()
            begin
                if Customer.Get("Employer Code") then begin
                    "Employer Name" := Customer.Name;
                end else
                    "Employer Name" := '';
                Rec.Validate("Posting Period");
            end;
        }
        field(14; "Employer Name"; Text[50])
        {
            Editable = false;
        }
        field(15; "Total Count"; Integer)
        {
            CalcFormula = Count("Checkoff Lines" WHERE("Checkoff Header" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(16; Description; Text[50])
        {
        }
        field(17; Posted; Boolean)
        {
        }
        field(18; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;

            trigger OnValidate()
            begin
                // if (Rec.Status = Status::Rejected) or (Rec.Status = Status::Approved) then begin
                //     Comments.Reset();
                //     Comments.SetRange("Commented By", UserId);
                //     Comments.SetRange("Viewd By Somebody Else", false);
                //     Comments.SetRange("Header No.", "No.");
                //     if not Comments.FindFirst() then
                //         Error('Please add a comment before performing this action');
                // end;
            end;
        }
        field(19; "Posted Records"; Integer)
        {
            CalcFormula = Count("Checkoff Lines" WHERE("Checkoff Header" = FIELD("No."),
                                                        Posted = FILTER(true)));
            FieldClass = FlowField;
        }
        field(20; "Vendor No"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(21; "Posting Period"; Date)
        {
            TableRelation = "Interest Due Period"."Interest Due Date" where(closed = const(false));

            trigger OnValidate()
            begin
                TestField("Account No.");

                Description := CopyStr(('Checkoff-' + CopyStr(Format(Rec."Posting Period", 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2DMY(Rec."Posting Period", 3)) /*+ ' ' + Rec."Employer Name"*/), 1, 50);
                "Document No." := "No.";// 'CHK' + CopyStr(Format(Rec."Posting Period", 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2DMY(Rec."Posting Period", 3));

            end;
        }
        field(22; Type; Option)
        {
            OptionCaption = ' ,Checkoff,Pension,STO,Allowance,Salary';
            OptionMembers = " ",Checkoff,Pension,STO,Allowance,Salary;

            trigger OnValidate()
            var
                Abreviation: Text;
            begin
                Abreviation := '';
                TestField("Posting Period");
                Validate("Posting Period");
                if Type <> Type::" " then begin
                    if Type = Type::Checkoff then
                        Abreviation := 'CHK'
                    else
                        if Type = Type::Pension then
                            Abreviation := 'PEN'
                        else
                            if Type = Type::STO then
                                Abreviation := 'STO'
                            else
                                if Type = Type::Allowance then
                                    Abreviation := 'ALL'
                                else
                                    if Type = Type::Salary then
                                        Abreviation := 'SAL';
                    Description := Description + ' ' + Abreviation;
                    "Document No." := "Document No." + ' ' + Abreviation;
                end
            end;
        }
        field(23; "CheckOff Type"; Option)
        {

            OptionMembers = " ",Savings,Loans,Lumpsum;
            ValuesAllowed = Savings, Loans;
        }
        field(24; "Total Count Not Validated"; Integer)
        {
            CalcFormula = Count("Checkoff Lines" WHERE("Checkoff Header" = FIELD("No."), "Savings Account" = filter(true), "Account No." = filter('')));
            FieldClass = FlowField;
            Editable = false;
        }
        field(25; "MKey Generated"; Boolean)
        {
            Editable = false;
        }
        field(26; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
        }
        field(27; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
        }
        field(28; "Loan Cutoff Date"; Date)
        {

        }
        field(29; "Sms Sent"; Boolean)
        {
            Editable = false;
        }
        field(50; Source; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "BC","Amali NCBA";
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
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Checkoff No.");
            "No." := NoSeriesMgt.GetNextNo(NoSetup."Checkoff No.");
            // NoSeriesMgt.InitSeries(NoSetup."Checkoff No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        i := 0;
        CashierTrans.RESET;
        CashierTrans.SETRANGE("Entered By", USERID);
        CashierTrans.SETFILTER(Status, '%1', Status::Open);
        IF CashierTrans.FIND('-') THEN BEGIN
            REPEAT
                i += 1;
                OPenrecords := CashierTrans."No.";
            UNTIL CashierTrans.NEXT = 0;
        END;

        IF i > 1 THEN ERROR('You are not allowed to open multiple applications.Complete %1 first.', OPenrecords);

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UserId;
        UserSetup.Get(UserId);
        "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        "Account Type" := "Account Type"::Customer;
    end;

    var
        NoSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Customer: Record Customer;
        CashierTrans: Record "Checkoff Header";
        OPenrecords: Code[200];
        i: integer;
        Comments: Record Comments;
        GlobalFunctions: Codeunit "Global Functions";
        UserSetup: Record "User Setup";

    [Scope('OnPrem')]
    procedure DetermineMonth(Month: Integer) StrMonth: Text[6]
    begin
        if Month = 1 then begin StrMonth := 'Jan' end;
        if Month = 2 then begin StrMonth := 'Feb' end;
        if Month = 3 then begin StrMonth := 'Mar' end;
        if Month = 4 then begin StrMonth := 'Apr' end;
        if Month = 5 then begin StrMonth := 'May' end;
        if Month = 6 then begin StrMonth := 'Jun' end;
        if Month = 7 then begin StrMonth := 'Jul' end;
        if Month = 8 then begin StrMonth := 'Aug' end;
        if Month = 9 then begin StrMonth := 'Sep' end;
        if Month = 10 then begin StrMonth := 'Oct' end;
        if Month = 11 then begin StrMonth := 'Nov' end;
        if Month = 12 then begin StrMonth := 'Dec' end;
    end;
}

