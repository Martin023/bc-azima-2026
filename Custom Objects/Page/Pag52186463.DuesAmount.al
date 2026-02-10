namespace ALProject.ALProject;

page 52186463 "Dues Amount"
{
    Caption = 'Dues Amount';
    PageType = List;
    SourceTable = "Final Dues";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cost Item"; Rec."Cost Item")
                {
                    ApplicationArea = Basic;
                }
                field("Cost Item Description"; Rec."Cost Item Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}
