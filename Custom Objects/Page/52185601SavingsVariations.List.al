page 52185601 "Savings Variations List"
{
    CardPageId = "Savings Variations";
    ApplicationArea = All;
    Caption = 'Savings Variations List';
    // DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Product Variations";
    SourceTableView = WHERE("Variation Type" = filter(Savings));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {

                }

                field("Application Date"; Rec."Application Date") { }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field(Digit; Rec.Digit)
                {
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                }


                field("Employer Code"; Rec."Employer Code") { }
                field("Employer Name"; Rec."Employer Name") { }
                field("Product Name"; Rec."Product Name")
                {
                    ToolTip = 'Specifies the value of the Product Name field.';
                }

                field("Amount On"; Rec."Amount On")
                {
                    Caption = 'New Amount';
                    ToolTip = 'Specifies the value of the Amount On field.';
                }
                field("Amount Off"; Rec."Amount Off")

                {
                    Caption = 'Old Amount';
                    ToolTip = 'Specifies the value of the Amount Off field.';
                }
                field(Balance; Rec.Balance) { }
                field("Responsible Officer"; Rec."Responsible Officer")
                {

                }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field("Product Type"; Rec."Product Type")
                {
                    ToolTip = 'Specifies the value of the Product Type field.';
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {

                }


            }
        }
    }
}
