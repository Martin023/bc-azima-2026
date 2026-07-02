page 52186155 "My Assigned Targets"
{
    Caption = 'My Assigned Targets';
    PageType = List;
    SourceTable = "HR Employee Target Assignment";
    CardPageID = "HR Employee Target Assgn Card";
    ApplicationArea = Basic;
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Assignment No"; Rec."Assignment No")
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
                field("Perspective Description"; Rec."Perspective Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Width = 40;
                }
                field(Strategy; Rec.Strategy)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Width = 30;
                }
                field("Targeted Score"; Rec."Targeted Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Baseline; Rec.Baseline)
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
                field("Employee Accepted"; Rec."Employee Accepted")
                {
                    ApplicationArea = Basic;
                    Editable = EmployeeCanEdit;
                }
                field("Employee Comments"; Rec."Employee Comments")
                {
                    ApplicationArea = Basic;
                    Editable = EmployeeCanEdit;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assigned Date"; Rec."Assigned Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = Basic;
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
                PromotedIsBig = true;
                Enabled = (Rec.Status = Rec.Status::Assigned) and EmployeeCanEdit;

                trigger OnAction()
                begin
                    if Rec.FindSet then
                        repeat
                            if Rec.Mark then begin
                                if Rec.Status = Rec.Status::Assigned then
                                    Rec.MarkAsAccepted();
                            end;
                        until Rec.Next = 0;
                    CurrPage.Update(false);
                end;
            }
            action("Import to New Appraisal")
            {
                ApplicationArea = Basic;
                Caption = 'Import to New Appraisal';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = EmployeeCanEdit;

                trigger OnAction()
                var
                    IndivTargetHeader: Record "HR Individual Targets Header";
                    Assignment: Record "HR Employee Target Assignment";
                    SelectedCount: Integer;
                    DeptTargetNo: Code[20];
                    AppraisalYear: Integer;
                begin
                    Assignment.Reset;
                    Assignment.CopyFilters(Rec);
                    Assignment.SetRange(Status, Assignment.Status::Assigned);
                    if Assignment.IsEmpty then begin
                        Error('No assigned targets available to import. Please select targets with status "Assigned".');
                    end;

                    if not Assignment.FindFirst then
                        Error('No target selected.');

                    DeptTargetNo := Assignment."Department Target No";
                    AppraisalYear := Assignment."Appraisal Year";

                    if not Confirm('This will create a new Individual Targets appraisal and import all assigned targets from Department Target %1 for year %2. Continue?', 
                        true, DeptTargetNo, AppraisalYear) then
                        exit;

                    IndivTargetHeader.Init;
                    IndivTargetHeader.Insert(true);
                    IndivTargetHeader."Appraisal Year" := AppraisalYear;
                    IndivTargetHeader."Appraisal Type" := IndivTargetHeader."Appraisal Type"::"Target Setting";
                    IndivTargetHeader.Modify;

                    IndivTargetHeader.ImportFromAssignedTargets(DeptTargetNo);

                    if Confirm('Appraisal %1 created successfully. Do you want to open it?', true, IndivTargetHeader."Appraisal No") then
                        PAGE.Run(PAGE::"HR BSC Appraisal Header-Q1", IndivTargetHeader);

                    CurrPage.Update(false);
                end;
            }
            action("View Department Target")
            {
                ApplicationArea = Basic;
                Caption = 'View Department Target';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    DeptHeader: Record "HR Department Targets Header";
                begin
                    if DeptHeader.Get(Rec."Department Target No") then
                        PAGE.Run(PAGE::"HR Department Targets Card", DeptHeader);
                end;
            }
        }
        area(navigation)
        {
            group(Filters)
            {
                Caption = 'Filters';
                action("Show Assigned Only")
                {
                    ApplicationArea = Basic;
                    Caption = 'Show Assigned Only';
                    Image = FilterLines;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::Assigned);
                        CurrPage.Update(false);
                    end;
                }
                action("Show Accepted")
                {
                    ApplicationArea = Basic;
                    Caption = 'Show Accepted';
                    Image = Approve;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::Accepted);
                        CurrPage.Update(false);
                    end;
                }
                action("Show All")
                {
                    ApplicationArea = Basic;
                    Caption = 'Show All';
                    Image = ClearFilter;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status);
                        CurrPage.Update(false);
                    end;
                }
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
            EmployeeCanEdit := true;
            CurrentEmployeeNo := HREmp."No.";
            Rec.SetRange("Employee No", CurrentEmployeeNo);
        end else begin
            EmployeeCanEdit := false;
            Error('Your Employee record is not linked to your User ID. Please contact HR Administrator.');
        end;
    end;

    var
        EmployeeCanEdit: Boolean;
        CurrentEmployeeNo: Code[20];
}
