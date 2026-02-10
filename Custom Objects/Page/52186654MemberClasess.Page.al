page 52186654 "Member Clasess"
{
    PageType = List;
    SourceTable = "Member Classes";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entrance Fee";Rec."Entrance Fee")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Share Capital"; Rec."Share Capital")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max. Installment"; Rec."Max. Installment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default Share Capital"; Rec."Default Share Capital")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default BOSA Deposit";Rec."Default BOSA Deposit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Checkoff; Rec.Checkoff)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Can Take Loan"; Rec."Can Take Loan")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Auto Generate Staff No"; Rec."Auto Generate Staff No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Acronym; Rec.Acronym)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Age";Rec."Minimum Age")
                {
                    
                }
               
            }
        }
        area(factboxes)
        {
            systempart(Control15; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control16; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control17; Links)
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
            CurrPage.Editable := false;
        end;
    end;
}

