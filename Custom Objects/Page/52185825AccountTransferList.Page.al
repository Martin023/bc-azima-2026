page 52185825 "Account Transfer List"
{
    CardPageID = "Account Transfer";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Account Transfer Header";
    SourceTableView = SORTING(No)
                      ORDER(Descending)
                      WHERE("Account Transfer Type" = CONST(" "),
                            Posted = CONST(false));

    ApplicationArea = Basic, Suite;
    UsageCategory = lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    var
        AccountTransferHeader: Record "Account Transfer Header";
}

