namespace KenpipeCBS.KenpipeCBS;

report 52186224 "Generate Actual progression"
{
    ApplicationArea = All;
    Caption = 'Generate Actual progression';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(DividendProgressionImport; "Dividend Progression Import")
        {
            trigger OnAfterGetRecord()
            begin
                SavAcc.reset;
                SavAcc.SetRange("Product Type", 'DCS');
                SavAcc.SetRange("Member No.", DividendProgressionImport."Member No.");
                if SavAcc.FindFirst() then begin
                    CreateDividendLines(SavAcc."No.", today, SavAcc."Product Type", SavAcc."Product Name", SavAcc."Member No.", DividendProgressionImport."Qualifying Shares", DividendProgressionImport.Shares, DividendProgressionImport."Gross Div.", DividendProgressionImport.WTax, DividendProgressionImport."Net Div.", CalcDate('<CM>', DividendProgressionImport.Date), CalcDate('<-CM>', DividendProgressionImport.Date), DivCalcMethod::Prorated, '', SavAcc."Employer Code")
                end;
            end;
        }


    }

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Message('Dividends progression updated successfully')
    end;

    procedure CreateDividendLines(AccountNo: Code[20]; ProcessingDate: Date; ProductID: Code[20]; ProductName: Text; MemberNo: Code[20]; QualifyingShares: Decimal; DivShares: Decimal; GrossDiv: Decimal; DivWHoldingTax: Decimal; NetDiv: Decimal; DivEndDate: Date; DivStartDate: Date; DivCalcMethod: Option " ","Flat Rate",Prorated; PayMode: Code[20]; EmpCode: Code[20]);
    var
        // CustMembr: Record Members;
        DivYear: Integer;
        DividendProgression: record "Dividend Progression";
        EntrNo: Integer;
    begin
        // TODO: Review this call
        // if CustMembr.Get(MemberNo) then begin
        //** IF CustMembr."Dividend Action"=CustMembr."Dividend Action"::Pay THEN 
        DividendProgression.Reset();
        DividendProgression.SetCurrentKey("Entry No.");
        if DividendProgression.FindLast() then
            EntrNo := DividendProgression."Entry No." + 1;
        DividendProgression.Init;
        DividendProgression."Entry No." := EntrNo;
        DividendProgression."Account No" := AccountNo;
        DividendProgression."Processing Date" := ProcessingDate;
        DividendProgression."Product Type" := ProductID;
        DividendProgression."Product Name" := PadStr(ProductName, 20);
        DividendProgression."Member No" := MemberNo;
        DividendProgression."Qualifying Shares" := QualifyingShares;
        DividendProgression.Shares := DivShares;
        DividendProgression."Gross Dividends" := GrossDiv;
        DividendProgression."Witholding Tax" := DivWHoldingTax;
        DividendProgression."Net Dividends" := NetDiv;
        DividendProgression."Start Date" := DivStartDate;
        DividendProgression."End Date" := DivEndDate;
        DividendProgression."Dividend Calc. Method" := DivCalcMethod;
        DividendProgression.Month := Date2DMY(DivEndDate, 2);
        DividendProgression."Month Name" := Format(DivEndDate, 0, '<Month Text>');
        DividendProgression."Payment Mode" := PayMode;
        DividendProgression.Forfeited := false;
        DividendProgression."Employer Code" := EmpCode;
        //DivYear := DATE2DWY(20220101D,3);
        //MESSAGE(FORMAT(DivYear));
        DividendProgression.Year := Date2dmy(DivStartDate, 3);
        DividendProgression.Posted := true;
        //MESSAGE('StartDate %1, Year %2',StartDate,DividendProgression.Year);
        if DividendProgression."Qualifying Shares" <> 0 then
            DividendProgression.Insert;
        //**END;
        // end;
    end;


    var
        SavAcc: Record "Savings Accounts";
        DivCalcMethod: Option " ","Flat Rate",Prorated;
}
