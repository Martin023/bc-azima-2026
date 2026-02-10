page 52186433 "BBF Requisation Lines"
{
    DeleteAllowed = true;
    Editable = false;
    PageType = ListPart;
    SourceTable = "BBF Requisation Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Pay To Name"; Rec."Pay To Name")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Pay To ID"; Rec."Pay To ID")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Pay To Relationship"; Rec."Pay To Relationship")
                {
                    Editable = false;
                    ShowMandatory = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Next of Kin"; Rec."Next of Kin")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("BBF Entitlement Code"; Rec."BBF Entitlement Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("BBF Entitlement"; Rec."BBF Entitlement")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sacco Income Recovable"; Rec."Sacco Income Recovable")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Beneficiary; Rec.Beneficiary)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("%Allocation"; Rec."%Allocation")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Deceased; Rec.Deceased)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
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

