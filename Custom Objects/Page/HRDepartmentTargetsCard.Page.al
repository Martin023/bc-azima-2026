Page 52185448 "HR Department Targets Card"
{
    Caption = 'Department Targets';
    PageType = Card;
    SourceTable = "HR Department Targets Header";
    ApplicationArea = Basic;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Information';
                
                field("Target No"; Rec."Target No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Target No.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Caption = 'Department';
                    Editable = IsEditable;
                    ShowMandatory = true;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                    Editable = IsEditable;
                    ShowMandatory = true;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                    Editable = IsEditable;
                    ShowMandatory = true;
                }
                field("Target Date"; Rec."Target Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("HOD Employee No"; Rec."HOD Employee No")
                {
                    ApplicationArea = Basic;
                    Editable = IsEditable;
                    ShowMandatory = true;
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            
            group("Department Goals")
            {
                Caption = 'Department Goals & Objectives';
                
                part("All Goals"; "Department Target Lines")
                {
                    Caption = 'All Department Goals';
                    ApplicationArea = Basic;
                    SubPageLink = "Department Target No" = FIELD("Target No");
                    UpdatePropagation = Both;
                    Editable = IsEditable;
                }
            }
            
            group("Employee Assignments")
            {
                Caption = 'Employee Target Assignments';
                
                part("Assigned Employees"; "HR Employee Target Assignments")
                {
                    Caption = 'Employees Assigned to Goals';
                    ApplicationArea = Basic;
                    SubPageLink = "Department Target No" = FIELD("Target No");
                    UpdatePropagation = Both;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Goal Management")
            {
                Caption = 'Goal Management';
                
                action("Manage Perspectives")
                {
                    Caption = 'Manage Perspectives';
                    Image = SetupColumns;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Create and manage performance perspective categories';
                    
                    trigger OnAction()
                    begin
                        PAGE.Run(PAGE::"HR Perspective Setup List");
                    end;
                }
            }
            
            group("Assignment Actions")
            {
                Caption = 'Assignment';
                
                action("Assign All Goals to Employee")
                {
                    Caption = 'Assign All Goals to Employee';
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Enabled = IsEditable;
                    ToolTip = 'Assign all department goals to a selected employee';

                    trigger OnAction()
                    var
                        Employee: Record "HR Employees";
                    begin
                        Employee.Reset;
                        Employee.SetRange("Department Code", Rec."Responsibility Center");
                        Employee.SetRange(Status, Employee.Status::Active);
                        if not Employee.FindFirst then
                            Error('No active employees found in department %1', Rec."Department Name");

                        if PAGE.RunModal(PAGE::"HR Employee List - Active", Employee) = ACTION::LookupOK then begin
                            Rec.AssignAllLinesToEmployee(Employee."No.");
                            CurrPage.Update(false);
                        end;
                    end;
                }
                action("View All Assignments")
                {
                    Caption = 'View All Assignments';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Employee Target Assgns List";
                    RunPageLink = "Department Target No" = FIELD("Target No");
                    ToolTip = 'View all employee target assignments for this department';
                }
            }
            
            group("Status Management")
            {
                Caption = 'Status';
                
                action("Send for Approval")
                {
                    Caption = 'Send for Approval';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = (Rec.Status = Rec.Status::Open) AND IsEditable;

                    trigger OnAction()
                    begin
                        if Confirm('Send these Department Targets for Approval?', true) = false then exit;

                        Rec.TestField("Target No");
                        Rec.TestField("Responsibility Center");
                        Rec.TestField("HOD Employee No");
                        Rec.Status := Rec.Status::"Pending Approval";
                        Rec.Modify;
                        Message('Department targets sent for approval');
                    end;
                }
                action("Approve")
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = Rec.Status = Rec.Status::"Pending Approval";

                    trigger OnAction()
                    begin
                        if Confirm('Approve these Department Targets?', true) = false then exit;

                        Rec.Status := Rec.Status::Approved;
                        Rec."Approved By" := UserId;
                        Rec."Approved Date" := Today;
                        Rec.Modify;
                        Message('Department targets approved successfully');
                    end;
                }
                action("Reopen")
                {
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = (Rec.Status = Rec.Status::Approved) OR (Rec.Status = Rec.Status::"Pending Approval");

                    trigger OnAction()
                    begin
                        if Confirm('Reopen these Department Targets for editing?', true) = false then exit;

                        Rec.Status := Rec.Status::Open;
                        Rec."Approved By" := '';
                        Rec."Approved Date" := 0D;
                        Rec.Modify;
                        Message('Department targets reopened');
                    end;
                }
                action("Close")
                {
                    Caption = 'Close';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = Rec.Status = Rec.Status::Approved;

                    trigger OnAction()
                    begin
                        if Confirm('Close these Department Targets? This cannot be undone.', false) = false then exit;

                        Rec.TestField(Status, Rec.Status::Approved);
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify;
                        Message('Department targets closed');
                    end;
                }
            }
            
            action("Print")
            {
                Caption = 'Print';
                Image = PrintForm;
                Promoted = true;
                PromotedCategory = Report;
            }
        }
    }
    
    trigger OnOpenPage()
    var
        HREmp: Record "HR Employees";
    begin
        HREmp.Reset;
        HREmp.SetRange("User ID", UserId);
        if HREmp.FindFirst then begin
            if HREmp."Department Code" = Rec."Responsibility Center" then
                IsEditable := true
            else
                IsEditable := false;
        end else begin
            IsEditable := false;
        end;
    end;
    
    var
        IsEditable: Boolean;
}