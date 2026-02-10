page 52186077 "Legal List"
{
    CardPageID = "Legal Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = Legal;
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = false;

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
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Name of Case;"; Rec."Name of Case")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Case Category"; Rec."Case Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Matter Code"; Rec."Matter Code")
                {
                    Caption = 'Mater Code';
                    ApplicationArea = Basic, Suite;
                }
                field("Lawyer"; Rec."Lawyer")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of filing the Suit"; Rec."Date of Filing the suit")
                {
                    Caption = 'Date of filing the suit';
                    ApplicationArea = Basic, Suite;
                }
                field("Advisory"; Rec."Advisory")
                {
                    Caption = 'Advisory';
                    ApplicationArea = Basic, Suite;
                }
                field("ADR"; Rec.ADR)
                {
                    
                }
                field("Case Status"; Rec."Case Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Captured On"; Rec."Created at")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
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

