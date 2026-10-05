codeunit 52185975 "Global Filter Engine"
{
    procedure GenerateRecipients(CampaignNo: Code[20]): Integer
    var
        Header: Record "Global Bulk SMS Header";
        ExistingLine: Record "Global Bulk SMS Line";
        MemberList: List of [Code[20]];
        ProcessedCount: Integer;
    begin
        if CampaignNo = '' then
            Error('Campaign No. cannot be blank.');

        if not Header.Get(CampaignNo) then
            Error('Campaign %1 does not exist.', CampaignNo);

        if not (Header.Status in [Header.Status::Draft, Header.Status::Ready]) then
            Error('Can only generate recipients for campaigns with status Draft or Ready. Current status: %1', Header.Status);

        ExistingLine.SetRange("Campaign No.", CampaignNo);
        if not ExistingLine.IsEmpty() then
            if not Confirm('Campaign already has %1 recipients. Delete and regenerate?', false, ExistingLine.Count()) then
                Error('');

        Header.SetStatusGenerating();

        ExistingLine.DeleteAll(true);
        Commit();

        MemberList := GetDistinctMembers(CampaignNo);

        if MemberList.Count() = 0 then begin
            Header.ResetToDraft();
            Error('No members match the configured filters.');
        end;

        ProcessedCount := CreateLinesFromMembers(CampaignNo, MemberList);

        if ProcessedCount = 0 then begin
            Header.ResetToDraft();
            Error('Failed to create any recipient lines. Check member phone numbers.');
        end;

        UpdateFilterSummary(CampaignNo);

        Header.Get(CampaignNo);
        Header.SetStatusReady();

        exit(ProcessedCount);
    end;

    local procedure GetDistinctMembers(CampaignNo: Code[20]): List of [Code[20]]
    var
        FilterRec: Record "Global Bulk SMS Filter";
        MemberList: List of [Code[20]];
        TempMemberList: List of [Code[20]];
        MemberNo: Code[20];
        i: Integer;
    begin
        FilterRec.SetRange("Campaign No.", CampaignNo);
        FilterRec.SetRange(Enabled, true);

        if FilterRec.IsEmpty() then begin
            MemberList := GetAllActiveMembers();
            exit(MemberList);
        end;

        if FilterRec.FindSet() then
            repeat
                case FilterRec."Filter Source" of
                    FilterRec."Filter Source"::Member:
                        TempMemberList := GetMembersFromMemberFilter(FilterRec);
                    FilterRec."Filter Source"::"Savings Account":
                        TempMemberList := GetMembersFromSavingsFilter(FilterRec);
                    FilterRec."Filter Source"::Loan:
                        TempMemberList := GetMembersFromLoanFilter(FilterRec);
                end;

                for i := 1 to TempMemberList.Count() do begin
                    MemberNo := TempMemberList.Get(i);
                    if not MemberList.Contains(MemberNo) then
                        MemberList.Add(MemberNo);
                end;

                Clear(TempMemberList);
            until FilterRec.Next() = 0;

        exit(MemberList);
    end;

    local procedure GetAllActiveMembers(): List of [Code[20]]
    var
        Member: Record Members;
        MemberList: List of [Code[20]];
    begin
        Member.SetFilter(Status, '<>%1&<>%2', Member.Status::Deceased, Member.Status::Closed);

        if Member.FindSet() then
            repeat
                if Member."Phone No." <> '' then
                    MemberList.Add(Member."No.");
            until Member.Next() = 0;

        exit(MemberList);
    end;

    local procedure GetMembersFromMemberFilter(FilterRec: Record "Global Bulk SMS Filter"): List of [Code[20]]
    var
        Member: Record Members;
        RecRef: RecordRef;
        FldRef: FieldRef;
        MemberList: List of [Code[20]];
        FilterExpr: Text;
        i: Integer;
        Found: Boolean;
    begin
        FilterExpr := FilterRec.GetFilterExpression();
        if FilterExpr = '' then
            exit(MemberList);

        RecRef.Open(Database::Members);

        Found := false;
        for i := 1 to RecRef.FieldCount() do begin
            FldRef := RecRef.FieldIndex(i);
            if UpperCase(FldRef.Name) = UpperCase(FilterRec."Field Name") then begin
                FldRef.SetFilter(FilterExpr);
                Found := true;
                break;
            end;
        end;

        if not Found then begin
            RecRef.Close();
            Error('Field %1 not found in Members table for filter on line %2.', FilterRec."Field Name", FilterRec."Line No.");
        end;

        if RecRef.FindSet() then
            repeat
                RecRef.SetTable(Member);
                if Member.Status <> Member.Status::Deceased then
                    if Member."Phone No." <> '' then
                        MemberList.Add(Member."No.");
            until RecRef.Next() = 0;

        RecRef.Close();
        exit(MemberList);
    end;

    local procedure GetMembersFromSavingsFilter(FilterRec: Record "Global Bulk SMS Filter"): List of [Code[20]]
    var
        SavingsAccount: Record "Savings Accounts";
        RecRef: RecordRef;
        FldRef: FieldRef;
        MemberList: List of [Code[20]];
        FilterExpr: Text;
        i: Integer;
        Found: Boolean;
    begin
        FilterExpr := FilterRec.GetFilterExpression();
        if FilterExpr = '' then
            exit(MemberList);

        RecRef.Open(Database::"Savings Accounts");

        Found := false;
        for i := 1 to RecRef.FieldCount() do begin
            FldRef := RecRef.FieldIndex(i);
            if UpperCase(FldRef.Name) = UpperCase(FilterRec."Field Name") then begin
                FldRef.SetFilter(FilterExpr);
                Found := true;
                break;
            end;
        end;

        if not Found then begin
            RecRef.Close();
            Error('Field %1 not found in Savings Accounts table for filter on line %2.', FilterRec."Field Name", FilterRec."Line No.");
        end;

        if RecRef.FindSet() then
            repeat
                RecRef.SetTable(SavingsAccount);
                if SavingsAccount."Member No." <> '' then
                    if not MemberList.Contains(SavingsAccount."Member No.") then
                        MemberList.Add(SavingsAccount."Member No.");
            until RecRef.Next() = 0;

        RecRef.Close();
        exit(MemberList);
    end;

    local procedure GetMembersFromLoanFilter(FilterRec: Record "Global Bulk SMS Filter"): List of [Code[20]]
    var
        Loan: Record Loans;
        RecRef: RecordRef;
        FldRef: FieldRef;
        MemberList: List of [Code[20]];
        FilterExpr: Text;
        i: Integer;
        Found: Boolean;
    begin
        FilterExpr := FilterRec.GetFilterExpression();
        if FilterExpr = '' then
            exit(MemberList);

        RecRef.Open(Database::Loans);

        Found := false;
        for i := 1 to RecRef.FieldCount() do begin
            FldRef := RecRef.FieldIndex(i);
            if UpperCase(FldRef.Name) = UpperCase(FilterRec."Field Name") then begin
                FldRef.SetFilter(FilterExpr);
                Found := true;
                break;
            end;
        end;

        if not Found then begin
            RecRef.Close();
            Error('Field %1 not found in Loans table for filter on line %2.', FilterRec."Field Name", FilterRec."Line No.");
        end;

        if RecRef.FindSet() then
            repeat
                RecRef.SetTable(Loan);
                if Loan."Member No." <> '' then
                    if not MemberList.Contains(Loan."Member No.") then
                        MemberList.Add(Loan."Member No.");
            until RecRef.Next() = 0;

        RecRef.Close();
        exit(MemberList);
    end;

    local procedure CreateLinesFromMembers(CampaignNo: Code[20]; MemberList: List of [Code[20]]): Integer
    var
        Member: Record Members;
        NewLine: Record "Global Bulk SMS Line";
        MemberNo: Code[20];
        ProcessedCount: Integer;
        i: Integer;
    begin
        ProcessedCount := 0;

        for i := 1 to MemberList.Count() do begin
            MemberNo := MemberList.Get(i);

            if not Member.Get(MemberNo) then
                continue;

            if Member."Phone No." = '' then
                continue;

            if Member.Status = Member.Status::Deceased then
                continue;

            Clear(NewLine);
            NewLine.Init();
            NewLine."Campaign No." := CampaignNo;
            NewLine."Member No." := MemberNo;
            NewLine.Validate("Member No.");

            if NewLine.Insert(true) then
                ProcessedCount += 1;
        end;

        Commit();
        exit(ProcessedCount);
    end;

    local procedure UpdateFilterSummary(CampaignNo: Code[20])
    var
        Header: Record "Global Bulk SMS Header";
        FilterRec: Record "Global Bulk SMS Filter";
        Summary: Text;
        FilterCount: Integer;
    begin
        if not Header.Get(CampaignNo) then
            exit;

        FilterRec.SetRange("Campaign No.", CampaignNo);
        FilterRec.SetRange(Enabled, true);
        FilterCount := FilterRec.Count();

        if FilterCount = 0 then
            Summary := 'No filters - All active members'
        else begin
            Summary := StrSubstNo('%1 filter(s): ', FilterCount);

            if FilterRec.FindSet() then
                repeat
                    if StrLen(Summary) > 400 then begin
                        Summary := Summary + '...';
                        break;
                    end;

                    if FilterRec."Line No." > 1 then
                        Summary := Summary + ', ';

                    Summary := Summary + FilterRec.Description;
                until FilterRec.Next() = 0;
        end;

        Header."Filter Summary" := CopyStr(Summary, 1, MaxStrLen(Header."Filter Summary"));
        Header.Modify(true);
    end;

    procedure TestFilters(CampaignNo: Code[20]): Integer
    var
        Header: Record "Global Bulk SMS Header";
        MemberList: List of [Code[20]];
    begin
        if CampaignNo = '' then
            Error('Campaign No. cannot be blank.');

        if not Header.Get(CampaignNo) then
            Error('Campaign %1 does not exist.', CampaignNo);

        MemberList := GetDistinctMembers(CampaignNo);

        exit(MemberList.Count());
    end;

    procedure ClearLines(CampaignNo: Code[20])
    var
        Header: Record "Global Bulk SMS Header";
        Line: Record "Global Bulk SMS Line";
    begin
        if CampaignNo = '' then
            Error('Campaign No. cannot be blank.');

        if not Header.Get(CampaignNo) then
            Error('Campaign %1 does not exist.', CampaignNo);

        Header.CheckEditAllowed();

        Line.SetRange("Campaign No.", CampaignNo);
        Line.DeleteAll(true);

        Header.ResetToDraft();

        Message('All recipients cleared for campaign %1.', CampaignNo);
    end;

    procedure GetFilterSummary(CampaignNo: Code[20]): Text
    var
        FilterRec: Record "Global Bulk SMS Filter";
        Summary: Text;
    begin
        if CampaignNo = '' then
            exit('');

        FilterRec.SetRange("Campaign No.", CampaignNo);
        FilterRec.SetRange(Enabled, true);

        if FilterRec.IsEmpty() then
            exit('No filters configured');

        Summary := '';

        if FilterRec.FindSet() then
            repeat
                if Summary <> '' then
                    Summary := Summary + '; ';

                Summary := Summary + FilterRec.Description;
            until FilterRec.Next() = 0;

        exit(Summary);
    end;

    procedure ValidateFilterConfiguration(CampaignNo: Code[20]): Text
    var
        FilterRec: Record "Global Bulk SMS Filter";
        ErrorText: Text;
    begin
        if CampaignNo = '' then
            exit('Campaign No. is blank');

        FilterRec.SetRange("Campaign No.", CampaignNo);
        FilterRec.SetRange(Enabled, true);

        if FilterRec.FindSet() then
            repeat
                if FilterRec."Field Name" = '' then
                    ErrorText := ErrorText + StrSubstNo('Filter line %1: Field Name is blank. ', FilterRec."Line No.");

                if FilterRec."Filter Value 1" = '' then
                    if not (FilterRec."Filter Operator" in [FilterRec."Filter Operator"::Blank, FilterRec."Filter Operator"::NotBlank]) then
                        ErrorText := ErrorText + StrSubstNo('Filter line %1: Filter Value 1 is blank. ', FilterRec."Line No.");

                if FilterRec."Filter Operator" = FilterRec."Filter Operator"::Range then
                    if FilterRec."Filter Value 2" = '' then
                        ErrorText := ErrorText + StrSubstNo('Filter line %1: Filter Value 2 is required for Range operator. ', FilterRec."Line No.");
            until FilterRec.Next() = 0;

        exit(ErrorText);
    end;
}
