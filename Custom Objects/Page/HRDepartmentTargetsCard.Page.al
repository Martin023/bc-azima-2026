Page 52185448 "HR Department Targets Card"
{
    Caption = 'Department Targets';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approval,Setup';
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
                    Editable = false;
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
                    Editable = (Rec.Status = Rec.Status::Open) and CanEditDepartmentTarget;
                    ShowMandatory = true;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                    Editable = (Rec.Status = Rec.Status::Open) and CanEditDepartmentTarget;
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
                    Editable = false;
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
                    Enabled = (Rec.Status = Rec.Status::Open) and CanEditDepartmentTarget;
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
            action("Approve Department Targets")
            {
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = (Rec.Status = Rec.Status::Open) and CanEditDepartmentTarget;
                ToolTip = 'Approve department targets to enable employee assignment';

                trigger OnAction()
                begin
                    if not Confirm('Approve these Department Targets? Once approved, targets can be assigned to employees.', true) then exit;

                    Rec.TestField("Target No");
                    Rec.TestField("Responsibility Center");
                    Rec.TestField("HOD Employee No");
                    Rec.Status := Rec.Status::Approved;
                    Rec."Approved By" := UserId;
                    Rec."Approved Date" := Today;
                    Rec.Modify;
                    Message('Department targets approved successfully and can now be assigned to employees');
                    CurrPage.Update(false);
                end;
            }
            
            group("Employee Assignment")
            {
                Caption = 'Employee Assignment';
                
                action("Assign All Goals to ONE Employee")
                {
                    Caption = 'Assign All Goals to ONE Employee';
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = (Rec.Status = Rec.Status::Approved) and CanEditDepartmentTarget;
                    ToolTip = 'Assign ALL department goals to ONE selected employee';

                    trigger OnAction()
                    var
                        Employee: Record "HR Employees";
                        TempEmployee: Record "HR Employees" temporary;
                        EmployeeSelection: Page "Employee Selection List";
                    begin
                        Employee.Reset;
                        Employee.SetRange("Responsibility Center", Rec."Responsibility Center");
                        Employee.SetRange(Status, Employee.Status::Active);
                        if not Employee.FindFirst then
                            Error('No active employees found in department %1', Rec."Department Name");

                        Employee.Reset;
                        Employee.SetRange("Responsibility Center", Rec."Responsibility Center");
                        Employee.SetRange(Status, Employee.Status::Active);
                        EmployeeSelection.SetTableView(Employee);
                        EmployeeSelection.LookupMode(true);

                        if EmployeeSelection.RunModal = ACTION::LookupOK then begin
                            EmployeeSelection.GetSelectedEmployees(TempEmployee);
                            
                            if TempEmployee.FindFirst then begin
                                if TempEmployee.Count > 1 then
                                    Error('Please select only ONE employee for this action. Use "Assign to Employees" on individual goals to assign to multiple employees.');
                                
                                Rec.AssignAllLinesToEmployee(TempEmployee."No.");
                                CurrPage.Update(false);
                            end else
                                Error('No employee selected. Please click on an employee row to select.');
                        end;
                    end;
                }
            
                action("View All Assignments")
                {
                    Caption = 'View All Assignments';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Employee Target Assgns List";
                    RunPageLink = "Department Target No" = FIELD("Target No");
                    ToolTip = 'View all employee target assignments for this department';
                }
            }
            
            group("Setup & Tools")
            {
                Caption = 'Setup & Tools';
                
                action("Manage Perspectives")
                {
                    Caption = 'Manage Perspectives';
                    Image = SetupColumns;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Create and manage performance perspective categories';
                    
                    trigger OnAction()
                    begin
                        PAGE.Run(PAGE::"HR Perspective Setup List");
                    end;
                }
                
                action("Reopen")
                {
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = ((Rec.Status = Rec.Status::Approved) OR (Rec.Status = Rec.Status::Closed)) and CanEditDepartmentTarget;

                    trigger OnAction()
                    begin
                        if Confirm('Reopen these Department Targets for editing?', true) = false then exit;

                        Rec.Status := Rec.Status::Open;
                        Rec."Approved By" := '';
                        Rec."Approved Date" := 0D;
                        Rec.Modify;
                        Message('Department targets reopened');
                        CurrPage.Update(false);
                    end;
                }
            }
            
            group("Reports")
            {
                Caption = 'Reports';
                
                action("Print Department Targets")
                {
                    Caption = 'Print Department Targets';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;

                    trigger OnAction()
                    var
                        DeptHeader: Record "HR Department Targets Header";
                    begin
                        DeptHeader.SetRange("Target No", Rec."Target No");
                        Report.Run(Report::"Department Targets Report", true, false, DeptHeader);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CanEditDepartmentTarget := CheckEditAccess();
    end;

    trigger OnAfterGetRecord()
    begin
        CanEditDepartmentTarget := CheckEditAccess();
    end;

    local procedure CheckEditAccess(): Boolean
    var
        HREmp: Record "HR Employees";
        HRHOD: Record "HR Heads of Departments";
    begin
        HREmp.Reset;
        HREmp.SetRange("User ID", UserId);
        if HREmp.FindFirst then begin
            HRHOD.Reset;
            HRHOD.SetRange("Employee No.", HREmp."No.");
            HRHOD.SetRange("Responsibility center", Rec."Responsibility Center");
            if HRHOD.FindFirst then
                exit(true);
        end;

        exit(false);
    end;

    var
        CanEditDepartmentTarget: Boolean;
}
