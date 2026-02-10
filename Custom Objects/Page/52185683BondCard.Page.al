page 52185683 "Bond Card"
{
    PageType = Card;
    SourceTable = Bond;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Bond No."; Rec."Bond No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bond Type"; Rec."Bond Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Address"; Rec."Member Address")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Post Code"; Rec."Member Post Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member City"; Rec."Member City")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Contact Person"; Rec."Member Contact Person")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Beneficiary No."; Rec."Beneficiary No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Beneficiary Name"; Rec."Beneficiary Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Beneficiary Address"; Rec."Beneficiary Address")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Beneficiary Post Code"; Rec."Beneficiary Post Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Beneficiary City"; Rec."Beneficiary City")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Valid From"; Rec."Valid From")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Valid To"; Rec."Valid To")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tender Details"; Rec."Tender Details")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Order/Contract Date"; Rec."Order/Contract Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cash Cover Required"; Rec."Cash Cover Required")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bond Validity Days"; Rec."Bond Validity Days")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cash Cover Refunded"; Rec."Cash Cover Refunded")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bond Status"; Rec."Bond Status")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Control43)
            {
                Caption = 'Approvals';
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sent for approval By"; Rec."Sent for approval By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Rejected/Approved By"; Rec."Rejected/Approved By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sent to Chase Bank By"; Rec."Sent to Chase Bank By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sent for Approval DateTime"; Rec."Sent for Approval DateTime")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Rejected/Approved Date Time"; Rec."Rejected/Approved Date Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Rejection Comment"; Rec."Rejection Comment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bond Created DateTime"; Rec."Bond Created DateTime")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Rejcted/Apprvd by Chase Bnk By"; Rec."Rejcted/Apprvd by Chase Bnk By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Rejcted/Apprvd -Chase Bnk Time"; Rec."Rejcted/Apprvd -Chase Bnk Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Issued By"; Rec."Issued By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Issued DateTime"; Rec."Issued DateTime")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sent to Chase Bank Time"; Rec."Sent to Chase Bank Time")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control42; "Bond Security List")
            {
                SubPageLink = "Bond No." = FIELD("Bond No.");
                SubPageView = SORTING("Bond No.", "Line No.");
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    //ApprovalsMgmt: Codeunit 1535;
                    lvBondSecurity: Record "Bond Security";
                begin

                    if Rec."Bond Status" <> Rec."Bond Status"::Open then
                        Error(DocMustbeOpen);


                    Rec.TestField("Member No.");
                    Rec.TestField("Application Date");
                    Rec.TestField("Bond Type");
                    Rec.TestField("Beneficiary Name");
                    Rec.TestField("Valid From");
                    Rec.TestField("Valid To");
                    Rec.TestField("Tender Details");
                    Rec.TestField(Purpose);
                    if Rec.Amount = 0 then Error('Bond Amount must not be 0');
                    Rec.TestField("Bond Status", Rec."Bond Status"::Open);
                    if Rec."Cash Cover Required" then begin
                        lvBondSecurity.Reset;
                        lvBondSecurity.SetRange("Bond No.", Rec."Bond No.");
                        lvBondSecurity.SetRange(Type, lvBondSecurity.Type::"Cash Cover");
                        if not lvBondSecurity.FindFirst then Error('Cash cover must be indicated.');
                        repeat
                            if (lvBondSecurity.Value = 0) or (lvBondSecurity."Guarantee Value" = 0) then
                                Error('Cash Cover must not have Value=0 or Guarantee value =0');
                        until lvBondSecurity.Next = 0;
                    end;

                    if Rec."Valid From" > Rec."Valid To" then
                        Error('Bond Valid-From cannot be earlier than Bond Valid-To');
                    if Rec."Valid From" < Today then
                        Error('Bond Valid-From must not be less than today');
                    if Confirm('You wish to send this bond for approval?', false) then begin
                        Rec."Sent for approval By" := UserId;
                        Rec."Sent for Approval DateTime" := CurrentDateTime;
                        Rec."Rejection Comment" := '';
                        Rec."Bond Status" := Rec."Bond Status"::"Pending Approval";
                        Rec.Modify;
                    end;


                    VarVariant := Rec;
                    // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                    //     CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                // ApprovalsMgmt: Codeunit 1535;
                begin

                    if Rec."Bond Status" <> Rec."Bond Status"::"Pending Approval" then
                        Error(DocMustbePending);

                    VarVariant := Rec;
                    //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Report Selection - Cash Flow";
                // approvalsMgmt: Codeunit 1535;
                begin

                    //// ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            separator(Action53)
            {
            }
            action("Send For Bank Approval")
            {
                ApplicationArea = Basic, Suite;
                Image = Bank;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm('You wish to send for bank approval?', false) then begin
                        Rec.TestField("Bond Status", Rec."Bond Status"::Approved);
                        Rec."Sent to Chase Bank By" := UserId;
                        Rec."Bond Status" := Rec."Bond Status"::"Sent to Bank";
                        Rec."Sent to Chase Bank Time" := CurrentDateTime;
                        Rec.Modify;
                    end;
                end;
            }
            action("Mark Rejected by Chase Bank")
            {
                ApplicationArea = Basic, Suite;
                Image = CancelIndent;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm('You wish to mark this bond as rejected?', false) then begin
                        Rec.TestField("Bond Status", Rec."Bond Status"::"Sent to Bank");
                        Rec.TestField("Rejection Comment");
                        Rec."Rejcted/Apprvd by Chase Bnk By" := UserId;
                        Rec."Bond Status" := Rec."Bond Status"::"Rejected by Bank";
                        Rec."Rejcted/Apprvd -Chase Bnk Time" := CurrentDateTime;
                        Rec.Modify;
                    end;
                end;
            }
            action("Issue Bond")
            {
                ApplicationArea = Basic, Suite;
                Image = IssueFinanceCharge;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm('You wish to issue this bond?', false) then begin
                        Rec.TestField("Bond Status", Rec."Bond Status"::"Sent to Bank");
                        Rec.IssueBond(Rec."Bond No.");

                        Rec."Rejcted/Apprvd by Chase Bnk By" := UserId;
                        Rec."Bond Status" := Rec."Bond Status"::Issued;
                        Rec."Rejcted/Apprvd -Chase Bnk Time" := CurrentDateTime;
                        Rec."Issued By" := UserId;
                        Rec."Issued DateTime" := CurrentDateTime;
                        Rec.Modify;
                    end;
                end;
            }
            action("Refund Cash Cover")
            {
                ApplicationArea = Basic, Suite;
                Image = Addresses;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin

                    if Confirm('You wish to refund cash cover for this bond?', false) then begin
                        UserSetup.Get(UpperCase(UserId));
                        //**IF NOT UserSetup."Bond Cash Refund" THEN ERROR('You are not allowed to refund cash cover.');
                        Rec.RefundCashCover(Rec."Bond No.");
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*IF "Bond Status"<>"Bond Status"::Open THEN
          CurrPage.EDITABLE:=FALSE
        ELSE
          CurrPage.EDITABLE:=TRUE;
          */

    end;

    var
        VarVariant: Variant;
        //  CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        Txt0000: Label 'Checkoff has been posted';

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

