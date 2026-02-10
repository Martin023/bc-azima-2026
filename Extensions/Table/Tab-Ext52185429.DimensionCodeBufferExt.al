namespace MNSProjectMwanga.MNSProjectMwanga;

using Microsoft.Finance.Dimension;
using Microsoft.Finance.GeneralLedger.Account;

tableextension 52185429 "Dimension Code Buffer Ext" extends "Dimension Code Buffer"
{
    fields
    {
        field(52185423; "Account Category"; Enum "G/L Account Category")
        {
            Caption = 'Account Category';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Lookup("G/L Account"."Account Category" WHERE("No." = FIELD("Code")));


        }
        field(52185424; "Account Sub Category"; Text[80])
        {
            Caption = 'Account Sub Category';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Lookup("G/L Account"."Account Subcategory Descript." WHERE("No." = FIELD("Code")));


        }

    }
}
