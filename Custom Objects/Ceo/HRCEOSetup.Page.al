page 52185897 "HR CEO Setup"
{
    Caption = 'CEO Setup';
    PageType = Card;
    SourceTable = "HR CEO Setup";
    InsertAllowed = false;
    DeleteAllowed = false;
    ApplicationArea = Basic;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'CEO Configuration';

                field("CEO Employee No."; Rec."CEO Employee No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    ToolTip = 'The employee record of the CEO. Must have a User ID linked on the employee card.';
                }
                field("CEO Name"; Rec."CEO Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("CEO User ID"; Rec."CEO User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Auto-filled from the employee record. This User ID is used to validate CEO goal creation.';
                }
                field("Set By"; Rec."Set By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Set Date"; Rec."Set Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        // ENSURE SINGLE RECORD EXISTS
        if not Rec.Get('CEO') then begin
            Rec.Init();
            Rec.Insert(true);
        end;
    end;
}
