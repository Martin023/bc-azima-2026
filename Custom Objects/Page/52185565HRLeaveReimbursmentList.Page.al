page 52185565 "HR Leave Reimbursment List1"
{
    CardPageID = "HR Leave Reimbursment Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions,Comments';
    SourceTable = "HR Leave Reimbursement";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Application Code"; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    Editable = "Application CodeEditable";
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = TRUE;
                }
                field("Leave Application No"; Rec."Leave Application No")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = "Responsibility CenterEditable";
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = Basic;
                    Editable = "Leave TypeEditable";
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        GetLeaveStats(Rec."Leave Type");
                        //                    CurrPage.UPDATE;
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "HR Leave Applications Factbox")
            {
                ApplicationArea = Basic;
                SubPageLink = "No." = FIELD("Employee No");
            }
            systempart(Control2; Outlook)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        EmpDept := '';
        //PASS VALUES TO VARIABLES ON THE FORM
        FillVariables;
        //GET LEAVE STATS FOR THIS EMPLOYEE FROM THE EMPLOYEE TABLE
        GetLeaveStats(Rec."Leave Type");
        //TO PREVENT USER FROM SEEING OTHER PEOPLES LEAVE APPLICATIONS
        //SETFILTER("User ID",USERID);

        Updatecontrols;
    end;

    trigger OnInit()
    begin
        NumberofPreviousAttemptsEditab := true;
        "Date of ExamEditable" := true;
        "Details of ExaminationEditable" := true;
        "Cell Phone NumberEditable" := true;
        SupervisorEditable := true;
        RequestLeaveAllowanceEditable := true;
        RelieverEditable := true;
        "Leave Allowance AmountEditable" := true;
        "Start DateEditable" := true;
        "Responsibility CenterEditable" := true;
        "Days AppliedEditable" := true;
        "Leave TypeEditable" := true;
        "Application CodeEditable" := true;
    end;

    var
        HREmp: Record "HR Employees";
        EmpJobDesc: Text[50];
        HRJobs: Record "HR Jobs";
        SupervisorName: Text[60];
        //SMTP: Codeunit "SMTP Mail";
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        HRSetup: Record "HR Setup";
        EmpDept: Text[30];
        EmpName: Text[70];

        "Application CodeEditable": Boolean;

        "Leave TypeEditable": Boolean;

        "Days AppliedEditable": Boolean;

        "Responsibility CenterEditable": Boolean;

        "Start DateEditable": Boolean;

        "Leave Allowance AmountEditable": Boolean;

        RelieverEditable: Boolean;

        RequestLeaveAllowanceEditable: Boolean;

        SupervisorEditable: Boolean;

        "Cell Phone NumberEditable": Boolean;

        "Details of ExaminationEditable": Boolean;

        "Date of ExamEditable": Boolean;

        NumberofPreviousAttemptsEditab: Boolean;
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        LeaveGjline: Record "HR Leave Journal Line";
        "LineNo.": Integer;
        HREmailParameters: Record "HR E-Mail Parameters";

    //[Scope('OnPrem')]
    procedure FillVariables()
    begin
        //GET THE APPLICANT DETAILS

        HREmp.Reset;
        if HREmp.Get(Rec."Employee No") then begin
            EmpName := HREmp.FullName;
            EmpDept := HREmp.Office;
        end else begin
            EmpDept := '';
        end;

        //GET THE JOB DESCRIPTION FRON THE HR JOBS TABLE AND PASS IT TO THE VARIABLE
        HRJobs.Reset;
        if HRJobs.Get(Rec."Job Tittle") then begin
            EmpJobDesc := HRJobs."Job Description";
        end else begin
            EmpJobDesc := '';
        end;

        //GET THE APPROVER NAMES
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", Rec.Supervisor);
        if HREmp.Find('-') then begin
            SupervisorName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        end else begin
            SupervisorName := '';
        end;
    end;

    //[Scope('OnPrem')]
    procedure GetLeaveStats(LeaveType: Text[50])
    begin

        dAlloc := 0;
        dEarnd := 0;
        dTaken := 0;
        dLeft := 0;
        cReimbsd := 0;
        cPerDay := 0;
        cbf := 0;
        if HREmp.Get(Rec."Employee No") then begin
            //HREmp.SETFILTER(HREmp."Leave Type Filter",LeaveType);
            HREmp.CalcFields(HREmp."Allocated Leave Days");
            dAlloc := HREmp."Allocated Leave Days";
            HREmp.Validate(HREmp."Allocated Leave Days");
            dEarnd := HREmp."Total (Leave Days)";
            HREmp.CalcFields(HREmp."Total Leave Taken");
            dTaken := HREmp."Total Leave Taken";
            dLeft := HREmp."Leave Balance";
            cReimbsd := HREmp."Total (Leave Days)";
            cPerDay := HREmp."Reimbursed Leave Days";
            cbf := HREmp."Cash - Leave Earned";
        end;
    end;

    //[Scope('OnPrem')]
    procedure TESTFIELDS()
    begin
        Rec.TestField("Leave Type");
        Rec.TestField("Days Applied");
        Rec.TestField("Start Date");
        Rec.TestField(Reliever);
        Rec.TestField(Supervisor);
    end;

    //[Scope('OnPrem')]
    procedure Updatecontrols()
    begin

        if Rec.Status = Rec.Status::New then begin
            "Application CodeEditable" := true;
            "Leave TypeEditable" := true;
            "Days AppliedEditable" := true;
            "Responsibility CenterEditable" := true;
            "Start DateEditable" := true;
            "Leave Allowance AmountEditable" := true;
            RelieverEditable := true;
            RequestLeaveAllowanceEditable := true;
            SupervisorEditable := true;
            "Cell Phone NumberEditable" := true;
            //CurrForm."E-mail Address".EDITABLE:=TRUE;
            "Details of ExaminationEditable" := true;
            "Date of ExamEditable" := true;
            NumberofPreviousAttemptsEditab := true;
        end else begin
            "Application CodeEditable" := false;
            "Leave TypeEditable" := false;
            "Days AppliedEditable" := false;
            "Responsibility CenterEditable" := false;
            "Start DateEditable" := false;
            "Leave Allowance AmountEditable" := false;
            RelieverEditable := false;
            RequestLeaveAllowanceEditable := false;
            SupervisorEditable := false;
            "Cell Phone NumberEditable" := false;
            //CurrForm."E-mail Address".EDITABLE:=FALSE;
            "Details of ExaminationEditable" := false;
            "Date of ExamEditable" := false;
            NumberofPreviousAttemptsEditab := false;
        end;
    end;

    //[Scope('OnPrem')]
    procedure TestLeaveFamily()
    var
        LeaveFamily: Record "HR Leave Family Groups";
        LeaveFamilyEmployees: Record "HR Leave Family Employees";
        Employees: Record "HR Employees";
    begin
        /*LeaveFamilyEmployees.SETRANGE(LeaveFamilyEmployees."Employee No","Employee No");
        IF LeaveFamilyEmployees.FINDSET THEN //find the leave family employee is associated with
        REPEAT
          LeaveFamily.SETRANGE(LeaveFamily.Code,LeaveFamilyEmployees.Family);
          LeaveFamily.SETFILTER(LeaveFamily."Max Employees On Leave",'>0');
          IF LeaveFamily.FINDSET THEN //find the status other employees on the same leave family
            BEGIN
              Employees.SETRANGE(Employees."No.",LeaveFamilyEmployees."Employee No");
              Employees.SETRANGE(Employees."Leave Status",Employees."Leave Status"::"0");
              IF Employees.COUNT>LeaveFamily."Max Employees On Leave" THEN
              ERROR('The Maximum number of employees on leave for this family has been exceeded, Contact th HR manager for more information');
            END
        UNTIL LeaveFamilyEmployees.NEXT = 0;
         */

    end;

    //[Scope('OnPrem')]
    procedure NewDetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    begin
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
            if NewDetermineIfIncludesNonWorking(Rec."Leave Type") = false then begin
                fReturnDate := CalcDate('1D', fReturnDate);
                if NewDetermineIfIsNonWorking(fReturnDate) then
                    varDaysApplied := varDaysApplied + 1
                else
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied - 1
            end
            else begin
                fReturnDate := CalcDate('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            end;
        until varDaysApplied = 0;
        exit(fReturnDate);
    end;

    //[Scope('OnPrem')]
    procedure NewDetermineIfIncludesNonWorking(var fLeaveCode: Code[10]): Boolean
    begin
        if HRLeaveTypes.Get(fLeaveCode) then begin
            if HRLeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
        end;
    end;

    //[Scope('OnPrem')]
    procedure NewDetermineIfIsNonWorking(var bcDate: Date) Isnonworking: Boolean
    begin

        HRSetup.Find('-');
        HRSetup.TestField(HRSetup."Base Calendar");
        BaseCalendarChange.SetFilter(BaseCalendarChange."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendarChange.SetRange(BaseCalendarChange.Date, bcDate);

        if BaseCalendarChange.Find('-') then begin
            if BaseCalendarChange.Nonworking = false then
                Error('Start date can only be a Working Day Date');
            exit(true);
        end;

        /*
        Customized.RESET;
        Customized.SETRANGE(Customized.Date,bcDate);
        IF Customized.FIND('-') THEN BEGIN
            IF Customized."Non Working" = TRUE THEN
            EXIT(TRUE)
            ELSE
            EXIT(FALSE);
        END;
         */

    end;

    //[Scope('OnPrem')]
    procedure NewDeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    begin
        ReturnDateLoop := true;
        fEndDate := fDate;
        if fEndDate <> 0D then begin
            fEndDate := CalcDate('-1D', fEndDate);
            while (ReturnDateLoop) do begin
                if NewDetermineIfIsNonWorking(fEndDate) then
                    fEndDate := CalcDate('-1D', fEndDate)
                else
                    ReturnDateLoop := false;
            end
        end;
        exit(fEndDate);
    end;

    //[Scope('OnPrem')]
    procedure NewCreateLeaveLedgerEntries()
    begin
        HRSetup.Reset;
        if HRSetup.Find('-') then begin

            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            LeaveGjline.DeleteAll;
            //Dave
            //HRSetup.TESTFIELD(HRSetup."Leave Template");
            //HRSetup.TESTFIELD(HRSetup."Leave Batch");

            HREmp.Get(Rec."Employee No");
            HREmp.TestField(HREmp."Company E-Mail");

            //POPULATE JOURNAL LINES

            "LineNo." := 10000;
            LeaveGjline.Init;
            LeaveGjline."Journal Template Name" := HRSetup."Leave Template";
            LeaveGjline."Journal Batch Name" := HRSetup."Leave Batch";
            LeaveGjline."Line No." := "LineNo.";
            LeaveGjline."Leave Calendar Code" := '2013';
            LeaveGjline."Document No." := Rec."Application Code";
            LeaveGjline."Staff No." := Rec."Employee No";
            LeaveGjline.Validate(LeaveGjline."Staff No.");
            LeaveGjline."Posting Date" := Today;
            LeaveGjline."Leave Entry Type" := LeaveGjline."Leave Entry Type"::Negative;
            LeaveGjline."Leave Approval Date" := Today;
            LeaveGjline.Description := 'Leave Taken';
            LeaveGjline."Leave Type" := Rec."Leave Type";
            //------------------------------------------------------------
            //HRSetup.RESET;
            //HRSetup.FIND('-');
            //HRSetup.TESTFIELD(HRSetup."Leave Posting Period[FROM]");
            //HRSetup.TESTFIELD(HRSetup."Leave Posting Period[TO]");
            //------------------------------------------------------------
            //LeaveGjline."Leave Period Start Date":=HRSetup."Leave Posting Period[FROM]";
            //LeaveGjline."Leave Period End Date":=HRSetup."Leave Posting Period[TO]";
            //IF LeaveGjline."No. of Days"<>0 THEN
            LeaveGjline.Insert(true);


            //Post Journal
            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            if LeaveGjline.Find('-') then begin
                //CODEUNIT.Run(CODEUNIT::Codeunit39005560, LeaveGjline);
            end;
            //Status := Status::"10";
            Rec.Modify;

            /*END ELSE BEGIN
            ERROR('You must specify no of days');
            END;
            END;*/
            //NotifyApplicant;
        end;

    end;

    //[Scope('OnPrem')]
    procedure NewNotifyApplicant()
    begin
        HREmp.Get(Rec."Employee No");
        HREmp.TestField(HREmp."Company E-Mail");

        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        HREmailParameters.Reset;
        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."Associate With"::"Interview Invitations");
        if HREmailParameters.Find('-') then begin


            HREmp.TestField(HREmp."Company E-Mail");
            // SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HREmp."Company E-Mail",
            // HREmailParameters.Subject, 'Dear' + ' ' + HREmp."First Name" + ' ' +
            // HREmailParameters.Body + ' ' + "Application Code" + ' ' + HREmailParameters."Body 2", true);
            // SMTP.Send();


            Message('Leave applicant has been notified successfully');
        end;
    end;
}

