page 52186403 "Social Listening Sites App."
{
    PageType = List;
    SourceTable = "Social Listening Sites App.";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control6; Notes)
            {
                ApplicationArea = Basic;
            }
            systempart(Control7; MyNotes)
            {
                ApplicationArea = Basic;
            }
            systempart(Control8; Links)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if MemberApplication.Get(Rec."Account No.") then begin
            if MemberApplication.Status <> MemberApplication.Status::Open then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
        end;
    end;

    var
        MemberApplication: Record "Member Application";
}

