namespace KenpipeCBS.KenpipeCBS;

page 52186226 "Broker Account list"
{
    ApplicationArea = All;
    Caption = 'Broker Account list';
    PageType = List;
    SourceTable = "Broker Account list";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("Broker Name"; Rec."Broker Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Broker Name field.', Comment = '%';
                }
            }
        }
    }
}
