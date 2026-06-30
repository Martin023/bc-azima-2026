page 52185588 "HR Perspective Setup Card"
{
    PageType = Card;
    SourceTable = "HR Perspectives Setup";
    Caption = 'HR Perspective Setup Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Perspective No"; Rec."Perspective No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the automatically generated perspective number.';
                    Importance = Promoted; 
                }
                field("Perspective type"; Rec."Perspective type")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true; 
                    ToolTip = 'Specifies the category of the balanced scorecard perspective.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true; 
                    ToolTip = 'Specifies a detailed description of the perspective.';
                }
            }
        }
    }
}