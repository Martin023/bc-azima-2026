page 52185549 "Nominee Request Form List"
{
    ApplicationArea = All;
    Caption = 'Nominee Request Form';
    PageType = List;
    SourceTable = "Nominee Form Request";
    UsageCategory = Lists;
    CardPageId = "Nominee Form Request Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.';
                }
                field("ID Card No."; Rec."Id Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID Card No. field.';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Dispatched; Rec."Dispatched")
                {
                    ApplicationArea = All;
                }
                field("Created at"; Rec."Created On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created at field.';
                }
                field("Created by"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created by field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            Rec.SetFilter("Current Department", UserSetup."Responsibility Centre");
        end else
            Error('You must be set up in user setup');
    end;
}
