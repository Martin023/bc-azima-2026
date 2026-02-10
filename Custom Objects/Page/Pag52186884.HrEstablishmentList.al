page 52186884 "Hr Establishment List"
{
    ApplicationArea = All;
    Caption = 'Hr Establishment List';
    PageType = List;
    SourceTable = "Hr Jobs";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
                field("Company PIN"; Rec."Company PIN")
                {
                    ToolTip = 'Specifies the value of the Company PIN field.';
                }
                field("Hr Proposal"; Rec."Hr Proposal")
                {
                    ToolTip = 'Specifies the value of the Hr Proposal field.';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.';
                }
                field(Female; Rec.Female)
                {
                    ToolTip = 'Specifies the value of the Female field.';
                }
                field(Male; Rec.Male)
                {
                    ToolTip = 'Specifies the value of the Male field.';
                }
            }
        }
    }
}
