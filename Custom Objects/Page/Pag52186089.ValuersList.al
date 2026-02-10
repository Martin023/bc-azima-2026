namespace MNS.MNS;

page 52186089 "Security Valuers List"
{
    Caption = 'Valuers List';
    PageType = List;
    SourceTable = "Security Valuers";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            Repeater(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Security No."; Rec."Security No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Valuer Name"; Rec."Valuer Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Valuer Address"; Rec."Valuer Address")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Valuer Contact"; Rec."Valuer Contact")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}
