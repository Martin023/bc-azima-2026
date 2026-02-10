page 52187010 "Moratorium Loan Card"
{
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "Moratorium Loan";
    Caption = 'Moratorium loan Card';
    PromotedActionCategories = 'New,Process,Reports,Approvals,Rejection,Loan Process';
    layout
    {
        area(Content)
        {
            group(General)
            {

                field("M-Num"; Rec."M-Num")
                {
                    ApplicationArea = All;
                    Caption = 'Moratorium Num';
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = all;
                    Editable = PageEdi;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec."Start Date Moratorium" := 0D;
                        Rec."End Date Moratorium" := 0D;
                    end;
                }

                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = all;
                }
                field("Start Date Moratorium"; Rec."Start Date Moratorium")
                {
                    ApplicationArea = all;
                    Editable = PageEdi;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec."End Date Moratorium" := 0D;

                    end;
                }
                field("Moratorium-Duration"; Rec."Moratorium-Duration")
                {
                    ApplicationArea = all;
                    Editable = PageEdi;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        DurationText: Text;
                    begin
                        Evaluate(DurationText, Format(Rec."Moratorium-Duration"));
                        DurationText := DelChr(Format(DurationText), '=', '-|+|');
                        Evaluate(Rec."Moratorium-Duration", DurationText);
                        Rec."End Date Moratorium" := CalcDate(Rec."Moratorium-Duration", rec."Start Date Moratorium");
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("End Date Moratorium"; Rec."End Date Moratorium")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Outsanding Balance"; Rec."Outsanding Balance")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Outsanding Interest"; Rec."Outsanding Interest")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ApplicationArea = all;
                    Editable = EdRej;

                }
            }

        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

            action("Send Approval")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Image = SendApprovalRequest;
                Enabled = SendAppEdi;

                trigger OnAction();
                var
                    CustomAppr: Codeunit "Custom Approvals Codeunit";
                    Varvariant: Variant;
                begin
                    Rec.TestField("Start Date Moratorium");
                    Rec.TestField("End Date Moratorium");
                    rec.TestField("Member No.");
                    Varvariant := Rec;

                    if CustomAppr.CheckApprovalsWorkflowEnabled(Varvariant) then
                        CustomAppr.OnSendDocForApproval(Varvariant);
                end;
            }
            action("Cancel Approval")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Image = CancelApprovalRequest;
                Enabled = CancelApp;

                trigger OnAction();
                var
                    CustomeAppro: Codeunit "Custom Approvals Codeunit";
                    Varvarient: Variant;
                begin
                    rec.TestField(Status, Rec.Status::Pending);
                    Varvarient := Rec;
                    if Rec.Status = Rec.Status::Pending then begin
                        CustomeAppro.OnCancelDocApprovalRequest(Varvarient);
                        Message('You have cancelled moratorium application');
                    end;
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                Enabled = RejectM;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("Reject Approval")
            {
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = RejectM;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField(Status, Rec.Status::Pending);

                    ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                end;
            }
            action("Process Moratorium")
            {
                Caption = 'Process Moratorium';
                Image = Process;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Enabled = ProcessMo;
                trigger OnAction()
                var
                    myInt: Integer;
                    Loans: Record Loans;

                begin
                    rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField(Processed, false);
                    Loans.Reset();
                    Loans.SetRange(Loans."Loan No.", Rec."Loan No");
                    Loans.SetFilter("Outstanding Balance", '>0');
                    if Loans.FindFirst() then begin
                        loans."Moratorium Loan" := true;
                        Loans."Moratorium Start Date" := Rec."Start Date Moratorium";
                        Loans."Moratorium End date" := Rec."End Date Moratorium";
                        Loans.Modify();
                    end;
                    if Rec.Status = Rec.Status::Approved then begin
                        Rec.Processed := true;
                        Rec.Modify();
                    end;
                    Message('Moratorium Loan processed Successfully');
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        case Rec.Status of
            rec.Status::Open:
                begin
                    // CurrPage.Editable := true;
                    ProcessMo := false;
                    SendAppEdi := true;
                    CancelApp := false;
                    RejectM := false;
                    PageEdi := true;
                    EdRej := false;
                end;
            rec.Status::Approved:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := true;
                    SendAppEdi := false;
                    CancelApp := false;
                    RejectM := true;
                    PageEdi := false;
                    EdRej := false;
                end;
            rec.Status::Pending:
                begin
                    //CurrPage.Editable := false;
                    ProcessMo := false;
                    SendAppEdi := false;
                    CancelApp := true;
                    RejectM := true;
                    PageEdi := false;
                    EdRej := true;
                end;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        case Rec.Status of
            rec.Status::Open:
                begin
                    //CurrPage.Editable := true;
                    ProcessMo := false;
                    SendAppEdi := true;
                    CancelApp := false;
                    RejectM := false;
                    PageEdi := true;
                    EdRej := false;
                end;
            rec.Status::Approved:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := true;
                    SendAppEdi := false;
                    CancelApp := false;
                    RejectM := true;
                    PageEdi := false;
                    EdRej := false;
                end;
            rec.Status::Pending:
                begin
                    ProcessMo := false;
                    SendAppEdi := false;
                    CancelApp := true;
                    RejectM := true;
                    EdRej := true;
                    PageEdi := false;

                end;
        end;

    end;

    var
        SendAppEdi: Boolean;
        Caesbo: Boolean;
        CancelApp: Boolean;
        ProcessMo: Boolean;
        RejectM: Boolean;
        PageEdi: Boolean;
        EdRej: Boolean;

}