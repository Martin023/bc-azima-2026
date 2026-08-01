page 52185937 "HR Email Template Variables"
{
    Caption = 'Available Tokens';
    PageType = ListPart;
    SourceTable = "HR Email Template Variables";
    ApplicationArea = Basic;
    AutoSplitKey = false;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Tokens)
            {
                field(Token; Rec.Token)
                {
                    ApplicationArea = Basic;
                    Editable = not Rec."System Defined";
                    Style = Strong;
                    StyleExpr = Rec."System Defined";
                    ToolTip = 'Copy this token exactly as shown and paste it into the email body or subject where you want this value to appear.';
                }
                field("Variable Name"; Rec."Variable Name")
                {
                    ApplicationArea = Basic;
                    Editable = not Rec."System Defined";
                    ToolTip = 'Human-readable label for this token.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = not Rec."System Defined";
                    ToolTip = 'What value this token will contain when the email is sent.';
                }
                field("System Defined"; Rec."System Defined")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'System tokens are required by the dispatcher and cannot be deleted.';
                }
                field("Source Table Name"; Rec."Source Table Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = not Rec."System Defined";
                    ToolTip = 'The table this token reads its value from at send time.';
                }
                field("Source Table No."; Rec."Source Table No.")
                {
                    ApplicationArea = Basic;
                    Editable = not Rec."System Defined";
                    Visible = false;
                    ToolTip = 'Table ID for the source table. The table name is shown automatically.';
                }
                field("Source Field Name"; Rec."Source Field Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = not Rec."System Defined";
                    ToolTip = 'The field this token reads from the source table.';
                }
                field("Source Field No."; Rec."Source Field No.")
                {
                    ApplicationArea = Basic;
                    Editable = not Rec."System Defined";
                    Visible = false;
                    ToolTip = 'Field number within the source table.';
                }
                field("Sort Order"; Rec."Sort Order")
                {
                    ApplicationArea = Basic;
                    Editable = not Rec."System Defined";
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Copy Token")
            {
                ApplicationArea = Basic;
                Caption = 'Copy Token to Clipboard';
                Image = Copy;
                ToolTip = 'Copy the selected token so you can paste it directly into the email body.';

                trigger OnAction()
                begin
                    if Rec.Token = '' then
                        exit;
                    // SHOW THE TOKEN IN A MESSAGE SO USER CAN COPY — CLIPBOARD API NOT AVAILABLE IN BC AL
                    Message('TOKEN: %1\Paste this into the email body or subject where you want this value.', Rec.Token);
                end;
            }
        }
    }
}
