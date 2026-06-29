namespace AzimaBC.AzimaBC;
using AZIMA.AZIMA;

page 52185480 "Commission Setup"
{
    ApplicationArea = All;
    Caption = 'Commission Setup';
    PageType = List;
    SourceTable = "Transaction Types";
    SourceTableView = where(Type = const(commission));
    UsageCategory = Lists;
    CardPageId = "Commission Setup Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Product Name"; Rec."Product Name")
                {
                    ToolTip = 'Specifies the value of the Product Name field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("Commission Type"; Rec."Commission Type")
                {
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ToolTip = 'Specifies the value of the Upper Limit field.', Comment = '%';
                }
            }
        }
    }

    
}
