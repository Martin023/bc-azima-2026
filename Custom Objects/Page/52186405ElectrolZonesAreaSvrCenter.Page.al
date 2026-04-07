page 52186405 "Electrol Zones/Area Svr Center"
{
    PageType = List;
    SourceTable = "Electrol Zones/Area Svr Center";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field(Type; Rec.Type)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mileage (KMs)"; Rec."Mileage (KMs)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }

            }
        }
        area(factboxes)
        {
            systempart(Control6; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control7; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control8; Links)
            {
                ApplicationArea = Basic, Suite;
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

