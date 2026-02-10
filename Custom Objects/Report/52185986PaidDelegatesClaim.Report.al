// report 52186010 "Paid Delegates Claim Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Paid Delegates Claim Report.rdl';


//     dataset
//     {
//         dataitem("Delegates Minutes Header";"Delegates Minutes Header")
//         {

//             column(Customer__No__; "No.")
//             {
//             }
//             column(Customer_Name; Name)
//             {
//             }
//             column(Status; Status
//             )
//             {
//             }
//             column(CustBalanceDueLCY_5__Control25; CustBalanceDueLCY[5])
//             {
//                 AutoFormatType = 1;
//             }
//             column(CustBalanceDueLCY_4__Control26; CustBalanceDueLCY[4])
//             {
//                 AutoFormatType = 1;
//             }
//             column(CustBalanceDueLCY_3__Control27; CustBalanceDueLCY[3])
//             {
//                 AutoFormatType = 1;
//             }
//             column(CustBalanceDueLCY_2__Control28; CustBalanceDueLCY[2])
//             {
//                 AutoFormatType = 1;
//             }
//             column(CustBalanceDueLCY_1__Control29; CustBalanceDueLCY[1])
//             {
//                 AutoFormatType = 1;
//             }
//             column(CustBalanceDueLCY_5__Control37; CustBalanceDueLCY[5])
//             {
//                 AutoFormatType = 1;
//             }
//             column(CustBalanceDueLCY_4__Control38; CustBalanceDueLCY[4])
//             {
//                 AutoFormatType = 1;
//             }
//             column(CustBalanceDueLCY_3__Control39; CustBalanceDueLCY[3])
//             {
//                 AutoFormatType = 1;
//             }
//             column(CustBalanceDueLCY_2__Control40; CustBalanceDueLCY[2])
//             {
//                 AutoFormatType = 1;
//             }
//             column(CustBalanceDueLCY_1__Control41; CustBalanceDueLCY[1])
//             {
//                 AutoFormatType = 1;
//             }
//             column(Customer___Summary_Aging_Simp_Caption; Customer___Summary_Aging_Simp_CaptionLbl)
//             {
//             }
//             column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
//             {
//             }
//             column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
//             {
//             }
//             column(Customer__No__Caption; FieldCaption("No."))
//             {
//             }
//             column(Customer_NameCaption; FieldCaption(Name))
//             {
//             }
//             column(CustBalanceDueLCY_5__Control25Caption; CustBalanceDueLCY_5__Control25CaptionLbl)
//             {
//             }
//             column(CustBalanceDueLCY_4__Control26Caption; CustBalanceDueLCY_4__Control26CaptionLbl)
//             {
//             }
//             column(CustBalanceDueLCY_3__Control27Caption; CustBalanceDueLCY_3__Control27CaptionLbl)
//             {
//             }
//             column(CustBalanceDueLCY_2__Control28Caption; CustBalanceDueLCY_2__Control28CaptionLbl)
//             {
//             }
//             column(CustBalanceDueLCY_1__Control29Caption; CustBalanceDueLCY_1__Control29CaptionLbl)
//             {
//             }
//             column(TotalCaption; TotalCaptionLbl)
//             {
//             }
//             column(CompanyInformation_Name; CompanyInformation.Name)
//             {
//             }
//             column(CompanyInformation_Picture; CompanyInformation.Picture)
//             {
//             }
//             column(CompanyAddress; CompanyAddress)
//             {
//             }
//             column(CompanyTelephone; CompanyTelephone)
//             {
//             }
//             column(CommunicationOnline; CommunicationOnline)
//             {
//             }

//             trigger OnAfterGetRecord()
//             var
//                 FilteredCustomer: Record Customer;
//                 ShouldSkipCustomer: Boolean;
//             begin
//                 FilteredCustomer.CopyFilters(Customer);
//                 FilteredCustomer.SetFilter("Date Filter", '..%1', StartDate);
//                 FilteredCustomer.SetRange("No.", "No.");
//                 ShouldSkipCustomer := FilteredCustomer.IsEmpty();
//                 OnCustomerOnAfterGetRecordOnAfterCalcShouldSkipCustomer(Customer, FilteredCustomer, DtldCustLedgEntry, CustBalanceDueLCY, PrintCust, ShouldSkipCustomer);
//                 if ShouldSkipCustomer then
//                     CurrReport.Skip();

//                 PrintCust := false;
//                 for i := 1 to 5 do begin
//                     DtldCustLedgEntry.SetCurrentKey("Customer No.", "Initial Entry Due Date", "Posting Date");
//                     DtldCustLedgEntry.SetRange("Customer No.", "No.");
//                     DtldCustLedgEntry.SetRange("Posting Date", 0D, StartDate);
//                     DtldCustLedgEntry.SetRange("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
//                     OnAfterGetRecordOnAfterDtldCustLedgEntrySetFilters(DtldCustLedgEntry);
//                     DtldCustLedgEntry.CalcSums("Amount (LCY)");
//                     CustBalanceDueLCY[i] := DtldCustLedgEntry."Amount (LCY)";
//                     if CustBalanceDueLCY[i] <> 0 then
//                         PrintCust := true;
//                 end;
//                 if not PrintCust then
//                     CurrReport.Skip();
//             end;

//             trigger OnPreDataItem()
//             begin
//                 Clear(CustBalanceDueLCY);
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field(StartingDate; StartDate)
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Starting Date';
//                         ToolTip = 'Specifies the date from which the report or batch job processes information.';
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }

//         trigger OnOpenPage()
//         begin
//             if StartDate = 0D then
//                 StartDate := WorkDate();
//         end;
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     var
//         FormatDocument: Codeunit "Format Document";
//     begin
//         CustFilter := FormatDocument.GetRecordFiltersWithCaptions(Customer);
//         PeriodStartDate[5] := StartDate;
//         PeriodStartDate[6] := DMY2Date(31, 12, 9999);
//         for i := 4 downto 2 do
//             PeriodStartDate[i] := CalcDate('<-30D>', PeriodStartDate[i + 1]);

//         if CompanyInformation.Get then
//             CompanyInformation.CalcFields(CompanyInformation.Picture);
//         CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
//         CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
//         CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
//     end;

//     var
//         DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
//         StartDate: Date;
//         PeriodStartDate: array[6] of Date;
//         CustBalanceDueLCY: array[5] of Decimal;
//         PrintCust: Boolean;
//         i: Integer;

//         Text001: Label 'As of %1';
//         Customer___Summary_Aging_Simp_CaptionLbl: Label 'Customer - Summary Aging Simp.';
//         CurrReport_PAGENOCaptionLbl: Label 'Page';
//         All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
//         CustBalanceDueLCY_5__Control25CaptionLbl: Label '0-30 Days';
//         CustBalanceDueLCY_4__Control26CaptionLbl: Label '31-90 Days';
//         CustBalanceDueLCY_3__Control27CaptionLbl: Label '91-180 Days';
//         CustBalanceDueLCY_2__Control28CaptionLbl: Label '181-360 Days';
//         CustBalanceDueLCY_1__Control29CaptionLbl: Label 'Over 360 Days';
//         TotalCaptionLbl: Label 'Total';
//         CompanyInformation: Record "Company Information";
//         CompanyAddress: Text;
//         CompanyTelephone: Text;
//         CommunicationOnline: Text;

//     protected var
//         CustFilter: Text;

//     procedure InitializeRequest(StartingDate: Date)
//     begin
//         StartDate := StartingDate;
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterGetRecordOnAfterDtldCustLedgEntrySetFilters(var DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnCustomerOnAfterGetRecordOnAfterCalcShouldSkipCustomer(Customer: Record Customer; var FilteredCustomer: Record Customer; var DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; var CustBalanceDueLCY: array[5] of Decimal; var PrintCust: Boolean; var ShouldSkipCustomer: Boolean)
//     begin
//     end;
// }


