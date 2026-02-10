page 52186421 "Loan Purpose"
{
    PageType = List;
    SourceTable = "Loan Purpose";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Available On Mobile"; Rec."Available On Mobile") { }
                field("Main Sector"; Rec."Main Sector") { }
                field("Main Sector Description"; Rec."Main Sector Description") { }
                field("Sub Sector Level1"; Rec."Sub Sector Level1") { }
                field("Sub Sector Level1 Description"; Rec."Sub Sector Level1 Description") { }
                field("Sub Sector Level2"; Rec."Sub Sector Level2") { }
                field("Sub Sector Level2 Description"; Rec."Sub Sector Level2 Description") { }
                field("Staff Salary Multiplier"; Rec."Staff Salary Multiplier")
                {
                    Caption = 'Staff Salary Multiplier.';
                    ToolTip = 'Specifies a factor that basic salary will be subjected to in loan qualification.';
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

