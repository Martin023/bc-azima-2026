page 52185658 "Temporary Staff List"
{
    Caption = 'Terminal Staff List';
    PageType = List;
    SourceTable = "HR Employees";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(DateOfBirth; Rec.DateOfBirth)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Location"; Rec."Contract Location")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("PIN No."; Rec."PIN No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

