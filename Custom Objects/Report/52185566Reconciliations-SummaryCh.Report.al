// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185566 "Reconciliations - Summary Ch"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Reconciliations - Summary Ch.rdl';

//     dataset
//     {
//         dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
//         {
//             RequestFilterFields = "Current Month Filter";
//             column(ReportForNavId_8631; 8631)
//             {
//             }
//             column(COMPANYNAME; COMPANYNAME)
//             {
//             }
//             // column(GETFILTERS; UnknownTable"HR EMPLOYEES".GetFilters)
//             // {
//             // }
//             column(USERID; UserId)
//             {
//             }
//             column(CurrReport_PAGENO; CurrReport.PageNo)
//             {
//             }
//             column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
//             {
//             }
//             column(CompanyInfo_Picture; CompanyInfo.Picture)
//             {
//             }
//             column(BalanceBF; BalanceBF)
//             {
//             }
//             column(HR_Employee__No__; "No.")
//             {
//             }
//             column(First_Name___________Middle_Name___________Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
//             {
//             }
//             column(HR_Employee_Status; Status)
//             {
//             }
//             column(HR_Employee__Gross_Income_Variation_; "Gross Income Variation")
//             {
//             }
//             column(HR_Employee__Gross_Income_Variation__Control1102755021; "Gross Income Variation")
//             {
//             }
//             column(Reconciliation___SummaryCaption; Reconciliation___SummaryCaptionLbl)
//             {
//             }
//             column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
//             {
//             }
//             column(AmountCaption; AmountCaptionLbl)
//             {
//             }
//             column(DescriptionCaption; DescriptionCaptionLbl)
//             {
//             }
//             column(CodeCaption; CodeCaptionLbl)
//             {
//             }
//             column(Gross_VariationCaption; Gross_VariationCaptionLbl)
//             {
//             }
//             column(Balance_BFCaption; Balance_BFCaptionLbl)
//             {
//             }
//             column(Entry_ExitsCaption; Entry_ExitsCaptionLbl)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 "HR Employees".CalcFields("Prev. Gross Pay", "Curr. Gross Pay");

//                 if ("HR Employees"."Prev. Gross Pay" = 0) and ("HR Employees"."Curr. Gross Pay" = 0) then
//                     CurrReport.Skip;

//                 if ("HR Employees"."Prev. Gross Pay" > 0) and ("HR Employees"."Curr. Gross Pay" > 0) then
//                     CurrReport.Skip;

//                 TotalEntryExits := TotalEntryExits + "HR Employees"."Gross Income Variation";
//             end;

//             trigger OnPreDataItem()
//             begin
//                 if "HR Employees".GetFilter("HR Employees"."Current Month Filter") = '' then
//                     Error('You must specify current Period filter.');

//                 Evaluate(SelectedPeriod, "HR Employees".GetFilter("Current Month Filter"));

//                 "HR Employees".SetFilter("Previous Month Filter", Format(CalcDate('-1M', SelectedPeriod)));

//                 BalanceBF := 0;
//                 TotalEntryExits := 0;
//                 TotalEVariations := 0;
//                 TotalDVariations := 0;

//                 Trans.Reset;
//                 Trans.SetRange(Trans."Transaction Code", 'NPAY');
//                 Trans.SetFilter(Trans."Current Month Filter", Format(CalcDate('-1M', SelectedPeriod)));
//                 if Trans.Find('-') then begin
//                     Trans.CalcFields(Trans."Curr. Amount");
//                     BalanceBF := Trans."Curr. Amount";
//                 end;

//                 if CompanyInfo.Get() then
//                     CompanyInfo.CalcFields(CompanyInfo.Picture);
//             end;
//         }
//         dataitem("PR Transaction Codes"; "PR Transaction Codes")
//         {
//             //DataItemTableView = sorting(Field215, Field216) where("Transaction Type" = const(Income));
//             column(ReportForNavId_6955; 6955)
//             {
//             }
//             column(prTransaction_Codes__Gross_Variation_; "Gross Variation")
//             {
//             }
//             column(prTransaction_Codes__Transaction_Name_; "Transaction Name")
//             {
//             }
//             column(prTransaction_Codes__Transaction_Code_; "Transaction Code")
//             {
//             }
//             column(TotalEVariations; TotalEVariations)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 //CALCFIELDS("Gross Variation");

//                 // IF "PR Transaction Codes"."Gross Variation" = 0 THEN
//                 // CurrReport.SKIP;

//                 // IF TransR.GET("PR Transaction Codes"."Transaction Code") THEN BEGIN
//                 // IF TransR."Non-Transactional" = TRUE THEN BEGIN
//                 // IF (TransR."Transaction Code" <> 'BPAY') AND (TransR."Transaction Code" <> 'PAYE') AND
//                 //   (TransR."Transaction Code" <> 'NHF') THEN
//                 // CurrReport.SKIP;
//                 // END;
//                 // END;


//                 //TotalEVariations:=TotalEVariations+"PR Transaction Codes"."Gross Variation"
//             end;

//             trigger OnPreDataItem()
//             begin
//                 if "HR Employees".GetFilter("Current Month Filter") = '' then
//                     Error('You must specify Current Period Filter.');

//                 "PR Transaction Codes".SetFilter("Current Month Filter", "HR Employees".GetFilter("Current Month Filter"));

//                 Evaluate(SelectedPeriod, "HR Employees".GetFilter("Current Month Filter"));

//                 "PR Transaction Codes".SetFilter("Previous Month Filter", Format(CalcDate('-1M', SelectedPeriod)));
//                 //SETFILTER("PR Transaction Codes"."Entry/Exit Filter",FORMAT(FALSE));
//             end;
//         }
//         dataitem("<prTransaction Codes2>"; "PR Transaction Codes")
//         {
//             DataItemTableView = where("Transaction Type" = const(Deduction));
//             column(ReportForNavId_9370; 9370)
//             {
//             }
//             column(prTransaction_Codes2___Gross_Variation_; "Gross Variation")
//             {
//             }
//             column(prTransaction_Codes2___Transaction_Name_; "Transaction Name")
//             {
//             }
//             column(prTransaction_Codes2___Transaction_Code_; "Transaction Code")
//             {
//             }
//             column(BalanceBF_TotalEntryExits_TotalEVariations_TotalDVariations; BalanceBF + TotalEntryExits + TotalEVariations + TotalDVariations)
//             {
//             }
//             column(TotalDVariations; TotalDVariations)
//             {
//             }
//             column(Prepared_by_Caption; Prepared_by_CaptionLbl)
//             {
//             }
//             column(NameCaption; NameCaptionLbl)
//             {
//             }
//             column(EmptyStringCaption; EmptyStringCaptionLbl)
//             {
//             }
//             column(EmptyStringCaption_Control1102755033; EmptyStringCaption_Control1102755033Lbl)
//             {
//             }
//             column(Authorised_by_Caption; Authorised_by_CaptionLbl)
//             {
//             }
//             column(NameCaption_Control1102755037; NameCaption_Control1102755037Lbl)
//             {
//             }
//             column(EmptyStringCaption_Control1102755038; EmptyStringCaption_Control1102755038Lbl)
//             {
//             }
//             column(Approved_by_Caption; Approved_by_CaptionLbl)
//             {
//             }
//             column(NameCaption_Control1102755040; NameCaption_Control1102755040Lbl)
//             {
//             }
//             column(Signature___DateCaption; Signature___DateCaptionLbl)
//             {
//             }
//             column(EmptyStringCaption_Control1102755042; EmptyStringCaption_Control1102755042Lbl)
//             {
//             }
//             column(Signature___DateCaption_Control1102755043; Signature___DateCaption_Control1102755043Lbl)
//             {
//             }
//             column(EmptyStringCaption_Control1102755044; EmptyStringCaption_Control1102755044Lbl)
//             {
//             }
//             column(Signature___DateCaption_Control1102755045; Signature___DateCaption_Control1102755045Lbl)
//             {
//             }
//             column(EmptyStringCaption_Control1102755046; EmptyStringCaption_Control1102755046Lbl)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 //CALCFIELDS("Gross Variation");

//                 // IF "Gross Variation" = 0 THEN
//                 // CurrReport.SKIP;

//                 // IF TransR.GET("Transaction Code") THEN BEGIN
//                 // IF TransR."Non-Transactional" = TRUE THEN BEGIN
//                 // IF (TransR."Transaction Code" <> 'BPAY') AND (TransR."Transaction Code" <> 'PAYE') AND
//                 //   (TransR."Transaction Code" <> 'NHF') THEN
//                 // CurrReport.SKIP;
//                 // END;
//                 // END;

//                 //TotalDVariations:=TotalDVariations + (-1*"Gross Variation")
//             end;

//             trigger OnPreDataItem()
//             begin
//                 if "HR Employees".GetFilter("Current Month Filter") = '' then
//                     Error('You must specify Current Period Filter.');

//                 "<prTransaction Codes2>".SetFilter("Current Month Filter", "HR Employees".GetFilter("Current Month Filter"));

//                 Evaluate(SelectedPeriod, "HR Employees".GetFilter("Current Month Filter"));

//                 "<prTransaction Codes2>".SetFilter("Previous Month Filter", Format(CalcDate('-1M', SelectedPeriod)));
//                 //SETFILTER("Entry/Exit Filter",FORMAT(FALSE));
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         TotalFor: label 'Total for ';
//         SelectedPeriod: Date;
//         Trans: Record "PR Transaction Codes";
//         BalanceBF: Decimal;
//         TotalEntryExits: Decimal;
//         TotalEVariations: Decimal;
//         TotalDVariations: Decimal;
//         TransR: Record "PR Transaction Codes";
//         CompanyInfo: Record "Company Information";
//         Reconciliation___SummaryCaptionLbl: label 'Reconciliation - Summary';
//         CurrReport_PAGENOCaptionLbl: label 'Page';
//         AmountCaptionLbl: label 'Amount';
//         DescriptionCaptionLbl: label 'Description';
//         CodeCaptionLbl: label 'Code';
//         Gross_VariationCaptionLbl: label 'Gross Variation';
//         Balance_BFCaptionLbl: label 'Balance BF';
//         Entry_ExitsCaptionLbl: label 'Entry/Exits';
//         Prepared_by_CaptionLbl: label 'Prepared by:';
//         NameCaptionLbl: label 'Name';
//         EmptyStringCaptionLbl: label '......................................................................................................................................................';
//         EmptyStringCaption_Control1102755033Lbl: label '......................................................................................................................................................';
//         Authorised_by_CaptionLbl: label 'Authorised by:';
//         NameCaption_Control1102755037Lbl: label 'Name';
//         EmptyStringCaption_Control1102755038Lbl: label '......................................................................................................................................................';
//         Approved_by_CaptionLbl: label 'Approved by:';
//         NameCaption_Control1102755040Lbl: label 'Name';
//         Signature___DateCaptionLbl: label 'Signature & Date';
//         EmptyStringCaption_Control1102755042Lbl: label '......................................................................................................................................................';
//         Signature___DateCaption_Control1102755043Lbl: label 'Signature & Date';
//         EmptyStringCaption_Control1102755044Lbl: label '......................................................................................................................................................';
//         Signature___DateCaption_Control1102755045Lbl: label 'Signature & Date';
//         EmptyStringCaption_Control1102755046Lbl: label '......................................................................................................................................................';
//         "Gross Variation": Decimal;
// }
