page 52186479 "Imprest Application List S/S."
{
    ApplicationArea = All;
    Caption = 'Imprest Application Self Service.';
    PageType = List;
    SourceTable = "Imprest Header";
    UsageCategory = Lists;
    CardPageID = "Imprest Request Header";

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
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                    editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter(Cashier, UserId);
    end;
}
