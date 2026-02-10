page 52186271 "Users Sessions"
{
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Active Session";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Server Instance Name"; Rec."Server Instance Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Server Computer Name"; Rec."Server Computer Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Login Datetime"; Rec."Login Datetime")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Database Name"; Rec."Database Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Client Computer Name"; Rec."Client Computer Name")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        OnAccesRestrictView();
    end;

    trigger OnOpenPage()
    begin
        OnAccesRestrictView();
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

