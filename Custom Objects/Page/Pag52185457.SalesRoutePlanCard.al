namespace AzimaBC.AzimaBC;
using System.Security.AccessControl;

page 52185457 "Sales Route Plan Card"
{
    ApplicationArea = All;
    Caption = 'Sales Route Plan Card';
    PageType = Card;
    SourceTable = "Sales Route Plans";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Sales Representative"; Rec."Sales Representative")
                {
                    ApplicationArea = All;
                }
                field("Route Date"; Rec."Route Date")
                {
                    ToolTip = 'Specifies the value of the Route Date field.', Comment = '%';
                }
                field(Day; Rec.Day)
                {
                    ToolTip = 'Specifies the value of the Day field.', Comment = '%';
                }
                field(Target; Rec.Target)
                {
                    Multiline = true;
                    ToolTip = 'Specifies the value of the Target field.', Comment = '%';
                }
                field("Place to visit"; Rec."Place to visit")
                {
                    ToolTip = 'Specifies the value of the Place to visit field.', Comment = '%';
                }
                field(Achievements; Rec.Achievements)
                {
                    ToolTip = 'Specifies the value of the Achievements field.', Comment = '%';
                }
                field(Leads; Rec.Leads)
                {
                    ToolTip = 'Specifies the value of the Leads field.', Comment = '%';
                }
                field("BDE Comments"; Rec."BDE Comments")
                {
                    Multiline = true;
                    ToolTip = 'Specifies the value of the BDE Comments field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
            group("Approval Information")
            {
                Caption = 'Approval Information';
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
            }
            part(PartName; "Sales Leads Lines")
            {
                caption = 'Sales Leads Lines';
                SubPageLink = "Header No" = field(No);
                ApplicationArea = Basic, Suite;
            }
            // part(PartName1; "Route Achievements List")
            // {
            //     caption = 'Route Achievements List';
            //     SubPageLink = "Header No" = field(No);
            //     ApplicationArea = Basic, Suite;
            // }
        }

    }
    actions
    {
        area(processing)
        {
            action("Send for Approval")
            {
                Caption = 'Send for Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    VarVariant: Variant;
                begin
                    Rec.TestField("Sales Representative");
                    Rec.TestField("Route Date");
                    Rec.TestField(Target);

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    VarVariant: Variant;
                begin
                    if Confirm('Are you sure you want to cancel this approval request?', false) = false then exit;

                    Rec.TestField(Status, Rec.Status::Pending);
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit 1535; //Approvals Mgmt.
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }
            action(Reopen)
            {
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntry: Record 454; //Approval Entry
                begin
                    if Confirm('Reopen this Sales Route Plan? This will reset status to Open and clear approval history.', false) = false then exit;

                    Rec.Status := Rec.Status::Open;
                    Rec."Approved By" := '';
                    Rec."Approved Date" := 0D;
                    Rec.Modify;

                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange(ApprovalEntry."Document No.", Rec.No);
                    ApprovalEntry.SetRange(ApprovalEntry."Table ID", Database::"Sales Route Plans");
                    if ApprovalEntry.FindSet() then
                        ApprovalEntry.DeleteAll();

                    Message('Sales Route Plan reopened and approval entries removed.');
                end;
            }
        }

    }

}
