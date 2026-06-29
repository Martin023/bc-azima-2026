page 52186396 "Checkoff Advice Lines"
{
    Caption = 'Checkoff Advice Lines';
    SourceTable = "Checkoff Advice Line";
    PageType = ListPart;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                // field("Entry No"; Rec."Entry No")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field(Type; Rec.Type)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Advice Header No."; Rec."Advice Header No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Work Station"; Rec."Work Station")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount On"; Rec."Amount On")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Amount Off"; Rec."Amount Off")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Balance On"; Rec."Balance On")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Balance Off"; Rec."Balance Off")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Advice Date"; Rec."Advice Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(Interest; Rec.Interest)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("DOD Options"; Rec."DOD Options")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Advice Type"; Rec."Advice Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(Manual; Rec.Manual)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Employer Account No."; Rec."Employer Account No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Modified By"; Rec."Modified By")
                // {
                //     Editable = false;
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Captured  By"; Rec."Captured  By")
                // {
                //     Editable = false;
                //     ApplicationArea = Basic, Suite;
                // }
                field(Reference; Rec.Reference)
                {
                    ToolTip = 'Specifies the value of the Reference field.';
                }

                field("Variation Action"; Rec."Variation Action")
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }

            }
        }
    }
}
