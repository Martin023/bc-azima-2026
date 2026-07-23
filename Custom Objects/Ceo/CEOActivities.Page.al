page 52185657 "CEO Activities"
{
    PageType = CardPart;
    SourceTable = "CEO Cue";
    Caption = 'Activities';

    layout
    {
        area(content)
        {
            cuegroup("Employees")
            {
                Caption = 'Employees';

                field("Active Employees"; Rec."Active Employees")
                {
                    ApplicationArea = Basic;
                    Caption = 'Active Employees';
                    DrillDownPageId = "HR Employee List - Active";
                    ToolTip = 'Total active employees';
                }
            }
            cuegroup("Performance")
            {
                Caption = 'Performance';

                field("Open Appraisals"; Rec."Open Appraisals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Open Appraisals';
                    DrillDownPageId = "HR Individual Appraisals List";
                    ToolTip = 'Appraisals currently open';
                    trigger OnDrillDown()
                    var
                        Appraisal: Record "HR Individual Targets Header";
                    begin
                        Appraisal.SetRange(Status, Appraisal.Status::Open);
                        PAGE.Run(PAGE::"HR Individual Appraisals List", Appraisal);
                    end;
                }
                field("Pending Approval Appraisals"; Rec."Pending Approval Appraisals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Appraisals Pending Approval';
                    DrillDownPageId = "HR Individual Appraisals List";
                    ToolTip = 'Appraisals submitted and awaiting supervisor approval';
                    trigger OnDrillDown()
                    var
                        Appraisal: Record "HR Individual Targets Header";
                    begin
                        Appraisal.SetRange(Status, Appraisal.Status::"Pending Approval");
                        PAGE.Run(PAGE::"HR Individual Appraisals List", Appraisal);
                    end;
                }
                field("Approved Appraisals"; Rec."Approved Appraisals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Appraisals';
                    DrillDownPageId = "HR Individual Appraisals List";
                    ToolTip = 'Appraisals approved by supervisors';
                    trigger OnDrillDown()
                    var
                        Appraisal: Record "HR Individual Targets Header";
                    begin
                        Appraisal.SetRange(Status, Appraisal.Status::Approved);
                        PAGE.Run(PAGE::"HR Individual Appraisals List", Appraisal);
                    end;
                }
                field("Open Dept Targets"; Rec."Open Dept Targets")
                {
                    ApplicationArea = Basic;
                    Caption = 'Open Dept. Targets';
                    DrillDownPageId = "HR Department Targets List";
                    ToolTip = 'Department targets still open';
                    trigger OnDrillDown()
                    var
                        DeptTarget: Record "HR Department Targets Header";
                    begin
                        DeptTarget.SetRange(Status, DeptTarget.Status::Open);
                        PAGE.Run(PAGE::"HR Department Targets List", DeptTarget);
                    end;
                }
                field("Approved Dept Targets"; Rec."Approved Dept Targets")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Dept. Targets';
                    DrillDownPageId = "HR Department Targets List";
                    ToolTip = 'Department targets approved by HODs';
                    trigger OnDrillDown()
                    var
                        DeptTarget: Record "HR Department Targets Header";
                    begin
                        DeptTarget.SetRange(Status, DeptTarget.Status::Approved);
                        PAGE.Run(PAGE::"HR Department Targets List", DeptTarget);
                    end;
                }
            }
            cuegroup("HR")
            {
                Caption = 'HR';

                field("Pending Leave Applications"; Rec."Pending Leave Applications")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pending Leave';
                    DrillDownPageId = "HR Leave Applications List1";
                    ToolTip = 'Leave applications pending approval';
                    trigger OnDrillDown()
                    var
                        LeaveApp: Record "HR Leave Application";
                    begin
                        LeaveApp.SetRange(Status, LeaveApp.Status::"Pending Approval");
                        PAGE.Run(PAGE::"HR Leave Applications List1", LeaveApp);
                    end;
                }
                field("Pending Approvals"; Rec."Pending Approvals")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pending Approvals';
                    DrillDownPageId = "Requests to Approve";
                    ToolTip = 'All open approval requests';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = Basic;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Personalise cue thresholds for this role center';
                trigger OnAction()
                var
                    CuesAndKpis: Codeunit "Cues And KPIs";
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
