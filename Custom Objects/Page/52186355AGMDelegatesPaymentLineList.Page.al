page 52186355 "AGMDelegates Payment Line List"
{
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "AGM Delegate Payment Line";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate MNO."; Rec."Delegate MNO.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Name"; Rec."Delegate Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tariff Code"; Rec."Tariff Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Payable"; Rec."Amount Payable")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                
               field("Account No";Rec."Account No")
               {
                Caption='Bal Account No';
                Editable=False;
               }
                
                field(Position; Rec.Position)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

