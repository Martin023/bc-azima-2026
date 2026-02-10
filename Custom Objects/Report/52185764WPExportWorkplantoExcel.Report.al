#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185764 "W/P Export Workplan to Excel"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Workplan Entry"; "Workplan Entry")
        {
            DataItemTableView = sorting("Workplan Code", "Activity Code", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Budget Dimension 1 Code", "Budget Dimension 2 Code", "Budget Dimension 3 Code", "Budget Dimension 4 Code", Date);
            RequestFilterFields = "Workplan Code", "Activity Code", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Budget Dimension 1 Code", "Budget Dimension 2 Code", "Budget Dimension 3 Code", "Budget Dimension 4 Code", Date;
            column(ReportForNavId_3459; 3459)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(TempBudgetBuf1);
                TempBudgetBuf1."Workplan Code" := "G/L Account No.";
                TempBudgetBuf1."Dimension Value Code 1" := GetDimValueCode(ColumnDimCode[1]);
                TempBudgetBuf1."Dimension Value Code 2" := GetDimValueCode(ColumnDimCode[2]);
                TempBudgetBuf1."Dimension Value Code 3" := GetDimValueCode(ColumnDimCode[3]);
                TempBudgetBuf1."Dimension Value Code 4" := GetDimValueCode(ColumnDimCode[4]);
                TempBudgetBuf1."Dimension Value Code 5" := GetDimValueCode(ColumnDimCode[5]);
                TempBudgetBuf1."Dimension Value Code 6" := GetDimValueCode(ColumnDimCode[6]);
                TempBudgetBuf1."Dimension Value Code 7" := GetDimValueCode(ColumnDimCode[7]);
                TempBudgetBuf1."Dimension Value Code 8" := GetDimValueCode(ColumnDimCode[8]);
                TempBudgetBuf1.Date := CalcPeriodStart(Date);
                TempBudgetBuf1.Amount := Amount;

                TempBudgetBuf2 := TempBudgetBuf1;
                if TempBudgetBuf2.Find then begin
                    TempBudgetBuf2.Amount :=
                      TempBudgetBuf2.Amount + TempBudgetBuf1.Amount;
                    TempBudgetBuf2.Modify;
                end else
                    TempBudgetBuf2.Insert;
            end;

            trigger OnPostDataItem()
            var
                DimValue: Record "Dimension Value";
                BusUnit: Record "Business Unit";
                Window: Dialog;
                RecNo: Integer;
                TotalRecNo: Integer;
                Continue: Boolean;
                LastBudgetRowNo: Integer;
                DimensionRange: array[2, 8] of Integer;
            begin
                Window.Open(
                  Text005 +
                  '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
                Window.Update(1, 0);
                TotalRecNo := GLAcc.Count;
                RecNo := 0;

                RowNo := 1;
                EnterCell(RowNo, 1, Text006, false, true, '', ExcelBuf."cell type"::Text);
                EnterCell(RowNo, 2, '', false, true, '', ExcelBuf."cell type"::Text);
                // EnterFilterInCell(UnknownTable52185985.GetFilter("Workplan Code"),UnknownTable52185985.FieldCaption("Workplan Code"));

                // GLSetup.Get;
                // EnterFilterInCell(UnknownTable52185985.GetFilter("Business Unit Code"),UnknownTable52185985.FieldCaption("Business Unit Code"));
                // if GLSetup."Global Dimension 1 Code" <> '' then begin
                //   Dim.Get(GLSetup."Global Dimension 1 Code");
                //   EnterFilterInCell(UnknownTable52185985.GetFilter("Global Dimension 1 Code"),Dim."Code Caption");
                // end;
                // if GLSetup."Global Dimension 2 Code" <> '' then begin
                //   Dim.Get(GLSetup."Global Dimension 2 Code");
                //   EnterFilterInCell(UnknownTable52185985.GetFilter("Global Dimension 2 Code"),Dim."Code Caption");
                // end;
                // GLBudgetName.Get(UnknownTable52185985.GetFilter("Workplan Code"));
                // if GLBudgetName."Budget Dimension 1 Code" <> '' then begin
                //   Dim.Get(GLBudgetName."Budget Dimension 1 Code");
                //   EnterFilterInCell(UnknownTable52185985.GetFilter("Budget Dimension 1 Code"),Dim."Code Caption");
                // end;
                // if GLBudgetName."Budget Dimension 2 Code" <> '' then begin
                //   Dim.Get(GLBudgetName."Budget Dimension 2 Code");
                //   EnterFilterInCell(UnknownTable52185985.GetFilter("Budget Dimension 2 Code"),Dim."Code Caption");
                // end;
                // if GLBudgetName."Budget Dimension 3 Code" <> '' then begin
                //   Dim.Get(GLBudgetName."Budget Dimension 3 Code");
                //   EnterFilterInCell(UnknownTable52185985.GetFilter("Budget Dimension 3 Code"),Dim."Code Caption");
                // end;
                // if GLBudgetName."Budget Dimension 4 Code" <> '' then begin
                //   Dim.Get(GLBudgetName."Budget Dimension 4 Code");
                //   EnterFilterInCell(UnknownTable52185985.GetFilter("Budget Dimension 4 Code"),Dim."Code Caption");
                // end;

                RowNo := RowNo + 2;
                HeaderRowNo := RowNo;
                //EnterCell(HeaderRowNo,1,UnknownTable52185985.FieldCaption("G/L Account No."),false,true,'',ExcelBuf."cell type"::Text);
                EnterCell(HeaderRowNo, 2, GLAcc.FieldCaption("Activity Description"), false, true, '', ExcelBuf."cell type"::Text);
                i := 0;
                ColNo := 2;
                Continue := true;
                while Continue do begin
                    i := i + 1;
                    if i > 8 then
                        Continue := false
                    else
                        if ColumnDimCode[i] = '' then
                            Continue := false;
                    if Continue then begin
                        ColNo := ColNo + 1;
                        if i = BusUnitDimIndex then
                            EnterCell(HeaderRowNo, ColNo, BusUnit.TableCaption, false, true, '', ExcelBuf."cell type"::Text)
                        else begin
                            Dim.Get(ColumnDimCode[i]);
                            EnterCell(HeaderRowNo, ColNo, Dim."Code Caption", false, true, '', ExcelBuf."cell type"::Text);
                        end;
                    end;
                end;
                if TempPeriod.Find('-') then
                    repeat
                        ColNo := ColNo + 1;
                        EnterCell(HeaderRowNo, ColNo, Format(TempPeriod."Period Start"), false, true, '', ExcelBuf."cell type"::Date);
                    until TempPeriod.Next = 0;

                "Workplan Entry".Copyfilter("G/L Account No.", GLAcc."No.");
                if GLAcc.Find('-') then
                    repeat
                        RecNo := RecNo + 1;
                        Window.Update(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                        RowNo := RowNo + 1;
                        EnterCell(
                          RowNo, 2, CopyStr(CopyStr(PadStr(' ', 100), 1, 2 * GLAcc.Indentation + 1) + GLAcc."Activity Description", 2),
                          GLAcc."Account Type" <> GLAcc."account type"::Posting, false, '', ExcelBuf."cell type"::Text);
                        EnterCell(
                          RowNo, 1, GLAcc."No.", GLAcc."Account Type" <> GLAcc."account type"::Posting, false, '', ExcelBuf."cell type"::Text);
                        if (GLAcc.Totaling = '') or (not IncludeTotalingFormulas) then begin
                            TempBudgetBuf2.SetRange("Workplan Code", GLAcc."No.");
                            if TempBudgetBuf2.Find('-') then begin
                                TempBudgetBuf1 := TempBudgetBuf2;
                                EnterDimValues;
                                if TempPeriod.Find('-') then;
                                repeat
                                    if (TempBudgetBuf1."Dimension Value Code 1" <>
                                        TempBudgetBuf2."Dimension Value Code 1") or
                                       (TempBudgetBuf1."Dimension Value Code 2" <>
                                        TempBudgetBuf2."Dimension Value Code 2") or
                                       (TempBudgetBuf1."Dimension Value Code 3" <>
                                        TempBudgetBuf2."Dimension Value Code 3") or
                                       (TempBudgetBuf1."Dimension Value Code 4" <>
                                        TempBudgetBuf2."Dimension Value Code 4") or
                                       (TempBudgetBuf1."Dimension Value Code 5" <>
                                        TempBudgetBuf2."Dimension Value Code 5") or
                                       (TempBudgetBuf1."Dimension Value Code 6" <>
                                        TempBudgetBuf2."Dimension Value Code 6") or
                                       (TempBudgetBuf1."Dimension Value Code 7" <>
                                        TempBudgetBuf2."Dimension Value Code 7") or
                                       (TempBudgetBuf1."Dimension Value Code 8" <>
                                        TempBudgetBuf2."Dimension Value Code 8")
                                    then begin
                                        RowNo := RowNo + 1;
                                        EnterCell(
                                          RowNo, 1, GLAcc."No.", GLAcc."Account Type" <> GLAcc."account type"::Posting, false, '', ExcelBuf."cell type"::Text);
                                        EnterDimValues;
                                        TempBudgetBuf1 := TempBudgetBuf2;
                                    end;
                                    TempPeriod.Get(0, TempBudgetBuf2.Date);
                                    EnterCell(
                                      RowNo, NoOfDimensions + 2 + TempPeriod."Period No.",
                                      Format(TempBudgetBuf2.Amount, 0, 1), GLAcc."Account Type" <> GLAcc."account type"::Posting,
                                      false, '#,##0.00', ExcelBuf."cell type"::Number);
                                    TempPeriod.Next;
                                until TempBudgetBuf2.Next = 0;
                            end else begin
                                Clear(TempBudgetBuf2);
                                EnterDimValues;
                            end;
                        end else
                            if TempPeriod.Find('-') then begin
                                repeat
                                    EnterFormula(
                                      RowNo,
                                      NoOfDimensions + 2 + TempPeriod."Period No.",
                                      GLAcc.Totaling,
                                      GLAcc."Account Type" <> GLAcc."account type"::Posting,
                                      false,
                                      '#,##0.00');
                                until TempPeriod.Next = 0;
                            end;
                    until GLAcc.Next = 0;
                if IncludeTotalingFormulas then
                    HasFormulaError := ExcelBuf.ExportBudgetFilterToFormula(ExcelBuf);
                Window.Close;
                LastBudgetRowNo := RowNo;

                RowNo := RowNo + 200; // Move way below the budget
                for i := 1 to NoOfDimensions do
                    if i = BusUnitDimIndex then begin
                        if BusUnit.FindSet then begin
                            DimensionRange[1, i] := RowNo;
                            repeat
                                EnterCell(RowNo, 1, BusUnit.Code, false, false, '', ExcelBuf."cell type"::Text);
                                RowNo := RowNo + 1;
                            until BusUnit.Next = 0;
                            DimensionRange[2, i] := RowNo - 1;
                        end;
                    end else begin
                        DimValue.SetRange("Dimension Code", ColumnDimCode[i]);
                        DimValue.SetFilter("Dimension Value Type", '%1|%2',
                          DimValue."dimension value type"::Standard, DimValue."dimension value type"::"Begin-Total");
                        if DimValue.FindSet(false, false) then begin
                            DimensionRange[1, i] := RowNo;
                            repeat
                                EnterCell(RowNo, 1, DimValue.Code, false, false, '', ExcelBuf."cell type"::Text);
                                RowNo := RowNo + 1;
                            until DimValue.Next = 0;
                            DimensionRange[2, i] := RowNo - 1;
                        end;
                    end;

                if HasFormulaError then
                    if not Confirm(StrSubstNo(Text007, ExcelBuf.GetExcelReference(7))) then
                        CurrReport.Break;

                //ExcelBuf.CreateBook(ExcelBuf.GetExcelReference(10),'WORKPLAN SHEET');
                ExcelBuf.SetCurrent(HeaderRowNo + 1, 1);
                ExcelBuf.StartRange;
                ExcelBuf.SetCurrent(LastBudgetRowNo, 1);
                ExcelBuf.EndRange;
                ExcelBuf.CreateRange(ExcelBuf.GetExcelReference(8));
                if TempPeriod.Find('-') then begin
                    repeat
                        ExcelBuf.SetCurrent(HeaderRowNo + 1, NoOfDimensions + 2 + TempPeriod."Period No.");
                        ExcelBuf.StartRange;
                        ExcelBuf.SetCurrent(LastBudgetRowNo, NoOfDimensions + 2 + TempPeriod."Period No.");
                        ExcelBuf.EndRange;
                        ExcelBuf.CreateRange(ExcelBuf.GetExcelReference(9) + '_' + Format(TempPeriod."Period No."));
                    until TempPeriod.Next = 0;
                end;

                for i := 1 to NoOfDimensions do begin
                    ExcelBuf.SetCurrent(HeaderRowNo + 1, i + 2);
                    ExcelBuf.StartRange;
                    ExcelBuf.SetCurrent(LastBudgetRowNo, i + 2);
                    ExcelBuf.EndRange;
                    ExcelBuf.CreateRange('NAV_DIM' + Format(i));
                    ExcelBuf.SetCurrent(DimensionRange[1, i], 1);
                    ExcelBuf.StartRange;
                    ExcelBuf.SetCurrent(DimensionRange[2, i], 1);
                    ExcelBuf.EndRange;
                    //ExcelBuf.CreateValidationRule('NAV_DIM' + Format(i));
                end;

                ExcelBuf.WriteSheet(
                  PadStr(StrSubstNo('%1 %2', GLBudgetName."Workplan Code", GLBudgetName."Workplan Description"), 30),
                  COMPANYNAME,
                  UserId);

                ExcelBuf.CloseBook;
                ExcelBuf.OpenExcel;
                // ExcelBuf.GiveUserControl;
            end;

            trigger OnPreDataItem()
            var
                BusUnit: Record "Business Unit";
            begin
                // if UnknownTable52185985.GetRangeMin("Workplan Code") <> UnknownTable52185985.GetRangemax("Workplan Code") then
                //   Error(Text001);

                if (StartDate = 0D) or
                   (NoOfPeriods = 0) or
                   (Format(PeriodLength) = '')
                then
                    Error(Text002);

                SelectedDim.Reset;
                SelectedDim.SetRange("User ID", UserId);
                SelectedDim.SetRange("Object Type", 3);
                SelectedDim.SetRange("Object ID", Report::"Export Budget to Excel");
                i := 0;
                if BusUnit.FindFirst then begin
                    i := i + 1;
                    BusUnitDimIndex := i;
                    BusUnitDimCode := CopyStr(UpperCase(BusUnit.TableCaption), 1, MaxStrLen(ColumnDimCode[1]));
                    ColumnDimCode[BusUnitDimIndex] := BusUnitDimCode;
                end;
                if SelectedDim.Find('-') then
                    repeat
                        i := i + 1;
                        if i > ArrayLen(ColumnDimCode) then
                            Error(Text003, ArrayLen(ColumnDimCode));
                        ColumnDimCode[i] := SelectedDim."Dimension Code";
                    until (SelectedDim.Next = 0) or (i = 8);
                NoOfDimensions := i;

                for i := 1 to NoOfPeriods do begin
                    if i = 1 then
                        TempPeriod."Period Start" := StartDate
                    else
                        TempPeriod."Period Start" := CalcDate(PeriodLength, TempPeriod."Period Start");
                    TempPeriod."Period End" := CalcDate(PeriodLength, TempPeriod."Period Start");
                    TempPeriod."Period End" := CalcDate('<-1D>', TempPeriod."Period End");
                    TempPeriod."Period No." := i;
                    TempPeriod.Insert;
                end;

                //UnknownTable52185985.SetRange(Date,StartDate,TempPeriod."Period End");
                TempBudgetBuf2.DeleteAll;
                ExcelBuf.DeleteAll;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Start Date';
                    }
                    field(NoOfPeriods; NoOfPeriods)
                    {
                        ApplicationArea = Basic;
                        Caption = 'No. of Periods';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period Length';
                    }
                    field(ColumnDim; ColumnDim)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Column Dimensions';
                        Editable = false;

                        trigger OnAssistEdit()
                        begin
                            DimSelectionBuf.SetDimSelectionMultiple(3, Report::"Export Budget to Excel", ColumnDim);
                        end;
                    }
                    field(IncludeTotalingFormulas; IncludeTotalingFormulas)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Totaling Formulas';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            ColumnDim := DimSelectionBuf.GetDimSelectionText(3, Report::"Export Budget to Excel", '');
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        DimSelectionBuf.CompareDimText(
          3, Report::"Export Budget to Excel", '', ColumnDim, Text000);
    end;

    var
        Text000: label 'Column Dimensions';
        Text001: label 'You can only export one budget at a time.';
        Text002: label 'You must specify a Start Date, a No of Periods and a Period Length.';
        Text003: label 'You can only select a maximum of %1 column dimensions.';
        Text005: label 'Analyzing Data...\\';
        Text006: label 'Export Filters';
        Text007: label 'Some filters cannot be converted into Excel formulas. You will have to check %1 errors in the Excel worksheet. Do you want to create the Excel worksheet ?';
        TempPeriod: Record Date temporary;
        SelectedDim: Record "Selected Dimension";
        TempBudgetBuf1: Record "W/P Budget Buffer" temporary;
        TempBudgetBuf2: Record "W/P Budget Buffer" temporary;
        DimSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        Dim: Record Dimension;
        GLBudgetName: Record Workplan;
        ExcelBuf: Record "Excel Buffer" temporary;
        GLAcc: Record "Workplan Activities";
        DimSelectionBuf: Record "Dimension Selection Buffer";
        StartDate: Date;
        PeriodLength: DateFormula;
        NoOfPeriods: Integer;
        NoOfDimensions: Integer;
        i: Integer;
        RowNo: Integer;
        ColNo: Integer;
        ColumnDim: Text[250];
        ColumnDimCode: array[8] of Code[20];
        HasFormulaError: Boolean;
        IncludeTotalingFormulas: Boolean;
        HeaderRowNo: Integer;
        BusUnitDimIndex: Integer;
        BusUnitDimCode: Code[20];

    local procedure CalcPeriodStart(EntryDate: Date): Date
    begin
        TempPeriod."Period Start" := EntryDate;
        TempPeriod.Find('=<');
        exit(TempPeriod."Period Start");
    end;

    local procedure GetDimValueCode(DimCode: Code[20]): Code[20]
    begin
        if DimCode = '' then
            exit('');
        if DimCode = BusUnitDimCode then
            exit("Workplan Entry"."Business Unit Code");
        DimSetEntry.SetRange("Dimension Set ID", "Workplan Entry"."Dimension Set ID");
        DimSetEntry.SetRange("Dimension Code", DimCode);
        if DimSetEntry.FindFirst then
            exit(DimSetEntry."Dimension Value Code");
        exit('');
    end;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30]; CellType: Option)
    begin
        ExcelBuf.Init;
        ExcelBuf.Validate("Row No.", RowNo);
        ExcelBuf.Validate("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text" := CellValue;
        ExcelBuf.Formula := '';
        ExcelBuf.Bold := Bold;
        ExcelBuf.Underline := UnderLine;
        ExcelBuf.NumberFormat := NumberFormat;
        ExcelBuf."Cell Type" := CellType;
        ExcelBuf.Insert;
    end;

    local procedure EnterFilterInCell("Filter": Text[250]; FieldName: Text[100])
    begin
        if Filter <> '' then begin
            RowNo := RowNo + 1;
            EnterCell(RowNo, 1, FieldName, false, false, '', ExcelBuf."cell type"::Text);
            EnterCell(RowNo, 2, Filter, false, false, '', ExcelBuf."cell type"::Text);
        end;
    end;

    local procedure EnterDimValue(ColDimIndex: Integer; DimValueCode: Code[20])
    begin
        if ColumnDimCode[ColDimIndex] <> '' then begin
            ColNo := ColNo + 1;
            EnterCell(RowNo, ColNo, DimValueCode, false, false, '', ExcelBuf."cell type"::Text);
        end;
    end;

    local procedure EnterDimValues()
    begin
        ColNo := 2;
        EnterDimValue(1, TempBudgetBuf2."Dimension Value Code 1");
        EnterDimValue(2, TempBudgetBuf2."Dimension Value Code 2");
        EnterDimValue(3, TempBudgetBuf2."Dimension Value Code 3");
        EnterDimValue(4, TempBudgetBuf2."Dimension Value Code 4");
        EnterDimValue(5, TempBudgetBuf2."Dimension Value Code 5");
        EnterDimValue(6, TempBudgetBuf2."Dimension Value Code 6");
        EnterDimValue(7, TempBudgetBuf2."Dimension Value Code 7");
        EnterDimValue(8, TempBudgetBuf2."Dimension Value Code 8");
    end;

    local procedure EnterFormula(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30])
    begin
        ExcelBuf.Init;
        ExcelBuf.Validate("Row No.", RowNo);
        ExcelBuf.Validate("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text" := '';
        ExcelBuf.Formula := CellValue; // is converted to formula later.
        ExcelBuf.Bold := Bold;
        ExcelBuf.Underline := UnderLine;
        ExcelBuf.NumberFormat := NumberFormat;
        ExcelBuf.Insert;
    end;
}
