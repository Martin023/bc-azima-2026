#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186477 pageextension52186477 extends "FA Reclass. Journal"
{
    Caption = 'FA Reclass. Journal';
    PromotedActionCategories = 'Home, Process, Reports, Approval';
    layout
    {
        addafter("Insert Bal. Account")
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
                Caption = 'Status';
                ToolTip = 'Status of the FA Reclass. Journal Line';
                Editable = false;
            }
        }
        modify(CurrentJnlBatchName)
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("FA Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("FA No.")
        {
            ApplicationArea = Basic;
        }
        modify("New FA No.")
        {
            ApplicationArea = Basic;
        }
        modify("Depreciation Book Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Reclassify Acq. Cost Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Reclassify Acq. Cost %")
        {
            ApplicationArea = Basic;
        }
        modify("Reclassify Acquisition Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Reclassify Depreciation")
        {
            ApplicationArea = Basic;
        }
        modify("Reclassify Write-Down")
        {
            ApplicationArea = Basic;
        }
        modify("Reclassify Appreciation")
        {
            ApplicationArea = Basic;
        }
        modify("Reclassify Custom 1")
        {
            ApplicationArea = Basic;
        }
        modify("Reclassify Custom 2")
        {
            ApplicationArea = Basic;
        }
        modify("Reclassify Salvage Value")
        {
            ApplicationArea = Basic;
        }
        modify("Insert Bal. Account")
        {
            ApplicationArea = Basic;
        }
        modify("Calc. DB1 Depr. Amount")
        {
            ApplicationArea = Basic;
        }
        modify(FADescription)
        {
            ApplicationArea = Basic;
        }
        modify(NewFADescription)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentJnlBatchName(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Posting Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New FA No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciation Book Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclassify Acq. Cost Amount"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclassify Acq. Cost %"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclassify Acquisition Cost"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclassify Depreciation"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclassify Write-Down"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclassify Appreciation"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclassify Custom 1"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclassify Custom 2"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclassify Salvage Value"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert Bal. Account"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calc. DB1 Depr. Amount"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FADescription(Control 35)".


        //Unsupported feature: Property Deletion (ShowCaption) on "FADescription(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NewFADescription(Control 36)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        addafter(Reclassify)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
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
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }


        }
        modify(Reclassify)
        {
            ApplicationArea = Basic;
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                Rec.TestField(Status, Rec.Status::Approved);
            end;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Reclassify(Action 30)".

    }

    //Unsupported feature: Property Modification (Length) on "FADescription(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //FADescription : 100;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //FADescription : 30;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "NewFADescription(Variable 1003)".

    //var
    //>>>> ORIGINAL VALUE:
    //NewFADescription : 100;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NewFADescription : 30;
    //Variable type has not been exported.

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).
    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;

}
