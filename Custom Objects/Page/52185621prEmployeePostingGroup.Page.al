page 52185621 "prEmployee Posting Group"
{
    PageType = List;
    SourceTable = "prEmployee Posting Group";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salary Account"; Rec."Salary Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Income Tax Account"; Rec."Income Tax Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("SSF Employer Account"; Rec."SSF Employer Account")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SSF Employer Expense Account';
                }
                field("SSF Employee Account"; Rec."SSF Employee Account")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SSF Total Payable Account';
                }
                field("Housing Levy Employer"; Rec."Housing Levy Employer")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SSF Total Expense Account';
                }
                field("Housing Levy Employee"; Rec."Housing Levy Employee")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HLEVY Total Payable Account';
                }
                field("Net Salary Payable"; Rec."Net Salary Payable")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pension Employer Acc"; Rec."Pension Employer Acc")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'PF Employer Expense Account';
                }
                field("Pension Employee Acc"; Rec."Pension Employee Acc")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'PF Total Payable Account';
                }
                field("Tax Code"; Rec."Tax Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payslip Report"; Rec."Payslip Report")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employment Tax Debit"; Rec."Employment Tax Debit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employment Tax Credit"; Rec."Employment Tax Credit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("NHIF Employee Account"; Rec."NHIF Employee Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("SHIF Account";Rec."SHIF Account")
                {
                    
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //OnViewCurrRec
    end;

    //[Scope('OnPrem')]
    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: Label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("View Payroll", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."Function Extended"::"View Payroll");
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;
}

