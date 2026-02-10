namespace System.IO;

using Microsoft.Finance.Dimension;
using System.Environment;
using System.Reflection;
using System.Security.AccessControl;

table 52187075 "System Edits Filters"
{
    ReplicateData = false;

    fields
    {
        field(2; "Record ID"; Code[30])
        {
            Editable = false;
        }

        field(3; "Field ID"; Integer)
        {
            Editable = false;
        }
        field(4; "Field Name"; Text[250])
        {
            Editable = false;
        }

        field(8; Filter; Text[250])
        {

        }
        
    }

    keys
    {
        key(Key1; "Record ID","Field ID")
        {
            Clustered = true;
        }
        
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
       
    end;

    trigger OnInsert()
    begin
    end;

    trigger OnRename()
    begin
    end;   

    var
        ConfigValidateMgt: Codeunit "Config. Validate Management";
        ConfigMgt: Codeunit "Config. Management";
        ConfigPackageMgt: Codeunit "Config. Package Management";
        Text001: Label 'You cannot use system table %1 in the package.';
}

