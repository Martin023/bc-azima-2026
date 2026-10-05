page 52185463 "Global Bulk SMS Card"
{
    PageType = Card;
    SourceTable = "Global Bulk SMS Header";
    Caption = 'Global Bulk SMS Campaign';
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Campaign Name"; Rec."Campaign Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StatusStyle;
                }
                field("Message Template"; Rec."Message Template")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        ValidateTokensInMessage();
                    end;
                }
            }

            group(Statistics)
            {
                Caption = 'Statistics';

                field("Total Recipients"; Rec."Total Recipients")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    begin
                        ShowRecipients();
                    end;
                }
                field("Sent Count"; Rec."Sent Count")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Failed Count"; Rec."Failed Count")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = Rec."Failed Count" > 0;
                }
                field("Pending Count"; Rec."Pending Count")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Filter Summary"; Rec."Filter Summary")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
            }

            group(Tracking)
            {
                Caption = 'Tracking';

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created DateTime"; Rec."Created DateTime")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Generated DateTime"; Rec."Generated DateTime")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sent DateTime"; Rec."Sent DateTime")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            part(Filters; "Global Bulk SMS Filter Part")
            {
                ApplicationArea = All;
                SubPageLink = "Campaign No." = field("Campaign No.");
                UpdatePropagation = Both;
            }

            part(Tokens; "Global Bulk SMS Token Part")
            {
                ApplicationArea = All;
                SubPageLink = "Campaign No." = field("Campaign No.");
                UpdatePropagation = Both;
            }

            part(Recipients; "Global Bulk SMS Line Part")
            {
                ApplicationArea = All;
                SubPageLink = "Campaign No." = field("Campaign No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Process)
            {
                Caption = 'Process';

                action(GenerateRecipients)
                {
                    ApplicationArea = All;
                    Caption = 'Generate Recipients';
                    Image = CreateInteraction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = CanGenerateRecipients;

                    trigger OnAction()
                    var
                        FilterEngine: Codeunit "Global Filter Engine";
                        RecipientCount: Integer;
                    begin
                        Rec.TestField("Campaign Name");
                        Rec.TestField("Message Template");

                        RecipientCount := FilterEngine.GenerateRecipients(Rec."Campaign No.");

                        Message('%1 recipients generated successfully.', RecipientCount);

                        CurrPage.Update(false);
                    end;
                }
                action(TestFilters)
                {
                    ApplicationArea = All;
                    Caption = 'Test Filters';
                    Image = TestReport;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        FilterEngine: Codeunit "Global Filter Engine";
                        MatchCount: Integer;
                    begin
                        MatchCount := FilterEngine.TestFilters(Rec."Campaign No.");
                        Message('%1 member(s) match the configured filters.', MatchCount);
                    end;
                }
                action(PreviewMessages)
                {
                    ApplicationArea = All;
                    Caption = 'Preview Messages';
                    Image = PreviewChecks;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        ShowPreview();
                    end;
                }
                action(SendSMS)
                {
                    ApplicationArea = All;
                    Caption = 'Send SMS';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = Rec.Status = Rec.Status::Ready;

                    trigger OnAction()
                    var
                        Sender: Codeunit "Global Bulk SMS Sender";
                        ValidationError: Text;
                    begin
                        ValidationError := Sender.ValidateBeforeSend(Rec."Campaign No.");

                        if ValidationError <> '' then
                            Error('Cannot send campaign:\%1', ValidationError);

                        Sender.SendCampaign(Rec."Campaign No.");

                        CurrPage.Update(false);
                    end;
                }
                action(ResendFailed)
                {
                    ApplicationArea = All;
                    Caption = 'Resend Failed';
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Sender: Codeunit "Global Bulk SMS Sender";
                    begin
                        Sender.ResendFailed(Rec."Campaign No.");
                        CurrPage.Update(false);
                    end;
                }
                action(CancelSending)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Sending';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Sender: Codeunit "Global Bulk SMS Sender";
                    begin
                        Sender.CancelSending(Rec."Campaign No.");
                        CurrPage.Update(false);
                    end;
                }
                action(TestSend)
                {
                    ApplicationArea = All;
                    Caption = 'Test Send';
                    Image = SendTo;

                    trigger OnAction()
                    var
                        Sender: Codeunit "Global Bulk SMS Sender";
                        TestMemberNo: Code[20];
                    begin
                        Rec.TestField("Message Template");

                        TestMemberNo := '';
                        Message('Please select a member from the Members list to test SMS sending.');
                        if Page.RunModal(Page::"Member List", TestMember) = Action::LookupOK then
                            TestMemberNo := TestMember."No."
                        else
                            exit;

                        if TestMemberNo = '' then
                            Error('Member No. cannot be blank.');

                        Sender.TestSendSingle(Rec."Campaign No.", TestMemberNo);
                    end;
                }
            }

            group(Manage)
            {
                Caption = 'Manage';

                action(ClearRecipients)
                {
                    ApplicationArea = All;
                    Caption = 'Clear Recipients';
                    Image = ClearLog;

                    trigger OnAction()
                    var
                        FilterEngine: Codeunit "Global Filter Engine";
                    begin
                        FilterEngine.ClearLines(Rec."Campaign No.");
                        CurrPage.Update(false);
                    end;
                }
                action(ResetToDraft)
                {
                    ApplicationArea = All;
                    Caption = 'Reset to Draft';
                    Image = ResetStatus;

                    trigger OnAction()
                    begin
                        Rec.ResetToDraft();
                        CurrPage.Update(false);
                        Message('Campaign reset to Draft status.');
                    end;
                }
                action(CopyCampaignAction)
                {
                    ApplicationArea = All;
                    Caption = 'Copy Campaign';
                    Image = Copy;

                    trigger OnAction()
                    begin
                        CopyCampaignData();
                    end;
                }
            }

            group(Navigate)
            {
                Caption = 'Navigate';

                action(ViewRecipients)
                {
                    ApplicationArea = All;
                    Caption = 'View Recipients';
                    Image = CustomerList;
                    RunObject = page "Global Bulk SMS Line List";
                    RunPageLink = "Campaign No." = field("Campaign No.");
                }
                action(ViewFilters)
                {
                    ApplicationArea = All;
                    Caption = 'View Filters';
                    Image = FilterLines;
                    RunObject = page "Global Bulk SMS Filter List";
                    RunPageLink = "Campaign No." = field("Campaign No.");
                }
                action(ViewTokens)
                {
                    ApplicationArea = All;
                    Caption = 'View Tokens';
                    Image = CodesList;
                    RunObject = page "Global Bulk SMS Token List";
                    RunPageLink = "Campaign No." = field("Campaign No.");
                }
            }

            group(Reports)
            {
                Caption = 'Reports';

                action(EstimateCost)
                {
                    ApplicationArea = All;
                    Caption = 'Estimate Cost';
                    Image = CalculateLines;

                    trigger OnAction()
                    var
                        Sender: Codeunit "Global Bulk SMS Sender";
                        EstimatedCost: Decimal;
                    begin
                        EstimatedCost := Sender.GetEstimatedCost(Rec."Campaign No.");
                        Message('Estimated SMS cost: %1', EstimatedCost);
                    end;
                }
                action(GetProgress)
                {
                    ApplicationArea = All;
                    Caption = 'Get Progress';
                    Image = Status;

                    trigger OnAction()
                    var
                        Sender: Codeunit "Global Bulk SMS Sender";
                        ProgressText: Text;
                    begin
                        ProgressText := Sender.GetProgress(Rec."Campaign No.");
                        Message(ProgressText);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateStatusStyle();
    end;

    trigger OnOpenPage()
    begin
        UpdateStatusStyle();
    end;

    local procedure UpdateStatusStyle()
    begin
        case Rec.Status of
            Rec.Status::Draft:
                StatusStyle := 'Standard';
            Rec.Status::Generating:
                StatusStyle := 'Attention';
            Rec.Status::Ready:
                StatusStyle := 'Favorable';
            Rec.Status::Sending:
                StatusStyle := 'Attention';
            Rec.Status::Completed:
                StatusStyle := 'Favorable';
            Rec.Status::Cancelled:
                StatusStyle := 'Unfavorable';
        end;
    end;

    local procedure ValidateTokensInMessage()
    var
        TokenEngine: Codeunit "Global Token Engine";
        ValidationError: Text;
    begin
        if Rec."Message Template" = '' then
            exit;

        ValidationError := TokenEngine.ValidateTokensInMessage(Rec."Message Template", Rec."Campaign No.");

        if ValidationError <> '' then
            Message('Token validation:\%1', ValidationError);
    end;

    local procedure ShowPreview()
    var
        TokenEngine: Codeunit "Global Token Engine";
        SampleMessages: List of [Text];
        PreviewText: Text;
        SampleMessage: Text;
        i: Integer;
    begin
        Rec.CalcFields("Total Recipients");

        if Rec."Total Recipients" = 0 then begin
            Message('No recipients to preview. Generate recipients first.');
            exit;
        end;

        SampleMessages := TokenEngine.GetSampleResolvedMessages(Rec."Campaign No.", 5);

        PreviewText := 'Sample Messages:\';

        for i := 1 to SampleMessages.Count() do begin
            SampleMessage := SampleMessages.Get(i);
            PreviewText := PreviewText + '\' + SampleMessage;

            if i < SampleMessages.Count() then
                PreviewText := PreviewText + '\\';
        end;

        Message(PreviewText);
    end;

    local procedure ShowRecipients()
    var
        Line: Record "Global Bulk SMS Line";
        LineList: Page "Global Bulk SMS Line List";
    begin
        Line.SetRange("Campaign No.", Rec."Campaign No.");
        LineList.SetTableView(Line);
        LineList.Run();
    end;

    local procedure CopyCampaignData()
    var
        SourceHeader: Record "Global Bulk SMS Header";
        NewHeader: Record "Global Bulk SMS Header";
        SourceFilter: Record "Global Bulk SMS Filter";
        NewFilter: Record "Global Bulk SMS Filter";
        SourceToken: Record "Global Bulk SMS Token Map";
        NewToken: Record "Global Bulk SMS Token Map";
    begin
        SourceHeader.Get(Rec."Campaign No.");

        NewHeader.Init();
        NewHeader."Campaign Name" := CopyStr(SourceHeader."Campaign Name" + ' (Copy)', 1, MaxStrLen(NewHeader."Campaign Name"));
        NewHeader.Description := SourceHeader.Description;
        NewHeader."Message Template" := SourceHeader."Message Template";
        NewHeader.Insert(true);

        SourceFilter.SetRange("Campaign No.", SourceHeader."Campaign No.");
        if SourceFilter.FindSet() then
            repeat
                NewFilter.Init();
                NewFilter.TransferFields(SourceFilter, false);
                NewFilter."Campaign No." := NewHeader."Campaign No.";
                NewFilter."Line No." := 0;
                NewFilter.Insert(true);
            until SourceFilter.Next() = 0;

        SourceToken.SetRange("Campaign No.", SourceHeader."Campaign No.");
        if SourceToken.FindSet() then
            repeat
                NewToken.Init();
                NewToken.TransferFields(SourceToken, false);
                NewToken."Campaign No." := NewHeader."Campaign No.";
                NewToken."Line No." := 0;
                NewToken.Insert(true);
            until SourceToken.Next() = 0;

        Message('Campaign copied to %1.', NewHeader."Campaign No.");

        Rec := NewHeader;
        CurrPage.Update(false);
    end;

    trigger OnAfterGetRecord()
    begin
        UpdatePageControls();
    end;

    local procedure UpdatePageControls()
    begin
        CanGenerateRecipients := Rec.Status in [Rec.Status::Draft, Rec.Status::Ready];
    end;

    var
        StatusStyle: Text;
        TestMember: Record Members;
        CanGenerateRecipients: Boolean;
}
