namespace MNS.MNS;

page 52185578 "Insurance Claims - List"
{
    ApplicationArea = All;
    Caption = 'Fixed Asset Insurance Claims - List';
    PageType = List;
    SourceTable = "Insurance Claims";
    UsageCategory = Lists;
    CardPageId = "Insurance Claims - Card";
    Editable = False;
    DeleteAllowed = False;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Claim No."; Rec."Claim No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Claim No. field.';
                }
                field("Insurance Claim"; Rec."Insurance Claims")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance Claim field.';
                }
                field("Asset No."; Rec."Asset No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Asset No. field.';
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Asset Description field.';
                }
                field("Date of Claim"; Rec."Date of Claim")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of the Claim field.';
                }
                field("Date of Reporting"; Rec."Date of Reporting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Reporting field.';
                }
            }
        }
    }
}
