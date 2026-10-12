page 52186139 "Global SMS Field Selector"
{
    PageType = List;
    Caption = 'Select Field';
    SourceTableTemporary = true;
    SourceTable = "Name/Value Buffer";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Fields)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Field Name';
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = All;
                    Caption = 'Field Caption';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SelectField)
            {
                ApplicationArea = All;
                Caption = 'OK';
                Image = Approve;
                InFooterBar = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec.Name = '' then
                        Error('Please select a field first.');
                        
                    SelectedFieldName := Rec.Name;
                    SelectedFieldCaption := Rec.Value;
                    CurrPage.Close();
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        // When user double-clicks a row or presses OK
        if CloseAction in [Action::OK, Action::LookupOK] then begin
            if Rec.Name <> '' then begin
                SelectedFieldName := Rec.Name;
                SelectedFieldCaption := Rec.Value;
            end;
        end;
    end;

    var
        SelectedFieldName: Text[100];
        SelectedFieldCaption: Text[100];

    procedure LoadFields(TableID: Integer)
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
        i: Integer;
        LineNo: Integer;
    begin
        Rec.Reset();
        Rec.DeleteAll();

        if TableID = 0 then
            exit;

        RecRef.Open(TableID);
        LineNo := 0;

        for i := 1 to RecRef.FieldCount() do begin
            FldRef := RecRef.FieldIndex(i);

            // Skip system fields
            if FldRef.Number < 1 then
                continue;

            // Skip FlowFields and FlowFilters for simplicity (can be enabled if needed)
            if FldRef.Class in [FieldClass::FlowField, FieldClass::FlowFilter] then
                continue;

            LineNo += 1;
            Rec.Init();
            Rec.ID := LineNo;
            Rec.Name := CopyStr(FldRef.Name, 1, MaxStrLen(Rec.Name));
            Rec.Value := CopyStr(FldRef.Caption, 1, MaxStrLen(Rec.Value));
            Rec.Insert();
        end;

        RecRef.Close();

        if Rec.FindFirst() then;
    end;

    procedure GetSelectedField(var FieldName: Text[100]; var FieldCaption: Text[100]): Boolean
    begin
        FieldName := SelectedFieldName;
        FieldCaption := SelectedFieldCaption;
        exit(SelectedFieldName <> '');
    end;
}
