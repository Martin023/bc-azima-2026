page 52185669 "prNHIF SetUp"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = prNHIF;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Tier Code"; Rec."Tier Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
                group(NHIF)
                {
                field(banded;Rec.banded)
                {
                    
                }
                Field("NHIF Employee";Rec."NHIF Employee")
                {

                }
                field("NHIF Based on";Rec."NHIF Based on")
                {

                }
                field("Max Allowable Limit";Rec."Max Allowable Limit")
                {

                }
                field("Amount on Max Allowable Limit";Rec."Amount on Max Allowable Limit")
                {
                    Caption='Maximum Amount';
                }
                }
            }
        }
    

    actions
    {
    }

    trigger OnOpenPage()
    begin
        // OnViewCurrRec();
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
        ChangePermission.SetRange("Function Extended", ChangePermission."Function Extended"::"Edit HR Setups");
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;
}

