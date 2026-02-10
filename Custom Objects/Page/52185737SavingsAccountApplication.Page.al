page 52185737 "Savings Account Application"
{
    CardPageID = "Savings Acc. Application Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Savings Account Application";
    SourceTableView = WHERE(Status = FILTER(Open | Pending | Approved));
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
                // field("CRM Application No."; Rec."CRM Application No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Savings Account No."; Rec."Savings Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Group Code"; Rec."Group Code")
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Source := Rec.Source::Navision;
    end;
}

