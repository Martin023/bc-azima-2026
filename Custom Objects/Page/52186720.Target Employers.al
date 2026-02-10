page 52186724 "Target Employers"
{
    ApplicationArea = All;
    Caption = 'Target Employerss';
    PageType = List;
    SourceTable = "Target Employers";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employer Code"; Rec."Employer Code")
                {
                    ToolTip = 'Specifies the value of the Employer Code field.';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ToolTip = 'Specifies the value of the Employer Name.';
                }
            }
        }
    }
}
