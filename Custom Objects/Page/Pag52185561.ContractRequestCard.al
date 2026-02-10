page 52185561 "Contract Request Card"
{
    Caption = 'Contract Request';
    PageType = Card;
    SourceTable = "Contract Request";
    PromotedActionCategories = 'Home, Process, Reports, Approval';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    editable = false;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Type field.';
                    trigger OnValidate()
                    begin
                        if Rec."Request Type" = Rec."Request Type"::Amendment then
                            VisibleExistingContract := true
                        else
                            VisibleExistingContract := false;
                        if Rec."Request Type" = Rec."Request Type"::Vetting then
                            VisibleExistingContract := true
                        else
                            VisibleExistingContract := false;
                        if Rec."Request Type" = Rec."Request Type"::Termination then
                            VisibleExistingContract := true
                        else
                            VisibleExistingContract := false;
                        if Rec."Request Type" = Rec."Request Type"::Renewal then
                            VisibleExistingContract := true
                        else
                            if Rec."Request Type" = Rec."Request Type"::Drafting then
                                VisibleExistingContract := false
                            else
                                if Rec."Request Type" = Rec."Request Type"::" " then
                                    VisibleExistingContract := false;
                    end;
                }

                field("Party to The Contract"; Rec."Party to The Contract")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Party to The Contract field.';
                }
                field("Contractor Type"; Rec."Contractor Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contractor Type field.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract No. field.';
                    //editable = false;
                    //Visible = VisibleExistingContract;
                }
                field("Contractor Name"; Rec."Contractor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contractor Name field.';
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Type field.';
                }
                field("Type of Service"; Rec."Type of Service")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type of Service field.';
                }
                field("Contract Description"; Rec."Contract Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Description field.';
                }
                field("Date of Request"; Rec."Date of Request")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Request field.';
                    //editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                    trigger OnValidate()
                    begin
                        Duration := '';

                        if (Rec."Start Date" <> 0D) then
                            Duration := HRCodeunit.DetermineAge(Rec."Start Date", Rec."End Date");
                        Rec."Contract Period" := HRCodeunit.DetermineAge(Rec."Start Date", Rec."End Date");
                    end;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                    trigger OnValidate()
                    begin
                        Duration := '';

                        if (Rec."Start Date" <> 0D) then
                            //Duration := HRCodeunit.DetermineAge(Rec."Start Date", Rec."End Date");
                            Rec."Contract Period" := HRCodeunit.DetermineAge(Rec."Start Date", Rec."End Date");
                    end;
                }
                field("Contract Period"; Rec."Contract Period")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Contract Sum"; Rec."Contract Sum")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Sum field.';
                }
                field("Termination Clause"; Rec."Termination Clause")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Termination Reason"; Rec."Termination Reason")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Renewal Clause"; Rec."Renewal Clause")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Branch Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Activity Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    Editable = false;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
            }
            group("Case Forwarding")
            {
                Editable = ForwardingEditable;
                field("Send/Forward to"; Rec."Send/Forward to")
                {
                    Editable = ForwardingEditable;
                }
                field("Originating Department"; Rec."Originating Department")
                {
                    Caption = 'Originating Department';
                    Editable = false;
                }
                field("Current Department"; Rec."Current Department")
                {
                    Caption = 'Current Department';
                    Editable = false;
                }
            }

        }
    }
    actions
    {
        area(Creation)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Send Approval Request';
                trigger OnAction()

                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);

                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    if Rec.Status <> Rec.Status::Pending then
                        Error(DocMustbePending);

                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            group("Document Forwarding")
            {
                action("Document Comments")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action("Return Documents")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Send/Forward to" = Rec."Current Department" then Error('You cannot return this document to %1 while its already in %1', Rec."Send/Forward to");
                        Comments.Reset();
                        Comments.SetRange("Header No.", Rec."No.");
                        if Comments.FindLast() then begin
                            if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
                            if Comments.Comment = '' then Error('Kindly leave a comment');
                        end else
                            Error('Kindly add a comment');
                        if not Confirm('Are you sure you want to return this document?') then exit;
                        if Rec."Originating Department" = Rec."Send/Forward to" then begin
                            // Rec."Originator Status" := Rec."Originator Status"::Returned;
                            // Rec."Recepient Status" := Rec."Recepient Status"::Returned;

                            CFPage.InsertTracker(Rec."No.", Rec."Send/Forward to", true, UserId, CurrentDateTime);
                            Rec."Current Department" := Rec."Send/Forward to";
                            Rec.Modify();
                            Message('Case sent successfully');
                        end
                        else begin
                            Error('You Can Only Return to the Originating Department!');
                        end;
                    end;
                }
                action("Send Case")
                {
                    ApplicationArea = Basic, Suite;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // Visible = SendCaseVisible;

                    trigger OnAction()
                    var
                    begin
                        if Rec."Send/Forward to" = Rec."Current Department" then Error('You cannot send this document to %1 while its already in %1', Rec."Send/Forward to");
                        Comments.Reset();
                        Comments.SetRange("Header No.", Rec."No.");
                        if Comments.FindLast() then begin
                            if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
                            if Comments.Comment = '' then Error('Kindly leave a comment');
                        end else
                            Error('Kindly add a comment');
                        if not Confirm('Are you sure you want to send this case?') then exit;
                        // Rec."Originator Status" := Rec."Originator Status"::Sent;
                        // Rec."Recepient Status" := Rec."Recepient Status"::New;
                        Rec."Current Department" := Rec."Send/Forward to";

                        // if (CurrentUsersDept <> Rec."Originating Department") and (Rec."Send/Forward to" = Rec."Originating Department") then begin
                        //     Rec."Originator Status" := Rec."Originator Status"::Returned;
                        //     Rec."Recepient Status" := Rec."Recepient Status"::Returned;
                        // end;
                        CFPage.InsertTracker(Rec."No.", Rec."Send/Forward to", true, UserId, CurrentDateTime);
                        Rec.Modify();
                        Message('Case sent successfully');
                    end;
                }
                action("Case Tracker")
                {
                    ApplicationArea = Basic, Suite;
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category4;

                    RunObject = page "CF Tracker List";
                    RunPageLink = "Header No." = field("No.");
                }
            }

        }
    }
    trigger OnOpenPage()
    begin
        CurrPage.UPDATE;
        if Rec.Status = Rec.Status::Open then begin
            //CurrPage.Editable := true
            PageEditable := true;
            ForwardingEditable := false;
        end
        else begin
            //CurrPage.Editable := false;
            PageEditable := false;
            ForwardingEditable := true;
        end;


        SetControlAppearance;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit 1535;
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    var
        VarVariant: Variant;
        PageEdit: Boolean;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        HRCodeunit: Codeunit "HR Codeunit";
        Duration: Text[100];
        VisibleExistingContract: Boolean;
        ForwardingEditable: Boolean;
        PageEditable: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
}


