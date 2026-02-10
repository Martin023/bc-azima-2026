page 52187339 "Witheld Tax Obligations On PV"
{
    ApplicationArea = All;
    Caption = 'Witheld Tax Obligations On PV';
    PageType = List;
    SourceTable = "Witheld Tax Obligations On PV";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Payment No."; Rec."Payment No.")
                {
                    ToolTip = 'Specifies the value of the Payment No. field.';
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ToolTip = 'Specifies the value of the Payment Date field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No.';
                }

                field("Invoice Date"; Rec."Invoice Date")
                {
                    ToolTip = 'Specifies the value of the Invoice Date field.';
                }
                field("Vendor KRA PIN"; Rec."Vendor KRA PIN")
                {
                    ToolTip = 'Specifies the value of the Vendor KRA PIN field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ToolTip = 'Specifies the value of the VAT Amount field.';
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ToolTip = 'Specifies the value of the Withholding Tax Amount field.';
                }
                field("VAT withheld Amount"; Rec."VAT withheld Amount")
                {
                    ToolTip = 'Specifies the value of the VAT withheld Amount field.';
                }
            }
        }
    }
}
