page 52186321 "Delegate Meeting Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Delegates Minutes Header";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Information,EDMS';


    layout
    {
        area(content)
        {

            group(General)
            {
                Editable = MeetingEditable;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Meeting Type"; Rec."Meeting Type")
                {
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                    end;
                }

                field("Electoral Region"; Rec."Electoral Region")
                {
                    Caption = 'Delegate Zone';
                    ApplicationArea = Basic, Suite;
                    Editable = ElectoralRegionEditable;

                }

                field("Electoral Name"; Rec."Electoral Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Branch; Rec.Branch)
                {

                }
                // field(Quarter; Rec.Quarter)
                // {
                //     Editable = QuarterEditable;
                // }
                field(Month; Rec.Month)
                {
                    Editable = not QuarterEditable;
                }

                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = false;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = false;
                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = false;
                }

                // Editable = false;

                field("Meeting Paid"; Rec."Meeting Paid")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {

                }
            }
            part(Control12; "Delegate Meeting Attendees")
            {
                Editable = MeetingEditable;
                ApplicationArea = Basic, Suite;
                // Editable = false;
                SubPageLink = "Header No" = FIELD(Code);
            }
        }
    }

    actions
    {
        area(creation)
        {
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
            action(Reaopen)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reaopen Card';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var

                begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
        }
        area(Processing)
        {
            action(SendApprovalRequest)
            {

                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    DelegateOfficials: Record "Delegate Officials";
                begin

                    DelegateOfficials.Reset;
                    DelegateOfficials.SetRange("Electoral Zone", Rec.Code);
                    if DelegateOfficials.FindFirst then begin
                        repeat
                            if DelegateOfficials."Member Number" = '' then
                                Error('Member number cannot be empty');
                            if DelegateOfficials.Position = '' then
                                Error('Position cannot be empty');
                        until DelegateOfficials.Next = 0;
                    end;

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }

            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Visible = true;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }

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
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField(Rec.Status, Rec.Status::Pending);
                    ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField(Rec.Status, Rec.Status::Pending);
                    ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                end;
            }
            action(Delegate)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField(Rec.Status, Rec.Status::Pending);
                    ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                end;
            }

            // group("EDMS Integration")
            // {
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = Category6;
            //         Image = Import;

            //         trigger OnAction()
            //         var
            //             Base64Convert: Codeunit "Base64 Convert";
            //             TempBlob: Codeunit "Temp Blob";
            //             InStr: InStream;

            //             EDMSFunctions: Codeunit "EDMS Functions";
            //             FileName: Text;
            //             FileContentsB64: Text;

            //             IDNumber: Text;
            //             ApplicationType: Label 'MA'; // Member Application
            //             PFNumber: Text;
            //         begin
            //             if Rec.Code <> '' then begin
            //                 FileName := EDMSFunctions.PickEDMSFile(TempBlob);

            //                 TempBlob.CreateInStream(InStr);
            //                 FileContentsB64 := Base64Convert.ToBase64(InStr);

            //                 if FileContentsB64 <> '' then begin
            //                     // UploadToEDMS(Rec, FileName, FileContentsB64);
            //                 end;
            //             end else begin
            //                 Error('Application No. is required for EDMS document upload');
            //             end;
            //         end;
            //     }
            //     action("EDMS File List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = Documents;
            //         Promoted = true;
            //         PromotedCategory = Category6;

            //         RunObject = page "EDMS Files List";
            //         RunPageLink = "Application No." = field(Code);
            //         // RunPageMode = Create;
            //     }
            // }
        }
    }
    var
        DelegatesMinutesHeader: Record "Delegates Minutes Header";
        DelegatesMonthlyReturns: Record "Delegates Monthly Returns";
        SendApprovalButton: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ApprovalButton: Boolean;
        MeetingEditable: boolean;
        ElectoralRegionEditable: Boolean;
        MeetingType: Record "Meeting Types";
        QuarterEditable: Boolean;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetControlAppearance();

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    procedure SetControlAppearance()
    begin
        MeetingEditable := true;
        if Rec.Status <> Rec.Status::Open then begin
            MeetingEditable := false;
        end;


        QuarterEditable := true;
        ElectoralRegionEditable := true;

        if MeetingType.Get(Rec."Meeting Type") then begin
            if MeetingType.Intervals = MeetingType.Intervals::Annual then begin
                QuarterEditable := false;
                ElectoralRegionEditable := false;
            end;
        end;
    end;
}

