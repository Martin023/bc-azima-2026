page 52186730 "Rejected BLA Application List"
{
    CardPageID = "B/S Loan Acc. Application Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "B/S Loan Account Application";
    SourceTableView = WHERE(Status = filter(Rejected | Deffered | Archived));

    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("CRM Application No."; Rec."CRM Application No.")
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
                field("Phone No.";Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}

