page 52186063 "Application Doc. Setup Card"
{
    PageType = Card;
    SourceTable = "Application Document Setup";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Retiree Document"; Rec."Retiree Document")
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

    trigger OnAfterGetCurrRecord()
    begin
        SOControl;
    end;

    var
        SinglePartyMultiple: Boolean;

    //[Scope('OnPrem')]
    procedure SOControl()
    begin
        case rec."Document Type" of
            rec."Document Type"::Member, rec."Document Type"::Account:
                begin
                    SinglePartyMultiple := true;
                end;

            rec."Document Type"::" ", rec."Document Type"::Loan:
                begin
                    SinglePartyMultiple := false;
                end;
        end;
    end;
}

