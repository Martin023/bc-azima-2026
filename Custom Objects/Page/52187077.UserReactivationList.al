page 52187077 "User Creation Request List"
{
    ApplicationArea = All;
    Caption = 'User Access Requests';
    PageType = List;
    SourceTable = "User Creation Requests";
    UsageCategory = Lists;

    //CardPageId = "User Creation Request Card";

    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Request ID"; Rec."Request ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }

                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                }

                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                }

                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }

                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }

                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }

                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }

                field("Contact Email"; Rec."Contact Email")
                {
                    ApplicationArea = All;
                }

                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = All;
                }

                field("Due Date Time"; Rec."Due Date Time")
                {
                    ApplicationArea = All;
                }

                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = All;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyle();
    end;

    local procedure SetStyle()
    begin
        case Rec.Status of

            Rec.Status::Open:
                StatusStyle := 'Standard';

            Rec.Status::Pending:
                StatusStyle := 'Ambiguous';

            Rec.Status::Approved:
                StatusStyle := 'Favorable';

            Rec.Status::Rejected:
                StatusStyle := 'Unfavorable';

            else
                StatusStyle := 'Standard';
        end;
    end;

    var
        StatusStyle: Text;
}