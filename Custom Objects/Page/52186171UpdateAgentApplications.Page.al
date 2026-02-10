page 52186171 "Update Agent Applications"
{
    PageType = Card;
    SourceTable = "Update Agent Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Update No"; Rec."Update No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Name of the Proposed Agent"; Rec."Name of the Proposed Agent")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Type of Business"; Rec."Type of Business")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Place of Business"; Rec."Place of Business")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Business/Work Experience"; Rec."Business/Work Experience")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Name of Banker"; Rec."Name of Banker")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("PIN(KRA)"; Rec."PIN(KRA)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withdrawal Limit Code"; Rec."Withdrawal Limit Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withdrawal Limit Amount"; Rec."Withdrawal Limit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Time Approved"; Rec."Time Approved")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Device ID"; Rec."Device ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Updated On"; Rec."Last Updated On")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Updated By"; Rec."Last Updated By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1000000043)
            {
                Caption = 'Approvals';
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                    // //ApprovalEntries: Page "Approval Entries";
                    // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: Label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField("Mobile No");
                        Rec.TestField("Device ID");
                        Rec.TestField(Comments);
                        VarVariant := Rec;
                        // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        //     CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec."Approval Status" <> rec."Approval Status"::Pending then
                            Error(DocMustbePending);

                        VarVariant := Rec;
                        // CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
            }
            group(Tasks)
            {
                Caption = 'Tasks';
                action(Update)
                {
                    ApplicationArea = Basic, Suite;
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Approval Status", "Approval Status"::Approved);
                        Rec.TestField(Updated, false);
                        Rec.FinalizeChanges();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CurrPage.Editable := false;
        if Rec."Approval Status" = "Approval Status"::Open then
            CurrPage.Editable := true;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,Agency;
        DocMustbePending: Label 'Application must be pending approval';
        VarVariant: Variant;
    // CustomApprovals: Codeunit "Custom Approvals Codeunit";
}

