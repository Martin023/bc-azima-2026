#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185446 pageextension52185446 extends "Item List"
{
    Caption = 'Item List';
    layout
    {
        addafter(InventoryField)
        {
            Field("Physical Count"; Rec."Physical Count")
            {

            }
            field(Variance; Rec.Variance)
            {

            }
        }

    }
    trigger OnAfterGetCurrRecord()
    begin
        Item.reset();
        Item.SetRange("No.", rec."No.");
        if item.findfirst() then begin
            if rec."Physical Count" = 0 then
                rec.Variance := 0 else
                rec.Variance := rec.Inventory - rec."Physical Count";
            rec."Physical Count Date" := Today;
        end;
    end;

    var
        Item: record Item;
}

