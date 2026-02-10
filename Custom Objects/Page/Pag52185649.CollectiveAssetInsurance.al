namespace MNS.MNS;

page 52185649 "Collective Asset Insurance"
{
    Caption = 'Collective Asset Insurance';
    PageType = ListPart;
    SourceTable = "Collective Asset Insurance";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Insurance No."; Rec."Insurance No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance No. field.';
                    Editable = false;
                }
                field("Asset No."; Rec."Asset No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Asset No. field.';
                }
                field("Book Value"; Rec."Book Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Book Value field.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                    Editable = false;
                }
                field("FA Class Code"; Rec."FA Class Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Class Code field.';
                    Editable = false;
                }
                field("FA Location Code"; Rec."FA Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Location Code field.';
                    Editable = false;
                }
                field("FA Subclass Code"; Rec."FA Subclass Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Subclass Code field.';
                    Editable = false;
                }
                field("Insured"; Rec."Insured")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insured field.';
                    Editable = false;
                }
            }
        }
    }
}
