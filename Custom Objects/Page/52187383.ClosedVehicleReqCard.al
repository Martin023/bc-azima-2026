page 52187383 "Closed Vehicle Req - Card"
{
    ApplicationArea = All;
    Caption = 'Closed Vehicle Req - Card';
    PageType = Card;
    SourceTable = "Motor Vehicle Request";
    DeleteAllowed = False;
    Editable = False;
    InsertAllowed = false;
    ModifyAllowed = false;
    CardPageId = "Approved Vehicle Req - Card";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = CONST(Deffered)); 
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Date of Request"; Rec."Date of Request")
                {
                    ToolTip = 'Specifies the value of the Date of Request field.';
                }
                field("Type of Travel"; Rec."Type of Travel")
                {
                    ToolTip = 'Specifies the value of the Type of Travel field.';
                    trigger OnValidate()

                    begin
                    VehReq.GET(Rec."Type of Travel");
                    if Rec."Type of Travel" = Rec."Type of Travel"::Department then 
                    IndividualRequest := true else
                    IndividualRequest := false;
                    end;
                }
                field("Vehicle Purpose"; Rec."Vehicle Purpose")
                {
                    ToolTip = 'Specifies the value of the Vehicle Purpose field.';
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field.';
                }
                // field("Date of Travel"; Rec."Date of Travel")
                // {
                //     ToolTip = 'Specifies the value of the Date of Travel field.';
                // }
                field("Resposibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Resposibility Center field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Status"; Rec."Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                // field("Driver Status"; Rec."Driver Status")
                // {
                //     ToolTip = 'Specifies the value of the Driver Status field.';
                //     Editable = false;
                // }
                // field("Vehicle Status"; Rec."Vehicle Status")
                // {
                //     ToolTip = 'Specifies the value of the Vehicle Status field.';
                //     Editable = false;
                // }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created Date field.';
                    Editable = false;
                }
            }

            group("Staff Details")
            {
                visible = IndividualRequest;
                Caption = 'Request Details';
                field("Staff No."; Rec."Staff No.")
                {
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }

            }
                // field(SystemCreatedAt; Rec.SystemCreatedAt)
                // {
                //     ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                // }
                // field(SystemCreatedBy; Rec.SystemCreatedBy)
                // {
                //     ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                // }
                // field(SystemId; Rec.SystemId)
                // {
                //     ToolTip = 'Specifies the value of the SystemId field.';
                // }
                // field(SystemModifiedAt; Rec.SystemModifiedAt)
                // {
                //     ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                // }
                // field(SystemModifiedBy; Rec.SystemModifiedBy)
                // {
                //     ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                // }

            
            group("Department Deatils")
            {
                visible = not IndividualRequest;
                Caption = 'Department Details';
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
            }

        }
    }
    actions
    {
        area(Creation)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()

                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    
                    Rec.TestField(Status, Rec.Status::Open);

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;

            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin


                    if Rec.Status <> Rec.Status::Pending then
                        Error(DocMustbePending);

                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action("Re-Open Document")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category5;
                Image = ReOpen;

                trigger OnAction()
                begin

                    if not Confirm('Are you sure you want to re-open this document?') then exit;
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                    Message('Document Reopened Sucessfully.');
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("Deffer Request")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                begin
                    Rec."Status" := Rec."Status"::Deffered;
                    Rec.MODIFY;
                    MESSAGE('Request Deffered');
                end;
            }
            action(Close)
            {
                ApplicationArea = All;
                Caption = 'Close Request';
                Image = Close;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                begin
                    if Rec."Status" = Rec."Status"::Approved then begin
                        Rec."Status" := Rec."Status"::Closed;
                        Rec.Modify;
                        Message('Vehicle Closed');
                    end;
                end;
            }
            // action("Allocate Driver")
            // {
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     trigger OnAction()
            //     begin
            //         Rec."Status" := Rec."Driver Status"::Allocated;
            //         Rec.MODIFY;
            //         MESSAGE('Driver Allocated');
            //     end;
            // }
            // action("Reallocate Driver")
            // {
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     trigger OnAction()
            //     begin
            //         Rec."Status" := Rec."Driver Status"::Reallocated;
            //         Rec.MODIFY;
            //         MESSAGE('Driver Reallocated');
            //     end;
            // }
            // action("Allocate Vehicle")
            // {
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     trigger OnAction()
            //     begin
            //         Rec."Status" := Rec."Vehicle Status"::Allocated;
            //         Rec.MODIFY;
            //         MESSAGE('Vehicle Allocated');
            //     end;
            // }
            // action("Reallocated Vehicle")
            // {
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     trigger OnAction()
            //     begin
            //         Rec."Status" := Rec."Vehicle Status"::Reallocated;
            //         Rec.MODIFY;
            //         MESSAGE('Vehicle Reallocated');
            //     end;
            // }
        }
    }

    trigger OnOpenPage()
    begin
        if UserSetup.Get(Rec."Created By") then begin
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
            Rec.Modify;
        end;
    end;
    
     var
        VehReq: Record "Motor Vehicle Request";
        IndividualRequest: Boolean;
        DepartmentRequest: Boolean;
        UserSetup: Record "User Setup";
        VisibleDepartment: Boolean;
        VisibleIndividual: Boolean;
        PageEditable: Boolean;
        PageEdit: Boolean;
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
}



