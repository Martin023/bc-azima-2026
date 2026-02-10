page 52187036 "Refund $ Account Trans List"
{
    CardPageID = "Bulk Refunds Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    //ApplicationArea = All;
    Caption = 'Refund And Account Transfer List ';

    SourceTable = "Refund,Account Transfer Header";
    SourceTableView = WHERE("Originating Unit" = const("General"));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.';
                }
                field("Time Entered"; Rec."Time Entered") { Editable = false; }
                field("Refund Type"; Rec."Refund Type") { }
                field("Posting date"; Rec."Posting date") { }
                field(Description; Rec.Description) { }

                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    ToolTip = 'Specifies the value of the Scheduled Amount field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Entered By"; Rec."Entered By")
                { }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
            }
        }
    }
}
