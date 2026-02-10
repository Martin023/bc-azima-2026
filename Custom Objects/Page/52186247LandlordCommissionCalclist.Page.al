page 52186247 "Landlord Commission Calc list"
{
    CardPageID = "Landlord Commission Calc Head";
    Editable = false;
    PageType = List;
    SourceTable = "Landlord Commission Calc";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Landlord No."; Rec."Landlord No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Processed Date"; Rec."Processed Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Processed Time"; Rec."Processed Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Processed By"; Rec."Processed By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Landlord Name"; Rec."Landlord Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Inflows; Rec.Inflows)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Outflows; Rec.Outflows)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Commission Rate"; Rec."Commission Rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Commission Amount"; Rec."Commission Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payable To Landlord"; Rec."Payable To Landlord")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Commssion Flat Amount"; Rec."Commssion Flat Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque date"; Rec."Cheque date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Letting Fee Amount"; Rec."Letting Fee Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reletting Fee Amount"; Rec."Reletting Fee Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Letting Flat Amount"; Rec."Letting Flat Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reletting Flat Amount"; Rec."Reletting Flat Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Letting Rate"; Rec."Letting Rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reletting Rate"; Rec."Reletting Rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Letting Date"; Rec."Last Letting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Next Reletting Date"; Rec."Next Reletting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT on Commission"; Rec."VAT on Commission")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Commission Fee"; Rec."Commission Fee")
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

