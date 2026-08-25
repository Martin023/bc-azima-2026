page 52185666 "HR SMS CC Recipients"
{
    Caption = 'CC Recipients';
    PageType = ListPart;
    SourceTable = "HR SMS CC Recipient Buffer";
    ApplicationArea = Basic;
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;

    layout
    {
        area(content)
        {
            repeater(Recipients)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    ShowMandatory = true;
                    ToolTip = 'Name used in SMS. Auto-filled from employee but editable (e.g., "Jane Smith", "HR Manager", "CEO").';
                    Width = 20;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Phone';
                    ShowMandatory = true;
                    ToolTip = 'SMS recipient phone. Auto-filled from employee but editable. Format: 0722123456 or 254722123456.';
                    Width = 15;
                }
                field(Salutation; Rec.Salutation)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salutation';
                    ToolTip = 'Prefix for name (e.g., "Dear", "Mr.", "Ms.", "Dr."). Used with [CC_RECIPIENT_SALUTATION] token.';
                    Width = 8;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee';
                    ToolTip = 'Select employee to auto-fill name and phone.';
                    Width = 12;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Delete Line")
            {
                ApplicationArea = Basic;
                Caption = 'Delete Line';
                Image = Delete;
                ToolTip = 'Remove this CC recipient from the list.';

                trigger OnAction()
                begin
                    if Rec."Line No." = 0 then
                        exit;
                    if Confirm('Remove this CC recipient?', true) then begin
                        Rec.Delete(true);
                        CurrPage.Update(false);
                    end;
                end;
            }
            action("Clear All")
            {
                ApplicationArea = Basic;
                Caption = 'Clear All Recipients';
                Image = ClearLog;
                ToolTip = 'Remove all CC recipients from this template.';

                trigger OnAction()
                begin
                    if not Confirm('Remove all CC recipients? This cannot be undone.', false) then
                        exit;
                    Rec.Reset();
                    Rec.DeleteAll();
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // AUTO-SET DEFAULT SALUTATION FOR NEW LINES
        Rec.Salutation := 'Dear';
    end;

    procedure GetAllRecords(var TempBuffer: Record "HR SMS CC Recipient Buffer" temporary)
    begin
        TempBuffer.Reset();
        TempBuffer.DeleteAll();
        if Rec.FindSet() then
            repeat
                TempBuffer := Rec;
                TempBuffer.Insert();
            until Rec.Next() = 0;
    end;

    procedure SetAllRecords(var TempBuffer: Record "HR SMS CC Recipient Buffer" temporary)
    begin
        Rec.Reset();
        Rec.DeleteAll();
        if TempBuffer.FindSet() then
            repeat
                Rec := TempBuffer;
                Rec.Insert();
            until TempBuffer.Next() = 0;
        CurrPage.Update(false);
    end;
}
