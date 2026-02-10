page 52185813 "Cheque Book Application List"
{
    CardPageID = "Cheque Application";
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    ApplicationArea = Basic, Suite;
    usagecategory = Lists;
    SourceTable = "Cheque Book Application";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Cheque Account No."; Rec."Cheque Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Application Exported"; Rec."Application Exported")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Export Applications")
            {
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                begin
                    ChqAppl.Reset;
                    ChqAppl.SetRange(ChqAppl."Application Exported", false);
                    ChqAppl.SetRange(Select, true);
                    XMLPORT.Run(52185623, true, false, ChqAppl);

                end;
            }
        }
    }

    var
        ChqAppl: Record "Cheque Book Application";
}

