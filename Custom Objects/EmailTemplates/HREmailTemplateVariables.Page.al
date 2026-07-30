page 52185937 "HR Email Template Variables"
{
    Caption = 'Placeholder Variables';
    PageType = ListPart;
    SourceTable = "HR Email Template Variables";
    ApplicationArea = Basic;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Variables)
            {
                field(Placeholder; Rec.Placeholder)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'The placeholder token used in the subject and body e.g. %1';
                }
                field("Variable Name"; Rec."Variable Name")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'What this placeholder represents e.g. Employee Name';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Detailed description of the value that will be substituted';
                }
            }
        }
    }
}
