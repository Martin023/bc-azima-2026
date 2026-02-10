page 52185648 "PR Transaction Codes List"
{
    CardPageID = "PR Transaction Code Card";
    PageType = List;
    SourceTable = "PR Transaction Codes";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    DeleteAllowed = False;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Enabled = true;
                ShowCaption = false;
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = true;
                }
                field("Balance Type"; Rec."Balance Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Enabled = true;
                }
                field(Allowable; Rec.Allowable)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    Enabled = true;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    Enabled = true;
                }
                field("Special Transactions"; Rec."Special Transactions")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //OnViewCurrRec();
    end;

    var
        PRTransCodes: Record prInsurancePolicies;
        PREmpTrans: Record "prSalary Arrears";
        String: Text;
        PREmpTrans_2: Record "prSalary Arrears";
        HREmp: Record "HR Succession Job Rotation";
        HRJobs: Record "HR Jobs";

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

