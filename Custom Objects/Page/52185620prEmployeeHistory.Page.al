page 52185620 "prEmployee History"
{
    PageType = List;
    SourceTable = "PR Employee P9 Info";
    ApplicationArea = Basic, Suite;


    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Gross Pay"; Rec."Gross Pay")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Net Pay"; Rec."Net Pay")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Allowances; Rec.Allowances)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Deductions; Rec.Deductions)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(PAYE; Rec.PAYE)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(NSSF; Rec.NSSF)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(NHIF; Rec.NHIF)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

