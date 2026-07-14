page 52185505 "HRHOD Department Targets"
{
    Caption = 'HOD Department Targets';
    PageType = List;
    SourceTable = "HR Department Targets Header";
    CardPageID = "HR Department Targets Card";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Target No"; Rec."Target No")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                }
                field("HOD Employee No"; Rec."HOD Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        DeptFilter: Text;
    begin
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            HRHOD.Reset;
            HRHOD.SetRange(HRHOD."Employee No.", HREmp."No.");
            if HRHOD.Find('-') then begin
                DeptFilter := '';
                repeat
                    if DeptFilter = '' then
                        DeptFilter := HRHOD."Responsibility center"
                    else
                        DeptFilter := DeptFilter + '|' + HRHOD."Responsibility center";
                until HRHOD.Next = 0;
                
                Rec.SetFilter("Responsibility Center", DeptFilter);
            end else begin
                Error('You are not assigned as a Head of Department. Please contact HR Administrator.');
            end;
        end else begin
            Error('Your Employee record is not linked to your User ID. Please contact HR Administrator.');
        end;
    end;

    var
        HREmp: Record "HR Employees";
        HRHOD: Record "HR Heads of Departments";
}