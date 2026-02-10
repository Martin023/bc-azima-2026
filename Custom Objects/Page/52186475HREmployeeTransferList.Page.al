page 52186475 "HR Employee Transfer List1"
{
    CardPageID = "HR Employee Transfer Card";
    Editable = false;
    PageType = List;
    SourceTable = "HR Employee Transfer Header";
    SourceTableView = WHERE("Transfer details Updated" = CONST(false));    
    ApplicationArea = Basic;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No"; Rec."Request No")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested"; Rec."Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Transfer details Updated"; Rec."Transfer details Updated")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

