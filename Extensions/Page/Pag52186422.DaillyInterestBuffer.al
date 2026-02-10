page 52187416 "Dailly Interest Buffer"
{
    ApplicationArea = All;
    Caption = 'Dailly Interest Buffer';
    PageType = List;
    SourceTable = "Loans Interest Buffer";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.';
                }
                field("Loan Product type"; Rec."Loan Product type")
                {
                    ToolTip = 'Specifies the value of the Loan Product type field.';
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ToolTip = 'Specifies the value of the Interest Amount field.';
                }
                field("Interest Date"; Rec."Interest Date")
                {
                    ToolTip = 'Specifies the value of the Interest Date field.';
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ToolTip = 'Specifies the value of the Issued Date field.';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    Editable = false;
                }
                field(Status; Rec.Status) { Editable = false; Caption = 'Member Status'; }
                field("Source Unit"; Rec."Source Unit") { }
                field(Posted; Rec.Posted)
                { }
            }
        }
    }
}
