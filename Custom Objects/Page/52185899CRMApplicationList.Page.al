page 52185899 "CRM Application List"
{
    CardPageID = "CRM Application Card";
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "CRM Application";
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
                field("Application Form No."; Rec."Application Form No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Created; Rec.Created)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Factory"; Rec."Product Factory")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payroll No."; Rec."Payroll No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Certificate No."; Rec."Certificate No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount On"; Rec."Amount On")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Off"; Rec."Amount Off")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Closure Type"; Rec."Closure Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Buyer No."; Rec."Buyer No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Buyer ID No."; Rec."Buyer ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Adviced; Rec.Adviced)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Adviced"; Rec."Date Adviced")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Adviced"; Rec."Time Adviced")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Adviced By"; Rec."Adviced By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Modification Type"; Rec."Modification Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shedule Type"; Rec."Shedule Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("In coming Guarantor No."; Rec."In coming Guarantor No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Replaced Guarantor No."; Rec."Replaced Guarantor No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Temp. Name"; Rec."Temp. Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Case360_Docs; Rec.Case360_Docs)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan status"; Rec."Loan status")
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

