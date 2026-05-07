page 52187083 "System Edits Fields"
{
    ApplicationArea = All;
    Caption = 'System Edits Fields';
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "System Edits Fields";
    CardPageId = "Image Data Edits";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                Editable = FieldsEditable;
                field("Record ID"; Rec."Record ID")
                {
                    Editable = false;
                }
                field("Field ID"; Rec."Field ID")
                {
                    Editable = false;
                }
                field("Field Type"; Rec."Field Type")
                {
                    Editable = false;
                }
                field("Field Name"; Rec."Field Name")
                {
                    Editable = false;
                }
                field("Old Value"; Rec."Old Value")
                {
                    Editable = false;
                }
                field("New Value"; Rec."New Value")
                {
                }
                field("Old Picture"; Rec."Old Picture")
                {

                }
                field("New Picture"; Rec."New Picture")
                {

                }
                field(Inserted; Rec.Inserted)
                {
                    Editable = false;
                }
                field(Modified; Rec.Modified)
                {
                    Editable = false;
                }
                field(Deleted; Rec.Deleted)
                {
                    Editable = false;
                }
                field("Generally Edited"; Rec."Generally Edited")
                {
                    Editable = false;
                }
            }
        }
    }
    trigger OnModifyRecord(): Boolean

    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetCurrRecord()
    var
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    var
    begin
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    var
    begin
        SetControlAppearance();
    end;

    local procedure SetControlAppearance()
    var
        SystemEdits: Record "System Edits";
    begin
        FieldsEditable := true;
        if SystemEdits.Get(Rec."Record ID") then begin
            if SystemEdits.Status <> SystemEdits.Status::Open then begin
                FieldsEditable := false;
            end;
            
        end;
    end;

    var
        FieldsEditable: Boolean;
}
