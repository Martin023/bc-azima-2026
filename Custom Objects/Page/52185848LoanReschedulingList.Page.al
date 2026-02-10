page 52185848 "Loan Rescheduling List"
{
    CardPageID = "Loan Rescheduling";
    // Editable = false;
    //InsertAllowed = false;
    PageType = List;
    SourceTable = "Loan Rescheduling";
    Caption = 'Loan Reshedulling List';
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
                field("Rescheduling Date"; Rec."Rescheduling Date")
                { ApplicationArea = Basic, Suite; }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = all;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = all;
                }
                field("Rescheduled By"; Rec."Rescheduled By")
                {
                    ApplicationArea = all;
                }
                field("New Amortised"; Rec."New Amortised")
                {
                    ApplicationArea = all;
                }
                field("Original Installments"; Rec."Original Installments")
                {
                    ApplicationArea = all;
                }
                field("New Installments"; Rec."New Installments")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Rescheduled; Rec.Rescheduled)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

