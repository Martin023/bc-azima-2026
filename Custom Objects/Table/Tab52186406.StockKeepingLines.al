table 52186406 "Stock Keeping Lines"
{
    Caption = 'Stock Keeping Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Item No"; Code[40])
        {
            Caption = 'Item No';
            TableRelation = item."No.";
            trigger OnValidate()
            begin
                item.reset();
                Item.SetRange("No.", "Item No");
                if item.findfirst() then begin
                    "Item Name" := item.Description;
                    item.CalcFields(Inventory);
                    Inventory := item.Inventory;

                end;
            end;
        }
        field(3; "Item Name"; Text[100])
        {
            Caption = 'Item Name';
            Editable = false;
        }
        field(4; Inventory; Decimal)
        {
            Caption = 'Inventory';
            Editable = false;
        }
        field(5; "Physical Count"; Decimal)
        {
            Caption = 'Physical Count';
            trigger onValidate()
            var
                Item: record Item;
            begin
                Item.reset();
                Item.SetRange("No.", rec."Item No");
                if item.findfirst() then begin
                    rec.Variance := rec.Inventory - rec."Physical Count";
                end;
            end;
        }
        field(6; Variance; Decimal)
        {
            Caption = 'Variance';
            Editable = false;
        }
        field(7; "Header No"; Code[40])
        {
            Caption = 'Header No';

        }
          field(8; "Expiry";Date)
        {
          

        }
        field(9;"Item Location";CODE[50])
        {

        }
        field(10;Conditon;text[100])
        {

        }
        field(11;"Disposal Reason";text[100])
        {

        }
        field(12;"Disposal Method";text[100])
        {
            
        }
        field(13;Types;Option)
        {
            OptionMembers=Stock,Disposal;
        }
    }
    keys
    {
        key(PK; "Line No.", "Header No", "Item No")
        {
            Clustered = true;
        }
    }
    var
        item: record Item;
}
