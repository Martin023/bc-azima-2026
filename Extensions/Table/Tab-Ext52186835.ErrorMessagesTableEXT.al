namespace MNSProjectMwanga.MNSProjectMwanga;

using System.Utilities;

tableextension 52186835 "Error Messages TableEXT" extends 700
{
    fields
    {
        field(50100; "User ID"; Code[50])
        {
            Caption = 'User ID';
            FieldClass = FlowField;
            CalcFormula = lookup("Error Message Register"."User ID" where(ID = field("Register ID")));
            Editable = false;
        }
    }
}
