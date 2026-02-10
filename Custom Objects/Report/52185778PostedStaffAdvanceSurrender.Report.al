// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185778 "Posted Staff Advance Surrender"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Posted Staff Advance Surrender.rdl';

//     dataset
//     {
//         dataitem(52185916;52185916)
//         {
//             DataItemTableView = sorting(No) order(ascending);
//             RequestFilterFields = No;
//             column(ReportForNavId_8154; 8154)
//             {
//             }
//             column(Staff_Advance_Surrender_Header_No;No)
//             {
//             }
//             column(StrCopyText;StrCopyText)
//             {
//             }
//             column(Staff_Advance_Surrender_Header__Imprest_Issue_Doc__No_;"Imprest Issue Doc. No")
//             {
//             }
//             column(Account_No___________CustName;"Account No." +':   '+CustName)
//             {
//             }
//             column(Staff_Advance_Surrender_Header_Amount;Amount)
//             {
//             }
//             column(Staff_Advance_Surrender_Header__Global_Dimension_1_Code_;"Global Dimension 1 Code")
//             {
//             }
//             column(Staff_Advance_Surrender_Header__Shortcut_Dimension_2_Code_;"Global Dimension 2 Code")
//             {
//             }
//             column(Staff_Advance_Surrender_Header__Staff_Advance_Surrender_Header___Surrender_Date_;"Staff Advance Surrender Header"."Surrender Date")
//             {
//             }
//             column(Staff_Advance_Surrender_Header__Currency_Code_;"Currency Code")
//             {
//             }
//             column(STAFF_ADVANCE_SURRENDERCaption;STAFF_ADVANCE_SURRENDERCaptionLbl)
//             {
//             }
//             column(Issue_Doc__No_Caption;Issue_Doc__No_CaptionLbl)
//             {
//             }
//             column(Name_Caption;Name_CaptionLbl)
//             {
//             }
//             column(Total_Amount_IssuedCaption;Total_Amount_IssuedCaptionLbl)
//             {
//             }
//             column(Staff_Advance_Surrender_Header__Global_Dimension_1_Code_Caption;UnknownTable52185916.FieldCaption("Global Dimension 1 Code"))
//             {
//             }
//             column(Staff_Advance_Surrender_Header__Shortcut_Dimension_2_Code_Caption;UnknownTable52185916.FieldCaption("Global Dimension 2 Code"))
//             {
//             }
//             column(Date_Caption;Date_CaptionLbl)
//             {
//             }
//             column(Staff_Advance_Surrender_Header__Currency_Code_Caption;UnknownTable52185916.FieldCaption("Currency Code"))
//             {
//             }
//             column(PAYMENT_DETAILSCaption;PAYMENT_DETAILSCaptionLbl)
//             {
//             }
//             column(ACTUAL_SPENTCaption;ACTUAL_SPENTCaptionLbl)
//             {
//             }
//             column(CASH_SURRENDERCaption;CASH_SURRENDERCaptionLbl)
//             {
//             }
//             column(Difference_StaffAdvanceSurrenderHeader;"Staff Advance Surrender Header".Difference)
//             {
//             }
//             column(Staff_Advance_Surrender_Header_Cheque;"Staff Advance Surrender Header"."Cheque No")
//             {
//             }
//             column(Staff_Advance_Surrender_Header_Pay_Mode;"Staff Advance Surrender Header"."Pay Mode")
//             {
//             }
//             column(Staff_Advance_Surrender_Header_Bank_Code;"Staff Advance Surrender Header"."Bank Code")
//             {
//             }
//             column(Staff_Advance_Surrender_Header_Account_Name;"Staff Advance Surrender Header"."Account Name")
//             {
//             }
//             column(Staff_Advance_Surrender_Header_Function_Name;"Staff Advance Surrender Header"."Function Name")
//             {
//             }
//             column(Staff_Advance_Surrender_Header_Budget_Center_Name;"Staff Advance Surrender Header"."Budget Center Name")
//             {
//             }
//             column(CompanyName;CompanyInfo.Name)
//             {
//             }
//             column(CompanyAdd;CompanyInfo.Address)
//             {
//             }
//             column(CompanyPicture;CompanyInfo.Picture)
//             {
//             }
//             dataitem(52185917;52185917)
//             {
//                 DataItemLink = "Surrender Doc No."=field(No);
//                 DataItemTableView = sorting("Surrender Doc No.","Line No.") order(ascending);
//                 column(ReportForNavId_8861; 8861)
//                 {
//                 }
//                 column(Staff_Advanc_Surrender_Details_Account_No;"Staff Advanc Surrender Details"."Account No:")
//                 {
//                 }
//                 column(Staff_Advanc_Surrender_Details__Account_Name_;"Account Name")
//                 {
//                 }
//                 column(Staff_Advanc_Surrender_Details__Actual_Spent_;"Actual Spent")
//                 {
//                 }
//                 column(Staff_Advanc_Surrender_Details__Cash_Receipt_Amount_;"Cash Receipt Amount")
//                 {
//                 }
//                 column(Staff_Advanc_Surrender_Details__Actual_Spent__Control1000000000;"Actual Spent")
//                 {
//                 }
//                 column(TIME_PRINTED_____FORMAT_TIME_;'TIME PRINTED:' + Format(Time))
//                 {
//                     AutoFormatType = 1;
//                 }
//                 column(DATE_PRINTED_____FORMAT_TODAY_0_4_;'DATE PRINTED:' + Format(Today,0,4))
//                 {
//                     AutoFormatType = 1;
//                 }
//                 column(USERID;UserId)
//                 {
//                 }
//                 column(Staff_Advanc_Surrender_Details__Currency_Code_;"Currency Code")
//                 {
//                 }
//                 column(NumberText_1_;NumberText[1])
//                 {
//                 }
//                 column(Staff_Advanc_Surrender_Details__Cash_Receipt_Amount__Control1102756007;"Cash Receipt Amount")
//                 {
//                 }
//                 column(TotalCaption;TotalCaptionLbl)
//                 {
//                 }
//                 column(Date_Caption_Control1102755030;Date_Caption_Control1102755030Lbl)
//                 {
//                 }
//                 column(Name_Caption_Control1102755034;Name_Caption_Control1102755034Lbl)
//                 {
//                 }
//                 column(Approved_By_Caption;Approved_By_CaptionLbl)
//                 {
//                 }
//                 column(Name_Caption_Control1102755036;Name_Caption_Control1102755036Lbl)
//                 {
//                 }
//                 column(Date_Caption_Control1102755037;Date_Caption_Control1102755037Lbl)
//                 {
//                 }
//                 column(Signature_Caption;Signature_CaptionLbl)
//                 {
//                 }
//                 column(Printed_By_Caption;Printed_By_CaptionLbl)
//                 {
//                 }
//                 column(Prepared_By_Caption;Prepared_By_CaptionLbl)
//                 {
//                 }
//                 column(Signature_Caption_Control1102755042;Signature_Caption_Control1102755042Lbl)
//                 {
//                 }
//                 column(I_confirm_that_the_above_are_legitimate_business_expenses_and_have_not_been_claimed_before_Caption;I_confirm_that_the_above_are_legitimate_business_expenses_and_have_not_been_claimed_before_CaptionLbl)
//                 {
//                 }
//                 column(EmptyStringCaption;EmptyStringCaptionLbl)
//                 {
//                 }
//                 column(Approvals_Caption;Approvals_CaptionLbl)
//                 {
//                 }
//                 column(Amount_in_wordsCaption;Amount_in_wordsCaptionLbl)
//                 {
//                 }
//                 column(Staff_Advanc_Surrender_Details_Surrender_Doc_No_;"Surrender Doc No.")
//                 {
//                 }
//                 column(Staff_Advanc_Surrender_Details_Line_No_;"Line No.")
//                 {
//                 }
//                 column(Staff_Advanc_Surrender_Details_Amount;Amount)
//                 {
//                 }
//                 column(Staff_Advanc_Surrender_Details_Difference;"Staff Advanc Surrender Details".Difference)
//                 {
//                 }
//             }
//             dataitem("Approval Entry";"Approval Entry")
//             {
//                 DataItemLink = "Document No."=field(No);
//                 DataItemTableView = where("Document Type"=const(16),Status=const(Approved));
//                 column(ReportForNavId_1000000014; 1000000014)
//                 {
//                 }
//                 column(ApproverID_ApprovalEntry;"Approval Entry"."Approver ID")
//                 {
//                 }
//                 column(LastDateTimeModified_ApprovalEntry;"Approval Entry"."Last Date-Time Modified")
//                 {
//                 }
//                 column(Sequence_No;"Approval Entry"."Sequence No.")
//                 {
//                 }
//                 column(SenderID_ApprovalEntry;"Approval Entry"."Sender ID")
//                 {
//                 }
//                 column(DateTimeSentforApproval_ApprovalEntry;"Approval Entry"."Date-Time Sent for Approval")
//                 {
//                 }
//             }

//             trigger OnAfterGetRecord()
//             begin

//                  StrCopyText:='';
//                 if "No. Printed">=1 then
//                   begin
//                     StrCopyText:='DUPLICATE';
//                   end;

//                   if Cust.Get("Staff Advance Surrender Header"."Account No.") then
//                     CustName:=Cust.Name;

//                 AmountRefundable:=0;
//                 "Staff Advance Surrender Header".CalcFields("Staff Advance Surrender Header".Difference);
//                 AmountRefundable:="Staff Advance Surrender Header".Difference;
//                 if AmountRefundable<0 then AmountRefundable:=AmountRefundable*-1;

//                 //Amount into words
//                 CheckReport.InitTextVariable;
//                 CheckReport.FormatNoText(NumberText,AmountRefundable,'');
//             end;

//             trigger OnPostDataItem()
//             begin
//                 if CurrReport.Preview=false then
//                   begin
//                     "No. Printed":="No. Printed" + 1;
//                     UnknownTable52185916.Modify;
//                   end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 LastFieldNo := UnknownTable52185916.FieldNo(No);
//                 // "Imprest Surrender Header".SETRANGE("Imprest Surrender Header".Posted,TRUE);
//                 CompanyInfo.Get;
//                 CompanyInfo.CalcFields(Picture);
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
//         LastFieldNo: Integer;
//         FooterPrinted: Boolean;
//         Cust: Record Customer;
//         CustName: Text[250];
//         CheckReport: Report Check;
//                          NumberText: array [2] of Text[80];
//                          StrCopyText: Text[30];
//                          STAFF_ADVANCE_SURRENDERCaptionLbl: label 'STAFF ADVANCE SURRENDER';
//         Issue_Doc__No_CaptionLbl: label 'Issue Doc. No.';
//         Name_CaptionLbl: label 'Name:';
//         Total_Amount_IssuedCaptionLbl: label 'Total Amount Issued';
//         Date_CaptionLbl: label 'Date:';
//         PAYMENT_DETAILSCaptionLbl: label 'PAYMENT DETAILS';
//         ACTUAL_SPENTCaptionLbl: label 'ACTUAL SPENT';
//         CASH_SURRENDERCaptionLbl: label 'CASH SURRENDER';
//         TotalCaptionLbl: label 'Total';
//         Date_Caption_Control1102755030Lbl: label 'Date:';
//         Name_Caption_Control1102755034Lbl: label 'Name:';
//         Approved_By_CaptionLbl: label 'Approved By:';
//         Name_Caption_Control1102755036Lbl: label 'Name:';
//         Date_Caption_Control1102755037Lbl: label 'Date:';
//         Signature_CaptionLbl: label 'Signature:';
//         Printed_By_CaptionLbl: label 'Printed By:';
//         Prepared_By_CaptionLbl: label 'Prepared By:';
//         Signature_Caption_Control1102755042Lbl: label 'Signature:';
//         I_confirm_that_the_above_are_legitimate_business_expenses_and_have_not_been_claimed_before_CaptionLbl: label 'I confirm that the above are legitimate business expenses and have not been claimed before.';
//         EmptyStringCaptionLbl: label '================================================================================================================================================================================================';
//         Approvals_CaptionLbl: label 'Approvals:';
//         Amount_in_wordsCaptionLbl: label 'Amount in words';
//         AmountRefundable: Decimal;
//         CompanyInfo: Record "Company Information";
// }
