page 52185798 "Cheque Types"
{
    PageType = List;
    SourceTable = "Cheque Types";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Clearing Days"; Rec."Clearing Days")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Clearing  Days"; Rec."Clearing  Days")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Limit"; Rec."Cheque Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Clearing Charge Code"; Rec."Clearing Charge Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Clearing Charges GL Account"; Rec."Clearing Charges GL Account")
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
        //OnAccesRestrictView();
    end;

    //[Scope('OnPrem')]
    procedure OnAccesRestrictView()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do Not have Permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1-%2';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("Edit Setup", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."Function Extended"::Administrator);
        if not ChangePermission.Find('-') then begin
            Error(ErrorOnRestrictViewTxt, UserId, Rec.TableCaption);
        end;
    end;
}

