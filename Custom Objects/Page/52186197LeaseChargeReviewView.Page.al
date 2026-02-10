page 52186197 "Lease Charge Review View"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Lease Charge Review";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lease No."; Rec."Lease No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge No."; Rec."Charge No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Name"; Rec."Charge Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Effect Date"; Rec."Effect Date")
                {
                    Caption = 'Escalaltion Date';
                    ApplicationArea = Basic, Suite;
                }
                field("Old Amount[Rate]"; Rec."Old Amount[Rate]")
                {
                    Caption = 'Old Rent Rate';
                    ApplicationArea = Basic, Suite;
                }
                // field("Old Amount[Review Amount]"; Rec."Old Amount[Review Amount]")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("New [Rate Amount]"; Rec."New [Rate Amount]")
                {
                    Caption = 'Escalated Rent Rate';
                    ApplicationArea = Basic, Suite;
                }
                // field("New [Review Amount]"; Rec."New [Review Amount]")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
            }
        }
    }

    actions
    {
    }
}

