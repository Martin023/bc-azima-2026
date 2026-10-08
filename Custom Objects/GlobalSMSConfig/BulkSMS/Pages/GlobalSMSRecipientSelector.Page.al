page 52186140 "Global SMS Recipient Selector"
{
    PageType = StandardDialog;
    Caption = 'Select SMS Recipients';
    SaveValues = false;

    layout
    {
        area(content)
        {
            group(Instructions)
            {
                Caption = 'Instructions';
                InstructionalText = 'Use the standard BC filters on each tab to select recipients. Click Preview to see how many members match.';
            }

            group(Options)
            {
                Caption = 'Filter Options';

                field(UseFilters; UseCustomFilters)
                {
                    ApplicationArea = All;
                    Caption = 'Use Configured Filters';
                    ToolTip = 'Use the filters already configured in the campaign, or set new filters below';

                    trigger OnValidate()
                    begin
                        UpdateFilterVisibility();
                    end;
                }
            }

            group(MemberFilters)
            {
                Caption = 'Member Filters';
                Visible = not UseCustomFilters;

                field(MemberFilter; MemberFilterText)
                {
                    ApplicationArea = All;
                    Caption = 'Member Filters';
                    Editable = false;
                    MultiLine = true;

                    trigger OnAssistEdit()
                    var
                        Member: Record Members;
                    begin
                        Member.FilterGroup(2);
                        Member.SetFilter(Status, '<>%1&<>%2', Member.Status::Deceased, Member.Status::Closed);
                        Member.FilterGroup(0);

                        if Page.RunModal(0, Member) = Action::LookupOK then begin
                            MemberFilterText := Member.GetView(false);
                            FilterCount := CountMembers(MemberFilterText);
                        end;
                    end;
                }

                field(MemberCount; FilterCount)
                {
                    ApplicationArea = All;
                    Caption = 'Matching Members';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
            }

            group(ConfiguredFilters)
            {
                Caption = 'Configured Campaign Filters';
                Visible = UseCustomFilters;

                field(ConfiguredFilterSummary; ConfiguredFilterText)
                {
                    ApplicationArea = All;
                    Caption = 'Active Filters';
                    Editable = false;
                    MultiLine = true;
                }

                field(ConfiguredCount; ConfiguredFilterCount)
                {
                    ApplicationArea = All;
                    Caption = 'Matching Members';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
            }

            group(Stats)
            {
                Caption = 'Phone Number Coverage';

                field(MembersWithPhone; MembersWithPhone)
                {
                    ApplicationArea = All;
                    Caption = 'Members with Valid Phone';
                    Editable = false;
                }

                field(MembersWithoutPhone; MembersWithoutPhone)
                {
                    ApplicationArea = All;
                    Caption = 'Members without Phone';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = MembersWithoutPhone > 0;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Preview)
            {
                ApplicationArea = All;
                Caption = 'Preview Count';
                Image = View;
                InFooterBar = true;

                trigger OnAction()
                begin
                    if UseCustomFilters then
                        PreviewConfiguredFilters()
                    else
                        PreviewMemberFilters();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        UseCustomFilters := true;
        UpdateFilterVisibility();
        PreviewConfiguredFilters();
    end;

    var
        CampaignNo: Code[20];
        UseCustomFilters: Boolean;
        MemberFilterText: Text;
        ConfiguredFilterText: Text;
        FilterCount: Integer;
        ConfiguredFilterCount: Integer;
        MembersWithPhone: Integer;
        MembersWithoutPhone: Integer;

    local procedure UpdateFilterVisibility()
    begin
        CurrPage.Update(false);
    end;

    local procedure CountMembers(FilterView: Text): Integer
    var
        Member: Record Members;
    begin
        if FilterView = '' then
            exit(0);

        Member.SetView(FilterView);
        exit(Member.Count());
    end;

    local procedure PreviewMemberFilters()
    var
        Member: Record Members;
        FilterEngine: Codeunit "Global Filter Engine";
    begin
        if MemberFilterText = '' then begin
            Message('Please set member filters first.');
            exit;
        end;

        Member.SetView(MemberFilterText);
        FilterCount := Member.Count();

        MembersWithPhone := 0;
        MembersWithoutPhone := 0;

        if Member.FindSet() then
            repeat
                if FilterEngine.GetMemberPhoneNumber(Member) <> '' then
                    MembersWithPhone += 1
                else
                    MembersWithoutPhone += 1;
            until Member.Next() = 0;

        Message('%1 members match.\%2 have valid phone numbers.\%3 without phone numbers will be skipped.',
                FilterCount, MembersWithPhone, MembersWithoutPhone);
    end;

    local procedure PreviewConfiguredFilters()
    var
        FilterEngine: Codeunit "Global Filter Engine";
        MemberList: List of [Code[20]];
        Member: Record Members;
        MemberNo: Code[20];
        i: Integer;
    begin
        if CampaignNo = '' then
            exit;

        ConfiguredFilterText := FilterEngine.GetFilterSummary(CampaignNo);
        MemberList := FilterEngine.GetDistinctMembersForPreview(CampaignNo);
        ConfiguredFilterCount := MemberList.Count();

        MembersWithPhone := 0;
        MembersWithoutPhone := 0;

        for i := 1 to MemberList.Count() do begin
            MemberNo := MemberList.Get(i);
            if Member.Get(MemberNo) then begin
                if FilterEngine.GetMemberPhoneNumber(Member) <> '' then
                    MembersWithPhone += 1
                else
                    MembersWithoutPhone += 1;
            end;
        end;

        CurrPage.Update(false);
    end;

    procedure SetCampaign(NewCampaignNo: Code[20])
    begin
        CampaignNo := NewCampaignNo;
    end;

    procedure GetMemberFilter(): Text
    begin
        exit(MemberFilterText);
    end;

    procedure IsUsingConfiguredFilters(): Boolean
    begin
        exit(UseCustomFilters);
    end;
}
