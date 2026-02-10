page 52187348 "ADR List"
{
    ApplicationArea = All;
    Caption = 'ADR List';
    PageType = List;
    SourceTable = Legal;
    UsageCategory = Lists;
    CardPageId = "ADR Card";
    //SourceTableView = WHERE(Status = CONST(Approved));
    SourceTableView = WHERE(ADR= CONST(True));
    DeleteAllowed = false;


    
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
                field("Case Type"; Rec."Matter Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of filing the Suit"; Rec."Date of Filing the suit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Case Status"; Rec."Case Status")
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
}
