page 52185886 "BBF Claims Lines"
{
    PageType = ListPart;
    SourceTable = "BBF Claim Lines";
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Code"; Rec."Product Code")
                {
                    Editable = false;
                }
                field("Product Class Type"; Rec."Product Class Type")
                {
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    Editable = false;
                }
                field("Product Name"; Rec."Product Name")
                {
                    Editable = false;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    Editable = false;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    Editable = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    Editable = false;
                }
                field("Total Balance"; Rec."Total Balance")
                {
                    Editable = false;
                }

                field("Amount Allocated"; Rec."Amount Allocated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Allocated field.';
                }

            }
        }
    }

    actions
    {
    }
}

