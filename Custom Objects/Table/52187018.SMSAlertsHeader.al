table 52187018 "SMS Alerts Header"
{
    Caption = 'SMS Alerts Header';
    DataClassification = ToBeClassified;
    DrillDownPageId = "SMS Alert Header List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Business Loan Acc App");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
        }
        field(3; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(4; "Created At"; DateTime)
        {
            Caption = 'Created At';
            Editable = false;
        }
        field(5; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(6; "Posted At"; DateTime)
        {
            Caption = 'Posted At';
            Editable = false;
        }
        field(7; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
        }
        field(8; "Send SMS"; Boolean)
        {
            Caption = 'Send SMS';
            trigger OnValidate()
            var
            begin
                SMSLines.Reset();
                SMSLines.SetRange("Header No", "No.");
                SMSLines.SetRange("Notice Type", SMSLines."Notice Type"::SMS);
                if SMSLines.FindSet() then SMSLines.DeleteAll();
            end;
        }
        field(9; "Send Email"; Boolean)
        {
            Caption = 'Send Email';
            trigger OnValidate()
            var
            begin
                SMSLines.Reset();
                SMSLines.SetRange("Header No", "No.");
                SMSLines.SetRange("Notice Type", SMSLines."Notice Type"::Email);
                if SMSLines.FindSet() then SMSLines.DeleteAll();
            end;
        }
        field(10; "Create Letters"; Boolean)
        {
            trigger OnValidate()
            var
            begin
                SMSLines.Reset();
                SMSLines.SetRange("Header No", "No.");
                SMSLines.SetRange("Notice Type", SMSLines."Notice Type"::Letter);
                if SMSLines.FindSet() then SMSLines.DeleteAll();
            end;
        }
        field(11; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(12; "Notice Type"; Option)
        {
            Caption = 'Notice Type';

            OptionMembers = "1st Notice","2nd Notice","Arrears Alert","CRB Notice","CRB Listing";

            trigger OnValidate()
            var
            begin
                SMSLines.Reset();
                SMSLines.SetRange("Header No", "No.");
                if SMSLines.FindSet() then SMSLines.DeleteAll();

                "Days From" := 0;
                "Days To" := 0;
            end;
        }

        field(14; "Days From"; Integer)
        {
            Caption = 'Days In Default From';
            trigger OnValidate()
            var
            begin
                "Days To" := 0;
                SMSLines.Reset();
                SMSLines.SetRange("Header No", "No.");
                if SMSLines.FindSet() then SMSLines.DeleteAll();
            end;
        }
        field(15; "Days To"; Integer)
        {
            Caption = 'Days In Default To';
            trigger OnValidate()
            var
            begin
                SMSLines.Reset();
                SMSLines.SetRange("Header No", "No.");
                if SMSLines.FindSet() then SMSLines.DeleteAll();
            end;
        }
        field(16; "Include Attached Loans"; Boolean)
        {
            Caption = 'Include Attached Loans';
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(19; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";
            Editable = false;
        }
        field(20; "Show Case After (Days)"; Integer)
        {

        }
        field(21; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No.")));
        }
        field(22; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No.")));
        }
        field(23; "Case Forwarding No"; Code[30])
        {
            Editable = false;
        }
        field(24; "Employer Code"; Code[20])
        {
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));
        }
        field(25; Period; date)
        {
            TableRelation = "Interest Due Period"."Interest Due Date";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ("Notice Type" = "Notice Type"::"1st Notice") or ("Notice Type" = "Notice Type"::"2nd Notice") then begin
                    if "Case Forwarding No" = '' then
                        DeleteAlertLines();
                end;
                CalcFields("Period Name");
            end;
        }
        field(26; "Period Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Interest Due Period".Name where("Interest Due Date" = field(Period)));
        }
        field(27; "Attachment Headers Created"; Boolean)
        {
            Editable = false;
        }
        field(28; "Auto Assign Task"; Boolean)
        {
            Editable = false;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."DMU SMS Alerts");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."DMU SMS Alerts");
            // NoSeriesMgt.InitSeries(SeriesSetup."DMU SMS Alerts", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Created At" := CurrentDateTime;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;

        // if "Auto Assign Task" then begin
        //     if not GlobalFunctions.AreUsersPresent(DepartMent::DMU,SubDepartments::"SMS Alerts") then
        //         Error('There are no users present for module SMS Alerts');
        //     GlobalFunctions.AssignUserTasks(DepartMent::DMU, SubDepartments::"SMS Alerts", "No.");
        // end else begin
        //     if not GlobalFunctions.IsCurrentUserPresent(DepartMent::DMU,SubDepartments::"SMS Alerts", UserId) then
        //         Error('You are not currently listed as the present user to perform this task');
        //     GlobalFunctions.InsertUserTasks(DepartMent::DMU, SubDepartments::"SMS Alerts", Rec."No.", UserId);
        // end;
    end;

    procedure DeleteAlertLines()
    begin
        SMSLines.Reset();
        SMSLines.SetRange("Header No", "No.");
        if SMSLines.FindSet() then SMSLines.DeleteAll();

        LoanLines.Reset();
        LoanLines.SetRange("Header No.", "No.");
        if LoanLines.FindSet() then LoanLines.DeleteAll();
    end;


    procedure InsertNoticeLines(HeaderNo: Code[30]; LoanNo: Code[30]; Notice: Text[1000]; PhoneNumber: Text[13]; Email: Text[50]; LetterRoute: Text[250];
    MemberNo: Code[30]; NoticeType: Option SMS,Email,Letter; DaysInArreas: Integer; Receipient: Option "Lonee","Guarantor"; NoticeCategory: Option "First Notice","Second Notice","CRB Notice","CRB Listing Notice")
    var
        NoticeLines: Record "SMS Alerts Lines";
        Loans: Record Loans;
    begin
        Loans.Get(LoanNo);
        Loans.CalcFields("Amount In Arreas SACCO");
        NoticeLines.Init();
        NoticeLines."Email Address" := Email;
        NoticeLines."Header No" := HeaderNo;
        NoticeLines."Letter Route" := LetterRoute;
        NoticeLines."Loan No" := LoanNo;
        NoticeLines."Member No" := MemberNo;
        NoticeLines."Notice Type" := NoticeType;
        NoticeLines."Phone Number" := PhoneNumber;
        NoticeLines.Notice := Notice;
        NoticeLines."Days In Arreas" := DaysInArreas;
        NoticeLines."Amount In Arreas" := Loans."Amount In Arreas SACCO";
        NoticeLines."Notice Category" := NoticeCategory;
        NoticeLines.Recepient := Receipient;
        NoticeLines."Send this Notification" := true;
        NoticeLines.Insert(true);
    end;

    procedure CheckIfLoanISPresentAndInsert(LoanNo: Code[50]; HeaderNo: Code[50]): Boolean
    var
        AlertLines: Record "Alerts Loan Lines";
        SMSHeader: Record "SMS Alerts Header";
        SkippedLoanNumbers: Record "Skipped Loans";
    begin
        if SMSHeader.Get(HeaderNo) then begin
            AlertLines.Reset();
            AlertLines.SetRange("Loan No.", LoanNo);
            AlertLines.SetFilter("Header No.", '<>%1', HeaderNo);
            AlertLines.SetRange(Period, SMSHeader.Period);
            AlertLines.SetRange("Notice Type", SMSHeader."Notice Type");
            AlertLines.SetFilter(Status, '<>%1', AlertLines.Status::Rejected);
            if AlertLines.FindFirst() then begin
                if SkippedLoanNumbers.Get(HeaderNo, LoanNo) then
                    SkippedLoanNumbers.Delete();
                SkippedLoanNumbers.Init();
                SkippedLoanNumbers."Header No." := HeaderNo;
                SkippedLoanNumbers."Loan No." := LoanNo;
                SkippedLoanNumbers."Present Header No." := AlertLines."Header No.";
                SkippedLoanNumbers.Insert(true);
                exit(true);
            end else
                exit(false);
        end;
    end;

    var
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        ProductFactory: Record "Product Factory";
        GeneralSetUp: Record "General Set-Up";
        UserSetup: Record "User Setup";
        SMSLines: Record "SMS Alerts Lines";
        LoanLines: Record "Alerts Loan Lines";
        GlobalFunctions: Codeunit "Global Functions";
        SubDepartments: Enum "Sub Module";
        DepartMent: Enum "Responsibility Center Enum";

}
