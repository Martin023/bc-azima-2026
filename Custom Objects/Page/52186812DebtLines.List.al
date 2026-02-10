page 52186812 "Debt Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Debt Lines";

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
                field("Member No."; Rec."Member No.")
                {
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                    Editable = false;
                }
                field("Interest Balance"; Rec."Interest Balance")
                {
                    Editable = false;
                }
                field("Principle Balance"; Rec."Principle Balance")
                {
                    Editable = false;
                }
                field("Days In Arreas"; Rec."Days In Arreas")
                {
                    Editable = false;
                }
                field("SASRA Categorisation"; Rec."SASRA Categorisation")
                {
                    Editable = false;
                }
                field("Installments In Falloff"; Rec."Installments In Falloff")
                {
                    Editable = false;
                }
                field("Total Loan Balance";Rec."Total Loan Balance")
                {
                    Editable = false;
                }
                field("Mark for Reassigning";Rec."Mark for Reassigning")
                {
                    
                }
                field("Reassign to Vendor No.";Rec."Reassign to Vendor No.")
                {

                }
                field("Reassign to Vendor Name";Rec."Reassign to Vendor Name")
                {
                    Editable = false;
                }
                field(Reasigned;Rec.Reasigned)
                {
                    Editable = false;
                }
                field("Reassigned By";Rec."Reassigned By")
                {
                    Editable = false;
                }
                field("Date Reassigned";Rec."Date Reassigned")
                {
                    Editable = false;
                }
                field("Entry Time"; Rec."Entry Time")
                {
                    Editable = false;
                }
                field("Entered By";Rec."Entered By")
                {
                    Editable = false;
                }
                field(Comment;Rec.Comment)
                {
                
                }

            }
        }
    }

    actions
    {
       
    }
}
