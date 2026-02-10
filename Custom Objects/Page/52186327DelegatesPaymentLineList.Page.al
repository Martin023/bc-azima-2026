page 52186327 "Delegates Payment Line List"
{
    PageType = ListPart;
    SourceTable = "Delegate Payment Line";
    Editable = true;
    InsertAllowed = true;
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field("Code"; Rec.Code)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }

                field("Delegate MNO."; Rec."Delegate MNO.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Delegate Name"; Rec."Delegate Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Electoral Zone"; Rec."Electoral Zone")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Electoral Zone Name"; Rec."Electoral Zone Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("No. of Meetings"; Rec."No. of Meetings")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Allowance Code";Rec."Allowance Code")
                {
                    
                }
                field("Allowances G/L";Rec."Allowances G/L")
                {
                    Editable = false;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }

                field("Withholding Tax"; Rec."Withholding Tax")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Withholding G\L Acc";Rec."Withholding G\L Acc")
                {
                    Editable =false;
                }

                // field("Processing Fee"; Rec."Processing Fee")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = true;
                // }

                // field("Excise Duty"; Rec."Excise Duty")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = true;
                // }

                field("Amount Payable"; Rec."Amount Payable")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }


    actions
    {

    }
}

