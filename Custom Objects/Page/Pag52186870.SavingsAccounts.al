
page 52186870 "Savings Accounts"
{
    ApplicationArea = All;
    Caption = 'Savings Account Register';
    PageType = List;
    SourceTable = "Savings Accounts";
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    CardPageID = "Savings Account Card";
    //Savings 
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("member No"; Rec."Member No.")
                {

                }
                field(Name; Rec.Name)
                {

                }
                field("Employer Code"; Rec."Employer Code")
                {

                }

                field("Product Type"; Rec."Product Type")
                {

                }
                field("Product Name"; Rec."Product Name")
                {

                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                // field("Date of Birth"; Rec."Date of Birth") { }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Product Type field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Product Category field.';
                }
                field("Last Transaction Date"; Rec."Last Transaction Date") { }

                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ToolTip = 'Specifies the value of the Balance (LCY) field.';
                }
                field("Lien Placed"; Rec."Lien Placed")
                {
                    ToolTip = 'Specifies the value of the Product Name field.';
                }
                // field(Prorata; Rec.Prorata)
                // {

                // }
                field("Monthly Contribution"; Rec."Monthly Contribution") { }
                field(Status; Rec.Status) { Caption = 'Account Status'; }
                field("Member Status"; Rec."Member Status") { }
                field("Member Sub Status"; Rec."Member Sub Status") { }
                field("Source Unit"; rec."Source Unit") { }
            
            }
        }
    }
}
