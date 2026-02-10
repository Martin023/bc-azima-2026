page 52187078 "Vehicles Repair"
{
    ApplicationArea = All;
    Caption = 'Vehicles Repair';
    PageType = Card;
    SourceTable = "Maintain Machne/Vehicles";
    PromotedActionCategories = 'Home, Process, Report, Approval';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Repair No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No field.';
                    Editable = false;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                Field("Fixed Asset No."; Rec."Asset No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the fixed asset Number';
                }
                field("Car Registration Number"; Rec."Registration No.")
                {
                    ToolTip = 'Specifies the value of the Car Registration Number field.';
                    Editable = false;
                }
                field("Vehicle Description"; Rec."Vehicle Description")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Editable = false;
                }
                Field("Status"; Rec."Status")
                {
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    editable = false;
                }
                field("Created at"; Rec."Created At")
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    Editable = false;
                }
            }
            group(Repair)
            {
                Caption = 'Vehicle Repair Details';
                
                field("Repair Date"; Rec."Repair Date")
                {
                    ToolTip = 'Specifies the value of the Repair Date field.';
                }
                field("Garage/Workshop"; Rec."Repair Garage/Workshop")
                {
                    ToolTip = 'Specifies the value of the Repair Garage/Workshop field.';
                }
                field("Description of Repair"; Rec."Description of Repair")
                {
                    ToolTip = 'Specifies the value of the Description of Repair field.';
                    MultiLine = true;
                }
                field("Cost of Repairs"; Rec."Repair Cost")
                {
                    ToolTip = 'Specifies the value of the Repair Cost field.';
                }
                field("Supervising Staff No."; Rec."Driver No.")
                {
                    
                    ToolTip = 'Specifies the value of the Supervisor Staff No. field.';
                }
                field("Driver PF No."; Rec."Driver PF No.")
                {
                    ToolTip = 'Specifies the value of the Driver PF No. field.';
                    Editable = false;
                }
                field("Supervising Staff Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Supervisor Name field.';
                    Editable = false;
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
                        if Rec.Status = Rec.Status::Approved then 
                        Error('Document is already approved!')
                        else
                        Rec.TestField("Vehicle No.");
                        Rec.TestField("Asset No.");
                        Rec.TestField("Registration No.");
                        Rec.TestField("Vehicle Description");
                        Rec.TestField("Driver No.");
                        Rec.TestField("Driver PF No.");
                        Rec.TestField("Driver Name");
                        Rec.TestField("Repair Date");
                        Rec.TestField("Repair Garage/Workshop");
                        Rec.TestField("Description of Repair");
                        Rec.TestField("Repair Cost");

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
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec.Status = Rec.Status::Approved then 
            //CurrPage.Editable := false;
            CurrPage.editable := false;
    end;

    var
        RepServ: Record "Maintain Machne/Vehicles";
        VehicleService: Boolean;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CurrPageEditable: Boolean;
}

