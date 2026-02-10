#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185601 "Payroll Summary RED"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Payroll Summary RED.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Current Month Filter", "Location/Division Code", "Department Code", "Cost Center Code", "Salary Grade", "Salary Notch/Step", "Posting Group";
            column(ReportForNavId_8631; 8631)
            {
            }
            // column(GETFILTERS; "HR Employees".GetFilters)
            // {
            // }
            column(USERID; UserId)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(cHeader_1_; cHeader[1])
            {
            }
            column(cHeader_2_; cHeader[2])
            {
            }
            column(cHeader_3_; cHeader[3])
            {
            }
            column(cHeader_7_; cHeader[7])
            {
            }
            column(cHeader_6_; cHeader[6])
            {
            }
            column(cHeader_5_; cHeader[5])
            {
            }
            column(cHeader_4_; cHeader[4])
            {
            }
            column(cHeader_11_; cHeader[11])
            {
            }
            column(cHeader_10_; cHeader[10])
            {
            }
            column(cHeader_9_; cHeader[9])
            {
            }
            column(cHeader_8_; cHeader[8])
            {
            }
            column(cHeader_12_; cHeader[12])
            {
            }
            column(cHeader_13_; cHeader[13])
            {
            }
            column(cHeader_14_; cHeader[14])
            {
            }
            column(cHeader_15_; cHeader[15])
            {
            }
            column(cHeader_17_; cHeader[17])
            {
            }
            column(cHeader_16_; cHeader[16])
            {
            }
            column(cHeader_18_; cHeader[18])
            {
            }
            column(cHeader_19_; cHeader[19])
            {
            }
            column(cHeader_20_; cHeader[20])
            {
            }
            column(cHeader_21_; cHeader[21])
            {
            }
            column(cHeader_22_; cHeader[22])
            {
            }
            column(cHeader_23_; cHeader[23])
            {
            }
            column(cHeader_24_; cHeader[24])
            {
            }
            column(cHeader_25_; cHeader[25])
            {
            }
            column(strEmpName; strEmpName)
            {
            }
            column(HR_Employee__HR_Employee___No__; "HR Employees"."No.")
            {
            }
            column(cValue_1_; cValue[1])
            {
            }
            column(cValue_2_; cValue[2])
            {
            }
            column(cValue_3_; cValue[3])
            {
            }
            column(cValue_6_; cValue[6])
            {
            }
            column(cValue_5_; cValue[5])
            {
            }
            column(cValue_4_; cValue[4])
            {
            }
            column(cValue_9_; cValue[9])
            {
            }
            column(cValue_8_; cValue[8])
            {
            }
            column(cValue_7_; cValue[7])
            {
            }
            column(cValue_11_; cValue[11])
            {
            }
            column(cValue_12_; cValue[12])
            {
            }
            column(cValue_13_; cValue[13])
            {
            }
            column(cValue_14_; cValue[14])
            {
            }
            column(cValue_15_; cValue[15])
            {
            }
            column(cValue_10_; cValue[10])
            {
            }
            column(cValue_19_; cValue[19])
            {
            }
            column(cValue_18_; cValue[18])
            {
            }
            column(cValue_17_; cValue[17])
            {
            }
            column(cValue_16_; cValue[16])
            {
            }
            column(cValue_20_; cValue[20])
            {
            }
            column(cValue_21_; cValue[21])
            {
            }
            column(cValue_22_; cValue[22])
            {
            }
            column(cValue_23_; cValue[23])
            {
            }
            column(cValue_24_; cValue[24])
            {
            }
            column(cValue_25_; cValue[25])
            {
            }
            column(HR_Employee__Department_Code_; "Department Code")
            {
            }
            column(cValue_19__Control1102755024; cValue[19])
            {
            }
            column(cValue_18__Control1102755029; cValue[18])
            {
            }
            column(cValue_17__Control1102755030; cValue[17])
            {
            }
            column(cValue_16__Control1102755031; cValue[16])
            {
            }
            column(cValue_15__Control1102755052; cValue[15])
            {
            }
            column(cValue_14__Control1102755053; cValue[14])
            {
            }
            column(cValue_13__Control1102755054; cValue[13])
            {
            }
            column(cValue_12__Control1102755055; cValue[12])
            {
            }
            column(cValue_11__Control1102755056; cValue[11])
            {
            }
            column(cValue_10__Control1102755057; cValue[10])
            {
            }
            column(cValue_9__Control1102755058; cValue[9])
            {
            }
            column(cValue_8__Control1102755059; cValue[8])
            {
            }
            column(cValue_7__Control1102755060; cValue[7])
            {
            }
            column(cValue_6__Control1102755061; cValue[6])
            {
            }
            column(cValue_5__Control1102755062; cValue[5])
            {
            }
            column(cValue_4__Control1102755063; cValue[4])
            {
            }
            column(cValue_3__Control1102755064; cValue[3])
            {
            }
            column(cValue_2__Control1102755065; cValue[2])
            {
            }
            column(cValue_1__Control1102755066; cValue[1])
            {
            }
            column(RCount; RCount)
            {
            }
            column(cValue_21__Control1102755086; cValue[21])
            {
            }
            column(cValue_20__Control1102755071; cValue[20])
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(Employee_CodeCaption; Employee_CodeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Payroll_SummaryCaption; Payroll_SummaryCaptionLbl)
            {
            }
            column(HR_Employee__Department_Code_Caption; "HR EMPLOYEES".FieldCaption("Department Code"))
            {
            }
            column(Prepared_by_Caption; Prepared_by_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755072; EmptyStringCaption_Control1102755072Lbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Signature_and_DateCaption; Signature_and_DateCaptionLbl)
            {
            }
            column(Signature_and_DateCaption_Control1102755076; Signature_and_DateCaption_Control1102755076Lbl)
            {
            }
            column(NameCaption_Control1102755077; NameCaption_Control1102755077Lbl)
            {
            }
            column(Authorised_by_Caption; Authorised_by_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755079; EmptyStringCaption_Control1102755079Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755080; EmptyStringCaption_Control1102755080Lbl)
            {
            }
            column(Signature_and_DateCaption_Control1102755081; Signature_and_DateCaption_Control1102755081Lbl)
            {
            }
            column(NameCaption_Control1102755082; NameCaption_Control1102755082Lbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755084; EmptyStringCaption_Control1102755084Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755085; EmptyStringCaption_Control1102755085Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                strEmpName := "Last Name" + ' ' + "First Name" + ' ' + "Middle Name";
                EmployeeCode := "HR Employees"."No.";
                SalCard.Get("No.");

                i := 1;
                repeat
                    i := i + 1;
                    cValue[i] := 0;
                until i = 30;

                PeriodTrans.Reset;
                PeriodTrans.SetFilter("Payroll Period", "HR Employees".GetFilter("Current Month Filter"));
                PeriodTrans.SetFilter("Employee Code", "HR Employees"."No.");
                if PeriodTrans.Find('-') then
                    repeat
                        //Basic Pay
                        if PeriodTrans."Transaction Code" = 'BPAY' then begin
                            cHeader[1] := 'Basic Pay ' + PeriodTrans."Employee Classification";
                            cValue[1] := PeriodTrans.Amount;
                        end;

                        //Housing
                        cHeader[2] := 'Housing ' + PeriodTrans."Employee Classification";
                        if PeriodTrans."Transaction Code" = 'HSE-EX' then begin
                            cValue[2] := cValue[2] + PeriodTrans.Amount;
                        end;

                        cHeader[3] := 'Transport ' + PeriodTrans."Employee Classification";
                        //Transport
                        if PeriodTrans."Transaction Code" = 'TRANS-EX' then begin
                            cValue[3] := cValue[3] + PeriodTrans.Amount;
                        end;

                        //Entertainment
                        if PeriodTrans."Transaction Code" = 'COLA' then begin
                            cHeader[4] := 'COLA';
                            cValue[4] := cValue[4] + PeriodTrans.Amount;
                        end;

                        //Leave
                        if PeriodTrans."Transaction Code" = 'LEAVE2' then begin
                            cHeader[5] := 'Leave';
                            cValue[5] := cValue[5] + PeriodTrans.Amount;
                        end;

                        //Utility
                        if PeriodTrans."Transaction Code" = 'MAINT' then begin
                            cHeader[6] := 'Maintenance';
                            cValue[6] := cValue[6] + PeriodTrans.Amount;
                        end;


                        //Bonus Special
                        if PeriodTrans."Transaction Code" = 'LUNCH' then begin
                            cHeader[7] := 'Lunch';
                            cValue[7] := cValue[7] + PeriodTrans.Amount;
                        end;
                        /*
                        //Inconvinience
                        cHeader[8]:='Inconvinience';
                        IF PeriodTrans."Transaction Category" = PeriodTrans."Transaction Category"::Inconvinience THEN BEGIN
                        cValue[8]:=cValue[8]+PeriodTrans."Curr. Amount";
                        END;


                        //Bonus Special
                        cHeader[9]:='Bonus Special';
                        IF PeriodTrans."Transaction Category" = PeriodTrans."Transaction Category"::"Bonus Special" THEN BEGIN
                        cValue[9]:=cValue[9]+PeriodTrans."Curr. Amount";
                        END;
                        */
                        //Gross Pay
                        //IF PeriodTrans."Transaction Code" = 'GPAY' THEN
                        begin
                            cHeader[10] := 'Gross Pay';
                            //cValue[10]:=PeriodTrans.amount;
                            cValue[10] := cValue[4] + cValue[5] + cValue[6] + cValue[7];
                        end;

                        begin
                            cHeader[11] := 'Gross Pay ' + SalCard.Currency;
                            cValue[11] := cValue[1] + cValue[2] + cValue[3];
                        end;

                        /*
                        //Taxable Pay
                        IF PeriodTrans."Transaction Code" = 'TXBP' THEN BEGIN
                        cHeader[11]:='Taxable Pay';
                        cValue[11]:=PeriodTrans.amount;
                        END;
                        */
                        //Gross Pay
                        if PeriodTrans."Transaction Code" = 'PAYE' then begin
                            cHeader[12] := 'P.A.Y.E';
                            cValue[12] := PeriodTrans.Amount;
                        end;


                        //NHF
                        cHeader[13] := 'PAYE ' + PeriodTrans."Employee Classification";
                        if PeriodTrans."Transaction Code" = 'PAYE-EX' then begin
                            cValue[13] := PeriodTrans.Amount;
                        end;

                        TransSet.SetRange(TransSet."Transaction Code", PeriodTrans."Transaction Code");
                        if TransSet.FindFirst then begin
                            // IF TransSet."Other Transaction" = TRUE THEN BEGIN
                            // cValue[25]+= PeriodTrans.State;
                            // cHeader[25]:='OtherDeductions';
                            // END;
                        end;

                        //Pension
                        // IF PeriodTrans."Transaction Code" = 'PENS2-EX' THEN BEGIN
                        // cHeader[14]:='Pension ' + PeriodTrans."Employee Classification";
                        // cValue[14]:=cValue[14]+PeriodTrans.State;
                        // END;
                        /*
                        //Surcharge
                        cHeader[15]:='Comp. Loan';//PKK'Surcharge';
                        IF PeriodTrans."Transaction Category" = PeriodTrans."Transaction Category"::"Compassionate Loan" THEN BEGIN
                        cValue[15]:=cValue[15]+PeriodTrans."Curr. Amount";
                        END;

                        //Housing Deduction
                        cHeader[16]:='Housing Loan';
                        IF PeriodTrans."Transaction Category" = PeriodTrans."Transaction Category"::"Housing Deduction" THEN BEGIN
                        cValue[16]:=cValue[16]+PeriodTrans."Curr. Amount";
                        END;

                        //Personal Loan
                        cHeader[17]:='Personal Loan';
                        IF PeriodTrans."Transaction Code" = '' THEN BEGIN
                        cValue[17]:=cValue[17]+PeriodTrans."Curr. Amount";
                        END;
                        */
                        //Other Co-Deductions
                        //IF PeriodTrans."Transaction Category" = PeriodTrans."Transaction Category"::"Other Co-deductions" THEN
                        begin
                            cHeader[18] := 'Deductions';
                            cValue[18] := cValue[12];
                        end;


                        //Other Deductions
                        //IF PeriodTrans."Transaction Code" = 'TOT-DED' THEN
                        begin
                            cHeader[19] := 'Deductions ' + SalCard.Currency;
                            cValue[19] := cValue[13] + cValue[14];
                        end;


                        //Net Pay
                        //IF PeriodTrans."Transaction Code" = 'NPAY' THEN
                        begin
                            cHeader[20] := 'Net Pay';
                            //cValue[20]:=PeriodTrans.amount;
                            cValue[20] := cValue[10] - cValue[18];
                        end;

                        //Net Pay
                        //IF PeriodTrans."Transaction Code" = 'BPAY' THEN
                        begin
                            cHeader[21] := 'Net Pay - ' + SalCard.Currency;
                            cValue[21] := cValue[1] + cValue[2] + cValue[3] - cValue[13] - cValue[14] - cValue[25];
                        end;

                        //Basic Pay Full
                        cHeader[22] := 'Basic Pay -' + SalCard.Currency;
                        cValue[22] := SalCard."Basic Pay";

                    //Abs
                    // IF PeriodTrans."Transaction Code" = 'ABS' THEN BEGIN
                    // cHeader[23]:='Absentism';
                    // cValue[23]:=PeriodTrans.State;
                    // END;

                    //NHF
                    // IF PeriodTrans."Transaction Code" = 'LATENESS' THEN BEGIN
                    // cHeader[24]:='Lateness';
                    // cValue[24]:=PeriodTrans.State;
                    // END;



                    until PeriodTrans.Next = 0;

                if (cValue[1] = 0) then
                    CurrReport.Skip;

                if PrintToExcel then begin
                    if HeaderCreated = false then begin
                        MakeExcelDataHeader;
                        HeaderCreated := true;
                    end;
                end;

                if PrintToExcel then
                    MakeExcelDataBody;


                RCount := RCount + 1;

            end;

            trigger OnPreDataItem()
            begin
                if "HR Employees".GetFilter("HR Employees"."Current Month Filter") = '' then
                    Error('You must specify current Period filter.');

                CurrReport.CreateTotals(cValue[1], cValue[2], cValue[3], cValue[4], cValue[5], cValue[6], cValue[7], cValue[8], cValue[9], cValue[10]);
                CurrReport.CreateTotals(cValue[11], cValue[12], cValue[13], cValue[14], cValue[15], cValue[16], cValue[17]);
                CurrReport.CreateTotals(cValue[18], cValue[19], cValue[20]);

                RCount := 0;

                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        if PrintToExcel then
            MakeExcelTotalBody;


        if PrintToExcel then
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        //IF PrintToExcel THEN
        //  MakeExcelInfo;
    end;

    var
        strEmpName: Text[100];
        cHeader: array[200] of Text[200];
        cValue: array[200] of Decimal;
        Trans: Record "PR Transaction Codes";
        ColNo: Integer;
        i: Integer;
        RCount: Integer;
        PrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        Text000: label 'Not Due';
        Text001: label 'Before';
        Text002: label 'days';
        Text003: label 'More than';
        Text004: label 'Aged by %1';
        Text005: label 'Total for %1';
        Text006: label 'Aged as of %1';
        Text007: label 'Aged by %1';
        Text008: label 'All Amounts in LCY';
        Text009: label 'Due Date,Posting Date,Document Date';
        Text010: label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        Text011: label 'Data';
        Text012: label 'Aged Accounts Receivable';
        Text013: label 'Company Name';
        Text014: label 'Report No.';
        Text015: label 'Report Name';
        Text016: label 'User ID';
        Text017: label 'Date';
        Text018: label 'Filters';
        Emp: Record "HR Employees";
        HeaderCreated: Boolean;
        EmployeeCode: Code[20];
        CompanyInfo: Record "Company Information";
        Employee_NameCaptionLbl: label 'Employee Name';
        Employee_CodeCaptionLbl: label 'Employee Code';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Payroll_SummaryCaptionLbl: label 'Payroll Summary';
        Prepared_by_CaptionLbl: label 'Prepared by:';
        EmptyStringCaptionLbl: label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755072Lbl: label '......................................................................................................................................................';
        NameCaptionLbl: label 'Name';
        Signature_and_DateCaptionLbl: label 'Signature and Date';
        Signature_and_DateCaption_Control1102755076Lbl: label 'Signature and Date';
        NameCaption_Control1102755077Lbl: label 'Name';
        Authorised_by_CaptionLbl: label 'Authorised by:';
        EmptyStringCaption_Control1102755079Lbl: label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755080Lbl: label '......................................................................................................................................................';
        Signature_and_DateCaption_Control1102755081Lbl: label 'Signature and Date';
        NameCaption_Control1102755082Lbl: label 'Name';
        Approved_by_CaptionLbl: label 'Approved by:';
        EmptyStringCaption_Control1102755084Lbl: label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755085Lbl: label '......................................................................................................................................................';
        PeriodTrans: Record "PR Period Transactions";
        SalCard: Record "PR Salary Card";
        TransSet: Record "PR Transaction Codes";


    procedure MakeExcelInfo()
    begin
        /*
        ExcelBuf.SetUseInfoSheed;
        ExcelBuf.AddInfoColumn(FORMAT(Text013),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text015),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn('Payroll Summary',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text016),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text017),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text018),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn("HR-Employee".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.ClearNewRow;
        //MakeExcelDataHeader;
        */

    end;

    local procedure MakeExcelDataHeader()
    begin
        /*
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Employee Code',FALSE,'',TRUE,FALSE,TRUE,'@');
        ExcelBuf.AddColumn('Names',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Department',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[1],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[2],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[3],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[4],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[5],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[6],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[7],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[8],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[9],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[10],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[11],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[12],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[13],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[14],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[15],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[16],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[17],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[18],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[19],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[20],FALSE,'',TRUE,FALSE,TRUE,'');
        {
        ExcelBuf.AddColumn(cHeader[21],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[22],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[23],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[24],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[25],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[26],FALSE,'',TRUE,FALSE,TRUE,'');
        }
        */

    end;


    procedure MakeExcelDataBody()
    begin
        /*
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(("HR-Employee"."No."),FALSE,'',FALSE,FALSE,FALSE,'@');
        ExcelBuf.AddColumn(strEmpName,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn("HR-Employee"."Department Code",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[1],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[2],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[3],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[4],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[5],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[6],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[7],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[8],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[9],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[10],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[11],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[12],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[13],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[14],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[15],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[16],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[17],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[18],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[19],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[20],FALSE,'',FALSE,FALSE,FALSE,'');
        {
        ExcelBuf.AddColumn(cValue[21],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[22],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[23],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[24],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[25],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[26],FALSE,'',FALSE,FALSE,FALSE,'');
        }
        */

    end;


    procedure CreateExcelbook()
    begin
        /*
        ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet(Text011,Text012,COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');
        */

    end;


    procedure MakeExcelTotalBody()
    begin
        /*
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'@');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[1],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[2],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[3],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[4],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[5],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[6],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[7],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[8],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[9],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[10],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[11],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[12],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[13],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[14],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[15],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[16],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[17],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[18],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[19],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[20],FALSE,'',FALSE,FALSE,FALSE,'');
        {
        ExcelBuf.AddColumn(cValue[21],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[22],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[23],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[24],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[25],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[26],FALSE,'',FALSE,FALSE,FALSE,'');
        }
        */

    end;
}
