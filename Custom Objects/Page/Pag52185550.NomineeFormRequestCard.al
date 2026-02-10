page 52185550 "Nominee Form Request Card"
{
    Caption = 'Nominee Form Request Card';
    PageType = Card;
    SourceTable = "Nominee Form Request";
    PromotedActionCategories = 'Home,New,Documents,Approvals,Report,Workflow,Forwarding,Process,Dispatch, Refresh';

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
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                    Editable = PageEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.';
                    Editable = false;
                }
                field("Id Number"; Rec."Id Number")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                    Editable = false;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created On field.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                    trigger OnValidate()
                    begin
                        UpdatePageControls;
                    end;
                }
                field(Dispatched; Rec.Dispatched)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Dispatched On"; Rec."Dispatched On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dispatched By"; Rec."Dispatched By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Dispatch Details")
            {
                Editable = DispatcheEditable;
                field("Dispatch Comment"; Rec."Dispatch Comment")
                {
                    ApplicationArea = All;
                    //Editable = DispatcheEditable;
                    MultiLine = true;
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
                field("Current Departmrnt"; Rec."Current Department")
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
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()

                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField(Status, Rec.Status::Open);

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
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
            action(Dispatch)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Dispatch';
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                Visible = DispatcheEditable;
                trigger OnAction()

                begin
                    Rec.Testfield(Rec.Status, Rec.Status::Approved);
                    // Rec.Testfield(Rec."User ID");
                    // UserSetup.Get(Rec."User ID");
                    // if UserSetup."User ID" = Rec."Created By" then

                    // Error('You cannot dispatch your own form request')
                    // else
                    if Rec.Status = Rec.Status::Approved then begin
                        Rec.Dispatched := true;
                        Rec."Dispatched By" := UserID;
                        Rec."Dispatched On" := CurrentDateTime;
                        Rec.Modify;
                    end;
                end;
            }
            action(Refresh)
            {
                ApplicationArea = Basic, Suite;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Category10;
                trigger OnAction()
                begin
                    //Rec.UpdateBBFLines();
                    CurrPage.Update();
                end;
            }

            group("Document Forwarding")
            {
                action("Document Comments")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category7;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action("Return Documents")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category7;

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
                    PromotedCategory = Category7;
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
                    PromotedCategory = Category7;

                    RunObject = page "CF Tracker List";
                    RunPageLink = "Header No." = field("No.");
                }
            }
        }
    }


    trigger OnOpenPage();
    begin
        // if UserSetup.Get(Rec."Created By") then begin
        //     Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        //     Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        //     Rec."Responsibility Center" := UserSetup."Responsibility Centre";
        //     Rec."Created By" := UserId;
        //     Rec.SystemCreatedAt := CURRENTDATETIME;
        //     Rec.Modify;
        //end;
        begin
            UpdatePageControls;
        end;
    end;


    procedure UpdatePageControls()
    begin
        if Rec.Status = Rec.Status::Open then begin
            PageEditable := True;
            DispatcheEditable := False;
            ForwardingEditable := false;
        end
        else begin
            if Rec.Status = Rec.Status::Pending then begin
                PageEditable := False;
                DispatcheEditable := False;
                ForwardingEditable := false;
            end
            else begin
                if Rec.Status = Rec.Status::Approved then begin
                    PageEditable := False;
                    DispatcheEditable := True;
                    ForwardingEditable := true;
                end;
            end;
        end;
    end;


    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdatePageControls;
    end;

    Var
        UserSetup: Record "User Setup";
        PageEditable: Boolean;
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DispatcheEditable: Boolean;
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        ForwardingEditable: Boolean;
}


