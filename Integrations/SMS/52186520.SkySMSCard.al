page 52186520 "Sky SMS Card"
{
    ApplicationArea = All;
    Caption = 'Sky SMS Card';
    PageType = Card;
    SourceTable = "Sky SMS Messages";
    PromotedActionCategories = 'New,Process,Reports,Creation';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(sender_type; Rec.sender_type)
                {
                    ToolTip = 'Specifies the value of the sender_type field.';
                    Editable = false;
                }
                field(sender; Rec.sender)
                {
                    ToolTip = 'Specifies the value of the sender field.';
                    Editable = false;
                }
                field(receiver_type; Rec.receiver_type)
                {
                    ToolTip = 'Specifies the value of the receiver_type field.';
                    Editable = false;
                }
                field(receiver; Rec.receiver)
                {
                    ToolTip = 'Specifies the value of the receiver field.';
                    Editable = CanEditReceiver;

                    trigger OnValidate()
                    begin
                        if Confirm('Are you sure you want to modify the receiver of this SMS? This action will be tracked') then begin
                            Rec."Overriden By" := UserId;
                            Rec.Modify;
                        end else begin
                            Error('Operation cancelled successfully');
                        end;
                    end;
                }
                field(msg; Rec.msg)
                {
                    ToolTip = 'Specifies the value of the msg field.';
                    MultiLine = true;
                    Editable = false;
                }
                field("SMS Date"; Rec."SMS Date")
                {
                    ToolTip = 'Specifies the value of the SMS Date field.';
                    Editable = false;
                }
                field(msg_status_date; Rec.msg_status_date)
                {
                    ToolTip = 'Specifies the value of the msg_status_date field.';
                    Editable = false;
                }
            }

            group(Audit)
            {
                Caption = 'Audit';

                field("Overriden By"; Rec."Overriden By")
                {
                    ToolTip = 'Specifies the value of the overriden by field.';
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.msg_status_code = 10 then begin
            CanEditReceiver := true;
        end;
    end;

    var
        CanEditReceiver: Boolean;
}
