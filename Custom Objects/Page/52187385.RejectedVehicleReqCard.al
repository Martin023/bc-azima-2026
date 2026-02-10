page 52187385 "Rejected Vehicle Req - Card"
{
    ApplicationArea = All;
    Caption = 'Rejected Vehicle Req - Card';
    PageType = Card;
    SourceTable = "Motor Vehicle Request";
    DeleteAllowed = False;
    Editable = False;
    InsertAllowed = false;
    ModifyAllowed = false;
    CardPageId = "Deffered Vehicle Req - Card";
        SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = CONST(Rejected)); 
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
            }
        }
    }
}
