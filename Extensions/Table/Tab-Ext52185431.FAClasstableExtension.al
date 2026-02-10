namespace KenpipeCBS.KenpipeCBS;

using Microsoft.FixedAssets.Setup;
using Microsoft.FixedAssets.Depreciation;

tableextension 52185431 "FA Class table Extension" extends "FA Class"
{
    fields
    {
        field(999; "Depreciation Book Code"; Code[20])
        {
            TableRelation = "Depreciation Book";

        }
        field(1000; "Depreciation Method"; Enum "FA Depreciation Method")
        {

        }
        field(1001; "Straight-Line %"; Decimal)
        {
            Caption = 'Straight-Line %';
            DecimalPlaces = 2 : 8;
            MinValue = 0;

            trigger OnValidate()
            begin
                if not (rec."Depreciation Method" in
                ["Depreciation Method"::"Straight-Line",
                "Depreciation Method"::"DB1/SL",
                "Depreciation Method"::"DB2/SL"]) then
                    Error('Straight-Line % can only be used with Depreciation Method Straight-Line, DB1/SL, or DB2/SL');
            end;
        }

    }
    fieldgroups
    {
        addlast(DropDown; "Code", Name, "Depreciation Method", "Straight-Line %")
        {
        }
    }
}