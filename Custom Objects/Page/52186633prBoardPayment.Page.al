page 52186633 "prBoard Payment"
{
    PageType = List;
    SourceTable = "PR Board Transactions";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    CardPageId = "prBoard Employees Card";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("G/L Accounts"; Rec."G/L Accounts")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Deduction"; Rec."Is Deduction")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }
    trigger OnClosePage()
    var
        myInt: Integer;
        PrBoards: Record "Board members";

    begin
        PrBoards.Reset();
        PrBoards.SetRange("No.", Rec."No.");
        if PrBoards.FindFirst() then
            PrBoards.CalcFields(PrBoards."Total earnings");

    end;
}

