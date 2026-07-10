page 52185643 "HR Employee Target Assgn Card"
{
    Caption = 'Employee Target Assignment Card';
    PageType = Card;
    SourceTable = "HR Employee Target Assignment";
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Assignment No"; Rec."Assignment No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Department Target No"; Rec."Department Target No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = Rec.Status = Rec.Status::Incorporated;
                }
            }
            group("Target Details")
            {
                Caption = 'Target Details';
                field("Perspective Name"; Rec."Perspective Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field(Strategy; Rec.Strategy)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field(Measures; Rec.Measures)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field(Baseline; Rec.Baseline)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Targeted Score"; Rec."Targeted Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Employee Details")
            {
                Caption = 'Employee Details';
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee Accepted"; Rec."Employee Accepted")
                {
                    ApplicationArea = Basic;
                    Editable = EmployeeCanEdit;
                }
                field("Employee Comments"; Rec."Employee Comments")
                {
                    ApplicationArea = Basic;
                    Editable = EmployeeCanEdit;
                    MultiLine = true;
                }
            }
            group("Incorporation Details")
            {
                Caption = 'Incorporation Details';
                Visible = Rec.Status = Rec.Status::Incorporated;
                field("Incorporated Into Appraisal No"; Rec."Incorporated Into Appraisal No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Incorporated Date"; Rec."Incorporated Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Audit Information")
            {
                Caption = 'Audit Information';
                field("Assigned By"; Rec."Assigned By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assigned Date"; Rec."Assigned Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Accept Assignment")
            {
                ApplicationArea = Basic;
                Caption = 'Accept Assignment';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = (Rec.Status = Rec.Status::Assigned) and EmployeeCanEdit;

                trigger OnAction()
                begin
                    Rec.MarkAsAccepted();
                    CurrPage.Update(false);
                end;
            }
            action("View Department Target")
            {
                ApplicationArea = Basic;
                Caption = 'View Department Target';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    DeptHeader: Record "HR Department Targets Header";
                begin
                    if DeptHeader.Get(Rec."Department Target No") then
                        PAGE.Run(PAGE::"HR Department Targets Card", DeptHeader);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        HREmp: Record "HR Employees";
    begin
        HREmp.Reset;
        HREmp.SetRange("User ID", UserId);
        if HREmp.FindFirst then
            EmployeeCanEdit := (HREmp."No." = Rec."Employee No")
        else
            EmployeeCanEdit := false;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Perspective Name", "Scoring Method", "Result Label");
    end;

    var
        EmployeeCanEdit: Boolean;
}
