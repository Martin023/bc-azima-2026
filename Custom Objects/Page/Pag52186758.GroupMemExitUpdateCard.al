namespace KenpipeBC.KenpipeBC;
using System.Security.User;
using System.Automation;

page 52186758 "Group Mem Exit & Update Card"
{
    Caption = 'Group Mem Exit & Update Card';
    PageType = Card;
    SourceTable = "Group Member Exit & Update";
    PromotedActionCategories = 'Home, Action, Process, Lists, Approval, Reports';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec.Type = Rec.Type::" " then begin
                            GroupClosure := False;
                            IndividualExit := False;
                            Transfer := False;
                            GroupEdit := false;
                        end;
                        if Rec.Type = Rec.Type::"Group Closure" then begin
                            GroupClosure := True;
                            IndividualExit := False;
                            Transfer := false;
                            GroupEdit := false;
                        end;
                        if Rec.Type = Rec.Type::"Individual Exit" then begin
                            GroupClosure := false;
                            IndividualExit := true;
                            Transfer := False;
                            GroupEdit := false;
                        end;
                        if Rec.Type = Rec.Type::Transfer then begin
                            GroupClosure := false;
                            IndividualExit := false;
                            Transfer := True;
                            GroupEdit := false;
                        end;
                        if Rec.Type = Rec.Type::"Group Edit" then begin
                            GroupClosure := false;
                            IndividualExit := false;
                            Transfer := false;
                            GroupEdit := true;
                        end;
                    end;
                }
                field("Group No."; Rec."Group No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Group No. field.', Comment = '%';
                }
                field("Group Name"; Rec."Group Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Group Name field.', Comment = '%';
                    Editable = false;
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registration No. field.', Comment = '%';
                    Editable = false;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the KRA PIN field.', Comment = '%';
                    Editable = false;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone Number field.', Comment = '%';
                    Editable = false;
                }
                field("Group Status"; Rec."Group Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        Members: Record Members;
                        GroupMembers: Record "Account Signatories";

                    begin
                        if (Rec.Type = Rec.Type::"Individual Exit") or (Rec.Type = Rec.Type::Transfer) then begin
                            if Members.Get(Rec."Group No.") then begin
                                GroupMembers.Reset();
                                GroupMembers.SetRange("Account No", Rec."Group No.");
                                if Not GroupMembers.Find('-') then
                                    Error('Member No. %1 is not a member of Group No. %2:', Rec."Member No.", Rec."Group No.");
                            end;
                        end;
                    end;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.', Comment = '%';
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field.', Comment = '%';
                    Editable = false;
                }
                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created At field.', Comment = '%';
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    Editable = false;
                }
            }
            group("Group Transfer")
            {
                Visible = Transfer;
                field("New Group No."; Rec."New Group No.")
                {
                    ApplicationArea = All;
                }
                field("New Group Name"; Rec."New Group Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part("Group Member Lines"; "Group Members Edit")
            {
                ApplicationArea = All;
                Editable = GroupEdit or Transfer or IndividualExit;
                SubPageLink = "Header No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(creation)
        {
            action("Clear Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = Signature;
                Promoted = true;
                Caption = 'Clear Lines';
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    LinesTable.Reset();
                    LinesTable.SetRange("Header No.", Rec."No.");
                    if LinesTable.Find('-') then
                        LinesTable.DeleteAll();
                end;
            }
            action("Group Members")
            {
                ApplicationArea = Basic, Suite;
                Image = Signature;
                Promoted = true;
                Caption = 'Group Members';
                PromotedCategory = Category4;
                RunObject = Page "Signatories List";
                RunPageLink = "Account No" = FIELD("Group No.");
                RunPageMode = View;
            }
            action("Post")
            {
                ApplicationArea = Basic, Suite;
                Image = Post;
                Promoted = true;
                Caption = 'Post';
                PromotedCategory = Category4;
                Enabled = Rec.Status = Rec.Status::Approved;
                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    //Rec.TestField(Posted, False);
                    if Rec.Posted then
                        Error('Document has already been posted!');

                    LoanCount := 0;
                    OutI := 0;
                    OutP := 0;
                    TotalOutStanding := 0;

                    if Rec.Type = Rec.Type::"Group Closure" then begin
                        if not Confirm('Are you sure you want to post this document?') then exit;

                        if MembersTable.Get(Rec."Group No.") then begin
                            LoansTable.RESET();
                            LoansTable.SetRange("Member No.", Rec."Group No.");
                            LoansTable.SetLoadFields(LoansTable."Total Balance", "Outstanding Balance", "Outstanding Interest");
                            if LoansTable.Find then begin
                                LoansTable.Calcfields(LoansTable."Total Balance", LoansTable."Outstanding Balance", LoansTable."Outstanding Interest");
                                if LoansTable."Total Balance" > 0 then begin
                                    repeat
                                        LoanCount := LoanCount + 1;
                                        OutP := OutP + LoansTable."Outstanding Balance";
                                        OutI := OutI + LoansTable."Outstanding Interest";
                                        TotalOutStanding := TotalOutStanding + LoansTable."Outstanding Balance";
                                    until Loanstable.next() = 0;
                                    Error('This group has %1 outstanding loans. Oustanding Principal Amount is %2. Oustanding Interest Amount is %3. Totaling to %4', LoanCount, OutP, OutI, TotalOutStanding);
                                end;
                            end;

                            SavingsAccounts.Reset();
                            SavingsAccounts.SetRange("No.", Rec."Group No.");
                            if SavingsAccounts.Find('-') then begin
                                SavingsAccounts.CalcFields("Balance (LCY)");
                                repeat
                                    if SavingsAccounts."Balance (LCY)" > 0 then
                                        Error('Savings Account No. %1 for group No. %2 has a balabce of %3', SavingsAccounts."No.", Rec."Group No.", SavingsAccounts."Balance (LCY)");
                                until SavingsAccounts.Next() = 0;
                            end;

                            MembersTable.Status := MembersTable.Status::Closed;
                            MembersTable.Subflag := MembersTable.Subflag::Closed;
                            MembersTable.Modify(true);
                            SavingsAccounts.Reset();
                            SavingsAccounts.SetRange("Member No.", Rec."Group No.");
                            if SavingsAccounts.FindSet() then begin
                                repeat
                                    SavingsAccounts.Status := SavingsAccounts.Status::Closed;
                                    SavingsAccounts.Modify(true);
                                until SavingsAccounts.Next = 0;
                            end;
                        end;

                    end
                    else if Rec.Type = Rec.Type::"Individual Exit" then begin
                        LinesTable.Reset();
                        LinesTable.SetRange("Header No.", Rec."No.");
                        if LinesTable.Find('-') then begin
                            repeat
                                if LinesTable.Exited = true then begin
                                    if GroupMembersTable.Get(LinesTable."Member No") then begin
                                        GroupMembersTable.Exited := true;
                                        GroupMembersTable.Modify();
                                    end;
                                end;
                            until LinesTable.Next() = 0;
                        end;
                    end
                    else if rec.Type = rec.Type::"New Group Member" then begin
                        LinesTable.Reset();
                        LinesTable.SetRange("Header No.", Rec."No.");
                        if LinesTable.Find('-') then begin
                            GroupMembersTable.Reset();
                            GroupMembersTable.FindLast();
                            EntryNo := GroupMembersTable."Entry No";
                            repeat
                                if Not GroupMembersTable.Find('-') then begin
                                    EntryNo += 1;
                                    GroupMembersTable.Init();
                                    GroupMembersTable."Entry No" := EntryNo;
                                    GroupMembersTable."Account No" := Rec."Group No.";
                                    GroupMembersTable."Member No." := LinesTable."Member No";
                                    GroupMembersTable.Names := LinesTable."Member Name";
                                    GroupMembersTable."ID Number" := LinesTable."ID No.";
                                    GroupMembersTable."PIN Number" := LinesTable."KRA PIN";
                                    GroupMembersTable."Phone No." := LinesTable."Phone No.";
                                    GroupMembersTable."Must be Present" := LinesTable."Must Be Present";
                                    GroupMembersTable.Type := LinesTable.Designation;
                                    GroupMembersTable."Must be Present" := LinesTable."Must Be Present";
                                    GroupMembersTable.Insert();
                                end
                            until LinesTable.Next() = 0;
                        end;
                    end
                    else if Rec.Type = Rec.Type::"Group Edit" then begin //Edit of group indiduals edit ie Phone Numbers, KRA PIN, Designations and other booelans


                    end;

                    Rec.Posted := True;
                    Rec.Modify;
                    Message('Changes Completed Successfuly!');
                end;
            }
        }
        area(Processing)
        {
            group(Approval)
            {
                Caption = 'Approval';

                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Visible = SendApprovalVisible;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        i: Integer;
                        MinimumGroupMembers: Integer;
                        Cahirman: Boolean;
                        Secretary: Boolean;
                        Treasurer: Boolean;
                        Signatory: Integer;
                        Members: Record Members;
                    begin
                        Rec.TestField(Status, Rec.Status::Open);


                        GenSetup.Get;
                        MinimumGroupMembers := GenSetup."Minimum No of Group Members";
                        if i < MinimumGroupMembers then
                            Error('Minimun number of Group Members is %1, Please add %2 more Members', GenSetup."Minimum No of Group Members", MinimumGroupMembers - i);

                        if not Secretary then Error('You must have a secretary');
                        if not Cahirman then Error('You must have a chair person');
                        if not Treasurer then Error('You must have a treasurer');
                        if Signatory = 0 then Error('You must have at least one signatory');

                        if UserSetup.Get(UserId) then begin
                            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
                            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
                            //Rec."Application Date" := Today;
                            Rec."Created By" := UserId;
                            Rec.Modify;
                        end;
                        if not Confirm('Are you sure you want to send this document for approval?') then exit;
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var

                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you sure you want to send this document for approval?') then exit;
                        Rec.TestField(Status, Rec.Status::Pending);
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        if not Confirm('Are you sure you want to cancel this approval request?') then exit;
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic, Suite;
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
                        if not Confirm('Are you sure you want to cancel this approval request?') then exit;
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var

                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);
                        if not Confirm('Are you sure you want to delegate this approval request?') then exit;
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category5;
                    // RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var

                        ApprovalCommentLine: Record "Approval Comment Line";
                    begin
                        ApprovalCommentLine.SetRange("Table ID", 52185690);
                        ApprovalCommentLine.SetRange("Record ID to Approve", Rec.RecordId);
                        PAGE.Run(PAGE::"Approval Comments", ApprovalCommentLine);
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec.Type = Rec.Type::" " then begin
            GroupClosure := False;
            IndividualExit := False;
            Transfer := False;
            GroupEdit := false;
        end;
        if Rec.Type = Rec.Type::"Group Closure" then begin
            GroupClosure := True;
            IndividualExit := False;
            Transfer := false;
            GroupEdit := false;
        end;
        if Rec.Type = Rec.Type::"Individual Exit" then begin
            GroupClosure := false;
            IndividualExit := true;
            Transfer := False;
            GroupEdit := false;
        end;
        if Rec.Type = Rec.Type::Transfer then begin
            GroupClosure := false;
            IndividualExit := false;
            Transfer := True;
            GroupEdit := false;
        end;
        if Rec.Type = Rec.Type::"Group Edit" then begin
            GroupClosure := false;
            IndividualExit := false;
            Transfer := false;
            GroupEdit := true;
        end;

    end;

    var
        Transfer: Boolean;
        IndividualExit: Boolean;
        GroupClosure: Boolean;
        GroupEdit: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        SendApprovalVisible: Boolean;
        GenSetup: Record "General Set-Up";
        UserSetup: Record "User Setup";
        MembersTable: Record Members;
        GroupMembersTable: Record "Account Signatories";
        SavingsAccounts: Record "Savings Accounts";
        LinesTable: Record "Group Members Edit";
        EntryNo: integer;
        LoansTable: Record Loans;
        TotalOutStanding: Decimal;
        OutI: Decimal;
        OutP: Decimal;
        LoanCount: Integer;
}