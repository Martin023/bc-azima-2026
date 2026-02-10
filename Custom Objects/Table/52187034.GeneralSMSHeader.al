table 52187034 "General SMS Header"
{
    Caption = 'General SMS Header';
    DataClassification = ToBeClassified;

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
                    NoSeriesMgt.TestManual(SeriesSetup."General SMS Nos.");
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
            // trigger OnValidate()
            // var
            // begin
            //     SMSLines.Reset();
            //     SMSLines.SetRange("Header No", "No.");
            //     SMSLines.SetRange("Notice Type", SMSLines."Notice Type"::SMS);
            //     if SMSLines.FindSet() then SMSLines.DeleteAll();
            // end;
        }
        field(11; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
            Editable = false;
        }
        // field(12; "Notice Type"; Option)
        // {
        //     Caption = 'Notice Type';

        //     OptionMembers = " ","1st & 2nd Notice","Arrears Alert","CRB Notice","CRB Listing";

        //     trigger OnValidate()
        //     var
        //     begin
        //         SMSLines.Reset();
        //         SMSLines.SetRange("Header No", "No.");
        //         if SMSLines.FindSet() then SMSLines.DeleteAll();

        //         "Days From" := 0;
        //         "Days To" := 0;
        //     end;
        // }


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

        field(27; "Attachment Headers Created"; Boolean)
        {
            Editable = false;
        }
        field(28; "Auto Assign Task"; Boolean)
        {
            Editable = false;
        }
        field(29; "SMS"; Text[100])
        {
            // Editable = false;
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
            SeriesSetup.TestField(SeriesSetup."General SMS Nos.");
            NoSeriesMgt.InitSeries(SeriesSetup."General SMS Nos.", xRec."No. Series", 0D, "No.", "No. Series");
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
        //     if not GlobalFunctions.AreUsersPresent(DepartMent::BLOANS, SubDepartments::"General SMS Alerts") then
        //         Error('There are no users present for module General SMS Alerts');
        //     GlobalFunctions.AssignUserTasks(DepartMent::BLOANS, SubDepartments::"General SMS Alerts", "No.");
        // end else begin
        //     if not GlobalFunctions.IsCurrentUserPresent(DepartMent::BLOANS, SubDepartments::"General SMS Alerts", UserId) then
        //         Error('You are not currently listed as the present user to perform this task');
        //     GlobalFunctions.InsertUserTasks(DepartMent::BLOANS, SubDepartments::"General SMS Alerts", Rec."No.", UserId);
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
        NoticeLines."Amount In Arreas" := Round(((Loans.Repayment / 30) * DaysInArreas), 1, '>');
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
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ProductFactory: Record "Product Factory";
        GeneralSetUp: Record "General Set-Up";
        UserSetup: Record "User Setup";
        SMSLines: Record "SMS Alerts Lines";
        LoanLines: Record "Alerts Loan Lines";
        GlobalFunctions: Codeunit "Global Functions";
        SubDepartments: Enum "Sub Module";
        DepartMent: Enum "Responsibility Center Enum";

}
