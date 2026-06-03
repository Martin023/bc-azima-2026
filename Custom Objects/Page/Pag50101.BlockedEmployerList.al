namespace BCAZIMA.BCAZIMA;

page 50101 "Blocked Employers List"
{
    ApplicationArea = All;
    Caption = 'Blocked Employer List';
    PageType = List;
    SourceTable = "Blocked Employers";

    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Employer Code"; Rec."Employer Code")
                {
                    ToolTip = 'Specifies the value of the Employer Code field.', Comment = '%';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ToolTip = 'Specifies the value of the Employer Name field.', Comment = '%';
                }
            }
        }
    }
}
