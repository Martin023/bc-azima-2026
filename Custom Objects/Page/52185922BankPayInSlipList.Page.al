page 52185922 "Bank Pay In Slip List"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Bank Slip";

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                ShowCaption = false;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Source Dimension 1 Name"; Rec."Source Dimension 1 Name")
                {
                    Caption = 'Source Depot';
                    ApplicationArea = Basic, Suite;
                }
                field("Source Dimension 2 Name"; Rec."Source Dimension 2 Name")
                {
                    Caption = 'Source Department';
                    ApplicationArea = Basic, Suite;
                }
                field("From Account Name"; Rec."From Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Dimension 1 Name"; Rec."Destination Dimension 1 Name")
                {
                    Caption = 'Destination Depot Name';
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Dimension 2 Name"; Rec."Destination Dimension 2 Name")
                {
                    Caption = 'Destination Department Name';
                    ApplicationArea = Basic, Suite;
                }
                field("To Account Name"; Rec."To Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

