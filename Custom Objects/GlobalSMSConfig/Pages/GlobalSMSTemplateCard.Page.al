page 52185667 "Global SMS Template Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Global SMS Template";
    Caption = 'SMS Template';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Event Code"; Rec."Event Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique event code (auto-formatted: uppercase, underscores)';
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
                field("SMS Source"; Rec."SMS Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'SMS source enum value';
                }
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enable/disable SMS for this event';
                }
            }

            group(MessageComposition)
            {
                Caption = 'Message Composition';

                field("Message Body"; Rec."Message Body")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'SMS message template with [TOKENS]';
                }

                field(PreviewMessage; PreviewText)
                {
                    ApplicationArea = All;
                    Caption = 'Preview with Sample Values';
                    MultiLine = true;
                    Editable = false;
                    ToolTip = 'Preview message with sample token values';
                }

                field(CharacterCount; StrLen(Rec."Message Body"))
                {
                    ApplicationArea = All;
                    Caption = 'Character Count';
                    Editable = false;
                    ToolTip = 'Number of characters in message';
                }
            }

            part(TokenUsage; "SMS Template Token Usage SF")
            {
                ApplicationArea = All;
                Caption = 'Tokens Used in This Template';
                SubPageLink = "Event Code" = field("Event Code");
            }

            group(Metadata)
            {
                Caption = 'Metadata';

                field("Token Count"; Rec."Token Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of tokens detected in message';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RefreshPreview)
            {
                ApplicationArea = All;
                Caption = 'Refresh Preview';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Refresh message preview with sample values';

                trigger OnAction()
                begin
                    UpdatePreview();
                    CurrPage.Update(false);
                    Message('Preview refreshed successfully.');
                end;
            }

            action(RefreshTokenDetection)
            {
                ApplicationArea = All;
                Caption = 'Refresh Token Detection';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Re-scan message body and detect all tokens used';

                trigger OnAction()
                var
                    TokensBeforeCount: Integer;
                    TokensAfterCount: Integer;
                begin
                    // GET TOKEN COUNT BEFORE REFRESH
                    Rec.CalcFields("Token Count");
                    TokensBeforeCount := Rec."Token Count";

                    // REFRESH TOKEN DETECTION
                    Rec.UpdateTokenUsage();

                    // GET TOKEN COUNT AFTER REFRESH
                    Rec.CalcFields("Token Count");
                    TokensAfterCount := Rec."Token Count";

                    // REFRESH PAGE
                    CurrPage.Update(false);

                    // SHOW FEEDBACK MESSAGE
                    if TokensAfterCount = 0 then
                        Message('No tokens detected in message body. Ensure tokens are in [BRACKET] format.')
                    else if TokensAfterCount = TokensBeforeCount then
                        Message('%1 token(s) detected (no change).', TokensAfterCount)
                    else if TokensAfterCount > TokensBeforeCount then
                        Message('Token detection updated: %1 → %2 tokens detected.', TokensBeforeCount, TokensAfterCount)
                    else
                        Message('Token detection updated: %1 → %2 tokens detected.', TokensBeforeCount, TokensAfterCount);
                end;
            }

            action(ViewAvailableTokens)
            {
                ApplicationArea = All;
                Caption = 'View Available Tokens';
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View all available tokens';

                trigger OnAction()
                begin
                    Page.Run(Page::"Global SMS Token List");
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
                    Page.Run(Page::"Global SMS Template History", History);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdatePreview();
    end;

    var
        PreviewText: Text;

    local procedure UpdatePreview()
    var
        TokenResolver: Codeunit "Global SMS Token Resolver";
    begin
        if Rec."Event Code" <> '' then
            PreviewText := TokenResolver.PreviewMessage(Rec."Event Code")
        else
            PreviewText := '';
    end;
}
