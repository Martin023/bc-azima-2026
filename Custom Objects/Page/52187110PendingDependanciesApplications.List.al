page 52187111 "Pending Dependancies Apps"
{
    CardPageID = "Dependancies Applications Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Dependancies Applications";
    SourceTableView = WHERE(Status = FILTER(<> Open), Created = const(false));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    Caption = 'Approved Dependancies Application';

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
                field("CRM No"; Rec."CRM No")
                {
                    Editable = false;
                }
                field("M-Smart No"; Rec."M-Smart No")
                {
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control11; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control12; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control13; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }
}

