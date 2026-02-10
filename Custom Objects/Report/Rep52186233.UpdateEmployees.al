namespace MNS.MNS;

report 52186233 "Update Employee Members"
{
    ApplicationArea = All;
    Caption = 'Sync Employees & Board with Members';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where("Account Category" = const("Staff Member"));
            column(No; "No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                HrEmployee.Reset();
                HrEmployee.SetRange("Member No.", "No.");
                HrEmployee.SetRange(Status, HrEmployee.Status::Active);
                if not HrEmployee.FindFirst() then begin
                    Members."Account Category" := Members."Account Category"::Member;
                    members.Modify();
                end;
            end;
        }
        dataitem(Hr_Employees; "HR Employees")
        {
            DataItemTableView = where(Status = const("Active"));
 
                   trigger OnAfterGetRecord()
            begin
                MembersII.Reset();
                MembersII.SetRange("No.", Hr_Employees."Member No.");
                //MembersII.SetRange(Status, MembersII.Status::Active);
                MembersII.setfilter("Account Category", '<>%1', MembersII."Account Category"::"Staff Member");
                if MembersII.FindFirst() then begin
                    MembersII."Account Category" := MembersII."Account Category"::"Staff Member";
                    MembersII.Modify();
                end;
            end;
        }
        dataitem("Board members"; "Board members")
        {
            //DataItemTableView = where(Status = const("Active"));
            trigger OnAfterGetRecord()
            begin
                MembersIII.Reset();
                MembersIII.SetRange("No.", Hr_Employees."Member No.");
                //MembersII.SetRange(Status, MembersII.Status::Active);
                MembersIII.setfilter("Account Category", '<>%1', MembersIII."Account Category"::"Staff Member");
                if MembersIII.FindFirst() then begin
                    MembersIII."Account Category" := MembersIII."Account Category"::"Staff Member";
                    MembersIII.Modify();
                end;
            end;
        }



    }
    trigger OnPreReport()
    begin
        OnViewCurrRec();
    end;

    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: Label 'You do not have Permissions to run this process. Contact system administrator for assistance.';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("View Payroll", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."Function Extended"::"View Payroll");
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;

    var
        HrEmployee: Record "HR Employees";
        MembersII: Record Members;
        MembersIII: record Members;

}
