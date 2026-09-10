page 52185976 "Global SMS Template List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Global SMS Template";
    Caption = 'Global SMS Templates';
    CardPageId = "Global SMS Template Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Templates)
            {
                field("Event Code"; Rec."Event Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique event code';
                }
                field("Event Description"; Rec."Event Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description of the event';
                }
                field(Module; Rec.Module)
                {
                    ApplicationArea = All;
                    ToolTip = 'Module this template belongs to';
                }
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                    ToolTip = 'Whether SMS is enabled for this event';
                }
                field("Token Count"; Rec."Token Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of tokens used in this template';
                }
                field("SMS Source"; Rec."SMS Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'SMS source enum value';
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last user to modify this template';
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last modification date';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(InstallDefaultTemplates)
            {
                ApplicationArea = All;
                Caption = 'Install Default Templates';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Install default message templates for common transactions';

                trigger OnAction()
                var
                    Installer: Codeunit "Global SMS Installer";
                begin
                    if Confirm('Install default templates for CBS transactions?', true) then
                        Installer.InstallDefaultTemplates();
                end;
            }

            action(ViewHistory)
            {
                ApplicationArea = All;
                Caption = 'View Change History';
                Image = History;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View audit trail of changes';

                trigger OnAction()
                var
                    History: Record "Global SMS Template History";
                begin
                    History.SetRange("Event Code", Rec."Event Code");
                    Page.Run(0, History);
                end;
            }
        }
    }
}
