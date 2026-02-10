namespace System.IO;

using Microsoft.Finance.Dimension;
using System.Environment;
using System.Reflection;
using System.Security.AccessControl;

table 52187076 "System Edits Fields"
{
    ReplicateData = false;
    LookupPageId = "System Edits Fields";
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

        field(8; "Old Value"; Text[250])
        {
            Editable = false;
        }
        field(9; "New Value"; Text[250])
        {
            trigger OnValidate()
            var
                FieldRef: FieldRef;
                RecRef: RecordRef;
                // NewRecRef: RecordRef;
                OptionValues: Option Setfilter,PostChanges,AssignRecRefs;
                GlobalFunctions: Codeunit "Global Functions";
                SystemEditsFilters: Record "System Edits Filters";
                FilterValue: Text;
            begin
                SystemEditsFilters.Reset();
                SystemEditsFilters.SetRange("Record ID", "Record ID");
                if SystemEditsFilters.FindFirst() then
                    FilterValue := SystemEditsFilters.Filter;

                SystemEditsTable.Get("Record ID");
                FieldRef := SystemEditsCodeunit.AssignFieldRefValue(SystemEditsTable."Table ID", "Record ID", "Field ID");
                if not ConfigValidateMgt.EvaluateTextToFieldRef("New Value", FieldRef, true) then
                    Error('The supplied value ''%1'' cannot be evaluated into type %2', "New Value", "Field Type")
                else
                    ConfigValidateMgt.EvaluateTextToFieldRef("New Value", FieldRef, false);

                "New Value" := FieldRef.Value;

                SystemEditsCodeunit.SetFilterFields(SystemEditsTable."Table ID", "Record ID", OptionValues::AssignRecRefs, RecRef, RecRef);

                RecRef.Field("Field ID").Value := FieldRef.Value;
                RecRef.Field("Field ID").Validate();


                if "Old Value" <> "New Value" then begin
                    if ("Old Value" = '') and ("New Value" <> '') then begin
                        Inserted := true;
                        "Generally Edited" := true;
                    end;


                    if ("Old Value" <> '') and ("New Value" = '') then begin
                        Deleted := true;
                        "Generally Edited" := true;
                    end;

                    if ("Old Value" <> '') and ("New Value" <> '') then begin
                        Modified := true;
                        "Generally Edited" := true;
                    end;

                end;

                if "Old Value" = "New Value" then begin
                    Inserted := false;
                    Deleted := false;
                    Modified := false;
                    "Generally Edited" := false;
                end;

                OnAfterSystemEditsFieldValidate(SystemEditsTable."Table ID", FilterValue, "Field ID", FieldRef)
            end;
        }
        field(10; Inserted; Boolean)
        {
            Editable = false;
        }
        field(11; Modified; Boolean)
        {
            Editable = false;
        }
        field(12; Deleted; Boolean)
        {
            Editable = false;
        }
        field(13; "Field Type"; Text[50])
        {
            Editable = false;
        }
        field(14; "Generally Edited"; Boolean)
        {
            Editable = false;
        }
        field(15; "Old Picture"; Blob)
        {
            SubType = Bitmap;
        }
        field(16; "New Picture"; Blob)
        {
            SubType = Bitmap;

            trigger OnValidate()
            begin
                if Rec."Old Picture".Length <> Rec."New Picture".Length then begin
                    if (not Rec."Old Picture".HasValue) and (Rec."New Picture".HasValue) then begin
                        Inserted := true;
                        "Generally Edited" := true;
                    end;


                    if (Rec."Old Picture".HasValue) and (not Rec."New Picture".HasValue) then begin
                        Deleted := true;
                        "Generally Edited" := true;
                    end;

                    if (Rec."Old Picture".HasValue) and (Rec."New Picture".HasValue) then begin
                        Modified := true;
                        "Generally Edited" := true;
                    end;

                end;

                if "Old Value" = "New Value" then begin
                    Inserted := false;
                    Deleted := false;
                    Modified := false;
                    "Generally Edited" := false;
                end;
            end;

        }
    }

    keys
    {
        key(Key1; "Record ID", "Field ID")
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

    [IntegrationEvent(false, false)]
    procedure OnAfterSystemEditsFieldValidate(TableID: Integer; FilterValue: Text; FieldID: Integer; NewFieldRef: FieldRef)
    begin

    end;

    var
        ConfigValidateMgt: Codeunit "Config. Validate Management";
        ConfigMgt: Codeunit "Config. Management";
        ConfigPackageMgt: Codeunit "Config. Package Management";
        Text001: Label 'You cannot use system table %1 in the package.';
        SystemEditsCodeunit: Codeunit "System Editss";
        SystemEditsTable: Record "System Edits";
}

