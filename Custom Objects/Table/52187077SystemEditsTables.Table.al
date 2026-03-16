namespace System.IO;

using Microsoft.Finance.Dimension;
using System.Environment;
using System.Reflection;
using System.Security.AccessControl;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.NoSeries;

table 52187077 "System Edits Tables"
{
    ReplicateData = false;
    DrillDownPageId = "System Edits Tables";
    LookupPageId = "System Edits Tables";


    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));

            trigger OnLookup()
            var
                AllTables: Record AllObj;
                RecRef: RecordRef;
                TableName: Text;
                RecId: RecordId;
                SystemEditsCodeunit: codeunit "System Editss";                
            begin
                ConfigValidateMgt.LookupTable("Table ID");
                if "Table ID" <> 0 then
                    Validate("Table ID");
                RecRef.Open("Table ID");
            end;
            trigger OnValidate()
            begin
                if ConfigMgt.IsSystemTable("Table ID") then
                    Error(Text001, "Table ID");

                // if "Table ID" <> xRec."Table ID" then
                //     "Page ID" := ConfigMgt.FindPage("Table ID");

                Message(SystemEditsCodeunit.Setfilters("Table ID",'',true, ''));
            end;
        }
        field(4; "Table Name"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Name" where("Object Type" = const(Table),
                                                                        "Object ID" = field("Table ID")));
            Caption = 'Table Name';
            Editable = false;
            FieldClass = FlowField;
        }

        field(5; "Table Caption"; Text[250])
        {
            
        }

        field(13; Activated; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Table ID")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "Table Caption","Table Name")
        {
        }
       
    }

    trigger OnRename()
    begin
    end;

    var
        ConfigValidateMgt: Codeunit "Config. Validate Management";
        ConfigMgt: Codeunit "Config. Management";
        ConfigPackageMgt: Codeunit "Config. Package Management";
        Text001: Label 'You cannot use system table %1 in the package.';
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        SystemEditsCodeunit: Codeunit "System Editss";
        CreditNoSeries: Record "Credit Nos. Series";
}

