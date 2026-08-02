page 52185965 "HR SMS Template Variables"
{
    Caption = 'Available Tokens';
    PageType = ListPart;
    SourceTable = "HR SMS Template Variables";
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
                    ToolTip = 'Copy this token and paste it into the message body where you want this value to appear.';
                }
                field("Variable Name"; Rec."Variable Name")
                {
                    ApplicationArea = Basic;
                    Editable = not Rec."System Defined";
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = not Rec."System Defined";
                }
                field("System Defined"; Rec."System Defined")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
            action("Show Token")
            {
                ApplicationArea = Basic;
                Caption = 'Show Token';
                Image = Info;
                ToolTip = 'Display the selected token so you can copy it into the message body.';

                trigger OnAction()
                begin
                    if Rec.Token = '' then
                        exit;
                    Message('TOKEN: %1\Paste this into the message body where you want this value to appear.', Rec.Token);
                end;
            }
        }
    }
}
