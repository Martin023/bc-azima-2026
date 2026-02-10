namespace KenpipeBC.KenpipeBC;

report 52186225 "Update Member Closure Date"
{
    ApplicationArea = All;
    Caption = 'Update Member Closure Date';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(MembershipClosure; "Membership Closure")
        {
            RequestFilterFields = Posted, "Member No.", "Employer Code";
            column(MemberNo; "Member No.") { }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                Members: Record Members;
            begin
                if MembershipClosure."Closing Date" <> 0D then begin
                    if Members.Get("Member No.") then begin
                        if UpdateDate = true then begin
                            Members."Closure Date" := MembershipClosure."Closing Date";
                            Members.Modify(TRUE);
                        end;
                        if UpdateDivBlocking = true then begin
                            Members."Block Div Advance" := True;
                            Members.Modify(true);
                        end;
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                field("Update Date"; UpdateDate)
                {
                    ApplicationArea = All;
                }
                field("Update Dividend Blocking"; UpdateDivBlocking)
                {
                    ApplicationArea = All;
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        UpdateDate: Boolean;
        UpdateDivBlocking: Boolean;
}
