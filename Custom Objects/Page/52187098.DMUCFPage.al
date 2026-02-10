page 52187098 "DMU CF Page"
{
    ApplicationArea = All;
    Caption = 'DMU CF Page';
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "DMU Case Forwarding";
    PromotedActionCategories = 'New,Process,Reports,Activities,Approvals,Category7_caption,Category8_caption,Category9_caption,Approvals';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = GeneralTabEditable;
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Case Intructions"; Rec."Case Intructions")
                {
                    Editable = CaseInstructionEditable;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();

                    end;
                }
                field(Description; Rec.Description)
                {
                    MultiLine = true;
                }
                field("Send/Forward to"; Rec."Send/Forward to")
                {

                }
                field("Employer Code"; Rec."Employer Code")
                {
                    Editable = EmployerCodeEditable;
                }
                field(Period; Rec.Period)
                {
                    Editable = PeriodEditable;
                }
                field("Period Name"; Rec."Period Name")
                {
                    Editable = false;
                }

                field("Total Issues"; Rec."Total Issues")
                {
                    Editable = false;
                }
                field("Open Issues"; Rec."Open Issues")
                {
                    Editable = false;
                }
                field("Originating Department"; Rec."Originating Department")
                {
                    Editable = false;
                }
                field("Current Departmrnt"; Rec."Current Departmrnt")
                {
                    Editable = false;
                }
                field("Originating Status"; Rec."Originating Status")
                {
                    Editable = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Recepient Status"; Rec."Recepient Status")
                {
                    Editable = false;
                }
                field("Case Closed"; Rec."Case Closed")
                {
                    Editable = false;
                }
                field("Viewed By Recepient"; Rec."Viewed By Recepient")
                {
                    Editable = false;
                }
                field("Case Closed At"; Rec."Case Closed At")
                {
                    Editable = false;
                }
                field("Case Closed By"; Rec."Case Closed By")
                {
                    Editable = false;
                }
                field("Sent At"; Rec."Sent At")
                {
                    Editable = false;
                }

            }

            part("DMU Case Forwarding Lines"; "DMU Case Forwarding Lines")
            {
                Editable = LinesTabEditable;
                SubPageLink = "Header No." = field("No.");
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Send Case")
            {
                ApplicationArea = Basic, Suite;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = SendCaseVisible;

                trigger OnAction()
                var
                begin
                    Rec.TestField(Description);
                    if Rec."Send/Forward to" = Rec."Current Departmrnt" then Error('You cannot send this document to %1 while its already in %1', Rec."Send/Forward to");
                    Comments.Reset();
                    Comments.SetRange("Header No.", Rec."No.");
                    if Comments.FindLast() then begin
                        ;
                        if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
                        if Comments.Comment = '' then Error('Kindly leave a comment');
                    end else
                        Error('Kindly add a comment');
                    if not Confirm('Are you sure you want to send this case?') then exit;
                    Rec."Originating Status" := Rec."Originating Status"::Sent;
                    Rec."Recepient Status" := Rec."Recepient Status"::New;
                    Rec."Current Departmrnt" := Rec."Send/Forward to";

                    if (CurrentUsersDept <> Rec."Originating Department") and (Rec."Send/Forward to" = Rec."Originating Department") then begin
                        Rec."Originating Status" := Rec."Originating Status"::Returned;
                        Rec."Recepient Status" := Rec."Recepient Status"::Returned;
                    end;
                    CFPage.InsertTracker(Rec."No.", Rec."Send/Forward to", true, UserId, CurrentDateTime);
                    Rec."Sent At" := CurrentDateTime;
                    Rec.Modify();
                    Message('Case sent successfully');
                end;
            }
            action("Close this Case")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Close Case';
                Image = Close;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = CloseCaseVisible;

                trigger OnAction()
                var
                    DMUCFLines: Record "DMU Case Forwarding Lines";
                begin
                    if not Confirm('Are you sure you want to mark these cases as actioned?') then exit;
                    CloseAll();
                    Rec."Case Closed" := true;
                    Rec.Modify();
                    Message('Case closed successfully');
                end;
            }

            action("Action This Case")
            {
                ApplicationArea = Basic, Suite;
                Image = CreateDocuments;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = ActionCaseVisible;

                trigger OnAction()
                var
                    DMUCFLines: Record "DMU Case Forwarding Lines";
                    SMSHeader: Record "SMS Alerts Header";
                    RecoveryHeaders: Record "Loan Recovery Header";
                    DepartMent: Enum "Responsibility Center Enum";

                begin

                    SMSHeader.Reset();
                    SMSHeader.SetRange("Case Forwarding No", Rec."No.");
                    if not SMSHeader.FindFirst() then begin
                        if Rec."Case Intructions" = Rec."Case Intructions"::"Fall Off" then begin
                            if not Confirm('Are you sure you want create headers?') then exit;

                            if not GlobalFunctions.AreUsersPresent(DepartMent::DMU, SubDepartments::"SMS Alerts") then
                                Error('There are no users present for module SMS Alerts');
                            CreateSMSHeader();
                        end;
                        Rec."Case Closed" := true;
                        Rec.Modify();
                        Message('Headers created successfully');
                    end else
                        Message('Headers have already been created');

                    RecoveryHeaders.Reset();
                    RecoveryHeaders.SetRange("Case Forwarding No", Rec."No.");
                    if not RecoveryHeaders.FindFirst() then begin
                        if Rec."Case Intructions" = Rec."Case Intructions"::Reversals then begin
                            if not Confirm('Are you sure you want create headers?') then exit;

                            if not GlobalFunctions.AreUsersPresent(DepartMent::DMU, SubDepartments::"Loan Recovery") then
                                Error('There are no users present for module loan recovery');
                            CreateReversalHeaders();

                            Rec."Case Closed" := true;
                            Rec.Modify();
                            Message('Headers created successfully');
                        end;
                    end else
                        Message('Headers have already been created');
                end;
            }
            action("Process FallOff")
            {
                ApplicationArea = Basic, Suite;
                Image = Process;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = RunSasraandFallOffVisible;
                trigger OnAction()
                var
                    LoansProcess: Codeunit "Loans Process";

                    intProgressTotal: Integer;
                    intProgressI: Integer;
                    TimeProgress: TIME;
                    NoOfRecsProgress: Decimal;
                    NoOfProgressed: Integer;
                    Generating: Label 'Task Progress ...';
                    diaProgress: Dialog;
                    intProgress: Integer;
                    AmountInArrearsSACCO: Decimal;
                    AmountInArrearsSASRA: Decimal;
                begin

                    Rec.TestField("Employer Code");
                    Loans.Reset();
                    Loans.SetRange("Employer Code", Rec."Employer Code");
                    Loans.SetFilter("Total Loan Balance", '>%1', 0);
                    if Loans.Find('-') then begin
                        intProgressTotal := Loans.Count;
                        intProgressI := 0;
                        TimeProgress := TIME;
                        NoOfRecsProgress := intProgressTotal DIV 100;
                        NoOfProgressed := 0;

                        diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
                        repeat

                            intProgressI += 1;

                            IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                                NoOfProgressed := NoOfProgressed + intProgressI;
                                diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                                intProgressI := 0;
                                TimeProgress := TIME;
                            END;
                            LoansProcess.CalculateLoanArrears(Loans, AmountInArrearsSASRA, AmountInArrearsSACCO, Today, true);
                        until Loans.Next() = 0;
                    end;

                    diaProgress.CLOSE;

                end;
            }

            action("Load CF Lines")
            {
                Caption = 'Generate Loan Lines';
                ApplicationArea = Basic, Suite;
                Image = Process;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = RunSasraandFallOffVisible;
                // ToolTip = 'This action has Several Actions 1. SASRA Categorisation 2. Fall Off Generation 3. Lines Generation NB: You will be promted for all';

                trigger OnAction()
                var
                begin
                    // if not Rec."Fall Off Has Run" then
                    //     Error('You need to process fall off before you continue with this action');

                    rec.TestField("Employer Code");

                    if Confirm('Are you sure you want to load loan lines?') then begin
                        DMUCFHeader.Reset();
                        DMUCFHeader.SetRange("No.", Rec."No.");
                        DMUCFHeader.SetRange("Employer Code", Rec."Employer Code");
                        if DMUCFHeader.FindFirst() then begin
                            Report.Run(52187326, true, false, DMUCFHeader);
                        end;
                    end;
                    Message('Lines inserted successfully');
                end;

            }


        }


        area(processing)
        {
            group(Workflows)
            {
                Caption = 'Case Details';

                action(Comments)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action("Case Tracker")
                {
                    ApplicationArea = Basic, Suite;
                    Image = History;
                    Promoted = true;

                    RunObject = page "CF Tracker List";
                    RunPageLink = "Header No." = field("No.");
                }
                action("Case History")
                {
                    ApplicationArea = Basic, Suite;
                    Image = History;
                    Promoted = true;


                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(History));
                }
                action("Recall this Case")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Return;
                    Promoted = true;
                    Visible = RecallVisible;
                    trigger OnAction()
                    var
                        myInt: Integer;
                        CaseTracker: Record "CF Tracker";
                    begin
                        if not Confirm('Are you sure you want to recall this case?') then exit;
                        Rec.CalcFields("Viewed By Recepient");
                        if not Rec."Viewed By Recepient" then begin
                            CaseTracker.Reset();
                            CaseTracker.SetRange("Header No.", Rec."No.");
                            if CaseTracker.FindLast() then
                                CaseTracker.Delete();

                            CaseTracker.Reset();
                            CaseTracker.SetRange("Header No.", Rec."No.");
                            if CaseTracker.FindLast() then begin
                                CaseTracker."Current Department" := true;
                                CaseTracker.Modify();
                            end;

                            Rec."Current Departmrnt" := Rec."Originating Department";
                            Rec."Originating Status" := Rec."Originating Status"::New;
                            Rec.Modify();

                        end else
                            Error('This case has already been viewed by the receipient');


                        Message('Case recalled successfully');
                    end;

                }

            }
        }
    }

    trigger OnOpenPage()
    var
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetCurrRecord()
    var
    begin
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");

            if Rec."Current Departmrnt" = UserSetUp."Responsibility Centre" then begin
                if Rec."Originating Status" <> Rec."Originating Status"::New then begin
                    CaseTracker.Reset();
                    CaseTracker.SetRange("Header No.", Rec."No.");
                    if CaseTracker.FindLast() then begin
                        CaseTracker."Viewed By Recepient" := true;
                        CaseTracker.Modify();
                    end;
                end;
            end;
        end else
            Error('You must be set up in user setup');

        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    var
    begin
        SetControlAppearance();
    end;



    procedure InsertHistory()
    var
        Comments: Record Comments;
    begin
        UserSetUp.Reset();
        UserSetUp.SetRange("User ID", UserId);
        if UserSetUp.FindFirst() then begin

            Comments.Init();
            Comments."Commented By" := UserId;
            Comments.Date := CurrentDateTime;
            Comments."Global Dimension 1 Code" := UserSetUp."Global Dimension 1 Code";
            Comments."Global Dimension 2 Code" := UserSetUp."Global Dimension 2 Code";
            Comments."Responsibility Center" := UserSetUp."Responsibility Centre";
            Comments."Header No." := Rec."No.";
            Comments.Types := Comments.Types::History;
            Comments.Insert(true);
        end;

    end;

    procedure CreateSMSHeader()
    var

        SMSHeader: Record "SMS Alerts Header";
        SMSHeaderInsert: Record "SMS Alerts Header";
        AlertLoanLines: Record "Alerts Loan Lines";
        GenerateLoans: Report "Generate Loans";
        Generating: Label 'Inserting Loan Lines ...';
        TotalUsers: Integer;
        TotalIssues: Integer;
        TotalHeaders: Integer;
        i: Integer;
        HeaderNumber: Integer;
        SkippedLoanNumbers: Record "Skipped Loans";

    begin
        Rec.CalcFields("Total Issues");

        AvailableUsers.Reset();
        AvailableUsers.SetRange("Sub Module", AvailableUsers."Sub Module"::"SMS Alerts");
        AvailableUsers.SetRange("User Active", true);
        if AvailableUsers.Find('-') then
            TotalUsers := AvailableUsers.Count;

        TotalIssues := Rec."Total Issues";

        TotalHeaders := TotalUsers;

        if TotalUsers > TotalIssues then
            TotalHeaders := TotalIssues;

        //Create Headers
        for i := 1 to TotalHeaders do begin
            SMSHeader.Init();
            SMSHeader."Notice Type" := SMSHeader."Notice Type"::"1st & 2nd Notice";
            SMSHeader."Employer Code" := Rec."Employer Code";
            SMSHeader.Period := Rec.Period;
            SMSHeader."Case Forwarding No" := Rec."No.";
            SMSHeader."Auto Assign Task" := true;
            SMSHeader."Case Forwarding No" := Rec."No.";
            SMSHeader.Insert(true);
            SMSHeaders.Add(i, SMSHeader."No.");
            Clear(SMSHeader);
        end;

        if TotalHeaders = 1 then
            SMSHeaderInsert.Get(SMSHeaders.Get(1));

        HeaderNumber := 0;

        CFLines.Reset();
        CFLines.SetRange("Header No.", Rec."No.");
        CFLines.SetRange("Ignore This Loan", false);
        CFLines.SetRange(Closed, false);
        if CFLines.Find('-') then begin

            intProgressTotal := CFLines.COUNT;

            intProgressI := 0;
            TimeProgress := TIME;
            NoOfRecsProgress := intProgressTotal DIV 100;
            NoOfProgressed := 0;

            diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            repeat
                HeaderNumber += 1;
                if HeaderNumber > TotalHeaders then
                    HeaderNumber := 1;

                intProgressI += 1;

                IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                END;

                Loans.Reset();
                Loans.SetRange("Loan No.", CFLines."Loan Number");
                if Loans.FindFirst() then begin
                    if TotalHeaders > 1 then
                        SMSHeaderInsert.Get(SMSHeaders.Get(HeaderNumber));

                    if not SMSHeader.CheckIfLoanISPresentAndInsert(Loans."Loan No.", SMSHeaderInsert."No.") then
                        GenerateLoans.InsertLoanLines(Loans, SMSHeaderInsert);
                end;
                CFLines.Closed := true;
                CFLines.Modify();
            until CFLines.Next() = 0;
            diaProgress.Close();
        end;


    end;

    procedure CreateReversalHeaders()
    var
        Loans: Record Loans;
        Generating: Label 'Creating Reversal Header ...';
    begin
        CFLines.Reset();
        CFLines.SetRange("Header No.", Rec."No.");
        CFLines.SetRange("Ignore This Loan", false);
        CFLines.SetRange(Closed, false);
        if CFLines.Find('-') then begin
            intProgressTotal := CFLines.COUNT;

            intProgressI := 0;
            TimeProgress := TIME;
            NoOfRecsProgress := intProgressTotal DIV 100;
            NoOfProgressed := 0;

            diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            repeat

                intProgressI += 1;

                IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                END;

                if Loans.Get(CFLines."Loan Number") then begin
                    CreateReversalHeader(Loans, CFLines."Header No.");
                    CFLines.Closed := true;
                    CFLines.Modify();
                end;
            until CFLines.Next() = 0;
            diaProgress.Close();
        end;
    end;

    procedure CreateReversalHeader(Loans: Record Loans; HeaderNo: Code[50])
    var
        AttachmentHeader: Record "Loan Recovery Header";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        SubDepartments: Enum "Sub Module";
        GlobalFunctions: Codeunit "Global Functions";
    begin
        AttachmentHeader.Reset();
        AttachmentHeader.SetRange("Member No.", Loans."Member No.");
        AttachmentHeader.SetRange("Recovery Type", AttachmentHeader."Recovery Type"::"Recovery and Attachment");
        AttachmentHeader.SetRange(Action, AttachmentHeader.Action::Recovered);
        AttachmentHeader.SetRange("Header Reversed", false);
        if AttachmentHeader.Find('-') then begin
            repeat
                CreditLedgerEntry.Reset();
                CreditLedgerEntry.SetRange("Document No.", AttachmentHeader."No.");
                CreditLedgerEntry.SetRange(Reversed, true);
                if not CreditLedgerEntry.FindFirst() then begin
                    LoanRecoveryHeader.Reset();
                    LoanRecoveryHeader.SetRange("Member No.", Loans."Member No.");
                    LoanRecoveryHeader.SetRange("Recovery Type", LoanRecoveryHeader."Recovery Type"::Reversal);
                    LoanRecoveryHeader.SetRange("Detach Recovery No", AttachmentHeader."No.");
                    if not LoanRecoveryHeader.FindFirst() then begin
                        Clear(LoanRecoveryHeader);
                        LoanRecoveryHeader.Init();
                        LoanRecoveryHeader."Member No." := Loans."Member No.";
                        LoanRecoveryHeader.Validate("Member No.");
                        LoanRecoveryHeader."Recovery Type" := LoanRecoveryHeader."Recovery Type"::Reversal;
                        LoanRecoveryHeader.Validate("Recovery Type");
                        LoanRecoveryHeader."Detach Recovery No" := AttachmentHeader."No.";
                        LoanRecoveryHeader.Validate("Detach Recovery No");
                        LoanRecoveryHeader."Auto Assign Task" := true;
                        LoanRecoveryHeader."Case Forwarding No" := HeaderNo;
                        LoanRecoveryHeader.Insert(true);
                        Clear(LoanRecoveryHeader);
                    end;
                end;
            until AttachmentHeader.Next() = 0;
        end;
    end;


    procedure InsertTracker(HeaderNo: Code[30]; AtDept: Code[30]; IsCurrDept: Boolean; ForwardedBy: Code[100]; TimeForwarded: DateTime)
    begin
        CaseTracker.Reset();
        CaseTracker.SetRange("Header No.", HeaderNo);
        if CaseTracker.FindLast() then begin
            CaseTracker."At Department" := AtDept;
            CaseTracker."Time Forwarded" := TimeForwarded;
            CaseTracker."Forwarded By" := ForwardedBy;
            CaseTracker."Current Department" := false;
            CaseTracker.Modify();
        end;

        Clear(CaseTracker);

        CaseTracker.Init();
        CaseTracker."Header No." := HeaderNo;
        CaseTracker."At Department" := AtDept;
        CaseTracker."Current Department" := IsCurrDept;
        CaseTracker."Forwarded By" := ForwardedBy;
        CaseTracker."Time Forwarded" := TimeForwarded;
        CaseTracker.Insert(true);
    end;

    procedure GetPreviousResponsibilityCenter(HeaderNo: Code[30]): Code[50]
    begin

        CaseTracker.Reset();
        CaseTracker.SetRange("Header No.", HeaderNo);
        if CaseTracker.Find('-') then
            if CaseTracker.Count = 1 then Error('This case has to move at least once');

        CaseTracker.Reset();
        CaseTracker.SetRange("Header No.", HeaderNo);
        CaseTracker.SetRange("Current Department", false);
        if CaseTracker.FindLast() then begin
            exit(CaseTracker."At Department");
        end;


    end;

    procedure CloseAll()
    var
    begin
        DMUCFLines.Reset();
        DMUCFLines.SetRange("Header No.", Rec."No.");
        if DMUCFLines.FindSet() then begin
            DMUCFLines.ModifyAll(Closed, true);
        end;
    end;

    procedure SetControlAppearance()
    begin
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            CurrentUsersDept := UserSetUp."Responsibility Centre";
        end else
            Error('You must be set up in user setup');

        GeneralTabEditable := true;
        LinesTabEditable := true;

        SendCaseVisible := true;
        CloseCaseVisible := true;
        ActionCaseVisible := true;

        RecallVisible := true;

        EmployerCodeEditable := true;
        RunSasraandFallOffVisible := true;

        PeriodEditable := true;
        PeriodNameEditable := true;

        CaseInstructionEditable := true;

        if Rec."Current Departmrnt" <> '' then begin
            Rec.CalcFields("Viewed By Recepient");

            if CurrentUsersDept <> Rec."Current Departmrnt" then begin
                SendCaseVisible := false;
                CloseCaseVisible := false;
                ActionCaseVisible := false;
            end;

            if Rec."Originating Status" = Rec."Originating Status"::New then begin
                CloseCaseVisible := false;
                ActionCaseVisible := false;
            end;

            if CurrentUsersDept <> Rec."Originating Department" then begin
                RecallVisible := false;
                CaseInstructionEditable := false;
                PeriodEditable := false;
            end;

            if Rec."Viewed By Recepient" then
                RecallVisible := false;

            if Rec."Originating Status" = Rec."Originating Status"::New then
                RecallVisible := false;

            if CurrentUsersDept <> Rec."Current Departmrnt" then begin
                GeneralTabEditable := false;
                LinesTabEditable := false;
            end else begin
                if Rec."Case Closed" then begin
                    GeneralTabEditable := false;
                    LinesTabEditable := false;
                end;
            end;

            if Rec."Case Intructions" <> Rec."Case Intructions"::"Fall Off" then begin
                RunSasraandFallOffVisible := false;
                EmployerCodeEditable := false;
                PeriodEditable := false;
                PeriodNameEditable := false;
            end;

            if CurrentUsersDept <> Rec."Originating Department" then
                RunSasraandFallOffVisible := false;

            CFStations.Reset();
            CFStations.SetRange(Department, CurrentUsersDept);
            CFStations.SetRange("Allowed Action", CFStations."Allowed Action"::"Can Edit Employer Code");
            if CFStations.FindFirst() then begin
                if CurrentUsersDept <> Rec."Originating Department" then
                    EmployerCodeEditable := false;
            end else
                EmployerCodeEditable := false;
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetUp: Record "User Setup";
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        Loans: Record Loans;
        DMUCFLines: Record "DMU Case Forwarding Lines";
        CFLines: Record "DMU Case Forwarding Lines";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        DMUCFHeader: Record "DMU Case Forwarding";
        AvailableUsers: Record "Present Users";
        SMSHeaders: Dictionary of [Integer, Code[50]];
        GlobalFunctions: Codeunit "Global Functions";
        SubDepartments: Enum "Sub Module";

        ActionedVisible: Boolean;
        Closed: Boolean;
        GeneralTabEditable: Boolean;
        LinesTabEditable: Boolean;
        SendCaseVisible: Boolean;
        RecallVisible: Boolean;
        CurrentUsersDept: Code[30];
        EmployerCodeEditable: Boolean;

        RunSasraandFallOffVisible: Boolean;
        CloseCaseVisible: Boolean;
        ActionCaseVisible: Boolean;
        PeriodEditable: Boolean;
        PeriodNameEditable: Boolean;
        CaseInstructionEditable: Boolean;


        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        diaProgress: Dialog;
        intProgress: Integer;

}
