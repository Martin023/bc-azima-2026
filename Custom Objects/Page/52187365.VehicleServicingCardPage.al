page 52187365 "Vehicle Servicing Card Page"
{
    ApplicationArea = All;
    Caption = 'Vehicle Servicing Card Page';
    PageType = Card;
    SourceTable = "Vehicle Servicing Table";
    PromotedActionCategories = 'Home, Process, Report, Approval';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                

                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No field.';
                    Editable = false;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                field("Fixed Asset No."; Rec."Asset No.")
                {
                    Editable = false;
                }
                field("Vehicle Registration No."; Rec."Registration No.")
                {
                    Editable = false;
                }
                field("Description"; Rec.Description)
                {
                    Editable = false;
                }
                field("Service Date"; Rec."Service Date")
                {
                    ToolTip = 'Specifies the value of the Service Date field.';
                }
                field("Driver No."; Rec."Driver No.")
                {
                    Caption = 'Driver Staff No.';
                }
                field("Supervising Staff No,"; Rec."Supervisor Staff No.") 
                { 
                    Caption = 'Driver Staff No.';
                    Editable = false;
                }
                field("Supervising Staff Name"; Rec."Supervisor Name")
                {
                    Editable = false;
                    Caption = 'Driver Name';
                }
                field("Service Garage/Workshop"; Rec."Service Garage/Workshop")
                {
                    ToolTip = 'Specifies the value of the Service Garage/Workshop field.';
                }
                field("Service description"; Rec."Service description")
                {
                    ToolTip = 'Specifies the value of the Service description field.';
                }
                field("Last service date"; Rec."Last service date")
                {
                    ToolTip = 'Specifies the value of the Last service date field.';
                    ShowMandatory = true;
                }
                field("Next Service Date"; Rec."Next Service Date")
                {
                    ToolTip = 'Specifies the value of the Next Service Date field.';
                }
                field("Next Service Mileage"; Rec."Next Service Mileage")
                {
                    ToolTip = 'Specifies the value of the Next Service Mileage field.';
                }
                field("Status"; Rec.Status)
                {
                    Editable = false;
                }
                field("Created at"; Rec."Created at")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created by")
                {
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Resposibility Center")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    Caption = 'Branch Code';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    Caption = 'Department Code';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
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
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                // action(Comment)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Comments';
                //     Image = ViewComments;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     RunObject = Page "Approval Comments";
                //     Visible = OpenApprovalEntriesExistForCurrUser;
                // }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
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
                        Rec.TestField("Vehicle No.");
                        Rec.TestField("Service Date");
                        Rec.TestField("Service Garage/Workshop");
                        Rec.TestField("Service description");
                        Rec.TestField("Last service date");
                        Rec.TestField("Registration No.");

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
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if Rec.Status = Rec.Status::Approved then 
            CurrPage.Editable := false;
    end;

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CurrPageEditable: Boolean;
}

