page 52186246 "Lease line Invoice"
{
    PageType = List;
    SourceTable = "Lease Line Invoices";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Batch No"; Rec."Batch No")
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
                field(Once; Rec.Once)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Once"; Rec."Charge Once")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Exclusive VAT"; Rec."Amount Exclusive VAT")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Property No"; Rec."Property No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tenant No."; Rec."Tenant No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Amount Inclusive VAT"; Rec."Total Amount Inclusive VAT")
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

