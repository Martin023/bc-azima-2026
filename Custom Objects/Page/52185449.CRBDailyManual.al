page 52185449 "CRB Daily Manual"
{
    Caption = 'CRB Daily Manual';
    SourceTable = "CRB Daily Manual";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    // Make it a read-only list page
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            // Define the columns to display in the list
            repeater(Group)
            {
                Caption = 'CRB Daily Manual';
                field("Snap Shot Date"; Rec."Snap Shot Date")
                {
                    ApplicationArea = All;
                }
                field("Client Type"; Rec."Client Type")
                {
                    ApplicationArea = All;
                }
                field("Sur Name"; Rec."Sur Name")
                {
                    ApplicationArea = All;
                }
                field("Fore Name 1"; Rec."Fore Name 1")
                {
                    ApplicationArea = All;
                }
                field("Fore Name 2"; Rec."Fore Name 2")
                {
                    ApplicationArea = All;
                }
                field("Fore Name 3"; Rec."Fore Name 3")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field("Primary Identification Type"; Rec."Primary Identification Type")
                {
                    ApplicationArea = All;
                }
                field("Primary Identification"; Rec."Primary Identification")
                {
                    ApplicationArea = All;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                }
                field("Currency Of Facility"; Rec."Currency Of Facility")
                {
                    ApplicationArea = All;
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = All;
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    ApplicationArea = All;
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ApplicationArea = All;
                }
                field("Current Bal"; Rec."Current Bal")
                {
                    ApplicationArea = All;
                }
                field("Installments In Arrears"; Rec."Installments In Arrears")
                {
                    ApplicationArea = All;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    ApplicationArea = All;
                }
                field("Account Status"; Rec."Account Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // Add actions here if needed
    }
}
