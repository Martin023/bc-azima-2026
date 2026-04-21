namespace AzimaCBS.AzimaCBS;

page 52186490 "Sales Teams"
{
    ApplicationArea = All;
    Caption = 'Sales Teams';
    PageType = Card;
    SourceTable = "Marketing Teams Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("No. of Members"; Rec."No. of Members")
                {
                    ToolTip = 'Specifies the value of the No. of Members field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
            }

            part(SalesLines; "Marketing Teams Lines")
            {
                // Editable = statuseditable;
                SubPageLink = No = FIELD(No);
            }
        }
    }
}
