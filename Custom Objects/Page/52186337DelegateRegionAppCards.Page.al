page 52186337 "Delegate Region App Cards"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Delegate Region Applicationss";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEditable;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Delegate Region Description"; Rec."Delegate Region Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Region Code"; Rec."Region Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Region Name"; Rec."Region Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Electoral Zone"; Rec."Electoral Zone")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Electoral Zone Name"; Rec."Electoral Zone Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Name"; Rec."Global Dimension 1 Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Name"; Rec."Global Dimension 2 Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("County Name"; Rec."County Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sub-County"; Rec."Sub-County")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sub-County Name"; Rec."Sub-County Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Delegate Count"; Rec."Delegate Count")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Created; Rec.Created)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
           
        }
    }

    actions
    {
        area(creation)
        {
            action(Approve)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                // ApprovalsMgmt: Codeunit 1535;
                begin
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify;
                end;
            }
            separator(Action21)
            {
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category9;

               
               
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                var
                //  ApprovalsMgmt: Codeunit 1535;
                begin
                    VarVariant := Rec;
                    //  CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;

                trigger OnAction()
                var
                //// //ApprovalEntries: Page "Approval Entries";
                //  approvalsMgmt: Codeunit 1535;
                begin
                    //  // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("Create Electoral Zone")
            {
                ApplicationArea = Basic, Suite;
                Image = CreateWarehousePick;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.TestField(Created, false);
                    Rec.TestField(Status, Rec.Status::Approved);
                    if not Confirm(ConfirmCreation) then
                        exit;
                    // RegistrationProcess.CreateDelegates(Rec);
                end;
            }
            action("Generate AGM Delegate")
            {
                ApplicationArea = Basic, Suite;
                Image = CreateLinesFromTimesheet;
                Promoted = true;
                PromotedCategory = Process;

                // trigger OnAction()
                // begin
                //     if rec.Type = rec.Type::ADM then
                //         // RegistrationProcess.CreateAGMDelegates(Rec)
                //     else
                //         exit;
                // end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
        SetControlAppearance;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
        SetControlAppearance;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        //  CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ConfirmCreation: Label 'Are you sure you want to create this group of delegates?';
        DelegateGroupss: Record "Delegate Region";
        // DelegateMembersApplicationss: Record "Delegate Members Applicationss";
        DelegateMemberss: Record "Delegate Members";
        RegistrationProcess: Codeunit "Registration Process";
        PageEditable: Boolean;

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        if (Rec.Status <> Rec.Status::Open) or (Rec.Created = true) then
            PageEditable := false else
            PageEditable := true;
    end;

    //[Scope('OnPrem')]
    procedure SetControlAppearance()
    var
    //  ApprovalsMgmt: Codeunit 1535;
    begin
        //  OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        //  OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

