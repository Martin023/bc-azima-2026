namespace ALProject.ALProject;

page 52186900 "Stock Keeping Lines"
{
    ApplicationArea = All;
    Caption = 'Stock Keeping Lines';
    PageType = ListPart;
    SourceTable = "stock keeping Lines";
   

    layout
    {
        area(content)
        {
            repeater(Group)
            {



                field("Item No"; Rec."Item No")
                {

                    ToolTip = 'Specifies the value of the Item No field.';
                }
                field("Item Name"; Rec."Item Name")
                {
                    ToolTip = 'Specifies the value of the Item Name field.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ToolTip = 'Specifies the value of the Inventory field.';
                }
                field("Physical Count"; Rec."Physical Count")
                {
                    ToolTip = 'Specifies the value of the Physical Count field.';
                }

                field(Variance; Rec.Variance)
                {
                    ToolTip = 'Specifies the value of the Variance field.';
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.types := rec.types::Stock;
    end;
}
