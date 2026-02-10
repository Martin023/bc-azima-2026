page 52185693 "Agent Application Card"
{
    PageType = Card;
    //Permissions = TableData TableData39006049 = rimd;
    SourceTable = "Agent Applications";
    SourceTableView = WHERE("Approval Status" = FILTER(Open | Pending | Rejected));

    layout
    {
        area(content)
        {
            group(General)
            {
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
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Document Serial No"; Rec."Document Serial No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Account; Rec.Account)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Comm Account"; Rec."Comm Account")
                {
                    Caption = 'Commission Account';
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Customer ID No"; Rec."Customer ID No")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Internal Agent"; Rec."Internal Agent")
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
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Device and Auth")
            {
                Caption = 'Device and Auth';
                field("Device IMEI"; Rec."Device IMEI")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        AgentApplications.Reset;
                        AgentApplications.SetFilter("Agent Code", '<>%1', Rec."Agent Code");
                        AgentApplications.SetRange("Device IMEI", Rec."Device IMEI");
                        if AgentApplications.FindFirst then Error('The Device IMEI Already Exists');
                    end;
                }
                field("Device Serial No"; Rec."Device Serial No")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        AgentApplications.Reset;
                        AgentApplications.SetFilter("Agent Code", '<>%1', Rec."Agent Code");
                        AgentApplications.SetRange("Device Serial No", Rec."Device Serial No");
                        if AgentApplications.FindFirst then Error('The Device Serial Number Already Exists');
                    end;
                }
                field("Software ID"; Rec."Software ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Processor ID"; Rec."Processor ID")
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
                    // ApprovalMgt: Codeunit "Approval Mgt.";
                    begin
                        EnsureRequiredFieldsHaveValues;
                        rec.TestField("Name of the Proposed Agent");
                        VarVariant := Rec;
                        // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant)
                        //   then
                        // CustomApprovals.OnSendDocForApproval(VarVariant);
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
                    // ApprovalMgt: Codeunit 1535;
                    begin
                        //ApprovalMgt.CancelAgencyAppr(Rec,TRUE,TRUE);
                        if rec."Approval Status" <> rec."Approval Status"::Pending then
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

                    trigger OnAction()
                    var
                    //// //ApprovalEntries: Page "Approval Entries";
                    //approvalsMgmt: Codeunit 1535;
                    begin

                        //// ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
        }
    }

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,Agency,"Agent Code";
        DocMustbePending: Label 'Application must be pending approval';
        VarVariant: Variant;
        //  CustomApprovals: Codeunit "Custom Approvals Codeunit";
        AgentApplications: Record "Agent Applications";
        SavingsAccounts: Record "Savings Accounts";

    local procedure EnsureRequiredFieldsHaveValues()
    begin
        rec.TestField("Name of the Proposed Agent");
        rec.TestField(Name);
        rec.TestField("Place of Business");
        rec.TestField("Mobile No");
        rec.TestField("Device IMEI");
        rec.TestField("Device Serial No");
        //TESTFIELD("Device ID");
    end;
}

