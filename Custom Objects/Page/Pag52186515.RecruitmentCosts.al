namespace mns.mns;

page 52186515 "Recruitment Costs"
{
    Caption = 'Recruitment Costs';
    PageType = List;
    SourceTable = "Recruitment Costs";
    ApplicationArea = Basic;
    UsageCategory = Lists;
   
    layout
    {
        area(content)
        {
            repeater(Group)
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

    actions
    {
    }
}


