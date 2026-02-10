page 52186813 "Debt Lines Logs"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Debt Lines Logs";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan No.";Rec."Loan No.")
                {
                    // Editable = false;
                }
                field("Amount Collected";Rec."Amount Collected")
                {
                    
                }
                field("Document No.";Rec."Document No.")
                {
                    
                }
                field("Commision Percentgae";Rec."Commision Percentgae")
                {
                    
                }
                field("Commision Amount";Rec."Commision Amount")
                {
                    Editable = false;
                }
                field("Entry Time";Rec."Entry Time")
                {
                    Editable = false;
                }
                field("Entered By";Rec."Entered By")
                {
                    Editable = false;
                }

            }
        }
    }

    actions
    {
       
    }
}
