page 52187042 "Refund $ Account Trans List BL"
{
    CardPageID = "Bulk Refunds Card BL";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    //ApplicationArea = All;
    Caption = 'Business Account Transfer List ';

    SourceTable = "Refund,Account Transfer Header";
    SourceTableView = WHERE("Originating Unit" = const("Business Loans"));
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
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
            }
        }
    }
}
