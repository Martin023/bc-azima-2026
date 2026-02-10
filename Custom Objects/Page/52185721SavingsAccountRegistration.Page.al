page 52185721 "Savings Account Registration"
{
    PageType = List;
    SourceTable = "Savings Account Registration";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control7; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control8; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control9; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        PageControl;
    end;

    trigger OnOpenPage()
    begin
        PageControl;
    end;

    //[Scope('OnPrem')]
    procedure PageControl()
    var
        MemberAppl: Record "Member Application";
    begin
        if MemberAppl.Get(Rec."No.") then begin
            case MemberAppl.Status of
                MemberAppl.Status::Pending, MemberAppl.Status::Approved, MemberAppl.Status::Rejected:
                    begin
                        CurrPage.Editable := false;
                    end;

                MemberAppl.Status::Open:
                    begin
                        CurrPage.Editable := true;
                    end;
            end;
        end;
    end;
}

