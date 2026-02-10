page 52185622 "prJournal Mapping"
{
    PageType = Card;
    SourceTable = "prJournal Trans Mapping";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("GL Navision"; Rec."GL Navision")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("GL Others"; Rec."GL Others")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Append StaffCode"; Rec."Append StaffCode")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount (Dr/Cr)"; Rec."Amount (Dr/Cr)")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Analysis)
            {
                field(Analysis0; Rec.Analysis0)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Analysis1; Rec.Analysis1)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Analysis2; Rec.Analysis2)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Analysis3; Rec.Analysis3)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Analysis4; Rec.Analysis4)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Analysis5; Rec.Analysis5)
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

