#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185504 pageextension52185504 extends "G/L Budget Names"
{
    Caption = 'G/L Budget Names';
    PromotedActionCategories=' ,,,,,,,,Approvals';

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""G/L Budget Names"(Page 121)".

    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Budget Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Budget Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Budget Dimension 3 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Budget Dimension 4 Code")
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".

        modify("Global Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Dimension 1 Code"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Dimension 2 Code"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Dimension 3 Code"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Dimension 4 Code"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 9)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(Blocked)
        {
            // field(Status; Status)
            // {
            //     ApplicationArea = Basic;
            // }
        }
    }
    actions
    {
        modify(EditBudget)
        {
            ApplicationArea = Basic;
        }
        modify(ReportTrialBalance)
        {

            //Unsupported feature: Property Modification (Name) on "ReportTrialBalance(Action 5)".

            Caption = 'Delegate';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on "ReportTrialBalance(Action 5)".


            //Unsupported feature: Property Modification (PromotedCategory) on "ReportTrialBalance(Action 5)".


            //Unsupported feature: Property Insertion (Visible) on "ReportTrialBalance(Action 5)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "EditBudget(Action 19)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "EditBudget(Action 19)".

        modify(ReportGroup)
        {
            Visible = false;
        }


        //Unsupported feature: Code Insertion (VariableCollection) on "Delegate(Action 5).OnAction".

        //trigger (Variable: ApprovalsMgmt)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "ReportTrialBalance(Action 5).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        REPORT.RUN(REPORT::"Trial Balance/Budget");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID)
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ReportTrialBalance(Action 5)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "ReportTrialBalance(Action 5)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "ReportTrialBalance(Action 5)".

        addafter(EditBudget)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        //     CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action("ReOpen Budget")
                {
                    ApplicationArea = Basic;
                    Caption = 'ReOpen Budget';
                    Image = ReOpen;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if not Confirm('Are you sure you want to reopen the budget ?', false) then exit;
                    end;
                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*
                        DocumentType := DocumentType::"Payment Voucher";
                        ApprovalEntries.Setfilters(DATABASE::"Payments Header","Document Type","No.");
                        ApprovalEntries.RUN;
                        */
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);

                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
                    end;
                }
            }
        }
    }

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

    var
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
    //CustomApprovals: Codeunit 52185460;

    //Unsupported feature: Property Deletion (Attributes) on "GetSelectionFilter(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
