page 52185740 "Fixed Deposit Type"
{
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    SourceTable = "Fixed Deposit Type";


    layout
    {
        area(content)
        {
            field("Code"; Rec.Code)
            {
                ApplicationArea = Basic, Suite;
            }
            field(Description; Rec.Description)
            {
                ApplicationArea = Basic, Suite;
            }
            field(Duration; Rec.Duration)
            {
                ApplicationArea = Basic, Suite;
            }
            field("Allowed Minimum Amount"; Rec."Allowed Minimum Amount")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Call Deposit"; Rec."Call Deposit")
            {
                ApplicationArea = Basic, Suite;
            }
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control1102755004; "FD Interest Calculation")
            {
                SubPageLink = Code = FIELD(Code);
            }
        }
    }

    actions
    {

    }
}

