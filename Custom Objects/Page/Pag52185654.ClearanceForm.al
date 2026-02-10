// namespace ALProject.ALProject;

page 52186744 "Clearance Form"//52185654
{
    Caption = 'Clearance Form';
    PageType = Card;
    SourceTable = "Clearance Form";
    PromotedActionCategories = 'New,Process,Report,Functions,Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Exit Interview No"; Rec."Clearance No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exit Interview No field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    Editable = false;
                }
                field("Employment Date"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employment Date field.';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;

                }
                field("Applicant User ID"; Rec."Applicant User ID")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
            }
            part(Control3; "Clearance Lines")
            {
                ApplicationArea = Basic;
                SubPageLink = "Header No" = FIELD("Clearance No");

            }





        }

    }
    actions
    {
        area(navigation)
        {

            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                    //  // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        // Rec.TestField("Position Reporting to");



                        VarVariant := Rec;




                        // Rec.Status := Rec.Status::Approved;
                        // Rec.MODIFY;

                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        //MESSAGE('Job Approved and now can be occupied')
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        Rec.TestField(Status, Rec.Status::Pending);
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);

                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = all;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        Rec.TestField(Status, Rec.Status::Pending);


                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
            }


            action(Commentss)
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                Caption = 'Comment';
                PromotedCategory = Category4;

                RunObject = page "Comments List";
                RunPageLink = "Header No." = field("Clearance No");
                RunPageView = where(Types = CONST(comment));
            }
            // action("Board Minutes[case 360 Docs]")
            // {
            //     ApplicationArea = Basic;
            //     Image = Document;
            //     Promoted = true;
            //     PromotedCategory = New;

            //     trigger OnAction()
            //     begin
            //         Message('Opens ed from browser if any doc for board mins is available');
            //         DMS.Reset;
            //         DMS.SetRange(DMS.Key, DMS.Key::"Board Minutes");
            //         if DMS.Find('-') then begin
            //             HyperLink(DMS."url path" + Rec."Job ID");
            //         end;
            //     end;
            // }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if rec."Clearance No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Clearance No");
            NoSeriesMgt.InitSeries(HRSetup."Clearance No", xRec."No Series", 0D, rec."Clearance No", rec."No Series");
        end;
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            // ExitClearance.reset();
            // ExitClearance.SetRange("Employee No.", HrEmp."No.");
            // ExitClearance.SetRange(closed, true);
            // if ExitClearance.FindFirst() then begin


            //Populate fields
            UserSetUp.Get(UserId);
            rec."Employee No." := HREmp."No.";
            rec."Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";

            rec.Date := Today;
            rec."Applicant User ID" := UserId;
            rec."Job Title" := HREmp."Job Title";

            rec."Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
            rec."Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
            rec."Responsibility Center" := UserSetUp."Responsibility Centre";

            // end else
            //     Error('Please Fill the Exit Clearance, Contact HR for assistance');
        end else
            ERROR('UserID' + ' ' + '[' + USERID + ']' + ' has not been assigned to any employee. Please consult the HR officer for assistance')
    end;


    trigger OnAfterGetCurrRecord()
    begin
        // InsertResponsibilityCentre;
    end;

    trigger OnAfterGetRecord()
    begin
        InsertResponsibilityCentre;
    end;


    Procedure InsertResponsibilityCentre()
    var
        LineNo: Integer;
    begin
        // LineNo := 0;
        // ClearanceLines.Reset;
        // ClearanceLines.SetRange("Header No",Rec."Clearance No");
        // if ClearanceLines.Find('-') then
        //     ClearanceLines.DeleteAll;


        // ResponsibilityCentre.reset();
        
        // if ResponsibilityCentre.FindSet() then begin

        //     Repeat
        //         //ClearanceLines.reset();
        //         ClearanceLines.init;
        //         ClearanceLines."Header No" := rec."Clearance No";
        //         ClearanceLines."Responsibility Centre" := ResponsibilityCentre.Code;
        //         ClearanceLines.Liabilities := GetLiabilities;
        //         ClearanceLines.insert(true);
        //     until ResponsibilityCentre.next = 0;
        // end;
    end;

    procedure fnLastLineNo() LastLineNo: Integer
    var

    begin
        ClearanceLines.Reset;
        if ClearanceLines.FindLast then begin
            LastLineNo := ClearanceLines."Line No.";
        end else begin
            LastLineNo := 1;
        end;
    end;

    Procedure GetLiabilities(EmpNo: Code[50]) Liabilities: decimal
    begin
        Members.reset();
        Members.SetRange("Payroll/Staff No.", EmpNo);
        if Members.FindFirst() then begin
            MemberNo := Members."No.";

            HrLoanArrears := LoansProcess.CalculateMemberArrearsPerSourceUnit(MemberNo, Today, 4);
            BusinessLoans := LoansProcess.CalculateMemberArrearsPerSourceUnit(MemberNo, Today, 3);
            BOSALoanArrears := LoansProcess.CalculateMemberArrearsPerSourceUnit(MemberNo, Today, 2);
            FosaLoans := LoansProcess.CalculateMemberArrearsPerSourceUnit(MemberNo, Today, 1);

            
            ClearanceLines.reset();
            ClearanceLines.setrange("Header No", rec."Clearance No");
            if ClearanceLines.FindFirst() then begin
                if ClearanceLines."Responsibility Centre" = 'BOSA' then
                    Liabilities := BOSALoanArrears;
                if ClearanceLines."Responsibility Centre" = 'BUSINESS LOANS' then
                    Liabilities := BusinessLoans;
                if ClearanceLines."Responsibility Centre" = 'HR' then
                    Liabilities := HrLoanArrears;
                if ClearanceLines."Responsibility Centre" = 'FOSA' then
                    Liabilities := FosaLoans;

            end;
        end;
    end;




    var
        HrSetup: record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: record "User Setup";
        HrEmp: record "HR Employees";
        ResponsibilityCentre: record "Responsibility CenterBR";
        ClearanceHeader: record "Clearance Form";
        ClearanceLines: record "Clearance Lines";
        LoansProcess: Codeunit "Loans Process";
        HrLoanArrears: decimal;
        BusinessLoans: decimal;
        BOSALoanArrears: decimal;
        FosaLoans: decimal;
        Members: record Members;
        MemberNo: code[100];
        ExitClearance: record "HR Employee Exit Interviews";
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";




}