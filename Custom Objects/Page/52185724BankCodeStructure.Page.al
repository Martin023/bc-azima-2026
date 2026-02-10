page 52185724 "Bank Code Structure"
{
    PageType = List;
    SourceTable = "Bank Code Structure";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code;Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name;Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Parent Code";Rec."Parent Code")
                {
                    
                }
                field(Type;Rec.Type)
                {

                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control9; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control10; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }

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

