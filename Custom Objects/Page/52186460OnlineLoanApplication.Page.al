// page 52186460 "Online Loan Application"
// {
//     DeleteAllowed = false;
//     Editable = true;
//     InsertAllowed = false;
//     ModifyAllowed = true;
//     PageType = Card;
//     SourceTable = "Online Loans Applications";
//     SourceTableView = WHERE(submitted = FILTER(true));

//     layout
//     {
//         area(content)
//         {
//             group("Member Details")
//             {
//                 Editable = false;
//                 field("BOSA No"; Rec."BOSA No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Member Names"; Rec."Member Names")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Id No"; Rec."Id No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Employment No"; Rec."Employment No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Telephone; Rec.Telephone)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Email; Rec.Email)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             group("Loan Details")
//             {
//                 Editable = false;
//                 field("Application Date"; Rec."Application Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Loan Type"; Rec."Loan Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Loan Type Description"; Rec."Loan Type Description")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Loan Amount"; Rec."Loan Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Repayment Period"; Rec."Repayment Period")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Interest Rate"; Rec."Interest Rate")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Approved; Rec.Approved)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Loan No"; Rec."Loan No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Self Guarantee"; Rec."Self Guarantee")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Control35; Rec."CRB Checked")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("CRB Checked By"; Rec."CRB Checked By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Payslip Verfied"; Rec."Payslip Verfied")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Payslip Verified By"; Rec."Payslip Verified By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Loan Purpose"; Rec."Loan Purpose")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Loan Purpose Code';
//                 }
//             }
//             group("Top Up")
//             {
//                 Editable = false;
//                 Visible = Rec.topup;
//                 field(topupref; Rec.topupref)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Loan Top Up';
//                 }
//             }
//             group("Salary Details")
//             {
//                 Editable = false;
//                 field("Basic Pay"; Rec."Basic Pay")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total Allowances"; Rec."Total Allowances")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(TotalDeduction; Rec.TotalDeduction)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             group(Remarks)
//             {
//                 Editable = NOT Rec.Posted;
//                 field("Loan Rejection Reason"; Rec."Loan Rejection Reason")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             group("Guarantors  Details")
//             {
//                 Editable = false;
//                 part(Control19; "Online Loan Guarantors")
//                 {
//                     SubPageLink = "Loan Application No" = FIELD("Application No");
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group(Action22)
//             {
//             }
//             action(Submit)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Validate Loan Details';
//                 Image = Approve;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 // trigger OnAction()
//                 // var
//                 //     LoansApplicationNo: Code[20];
//                 //     NewBosaLoanRecordID: RecordID;
//                 //     NewSequenceNo: Integer;
//                 //     DepositBal: Decimal;
//                 //     "Count": Integer;
//                 // begin
//                 //     Rec.TestField(submitted);
//                 //     Rec.TestField(Rejected, false);
//                 //     Rec.TestField(Posted, false);

//                 //     //VALIDATIONS
//                 //     if MemberCard.Get(Rec."Membership No") then begin
//                 //         MemberCard.TestField("Primary Identification");
//                 //         MemberCard.TestField(Status, MemberCard.Status::Active);

//                 //         LoansTable.Reset;
//                 //         LoansTable.SetRange("Member No.", Rec."Membership No");
//                 //         if LoansTable.FindFirst then begin
//                 //             repeat
//                 //                 if (LoansTable."Loans Category-SASRA" = LoansTable."Loans Category-SASRA"::Doubtful)
//                 //                   or (LoansTable."Loans Category-SASRA" = LoansTable."Loans Category-SASRA"::Loss)
//                 //                   or (LoansTable."Loans Category-SASRA" = LoansTable."Loans Category-SASRA"::Watch)
//                 //                 then
//                 //                     Error(Err001, LoansTable."Loan No.", LoansTable."Loans Category-SASRA");
//                 //             until LoansTable.Next = 0;
//                 //         end;
//                 //     end;


//                 //     if Confirm(CnfSubmit) then begin
//                 //         //check if credit account exists
//                 //         ProductFactory.Get(Rec."Loan Type");
//                 //         MemberCard.Get(Rec."Membership No");

//                 //         //check if salary passes thru FOSA
//                 //         if (MemberCard."Employer Code" = '99') or (MemberCard."Employer Code" = '05') then begin
//                 //             SavingsAccounts.Reset;
//                 //             SavingsAccounts.SetRange(SavingsAccounts."Member No.", MemberCard."No.");
//                 //             SavingsAccounts.SetRange("Loan Disbursement Account", true);
//                 //             SavingsAccounts.SetRange("Salary Through FOSA", true);
//                 //             if not SavingsAccounts.Find('-') then
//                 //                 Error('Member Salary does not pass through FOSA');
//                 //         end;


//                 //         OnlineLoanGuarantors.Reset;
//                 //         OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors."Loan Application No", Rec."Application No");
//                 //         OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors.Approved, false);
//                 //         if OnlineLoanGuarantors.FindFirst then
//                 //             Error('Member %1 has not approved to guarantee this loan', OnlineLoanGuarantors."Guarantor No.");

//                 //         AcctNo := ProductFactory."Account No. Prefix" + MemberCard."No." + ProductFactory."Account No. Suffix";

//                 //         if CreditAccounts.Get(AcctNo) = false then
//                 //             AcctNo := LoanProcessing.CreateLoanAccount(MemberCard."No.", Rec."Loan Type");

//                 //         if ProductFactory.Get(ProductFactory."Product ID") then begin
//                 //             if ProductFactory."Product ID" = '112' then begin
//                 //                 MembNoSeries.Get;
//                 //                 MembNoSeries.TestField(MembNoSeries."Loan Nos.");
//                 //                 NoSeriesMgt.InitSeries(MembNoSeries."Loan No Web EM", LoansTable."No. Series", 0D, LoanNo, LoansTable."No. Series");
//                 //             end else
//                 //                 if ProductFactory."Product ID" = '111' then begin
//                 //                     MembNoSeries.Get;
//                 //                     MembNoSeries.TestField(MembNoSeries."Loan Nos.");
//                 //                     NoSeriesMgt.InitSeries(MembNoSeries."Loan No Web DEV", LoansTable."No. Series", 0D, LoanNo, LoansTable."No. Series");
//                 //                 end else begin
//                 //                     MembNoSeries.Get;
//                 //                     MembNoSeries.TestField(MembNoSeries."Loan Nos.");
//                 //                     NoSeriesMgt.InitSeries(MembNoSeries."Loan No Web SF", LoansTable."No. Series", 0D, LoanNo, LoansTable."No. Series");
//                 //                 end;
//                 //         end;

//                 //         LoansTable.Init;
//                 //         LoansTable."Loan No." := LoanNo;
//                 //         LoansTable."Application Date" := Today;
//                 //         LoansTable.Validate("Application Date");
//                 //         LoansTable."Member No." := Rec."Membership No";
//                 //         LoansTable.Validate("Member No.");
//                 //         LoansTable."Staff No" := MemberCard."Payroll/Staff No.";
//                 //         //LoansTable."Disbursement Account No" :='';
//                 //         LoansTable.Validate("Member No.");
//                 //         LoansTable."Loan Product Type" := Rec."Loan Type";
//                 //         LoansTable."Loan Account" := AcctNo;
//                 //         //LoansTable.VALIDATE("Loan Product Type");

//                 //         //get loan type
//                 //         //NewLoans.VALIDATE(NewLoans."Loan Product Type");
//                 //         if ProductFactory.Get(LoansTable."Loan Product Type") then begin
//                 //             LoansTable."Loan Product Type Name" := ProductFactory."Product Description";
//                 //             LoansTable."Grace Period" := ProductFactory."Grace Period - Interest";
//                 //             LoansTable.Interest := ProductFactory."Interest Rate (Min.)";
//                 //             LoansTable."Grace Period" := ProductFactory."Grace Period - Interest";
//                 //             LoansTable."Interest Calculation Method" := ProductFactory."Interest Calculation Method";
//                 //             LoansTable."Loan Span" := ProductFactory."Loan Span";
//                 //             LoansTable.Installments := ProductFactory."Ordinary Default Intallments";
//                 //             LoansTable."Compute Interest Due on Postin" := ProductFactory."Compute Interest Due on Postin";
//                 //             LoansTable."Repayment Frequency" := ProductFactory."Repayment Frequency";
//                 //             LoansTable.Validate("Loan Product Type");

//                 //         end;

//                 //         LoansTable.Installments := Rec."Repayment Period";
//                 //         LoansTable.Validate(Installments);
//                 //         LoansTable.Validate("Sub Sector Level2", Rec."Loan Purpose");
//                 //         LoansTable."Requested Amount" := Rec."Loan Amount";
//                 //         LoansTable.Validate("Requested Amount");
//                 //         //LoansTable."Member Name" := "Member Names";
//                 //         LoansTable.Status := LoansTable.Status::Open;
//                 //         LoansTable.Validate(Status);
//                 //         //LoansTable."Staff No" := "Employment No";
//                 //         if (MemberCard."Employer Code" = '99') or (MemberCard."Employer Code" = '05') then begin
//                 //             LoansTable."Recovery Mode" := LoansTable."Recovery Mode"::Salary;
//                 //             LoansTable."Recommended Amount" := GetAppraisaOrdinaryLoans;
//                 //             if LoansTable."Recommended Amount" > LoansTable."Requested Amount" then
//                 //                 LoansTable."Recommended Amount" := LoansTable."Requested Amount";
//                 //             LoansTable."Approved Amount" := LoansTable."Recommended Amount";
//                 //             LoansTable."Amount To Disburse" := LoansTable."Approved Amount";
//                 //             LoansTable.Status := LoansTable.Status::Approved;
//                 //         end else begin
//                 //             LoansTable."Recovery Mode" := ProductFactory."Repay Mode";
//                 //         end;
//                 //         LoansTable."Sent Online" := true;
//                 //         LoansTable."Global Dimension 1 Code" := MemberCard."Global Dimension 1 Code";
//                 //         LoansTable."Global Dimension 2 Code" := MemberCard."Global Dimension 2 Code";

//                 //         OnlineLoanGuarantors.Reset;
//                 //         OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors."Loan Application No", Rec."Application No");
//                 //         OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors.Approved, true);
//                 //         if OnlineLoanGuarantors.FindFirst then //OnlineLoanApplication
//                 //           begin
//                 //             repeat
//                 //                 SavingsAccounts.Reset;
//                 //                 SavingsAccounts.SetRange("Member No.", OnlineLoanGuarantors."Guarantor No.");
//                 //                 SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
//                 //                 if SavingsAccounts.Find('-') then begin
//                 //                     LoansGuarantors.Init;
//                 //                     LoansGuarantors."Loan No" := LoanNo;
//                 //                     LoansGuarantors.Validate("Savings Account No./Member No.", SavingsAccounts."No.");
//                 //                     //LoansGuarantors.VALIDATE("Amount Guaranteed",OnlineLoanGuarantors."Guarantor Amount");
//                 //                     LoansGuarantors.Insert(true);
//                 //                 end
//                 //             until OnlineLoanGuarantors.Next = 0;
//                 //         end;

//                 //         LoansTable.Insert(true);

//                 //         //assign variable to currently generated Loans Application number
//                 //         LoansApplicationNo := LoansTable."Loan No.";

//                 //         RecordLink.Reset;
//                 //         RecordLinkExisting.Reset;

//                 //         //    RecordLinkExisting.SETRANGE(RecordLinkExisting."Online Loan Document No", "Application No");

//                 //         if RecordLinkExisting.Find('-') then begin
//                 //             with RecordLink do begin
//                 //                 repeat
//                 //                     if RecordLink.FindLast then
//                 //                         NewSequenceNo := RecordLink."Link ID" + 1
//                 //                     else
//                 //                         NewSequenceNo := 1;

//                 //                     RecordLink."Link ID" := NewSequenceNo;
//                 //                     RecordLink."Record ID" := NewBosaLoanRecordID;
//                 //                     RecordLink.URL1 := RecordLinkExisting.URL1;
//                 //                     //RecordLink."Doc Tracking Value" := DocTrackingValue;
//                 //                     RecordLink.Description := RecordLinkExisting.Description;
//                 //                     RecordLink."User ID" := UserId;
//                 //                     RecordLink.Company := RecordLinkExisting.Company;
//                 //                     RecordLink.Created := CurrentDateTime;
//                 //                     // RecordLink."Document No" := LoanNo;
//                 //                     RecordLink.Insert(true);

//                 //                 until RecordLink.Next = 0;
//                 //             end
//                 //         end;

//                 //         //POST loan for DOD and Wafanisi
//                 //         if (MemberCard."Employer Code" = '99') or (MemberCard."Employer Code" = '05') then begin
//                 //             LoanProcessing.PostSingleLoan(LoanNo);
//                 //             Message('Loan successfully generated as %1 and has been posted', LoanNo);
//                 //         end else
//                 //             Message('Loan successfully generated as %1 under Loans and ready for appraisal process', LoanNo);

//                 //         Rec.Approved := true;
//                 //         Rec.Posted := true;
//                 //         Rec."Posted By" := UserId;
//                 //         Rec."Posted Date" := CurrentDateTime;
//                 //         Rec."Loan No" := LoansApplicationNo;
//                 //         Rec."Branch Code" := MemberCard."Global Dimension 2 Code";
//                 //         Rec.Modify(true);
//                 //     end

//                 //     else begin
//                 //         Message('User cancellation');
//                 //     end;
//                 // end;

//                 trigger OnAction()
//                 var
//                     LoansApplicationNo: Code[20];
//                     NewBosaLoanRecordID: RecordID;
//                     NewSequenceNo: Integer;
//                     DepositBal: Decimal;
//                     "Count": Integer;
//                     NoSeries: Codeunit "No. Series";
//                 begin
//                     Rec.TestField(submitted);
//                     Rec.TestField(Rejected, false);
//                     Rec.TestField(Posted, false);

//                     //VALIDATIONS
//                     if MemberCard.Get(Rec."Membership No") then begin
//                         MemberCard.TestField("Primary Identification");
//                         MemberCard.TestField(Status, MemberCard.Status::Active);

//                         LoansTable.Reset;
//                         LoansTable.SetRange("Member No.", Rec."Membership No");
//                         if LoansTable.FindFirst then begin
//                             repeat
//                                 if (LoansTable."Loans Category-SASRA" = LoansTable."Loans Category-SASRA"::Doubtful)
//                                   or (LoansTable."Loans Category-SASRA" = LoansTable."Loans Category-SASRA"::Loss)
//                                   or (LoansTable."Loans Category-SASRA" = LoansTable."Loans Category-SASRA"::Watch)
//                                 then
//                                     Error(Err001, LoansTable."Loan No.", LoansTable."Loans Category-SASRA");
//                             until LoansTable.Next = 0;
//                         end;
//                     end;

//                     if Confirm(CnfSubmit) then begin
//                         //check if credit account exists
//                         ProductFactory.Get(Rec."Loan Type");
//                         MemberCard.Get(Rec."Membership No");

//                         //check if salary passes thru FOSA
//                         if (MemberCard."Employer Code" = '99') or (MemberCard."Employer Code" = '05') then begin
//                             SavingsAccounts.Reset;
//                             SavingsAccounts.SetRange(SavingsAccounts."Member No.", MemberCard."No.");
//                             SavingsAccounts.SetRange("Loan Disbursement Account", true);
//                             SavingsAccounts.SetRange("Salary Through FOSA", true);
//                             if not SavingsAccounts.Find('-') then
//                                 Error('Member Salary does not pass through FOSA');
//                         end;

//                         OnlineLoanGuarantors.Reset;
//                         OnlineLoanGuarantors.SetRange("Loan Application No", Rec."Application No");
//                         OnlineLoanGuarantors.SetRange(Approved, false);
//                         if OnlineLoanGuarantors.FindFirst then
//                             Error('Member %1 has not approved to guarantee this loan', OnlineLoanGuarantors."Guarantor No.");

//                         AcctNo := ProductFactory."Account No. Prefix" + MemberCard."No." + ProductFactory."Account No. Suffix";

//                         if CreditAccounts.Get(AcctNo) = false then
//                             AcctNo := LoanProcessing.CreateLoanAccount(MemberCard."No.", Rec."Loan Type");

//                         if ProductFactory.Get(ProductFactory."Product ID") then begin
//                             MembNoSeries.Get;
//                             MembNoSeries.TestField(MembNoSeries."Loan Nos.");

//                             if ProductFactory."Product ID" = '112' then begin
//                                 //NoSeriesMgt.InitSeries(MembNoSeries."Loan No Web EM", LoansTable."No. Series", 0D, LoanNo, LoansTable."No. Series");
//                                 LoanNo := NoSeries.GetNextNo(MembNoSeries."Loan No Web EM", WorkDate());
//                                 LoansTable."No. Series" := MembNoSeries."Loan No Web EM";
//                             end else
//                             if ProductFactory."Product ID" = '111' then begin
//                                 //NoSeriesMgt.InitSeries(MembNoSeries."Loan No Web DEV", LoansTable."No. Series", 0D, LoanNo, LoansTable."No. Series");
//                                 LoanNo := NoSeries.GetNextNo(MembNoSeries."Loan No Web DEV", WorkDate());
//                                 LoansTable."No. Series" := MembNoSeries."Loan No Web DEV";
//                             end else begin
//                                 //NoSeriesMgt.InitSeries(MembNoSeries."Loan No Web SF", LoansTable."No. Series", 0D, LoanNo, LoansTable."No. Series");
//                                 LoanNo := NoSeries.GetNextNo(MembNoSeries."Loan No Web SF", WorkDate());
//                                 LoansTable."No. Series" := MembNoSeries."Loan No Web SF";
//                             end;
//                         end;

//                         LoansTable.Init;
//                         LoansTable."Loan No." := LoanNo;
//                         LoansTable."Application Date" := Today;
//                         LoansTable.Validate("Application Date");
//                         LoansTable."Member No." := Rec."Membership No";
//                         LoansTable.Validate("Member No.");
//                         LoansTable."Staff No" := MemberCard."Payroll/Staff No.";
//                         LoansTable.Validate("Member No.");
//                         LoansTable."Loan Product Type" := Rec."Loan Type";
//                         LoansTable."Loan Account" := AcctNo;

//                         if ProductFactory.Get(LoansTable."Loan Product Type") then begin
//                             LoansTable."Loan Product Type Name" := ProductFactory."Product Description";
//                             LoansTable."Grace Period" := ProductFactory."Grace Period - Interest";
//                             LoansTable.Interest := ProductFactory."Interest Rate (Min.)";
//                             LoansTable."Grace Period" := ProductFactory."Grace Period - Interest";
//                             LoansTable."Interest Calculation Method" := ProductFactory."Interest Calculation Method";
//                             LoansTable."Loan Span" := ProductFactory."Loan Span";
//                             LoansTable.Installments := ProductFactory."Ordinary Default Intallments";
//                             LoansTable."Compute Interest Due on Postin" := ProductFactory."Compute Interest Due on Postin";
//                             LoansTable."Repayment Frequency" := ProductFactory."Repayment Frequency";
//                             LoansTable.Validate("Loan Product Type");
//                         end;

//                         LoansTable.Installments := Rec."Repayment Period";
//                         LoansTable.Validate(Installments);
//                         LoansTable.Validate("Sub Sector Level2", Rec."Loan Purpose");
//                         LoansTable."Requested Amount" := Rec."Loan Amount";
//                         LoansTable.Validate("Requested Amount");
//                         LoansTable.Status := LoansTable.Status::Open;
//                         LoansTable.Validate(Status);

//                         if (MemberCard."Employer Code" = '99') or (MemberCard."Employer Code" = '05') then begin
//                             LoansTable."Recovery Mode" := LoansTable."Recovery Mode"::Salary;
//                             LoansTable."Recommended Amount" := GetAppraisaOrdinaryLoans;
//                             if LoansTable."Recommended Amount" > LoansTable."Requested Amount" then
//                                 LoansTable."Recommended Amount" := LoansTable."Requested Amount";
//                             LoansTable."Approved Amount" := LoansTable."Recommended Amount";
//                             LoansTable."Amount To Disburse" := LoansTable."Approved Amount";
//                             LoansTable.Status := LoansTable.Status::Approved;
//                         end else begin
//                             LoansTable."Recovery Mode" := ProductFactory."Repay Mode";
//                         end;

//                         LoansTable."Sent Online" := true;
//                         LoansTable."Global Dimension 1 Code" := MemberCard."Global Dimension 1 Code";
//                         LoansTable."Global Dimension 2 Code" := MemberCard."Global Dimension 2 Code";

//                         LoansTable.Insert(true);

//                         LoansApplicationNo := LoansTable."Loan No.";

//                         if (MemberCard."Employer Code" = '99') or (MemberCard."Employer Code" = '05') then begin
//                             LoanProcessing.PostSingleLoan(LoanNo);
//                             Message('Loan successfully generated as %1 and has been posted', LoanNo);
//                         end else
//                             Message('Loan successfully generated as %1 under Loans and ready for appraisal process', LoanNo);

//                         Rec.Approved := true;
//                         Rec.Posted := true;
//                         Rec."Posted By" := UserId;
//                         Rec."Posted Date" := CurrentDateTime;
//                         Rec."Loan No" := LoansApplicationNo;
//                         Rec."Branch Code" := MemberCard."Global Dimension 2 Code";
//                         Rec.Modify(true);
//                     end else begin
//                         Message('User cancellation');
//                     end;
//                 end;
//             }
//             action(Reject)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Reject Loan';
//                 Image = Reject;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     Rec.TestField(submitted, true);
//                     Rec.TestField(Rejected, false);
//                     Rec.TestField(Posted, false);

//                     if not Confirm(CnfReject) then exit;

//                     Rec.TestField("Loan Rejection Reason");

//                     //Internetbanking.SendSms('', Rec.Telephone, 'Harambe Sacco Portal. Your ' + Rec."Loan Type Description" + ' Loan Application has been rejected with the following reason: ' + Rec."Loan Rejection Reason");

//                     Rec.Rejected := true;
//                     Rec.Posted := true;
//                     Rec."Posted By" := UserId;
//                     Rec."Posted Date" := CurrentDateTime;
//                     Rec.Modify;

//                     Message('Loan Application Rejected Successfully');
//                 end;
//             }
//             action("Loan[File]")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Document;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 Visible = false;

//                 trigger OnAction()
//                 var
//                     DMS: Record EDMS;
//                 begin
//                     DMS.Reset;
//                     DMS.SetRange(DMS.Key, DMS.Key::"Online Loans");
//                     if DMS.Find('-') then begin
//                         HyperLink(DMS."url path" + Format(Rec."Application No"));
//                     end;
//                 end;
//             }
//             action("Loan Form")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = "Report";
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     OnlineLoanApplication.Reset;
//                     OnlineLoanApplication.SetRange(OnlineLoanApplication."Application No", Rec."Application No");

//                     if not OnlineLoanApplication.FindFirst then exit;
//                     //REPORT.Run(REPORT::"Online Loan Application Form", true, false, OnlineLoanApplication);
//                 end;
//             }
//             action("CRB Checked")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = DepositSlip;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     if Rec."CRB Checked" then Error(Err003);

//                     if not Confirm(CnfCRB) then exit;

//                     Rec.Validate("CRB Checked", true);
//                     Rec.Modify;
//                 end;
//             }
//             action("Verify Payslip")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Check;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     if Rec."Payslip Verfied" then Error(Err004);

//                     if not Confirm(CnfPayslip) then exit;

//                     Rec.Validate("Payslip Verfied", true);

//                     Rec.Modify;
//                 end;
//             }
//         }
//     }

//     var
//         OnlineLoanApplication: Record "Online Loans Applications";
//         OnlineLoanGuarantors: Record "Online Loan Guarantors";
//         LoansTable: Record Loans;
//         LoansGuarantors: Record "Loan Guarantors and Security";
//         AppraisalSalaryDetails: Record "Appraisal Salary Details";
//         LoansTopup: Record "Loans Top up";
//         RecordLink: Record "Record Link";
//         RecordLinkExisting: Record "Record Link";
//         LoanProcessing: Codeunit "Loans Process";
//         CreditAccounts: Record "Credit Accounts";
//         ProductFactory: Record "Product Factory";
//         MemberCard: Record Members;
//         AcctNo: Code[80];
//         MembNoSeries: Record "Credit Nos. Series";
//         NoSeriesMgt: Codeunit "No. Series";
//         Err001: Label 'Member has a loan %1 marked %2.';
//         CnfReject: Label 'Are you sure you want to reject this loan?';
//         CnfSubmit: Label 'Are you sure you want to send this loan for Appraisal?';
//         // [RunOnClient]
//         // PromptWindow: DotNet Interaction;
//         Reason: Text;
//         Err002: Label 'Kindly input reason for rejection.';
//         SavingsAccounts: Record "Savings Accounts";
//         Err003: Label 'CRB already checked';
//         Err004: Label 'Payslip already verified';
//         CnfPayslip: Label 'Confirm having verified member payslip.';
//         CnfCRB: Label 'Confirm having checked CRB.';
//         AppraisalDetailsSetup: Record "Appraisal Salary Set-up";
//         LoanNo: Code[15];
//         saccoAccount: Record "Savings Accounts";
//         SalBuffer: Record "Salary Lines";
//         SaccoAccount1: Record "Savings Accounts";
//         Loans: Record Loans;

//     //[Scope('OnPrem')]
//     procedure GetAppraisaOrdinaryLoans() QualifiedAmountFinal: Decimal
//     var
//         QualifiedAmount: Text;
//         LoanProductType: Text[10];
//         LoanProductTypeName: Text;
//         Members: Record Members;
//         StandingOrderHeader: Record "Standing Order Header";
//         StandingOrders: Record "Standing Order Lines";
//         sto: Decimal;
//         DepositCont: Decimal;
//         AvailableAmount: Decimal;
//         SaccoAccMemberNo: Code[10];
//         QualifyingAfterDed: Integer;
//         OutstandingAmount: Integer;
//         Salary1: Decimal;
//         Salary2: Decimal;
//         Salary3: Decimal;
//         i: Integer;
//         Minimum: Decimal;
//     begin


//         SaccoAccMemberNo := '';
//         QualifiedAmountFinal := 0;
//         QualifyingAfterDed := 0;
//         sto := 0;
//         OutstandingAmount := 0;
//         DepositCont := 0;

//         saccoAccount.Reset;
//         saccoAccount.SetRange(saccoAccount."Member No.", Rec."Membership No");
//         SavingsAccounts.SetRange("Loan Disbursement Account", true);
//         saccoAccount.SetFilter(saccoAccount.Status, '%1|%2', saccoAccount.Status::Active, saccoAccount.Status::New);
//         if saccoAccount.Find('-') then begin

//             // LOAN product //
//             if ProductFactory.Get(Rec."Loan Type") then begin

//                 SaccoAccMemberNo := saccoAccount."No.";
//                 Salary1 := 0;
//                 Salary2 := 0;
//                 Salary3 := 0;
//                 i := 1;
//                 if (saccoAccount."Employer Code" = '05') or (saccoAccount."Employer Code" = '99') then begin //KDF MEMBERS
//                                                                                                              //MESSAGE('TEST1');
//                     SalBuffer.SetCurrentKey(SalBuffer."Member No.", SalBuffer."Posting Date");
//                     //SalBuffer.SETRANGE(SalBuffer."Account No.",SaccoAccMemberNo);
//                     SalBuffer.SetRange(SalBuffer."Member No.", saccoAccount."Member No.");
//                     SalBuffer.SetRange(SalBuffer.Posted, true);
//                     SalBuffer.SetFilter(SalBuffer."Posting Date", '%1..%2', CalcDate('-3M', CalcDate('<-CM>', Today)), CalcDate('<-CM>', Today));
//                     if (SalBuffer.Count() >= 3) then begin
//                         ///MESSAGE('TEST2');
//                         //Month One
//                         SalBuffer.SetCurrentKey(SalBuffer."Member No.", SalBuffer."Posting Date");
//                         SalBuffer.SetRange(SalBuffer."Member No.", saccoAccount."Member No.");
//                         SalBuffer.SetRange(SalBuffer.Posted, true);
//                         SalBuffer.SetFilter(SalBuffer."Posting Date", '%1..%2', CalcDate('-1M', CalcDate('<-CM>', Today)), CalcDate('<-CM>', Today));
//                         if SalBuffer.CalcSums(SalBuffer.Amount) then
//                             Salary1 := SalBuffer.Amount;
//                         //Month Two
//                         SalBuffer.SetCurrentKey(SalBuffer."Member No.", SalBuffer."Posting Date");
//                         SalBuffer.SetRange(SalBuffer."Member No.", saccoAccount."Member No.");
//                         SalBuffer.SetRange(SalBuffer.Posted, true);
//                         SalBuffer.SetFilter(SalBuffer."Posting Date", '%1..%2', CalcDate('-2M', CalcDate('<-CM>', Today)), CalcDate('-1M', CalcDate('<-CM>', Today)));
//                         if SalBuffer.CalcSums(SalBuffer.Amount) then
//                             Salary2 := SalBuffer.Amount;

//                         //Month Three
//                         SalBuffer.SetCurrentKey(SalBuffer."Member No.", SalBuffer."Posting Date");
//                         SalBuffer.SetRange(SalBuffer."Member No.", saccoAccount."Member No.");
//                         SalBuffer.SetRange(SalBuffer.Posted, true);
//                         SalBuffer.SetFilter(SalBuffer."Posting Date", '%1..%2', CalcDate('-3M', CalcDate('<-CM>', Today)), CalcDate('-2M', CalcDate('<-CM>', Today)));
//                         if SalBuffer.CalcSums(SalBuffer.Amount) then
//                             Salary3 := SalBuffer.Amount;

//                     end;//denis
//                 end;
//                 if Salary1 < Salary2 then begin
//                     Minimum := Salary1;
//                 end else begin
//                     Minimum := Salary2;
//                 end;


//                 if Minimum < Salary3 then begin
//                     Minimum := Minimum;
//                 end else begin
//                     Minimum := Salary3;
//                 end;

//                 ///MESSAGE(FORMAT(Minimum));
//                 ///MESSAGE(FORMAT(QualifyingAfterDed));

//                 StandingOrderHeader.Reset;
//                 //StandingOrderHeader.SETRANGE("Member No.","Member No.");
//                 StandingOrderHeader.SetRange(Status, StandingOrderHeader.Status::Approved);
//                 StandingOrderHeader.SetRange("Source Account No.", SaccoAccMemberNo);
//                 if StandingOrderHeader.Find('-') then begin
//                     repeat
//                         StandingOrders.Reset;
//                         StandingOrders.SetRange("Document No.", StandingOrderHeader."No.");
//                         //StandingOrders.SETRANGE(StandingOrders."Destination Account No.","No.");
//                         //StandingOrders.SETRANGE(s", StandingOrders.Status::Approved);
//                         if StandingOrders.FindFirst then begin
//                             StandingOrders.CalcSums(StandingOrders.Amount);
//                             sto := StandingOrders.Amount + sto;
//                         end;
//                     //MESSAGE('%1',sto);
//                     until StandingOrderHeader.Next = 0;
//                 end;

//                 // check Salary Advance & Salary In Advance Loan Repayment

//                 Loans.Reset;
//                 Loans.SetRange(Loans.Status, Loans.Status::Approved);
//                 Loans.SetRange(Loans."Member No.", saccoAccount."Member No.");
//                 Loans.SetFilter(Loans."Loan Product Type", '%1|%2', '123', '119');
//                 if Loans.Find('-') then begin
//                     repeat
//                         Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
//                         if (Loans."Outstanding Balance" + Loans."Outstanding Interest") > 0 then begin
//                             sto += Loans.Repayment;

//                         end;
//                     until Loans.Next = 0
//                 end;

//                 //check Total Loan Balance

//                 Loans.Reset;
//                 Loans.SetRange(Loans.Status, Loans.Status::Approved);
//                 Loans.SetRange(Loans."Member No.", saccoAccount."Member No.");
//                 //Loans.SETFILTER(Loans."Loan Product Type",'%1|%2','123','119');
//                 if Loans.Find('-') then begin
//                     repeat
//                         Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
//                         if (Loans."Outstanding Balance" + Loans."Outstanding Interest") > 0 then begin
//                             OutstandingAmount += Loans."Outstanding Balance" + Loans."Outstanding Interest";

//                         end;
//                     until Loans.Next = 0
//                 end;

//                 //Chec Deposit

//                 SaccoAccount1.Reset;
//                 SaccoAccount1.SetRange("Member No.", saccoAccount."Member No.");
//                 SaccoAccount1.SetRange("Product Category", SaccoAccount1."Product Category"::"BOSA Deposits");
//                 if SaccoAccount1.Find('-') then begin
//                     SaccoAccount1.CalcFields("Balance (LCY)");
//                     DepositCont := SaccoAccount1."Balance (LCY)";
//                 end;

//                 //Get Qualify Amount
//                 QualifiedAmountFinal := ((Minimum - sto) * 0.5) * (ProductFactory."Ordinary Default Intallments");
//                 AvailableAmount := (DepositCont * 3) - OutstandingAmount;
//                 if AvailableAmount > 0 then begin
//                     if AvailableAmount < QualifiedAmountFinal then
//                         QualifiedAmountFinal := AvailableAmount;
//                 end else
//                     QualifiedAmountFinal := 0;


//             end;
//             //Disqualify Everyyone- STOP THE LOAN
//             //**QualifiedAmountFinal:=0;
//         end;
//     end;
// }

