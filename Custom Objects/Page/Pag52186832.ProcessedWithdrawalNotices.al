page 52186832 "Processed WithDrawal Notices"
{
    CardPageID = "Member withdrawal Notice";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Member withdrawal Notice";
    SourceTableView = WHERE(Status = CONST(Approved), "Notice Finalized" = const(true));
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
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reason for withdrawal"; Rec."Reason for withdrawal")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withdrawal Notice Date"; Rec."Withdrawal Notice Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Modified"; Rec."Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Notice Finalized"; Rec."Notice Finalized")
                {
                    ToolTip = 'Specifies the value of the Notice Finalized field.';
                }
                field("Finalized By"; Rec."Finalized By")
                {
                    ToolTip = 'Specifies the value of the Finalized By field.';
                }
                field("DateTime Finalized"; Rec."DateTime Finalized")
                {
                    ToolTip = 'Specifies the value of the DateTime Finalized field.';
                }
                field("Actioning Department"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Actioning Department';
                }
            }
        }
    }

    actions
    {
    }
}


