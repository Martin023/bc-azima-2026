page 52186425 "Promise Topay Lines"
{
    PageType = List;
    SourceTable = "Promise Topay Lines";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = PageEditable;
                field("Member No."; Rec."Member No.")
                {
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field("Loan No."; Rec."Loan No.")
                {

                }
                field("Loan Account No."; Rec."Loan Account No.")
                {
                    Editable = false;
                }
                field("Amount to Pay";Rec."Amount to Pay")
                {

                }
                
                field("Topay Date"; Rec."Topay Date")
                {

                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    Editable = false;
                }
                field("Entered At"; Rec."Entered At")
                {
                    Editable = false;
                }

                field(Comment; Rec.Comment)
                {

                }
                field("Amount Paid";Rec."Amount Paid")
                {
                    Editable = false;
                }
                field("Last Date Paid";Rec."Last Date Paid")
                {

                }
                field("Close Promise"; Rec."Close Promise")
                {

                }
            }
        }
    }
    var
    PageEditable: Boolean;

    trigger OnOpenPage()
    begin
        PageControl();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        PageControl();
    end;

    trigger OnAfterGetRecord()
    begin
        PageControl();
    end;

    procedure PageControl()
    begin
        PageEditable := true;
        if Rec."Close Promise" then
        PageEditable := false;
    end;
}

