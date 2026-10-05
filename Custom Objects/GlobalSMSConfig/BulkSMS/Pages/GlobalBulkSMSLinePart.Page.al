page 52186094 "Global Bulk SMS Line Part"
{
    PageType = ListPart;
    SourceTable = "Global Bulk SMS Line";
    Caption = 'Recipients';
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
                field("Sent DateTime"; Rec."Sent DateTime")
                {
                    ApplicationArea = All;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = Rec."Error Message" <> '';
                }
                field("Retry Count"; Rec."Retry Count")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewMessage)
            {
                ApplicationArea = All;
                Caption = 'View Message';
                Image = ViewDetails;

                trigger OnAction()
                begin
                    Message('Personalized Message:\%1\\Token Values:\%2',
                           Rec."Personalized Message",
                           Rec."Token Values");
                end;
            }
            action(ResetLine)
            {
                ApplicationArea = All;
                Caption = 'Reset for Retry';
                Image = ResetStatus;

                trigger OnAction()
                begin
                    Rec.ResetForRetry();
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        case Rec.Status of
            Rec.Status::Pending:
                StatusStyle := 'Standard';
            Rec.Status::Sent:
                StatusStyle := 'Favorable';
            Rec.Status::Failed:
                StatusStyle := 'Unfavorable';
            Rec.Status::Skipped:
                StatusStyle := 'Subordinate';
        end;
    end;

    var
        StatusStyle: Text;
}
