// page 52187305 "Loan Application Card_BOSA"
// {
//     //DeleteAllowed = false;
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Reports,History,Loan File,Cancellation,Category7_caption,Document Movement,Approval Request,CRM Actions,EDMS,,CRB - Metropol';
//     SourceTable = Loans;
//     SourceTableView = WHERE(Posted = CONST(false), "Source Unit" = const(BOSA));
//     DeleteAllowed = false;
//     InsertAllowed = true;//All originations are from CRM
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("Loan No."; Rec."Loan No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("CRM Application No."; Rec."Loan No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     Caption = 'CRM Application No.';
//                 }
//                 field("Source Aplication"; Rec."Source Aplication")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Responsible Officer"; Rec."Responsible Officer")
//                 {
//                     Editable = false;
//                 }

//                 field("Member No."; Rec."Member No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Member No.';
//                     Editable = ApplicationDetailsEdit;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin
//                         SADVisible := false;
//                         if Members.Get(Rec."Member No.") then
//                             if Members."Employer Code" = '05' then
//                                 SADVisible := true;


//                         if ProdFac.Get(Rec."Loan Product Type") then begin
//                             if ProdFac."Mortgage Loan" = true then begin
//                                 Members.Get(Rec."Member No.");
//                                 if Members."Employer Code" = '99' then
//                                     CheckRetirementDate := true
//                                 else
//                                     CheckRetirementDate := false
//                             end;
//                         end;
//                         if Members.Get(Rec."Member No.") then begin
//                             if Members."Phone No." = '' then
//                                 Message('Member must have phone number in the system');

//                             if StrLen(Members."Phone No.") < 10 then
//                                 Message('Member phone number is not valid');
//                         end;
//                     end;
//                 }
//                 field("Staff No"; Rec."Staff No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Staff No';
//                     Editable = false;
//                     TableRelation = Employee."No.";
//                 }
//                 field("Override Loan Qualification"; Rec."Override Loan Qualification")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }

//                 field("Member Name"; Rec."Member Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("SAD No."; Rec."SAD No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = SADVisible;
//                     Visible = false;
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field("Member Deposits"; Rec."Member Deposits")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Loan Product Type"; Rec."Loan Product Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = ApplicationDetailsEdit;
//                     ShowMandatory = true;


//                     trigger OnValidate()
//                     begin
//                         ProdFac.Get(Rec."Loan Product Type");
//                         //Commented for No salary
//                         Members.Get(Rec."Member No.");

//                         if ProdFac."Repay Mode" = ProdFac."Repay Mode"::Salary then begin
//                             //IF NOT (Members."Member Class"='CONTRACT')AND (Members."Employer Code"='00') THEN BEGIN//To cater for BDE To receive salary advance

//                             EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
//                             SalProc.Reset;
//                             SalProc.SetRange("Account No.", Rec."Disbursement Account No");
//                             SalProc.SetRange("Posting Date", EndDateSalo, Today);
//                             SalProc.SetRange(Posted, true);
//                             if SalProc.Find('-') then begin
//                                 if SalProc.Count < ProdFac."No. of Salary Times" then
//                                     Error(Text010);

//                             end else
//                                 Error(Text010);
//                             //END;
//                         end;
//                         ProdFac.Get(Rec."Loan Product Type");

//                         if (ProdFac."Requires Salary Processing" = true) then begin
//                             //IF NOT (Members."Member Class"='CONTRACT') AND (Members."Employer Code"='00')THEN BEGIN//To cater for BDE To receive salary advance
//                             EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
//                             SalProc.Reset;
//                             SalProc.SetRange("Account No.", Rec."Disbursement Account No");
//                             SalProc.SetRange("Posting Date", EndDateSalo, Today);
//                             //SalProc.SETRANGE(Posted,TRUE);
//                             if SalProc.Find('-') then begin
//                                 if SalProc.Count < ProdFac."No. of Salary Times" then
//                                     Error(Text010);

//                             end else
//                                 if Rec."Loan Product Type" = '140' then
//                                     Rec.Installments := 72
//                                 else
//                                     Error(Text010);
//                             //END;
//                         end;

//                         if ProdFac.Get(Rec."Loan Product Type") then begin
//                             if ProdFac."Mortgage Loan" = true then
//                                 IfMortgage := true
//                             else
//                                 IfMortgage := false;
//                         end;

//                         if ProdFac.Get(Rec."Loan Product Type") then begin
//                             if ProdFac."Mortgage Loan" = true then begin
//                                 Members.Get(Rec."Member No.");
//                                 if Members."Employer Code" = '99' then
//                                     CheckRetirementDate := true
//                                 else
//                                     CheckRetirementDate := false
//                             end;
//                         end;

//                         if ProdFac.Get(Rec."Loan Product Type") then begin
//                             if ProdFac."Mortgage Loan" = true then
//                                 IsMortgageLoan := true
//                             else
//                                 IsMortgageLoan := false;

//                             if Rec."Loan Product Type" = '138' then
//                                 IfJenga := true
//                             else
//                                 IfJenga := false;

//                         end;
//                         if ProdFac.Get(Rec."Loan Product Type") then begin
//                             if ProdFac."Shamba Loan" = true then
//                                 IsShambaLoan := true
//                             else
//                                 IsShambaLoan := false;
//                         end;

//                         CurrPage.Update;
//                     end;
//                 }
//                 field("Loan Product Type Name"; Rec."Loan Product Type Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Interest Calculation Method"; Rec."Interest Calculation Method")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Recovery Mode"; Rec."Recovery Mode")
//                 {
//                     ApplicationArea = Basic, Suite;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField("Member No.");
//                         if Rec."Recovery Mode" = Rec."Recovery Mode"::"Internal STO" then begin
//                             SavingsAccounts.Reset;
//                             SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
//                             SavingsAccounts.SetRange("Member No.", Rec."Member No.");
//                             SavingsAccounts.SetRange("Salary Through FOSA", true);
//                             if not SavingsAccounts.FindFirst then Error('Member''s salary does not pass through FOSA');
//                         end;

//                         Rec.TestField("Loan Product Type");
//                         if Rec."Loan Product Type" = '142' then begin
//                             if (Rec."Recovery Mode" <> Rec."Recovery Mode"::Checkoff) and (Rec."Recovery Mode" <> Rec."Recovery Mode"::"Internal STO") then
//                                 Error('Recovery mode must be either Checkoff or internal STO');
//                         end;
//                     end;
//                 }
//                 field("Appraisal Parameter Type"; Rec."Appraisal Parameter Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Retirement/Expiry Date"; Rec."Retirement/Expiry Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = CheckRetirementDate;
//                 }
//                 field(Installments; Rec.Installments)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = ApplicationDetailsEdit;

//                     trigger OnValidate()
//                     begin
//                         if (ProdFac."Requires Salary Processing" = true) then begin
//                             //IF NOT (Members."Member Class"='CONTRACT') AND (Members."Employer Code"='00')THEN BEGIN//To cater for BDE To receive salary advance
//                             EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
//                             SalProc.Reset;
//                             SalProc.SetRange("Account No.", Rec."Disbursement Account No");
//                             SalProc.SetRange("Posting Date", EndDateSalo, Today);
//                             //SalProc.SETRANGE(Posted,TRUE);
//                             if SalProc.Find('-') then begin
//                                 if SalProc.Count < ProdFac."No. of Salary Times" then
//                                     Error(Text010);

//                             end else
//                                 if (Rec."Loan Product Type" = '140') and (Rec.Installments > 72) then begin
//                                     Rec.Installments := 72;
//                                     Message('Installments must less than or equal to 72');
//                                 end;
//                             //END;
//                         end;
//                     end;
//                 }
//                 field(Interest; Rec.Interest)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = ApplicationDetailsEdit;
//                 }
//                 field("Cost Value of House"; Rec."Cost Value of House")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = IfMortgage;
//                     Visible = false;
//                 }
//                 field("Property Cost Value"; Rec."Property Cost Value")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Property Cost Value';
//                     Editable = IsShambaLoan;
//                     Visible = false;
//                 }
//                 field("Requested Amount"; Rec."Requested Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Amount Applied';
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field("Recommended Amount"; Rec."Recommended Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'System Recommended Amount';
//                     Editable = false;
//                 }
//                 field("Approved Amount"; Rec."Approved Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Approved Amount';
//                     Editable = ApplicationDetailsEdit;
//                 }
//                 field("Amount To Disburse"; Rec."Amount To Disburse")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = ApplicationDetailsEdit;

//                     trigger OnValidate()
//                     begin
//                         if Rec."Mode of Disbursement" = Rec."Mode of Disbursement"::"Partial Disbursement" then
//                             UseBatch := true
//                     end;
//                 }
//                 field("Comment for Exemptions"; Rec."Comment for Exemptions")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Remarks; Rec.Remarks)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = true;
//                     Visible = true;
//                 }
//                 field("Commercial Buyoff"; Rec."Commercial Buyoff")
//                 {
//                     ApplicationArea = all;
//                     Editable = EditCom;
//                     trigger OnValidate()
//                     var
//                         myInt: Integer;
//                     begin
//                         if Rec."Commercial Buyoff" = true then
//                             SendBosa := true
//                         else
//                             SendBosa := false;
//                     end;
//                 }
//                 field("CRB Rating"; Rec."CRB Rating")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = ApplicationDetailsEdit;
//                 }
//                 field("Purpose of Loan"; Rec."Purpose of Loan")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = ApplicationDetailsEdit;
//                     // Visible = false;
//                 }
//                 field("Share Boosted Amount"; Rec."Share Boosted Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("BDE Type"; Rec."BDE Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = ApplicationDetailsEdit;
//                 }
//                 field("Relation Officer"; Rec."Relation Officer")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = ApplicationDetailsEdit;
//                 }
//                 field("Loan Appraised By"; Rec."Loan Appraised By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Approved By"; Rec."Approved By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Source Unit"; Rec."Source Unit")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Source Unit';
//                     Editable = false;
//                 }
//                 field("Loans - Deposit Purchase"; Rec."Loans - Deposit Purchase")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Share Boosting- Purchase';
//                     Editable = ApplicationDetailsEdit;

//                     trigger OnValidate()
//                     begin
//                         if Rec."Share Boosted Amount" > Rec."Approved Amount" then
//                             Error('you cannot share boost more than the approved amount');
//                         if Members.Get(Rec."Member No.") then begin
//                             if Cust.Get(Members."Employer Code") then begin
//                                 if Cust."Self Employed" then begin
//                                     Error(ShareBoostError);
//                                     Rec."Share Boosted Amount" := 0.0;
//                                     Rec.Modify;
//                                 end;
//                             end;
//                         end;
//                     end;
//                 }
//                 field("Responsibility Centre"; Rec."Responsibility Centre")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Self Guarantee"; Rec."Self Guarantee")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = ApplicationDetailsEdit;
//                 }
//                 field("Loan Account"; Rec."Loan Account")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Disbursement Account No"; Rec."Disbursement Account No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Batch No."; Rec."Batch No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = UseBatch;
//                     //ditable = true;
//                 }

//                 field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Repayment; Rec.Repayment)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Discounted Amount"; Rec."Discounted Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = ApprovedEdit;
//                 }
//                 field("Mode of Disbursement"; Rec."Mode of Disbursement")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = ApplicationDetailsEdit;

//                     trigger OnValidate()
//                     begin

//                         if Rec."Mode of Disbursement" = Rec."Mode of Disbursement"::"Partial Disbursement" then
//                             UseBatch := true else
//                             UseBatch := false;
//                     end;
//                 }
//                 field("Disbursement Destination"; Rec."Disbursement Destination")
//                 {
//                     ApplicationArea = Basic, Suite;

//                     Editable = false;//ApplicationDetailsEdit;
//                 }
//                 field("Captured By"; Rec."Captured By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Member Age"; Rec."Member Age")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Rejected By"; Rec."Rejected By")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }

//                 field("Details Verified By"; Rec."Details Verified By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Repayment Frequency"; Rec."Repayment Frequency")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Disbursement Date"; Rec."Disbursement Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Repayment Start Date"; Rec."Repayment Start Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     Visible = true;
//                 }
//                 field("Expected Date of Completion"; Rec."Expected Date of Completion")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     Visible = true;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Recover ShareCapital"; Rec."Recover ShareCapital")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                     Visible = false;
//                 }

//                 field("Loan Rejection Reason"; Rec."Loan Rejection Reason")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = DisbursementEdit;

//                     trigger OnValidate()
//                     var
//                         AppraisaComme: Record "Loan Appraisal Comments";
//                     begin


//                         CurrPage.Update;
//                     end;
//                 }

//                 field("Loan Defferal Reason"; Rec."Loan Defferal Reason")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Visible = true;
//                     trigger OnValidate()
//                     var
//                         AppraisaComme: Record "Loan Appraisal Comments";
//                     begin
//                         CurrPage.Update;
//                     end;
//                 }
//                 field("Outstanding Balance"; Rec."Outstanding Balance")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Approval Date"; Rec."Approval Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Sub Sector Level2"; Rec."Sub Sector Level2")
//                 {
//                     ApplicationArea = Basic, Suite;

//                     //Editable = ApplicationDetailsEdit;
//                     //Visible = false;
//                 }
//                 field("Hold Installment(s)"; Rec."Hold Installment(s)")
//                 {

//                 }
//                 field("Number Of Installment(s)"; Rec."Number Of Installment(s)")
//                 {

//                 }
//                 field("Held Funds Comments"; Rec."Held Funds Comments")
//                 {
//                     trigger OnValidate()
//                     var
//                         myInt: Integer;
//                     begin
//                         Rec.TestField("Hold Installment(s)", true);
//                     end;
//                 }
//                 field("Moratorium Loan"; Rec."Moratorium Loan")
//                 {
//                     ApplicationArea = ALL;
//                     Editable = false;

//                 }
//                 field("Current User"; Rec."Current User")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(WorkTime; Rec.WorkTime)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Loan Exceptions"; Rec."Loan Exceptions")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Commercial Approval"; Rec."Commercial Approval")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Days In Arrears"; Rec."Days In Arrears")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }

//             }


//             group("Sectoral Classification")
//             {
//                 Caption = 'Sectoral Classification';
//                 Editable = true;
//                 field("Main Sector"; Rec."Main Sector")
//                 {
//                     ApplicationArea = Basic, Suite;

//                 }
//                 field("Main Sector Description"; Rec."Main Sector Description")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Sub Sector Level1"; Rec."Sub Sector Level1")
//                 {
//                     ApplicationArea = Basic, Suite;

//                 }
//                 field("Sub Sector Level1 Description"; Rec."Sub Sector Level1 Description")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(SubSectorLevel2; Rec."Sub Sector Level2")
//                 {
//                     Caption = 'Sub Sector Level2';
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Sub Sector Level2 Description"; Rec."Sub Sector Level2 Description")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//             }
//             group("Mortage Loan Mandatory Requirement")
//             {
//                 Caption = 'Mortage Loan Mandatory Requirement';
//                 Editable = ApplicationDetailsEdit;
//                 Visible = IsMortgageLoan;
//                 field("Title/Lease Provided"; Rec."Title/Lease Provided")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Title/Lease No"; Rec."Title/Lease No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Three Months Payslip"; Rec."Three Months Payslip")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Mortgage Protection Policy"; Rec."Mortgage Protection Policy")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Mortgage Protection Policy No"; Rec."Mortgage Protection Policy No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Domestic Insurance Cover"; Rec."Domestic Insurance Cover")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Domestic Insurance Cover No"; Rec."Domestic Insurance Cover No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Employer Introduction Letter"; Rec."Employer Introduction Letter")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Six Months Bank Statement"; Rec."Six Months Bank Statement")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("National ID"; Rec."National ID")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("ID No."; Rec."ID No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("KRA PIN Copy"; Rec."KRA PIN Copy")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }

//                 field("KRA PIN"; Rec."KRA PIN")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Vendor Letter/Sale Agreement"; Rec."Vendor Letter/Sale Agreement")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Offer Letter/Draft Sale agreement';
//                 }
//                 field("Injury Benefit Insurance"; Rec."Injury Benefit Insurance")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = IfJenga;
//                 }
//                 field("Drawdown Schedule"; Rec."Drawdown Schedule")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = IfJenga;
//                 }
//                 field("Mortgage Insurance Amount"; Rec."Mortgage Insurance Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             group("Shamba Loan Mandatory Requirements")
//             {
//                 Caption = 'Shamba Loan Mandatory Requirements';
//                 Visible = IsShambaLoan;
//                 field("Sale Agreement"; Rec."Sale Agreement")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("20% Payment Slip"; Rec."20% Payment Slip")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Land Valuation Done"; Rec."Land Valuation Done")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Title Deed"; Rec."Title Deed")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             group("External STO Details")
//             {
//                 Caption = 'External STO Details';
//                 Editable = Rec."Recovery Mode" = Rec."Recovery Mode"::"External STO";
//                 field("Client Bank Code"; Rec."Client Bank Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ShowMandatory = true;
//                 }
//                 field("Client Bank Name"; Rec."Client Bank Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ShowMandatory = true;
//                 }
//                 field("Client Account No"; Rec."Client Account No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ShowMandatory = true;
//                 }
//                 field("External STO  Amount"; Rec."External STO  Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("External STO Effective Date"; Rec."External STO Effective Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ShowMandatory = true;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part("Approved Images"; "Member Picture & Signature")
//             {
//                 Caption = 'Approved Images';
//                 SubPageLink = "Member No" = FIELD("Member No.");
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action("Loan Payment Schedule")
//             {
//                 Visible = false;
//                 ApplicationArea = Basic, Suite;
//                 Image = ReturnCustomerBill;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page "Loan Payment Schedule";
//                 RunPageLink = "Loan No." = FIELD("Loan No.");
//             }
//             action(AssinedUser)
//             {
//                 ApplicationArea = all;
//                 Image = Task;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page "User Tasks";
//                 RunPageLink = "Record ID" = FIELD("Loan No.");
//                 Caption = 'User Assigned';
//             }
//             action("Create Loan Account")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = NewCustomer;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     if ProdFac.Get(Rec."Loan Product Type") then
//                         if Credit.Get(ProdFac."Account No. Prefix" + Rec."Member No." + ProdFac."Account No. Suffix") then
//                             Rec."Loan Account" := ProdFac."Account No. Prefix" + Rec."Member No." + ProdFac."Account No. Suffix"
//                         else begin
//                             Rec."Loan Account" := LoanProcess.CreateLoanAccount(Rec."Member No.", Rec."Loan Product Type");

//                         end;
//                     Rec.Modify;
//                     Message('Loan account created!');
//                 end;
//             }
//             separator(Action44)
//             {
//             }

//             separator(Action21)
//             {
//             }
//             action("Salary Details")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = StatisticsGroup;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunObject = Page "Appraisal Salary Details";
//                 RunPageLink = "Loan No" = FIELD("Loan No."),
//                               "Client Code" = FIELD("Member No.");

//                 trigger OnAction()
//                 begin
//                     //Load defaults
//                     AppraisalDetailsSetup.Reset;
//                     if AppraisalDetailsSetup.Find('-') then begin
//                         repeat
//                             AppraisalSalDetails.Reset;
//                             AppraisalSalDetails.SetRange(AppraisalSalDetails."Loan No", Rec."Loan No.");
//                             AppraisalSalDetails.SetRange(AppraisalSalDetails.Type, AppraisalDetailsSetup.Type);
//                             AppraisalSalDetails.SetRange(Code, AppraisalDetailsSetup.Code);

//                             if AppraisalSalDetails.Find('-') then
//                                 exit;
//                             AppraisalSalDetails.Init;
//                             AppraisalSalDetails."Loan No" := Rec."Loan No.";
//                             AppraisalSalDetails."Client Code" := Rec."Member No.";
//                             AppraisalSalDetails.Code := AppraisalDetailsSetup.Code;
//                             AppraisalSalDetails.Description := AppraisalDetailsSetup.Description;
//                             AppraisalSalDetails.Type := AppraisalDetailsSetup.Type;
//                             AppraisalSalDetails.Insert;
//                         until AppraisalDetailsSetup.Next = 0;
//                     end;
//                 end;
//             }
//             action("Guarantors & Security")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Guarantors& Security';
//                 Image = ItemGroup;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunObject = Page "Loan Guarantors and Security";
//                 RunPageLink = "Loan No" = FIELD("Loan No.");
//             }
//             separator(Action24)
//             {
//             }
//             action("Loan Top Ups")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Add;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunObject = Page "Loan Top Up";
//                 RunPageLink = "Loan No." = FIELD("Loan No."),
//                               "Client Code" = FIELD("Member No.");
//             }
//             action("Send Back to CRM")
//             {
//                 ApplicationArea = all;
//                 Image = Return;
//                 Promoted = true;
//                 PromotedCategory = Category10;
//                 Visible = IsNotSentBackToCRM;
//                 trigger OnAction()
//                 var
//                     AppraisaComme: Record "Loan Appraisal Comments";
//                 begin
//                     Rec.TestField(Status, Rec.Status::Open);

//                     AppraisaComme.Reset();
//                     AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
//                     AppraisaComme.SetRange(Commented, false);
//                     if not AppraisaComme.FindFirst() then
//                         Error('Appraisal Comments Must have a value')
//                     else
//                         if Confirm('This application will be sent back to CRM for editing. Are you sure you want to proceed?') then begin
//                             Rec."Sent Back to CRM" := true;
//                             Rec."Document Excalated" := true;
//                             Rec.Modify;
//                             Message('Document has been sent back to CRM');
//                             AppraisaComme.Reset();
//                             AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
//                             AppraisaComme.SetRange(Commented, false);
//                             if AppraisaComme.FindFirst() then begin
//                                 repeat
//                                     AppraisaComme.Commented := true;
//                                     AppraisaComme.Modify();
//                                 until AppraisaComme.next = 0;
//                             end;

//                             CurrPage.Close();
//                         end;
//                 end;
//             }



//             action("Member Statistics")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = StatisticsGroup;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 PromotedCategory = Process;
//                 RunObject = Page "Member Statistics";
//                 RunPageLink = "No." = FIELD("Member No.");

//                 trigger OnAction()
//                 begin
//                     Rec.TestField(Rec."Member No.");

//                     if UserSetup.Get(UserId) then begin
//                         if UserSetup."Show Hidden" = false then
//                             Error('You do not have permissions to view this account information.');
//                     end;

//                 end;
//             }
//             action("Loans Guaranteed List")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Document;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunObject = Page "Guarantors List";
//                 RunPageLink = "Member No" = FIELD("Member No.");
//             }
//             action("Repayment Method")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Payment;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunObject = Page "Loan Payment Method";
//                 RunPageLink = "Loan No." = FIELD("Loan No."),
//                               "Member No." = FIELD("Member No.");

//                 trigger OnAction()
//                 begin

//                     if Rec."Appraisal Parameter Type" = Rec."Appraisal Parameter Type"::"Check Off" then begin
//                         RepMethods.Reset;
//                         RepMethods.SetRange("Loan No.", Rec."Loan No.");
//                         if not RepMethods.Find('-') then begin
//                             RepMethods."Loan No." := Rec."Loan No.";
//                             RepMethods.Amount := Rec.Repayment;
//                             RepMethods."Member No." := Rec."Member No.";
//                             RepMethods."Payment Method" := RepMethods."Payment Method"::Checkoff;
//                             RepMethods.Insert;
//                         end;
//                     end;
//                 end;
//             }

//             action("Other Commitments Clearance")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Other Commitments/Loan Takeoff.';
//                 Image = Cost;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunObject = Page "Other Commitments Clearance";
//                 RunPageLink = "Loan No." = FIELD("Loan No.");
//             }
//             action("Partial Loan Disbursement Schedule")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Partial Loan Disbursement Schedule';
//                 Image = PutAwayWorksheet;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunObject = Page "Partial Disbursement Schedule";
//                 RunPageLink = "Loan No." = FIELD("Loan No.");
//             }
//             action("Asset Finance Deduction")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = BarCode;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunObject = Page "Asset Finance Loans";
//                 RunPageLink = "Loan No." = FIELD("Loan No.");
//             }
//             action("Loan Appraisal Comments")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = ViewComments;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunPageLink = "Loan No." = FIELD("Loan No.");
//                 RunObject = Page "52187231Loan Appr. Comments";
//             }
//             action("CRM Appraisal Comments")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = ViewComments;
//                 Promoted = true;
//                 PromotedCategory = Category10;
//                 PromotedIsBig = true;
//                 RunPageLink = "Loan No." = FIELD("Loan No.");
//                 RunObject = Page "52187231Loan Appr. Comments";
//                 Visible = IsNotSentBackToCRM;
//             }

//             separator(Action27)
//             {
//             }

//             action("Loan Exceptions.")
//             {
//                 Caption = 'Loan Exceptions';
//                 ApplicationArea = Basic, Suite;
//                 Image = StatisticsGroup;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Visible = false;
//                 PromotedIsBig = true;
//                 RunObject = Page "Exceptions/ Rejection Reason";
//                 RunPageLink = Code = FIELD("Loan No.");

//                 trigger OnAction()
//                 begin
//                     //Load defaults
//                 end;
//             }

//             action("Loan Collateral")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = SocialSecurity;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 RunObject = Page "Loan Collaterals1";
//                 RunPageLink = "Loan No." = FIELD("Loan No."),
//                               "Client Code" = FIELD("Member No.");
//                 Visible = false;
//             }
//             action("Generate Repayment  Schedule")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = ReceivableBill;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     if Rec.Posted then
//                         Error('The loan is already posted thus cannot generate the schedule');

//                     //Delete schedule
//                     RSchedule.Reset;
//                     RSchedule.SetRange(RSchedule."Loan No.", Rec."Loan No.");
//                     RSchedule.DeleteAll;

//                     QCounter := 0;
//                     QCounter := 3;




//                     LoansR.Reset;
//                     LoansR.SetRange(LoansR."Loan No.", Rec."Loan No.");
//                     if LoansR.Find('-') then begin

//                         Rec.TestField("Disbursement Date");
//                         Rec.TestField("Repayment Start Date");


//                         LoanAmount := LoansR."Approved Amount";
//                         InterestRate := LoansR.Interest;
//                         RepayPeriod := LoansR.Installments;
//                         InitialInstal := LoansR.Installments;
//                         LBalance := LoansR."Approved Amount";
//                         RunDate := Rec."Repayment Start Date";
//                         InstalNo := 0;
//                         repeat
//                             InstalNo := InstalNo + 1;
//                             if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::Amortised then begin
//                                 Rec.TestField(Interest);
//                                 Rec.TestField(Installments);
//                                 TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 1, '>');
//                                 LInterest := Round(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
//                                 LPrincipal := TotalMRepay - LInterest;
//                             end;

//                             if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Straight Line" then begin
//                                 Rec.TestField(Interest);
//                                 Rec.TestField(Installments);
//                                 LPrincipal := LoanAmount / RepayPeriod;
//                                 LInterest := (InterestRate / 12 / 100) * LoanAmount;
//                                 // Grace Period Interest
//                                 // LInterest:=(LInterest*InitialInstal)/(InitialInstal-InitialGraceInt);
//                             end;

//                             if (Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Reducing Balance") or
//                               (Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Reducing Flat") then begin
//                                 Rec.TestField(Interest);
//                                 Rec.TestField(Installments);
//                                 LPrincipal := LoanAmount / RepayPeriod;
//                                 LInterest := Round((InterestRate / 12 / 100) * LBalance, 1.0, '>');
//                             end;
//                             /*
//                             IF "Interest Calculation Method"="Interest Calculation Method"::"Straight Line" THEN BEGIN
//                             TESTFIELD(Repayment);
//                             IF LBalance < Repayment THEN
//                             LPrincipal:=LBalance
//                             ELSE
//                             LPrincipal:=Repayment;
//                             LInterest:=Interest;
//                             END;
//                             */
//                             //kma



//                             //Grace Period
//                             if GrPrinciple > 0 then begin
//                                 LPrincipal := 0
//                             end else begin
//                                 //IF "Instalment Period" <> InPeriod THEN
//                                 LBalance := LBalance - LPrincipal;

//                             end;

//                             if GrInterest > 0 then
//                                 LInterest := 0;

//                             GrPrinciple := GrPrinciple - 1;
//                             GrInterest := GrInterest - 1;

//                             Evaluate(RepayCode, Format(InstalNo));

//                             RSchedule.Init;
//                             RSchedule."Repayment Code" := RepayCode;
//                             RSchedule."Loan No." := Rec."Loan No.";
//                             RSchedule."Loan Amount" := LoanAmount;
//                             RSchedule."Instalment No" := InstalNo;
//                             RSchedule."Repayment Date" := RunDate;
//                             RSchedule."Member No." := Rec."Member No.";
//                             RSchedule."Loan Category" := Rec."Loan Product Type";
//                             RSchedule."Monthly Repayment" := Round((LInterest + LPrincipal), 1, '>');
//                             RSchedule."Monthly Interest" := LInterest;
//                             RSchedule."Principal Repayment" := LPrincipal;
//                             RSchedule.Insert;


//                             //Repayment Frequency
//                             if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Daily then
//                                 RunDate := CalcDate('1D', RunDate)
//                             else
//                                 if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Weekly then
//                                     RunDate := CalcDate('1W', RunDate)
//                                 else
//                                     if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Monthly then
//                                         RunDate := CalcDate('1M', RunDate)
//                                     else
//                                         if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Quarterly then
//                                             RunDate := CalcDate('1Q', RunDate)
//                                         else
//                                             if Rec."Repayment Frequency" = Rec."Repayment Frequency"::"Bi-Annual" then
//                                                 RunDate := CalcDate('6M', RunDate)
//                                             else
//                                                 if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Yearly then
//                                                     RunDate := CalcDate('1Y', RunDate);

//                         until LBalance < 1

//                     end;

//                     Commit;
//                     LoanApp.Reset;
//                     LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
//                     if LoanApp.Find('-') then
//                         REPORT.Run(Report::"Ideal Repayment Schedule", true, false, LoanApp);

//                 end;
//             }
//             action("Loan Appraisal Summary")
//             {
//                 Image = Document;
//                 ApplicationArea = Basic, Suite;
//                 Promoted = true;
//                 Visible = false;
//                 PromotedCategory = Process;
//                 Caption = 'Loan Appraisal Summary';
//                 PromotedIsBig = true;
//                 RunObject = Page "Loan Appraisals";
//                 RunPageLink = "Loan No." = FIELD("Loan No.");

//                 trigger OnAction()
//                 var
//                     myInt: Integer;
//                     GlobalFunc: Codeunit "Global Functions";
//                 begin
//                     //Message('testSummary');
//                     GlobalFunc.InsertAppraisalSummary(Rec."Loan No.");
//                 end;

//             }

//             action("Mandatory Requirements")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = RegisteredDocs;
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 PromotedIsBig = true;
//                 RunObject = Page "Loan Required Documents";
//                 RunPageLink = "Loan No." = FIELD("Loan No.");
//             }

//             action("Loan History")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = History;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                 RunObject = Page "Loan History";
//                 RunPageLink = "Loan Application No." = FIELD("Loan No.");
//             }

//             action("Business Income")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 PromotedIsBig = true;
//                 RunObject = Page "Business Incomes";
//                 RunPageLink = "Loan No." = FIELD("Loan No.");

//                 trigger OnAction()
//                 begin
//                     LoanProcess.BusinessLoan(Rec);
//                 end;
//             }

//             action("Financial Business Appraisal")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = BankAccountStatement;
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 PromotedIsBig = true;
//                 RunObject = Page "Business Appraisals";
//                 RunPageLink = "Loan No." = FIELD("Loan No.");
//                 Visible = true;

//                 trigger OnAction()
//                 begin
//                     //Load defaults

//                     if Rec."Appraisal Parameter Type" = Rec."Appraisal Parameter Type"::"Corporate or Business" then begin
//                         BusApprDet.Reset;
//                         BusApprDet.SetRange("Loan No.", Rec."Loan No.");
//                         BusApprDet.SetRange(Position, BusAppr.Position);
//                         if BusApprDet.Find('-') then
//                             BusApprDet.DeleteAll;
//                         BusAppr.Reset;
//                         if BusAppr.Find('-') then begin
//                             repeat
//                                 /*BusApprDet.RESET;
//                                 BusApprDet.SETRANGE("Loan No.","Loan No.");
//                                 BusApprDet.SETRANGE(Position,BusAppr.Position);
//                                 IF BusApprDet.FIND('-') THEN
//                                   EXIT;*/
//                                 TotalLoans := 0;
//                                 BusApprDet.Init;
//                                 BusApprDet.Code := BusAppr."Classifiaction Code";
//                                 BusApprDet.Position := BusAppr.Position;
//                                 BusApprDet.Description := BusAppr.Description;
//                                 if BusApprDet.Code = 'LONG TERM LOANS' then begin
//                                     LoanApp.Reset;
//                                     LoanApp.SetRange("Member No.", Rec."Member No.");
//                                     if LoanApp.Find('-') then begin
//                                         repeat
//                                             LoanApp.CalcFields("Outstanding Balance");
//                                             TotalLoans := TotalLoans + LoanApp."Outstanding Balance";
//                                         until LoanApp.Next = 0;
//                                     end;
//                                 end;
//                                 BusApprDet."Loan With Sacco" := TotalLoans;
//                                 BusApprDet."Financial Classification Code" := BusAppr."Financial Classifiaction";
//                                 BusApprDet."Loan No." := Rec."Loan No.";
//                                 BusApprDet.Insert;
//                             until BusAppr.Next = 0;
//                         end;
//                     end;

//                 end;
//             }
//             separator(Action35)
//             {
//             }
//             action("Business Evaluation Report")
//             {
//                 ApplicationArea = Basic, Suite;
//                 //Image = "REPORT";
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 PromotedIsBig = true;
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     LoanApp.Reset;
//                     LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
//                     //if LoanApp.Find('-') then
//                     //REPORT.Run(52185726, true, false, LoanApp)
//                 end;
//             }
//             action("Loan Appraisal Report")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = "Report";
//                 Promoted = true;
//                 PromotedCategory = "Report";
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 var
//                     loanRecc: Record Loans;
//                 begin
//                     ProdFac.Get(Rec."Loan Product Type");
//                     Rec.TestField("Recovery Mode");
//                     Rec.TestField(Rec."Approved Amount");
//                     LoanApp.Reset;
//                     LoanApp.SetRange(LoanApp."Member No.", Rec."Member No.");
//                     LoanApp.SetRange(LoanApp."Loan Product Type", Rec."Loan Product Type");
//                     LoanApp.SetFilter(LoanApp."Total Loan Balance", '>0');
//                     if LoanApp.Find('-') then begin
//                         LoanApp.CalcFields("Total Loan Balance");
//                         if LoanApp."Total Loan Balance" > LoanApp.Repayment then begin
//                             LoansTopup.Reset;
//                             LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
//                             LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
//                             if not LoansTopup.Find('-') then
//                                 Error('Member has an existing %1 Loan No. %2, Kindly TopUp', Rec."Loan Product Type Name", LoanApp."Loan No.");
//                         end;
//                     end;
//                     LoanApp.Reset;
//                     LoanApp.SetRange(LoanApp."Member No.", Rec."Member No.");
//                     LoanApp.SetRange(LoanApp."Loan Product Type", Rec."Loan Product Type");
//                     LoanApp.SetFilter(LoanApp."Outstanding Balance", '>0');
//                     if LoanApp.Find('-') then begin
//                         LoansTopup.Reset;
//                         LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
//                         LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
//                         if not LoansTopup.Find('-') then
//                             Error('Member has an existing %1 Loan No. %2, Kindly TopUp', Rec."Loan Product Type", LoanApp."Loan No.");
//                     end;

//                     LoanApp.Reset;
//                     LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
//                     if LoanApp.Find('-') then begin
//                         if LoanApp."Appraisal Parameter Type" = LoanApp."Appraisal Parameter Type"::"Check Off" then begin
//                             if (ProdFac."Mortgage Loan" = false) then begin
//                                 REPORT.Run(Report::"Loan Appraisal Checkoff", true, false, LoanApp);
//                                 CreateAppraisalBackup(LoanApp."Loan No.", 52185745);
//                             end else
//                                 if ProdFac."Mortgage Loan" = true then begin
//                                     IF rec."Mortgage Insurance Amount" <= 0 THEN ERROR('Kindly specify Mortgage Insurance amount');
//                                     REPORT.Run(Report::"Loan Appraisal Haramb-Mortgage", true, false, LoanApp);
//                                     CreateAppraisalBackup(LoanApp."Loan No.", 52185957);
//                                 end;
//                         end;
//                         if LoanApp."Appraisal Parameter Type" = LoanApp."Appraisal Parameter Type"::Salary then begin
//                             REPORT.Run(Report::"Loan Appraisal Report-Salaried", true, false, LoanApp);
//                             CreateAppraisalBackup(LoanApp."Loan No.", 52185640);
//                         end;
//                         if LoanApp."Appraisal Parameter Type" = LoanApp."Appraisal Parameter Type"::"Corporate or Business" then begin
//                             REPORT.Run(Report::"Loan Appraisal Bus-Special", true, false, LoanApp);
//                             CreateAppraisalBackup(LoanApp."Loan No.", 52185747);
//                         end;
//                         if LoanApp."Appraisal Parameter Type" = LoanApp."Appraisal Parameter Type"::"Staff Loans" then begin
//                             REPORT.Run(Report::"Loan Appraisal Staff", true, false, LoanApp);
//                             CreateAppraisalBackup(LoanApp."Loan No.", 52186719);
//                         end;
//                     end;

//                 end;
//             }
//             separator(Action53)
//             {
//             }
//             action("Post Advance")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = PostDocument;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     if Confirm('Are you sure you want to Post?', false) = true then begin
//                         if ProdFac.Get(Rec."Loan Product Type") then begin
//                             if ProdFac."Does not Require Batching" then
//                                 LoanProcess.PostSingleLoan(Rec."Loan No.")
//                             else
//                                 Error('This product requires a batch process');
//                         end;
//                     end;
//                 end;
//             }



//             action("Loan Terms And conditions")
//             {
//                 ApplicationArea = all;
//                 Image = DocumentEdit;
//                 Promoted = true;
//                 Caption = '';
//                 PromotedIsBig = true;
//                 PromotedCategory = Process;
//                 RunPageLink = "Loan No." = FIELD("Loan No.");
//                 RunObject = Page "loan Tearms And Conditions";
//             }
//             action("Discount Loan")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Discount;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     if Confirm('Are you sure you want to discount loan?', false) = true then begin
//                         LoanProcess.PostDiscounting(Rec."Loan No.", Rec."Discounted Amount");

//                         //Reset
//                         Rec."Discounted Amount" := 0;
//                         Rec.Modify;
//                     end;
//                 end;
//             }

//             action(Approve)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Approve';
//                 Image = Approve;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                 Visible = LoanApprove;

//                 trigger OnAction()
//                 var
//                 // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                 begin
//                     ProdFac.Get(Rec."Loan Product Type");
//                     if ProdFac."Shamba Loan" = true then begin
//                         Rec.TestField("Land Valuation Done", true);
//                         Rec.TestField("Sale Agreement", true);
//                         Rec.TestField("20% Payment Slip", true);
//                         Rec.TestField("Title Deed");
//                     end;

//                     FoundOne := false;
//                     Rec.TestField("Recovery Mode");
//                     Rec.TestField("Member No.");
//                     if Rec."Recovery Mode" = Rec."Recovery Mode"::Checkoff then begin
//                         StandingOrderHeader.Reset;
//                         StandingOrderHeader.SetRange("Member No.", Rec."Member No.");
//                         StandingOrderHeader.SetRange(Status, StandingOrderHeader.Status::Approved);
//                         if StandingOrderHeader.FindFirst then begin
//                             repeat
//                                 StandingOrderLines.Reset;
//                                 StandingOrderLines.SetRange("Document No.", StandingOrderHeader."No.");
//                                 StandingOrderLines.SetRange("Destination Account Type", StandingOrderLines."Destination Account Type"::Credit);
//                                 StandingOrderLines.SetRange("Loan No.", Rec."Loan No.");
//                                 if StandingOrderLines.FindFirst then begin
//                                     FoundOne := true;
//                                 end;
//                             until StandingOrderHeader.Next = 0;
//                         end;
//                         if FoundOne = false then Error('There is no standing order associated with this loan');
//                     end;


//                     if Rec."Captured By" = UserId then Error('You cannot approve  loan you captured!');

//                     if (Rec."Loan Product Type" <> '142') then
//                         if Rec."Loan Appraised By" <> UserId then Error('Kindly Run the appraisal report');


//                     if (Rec."Loan Product Type" <> '123') and (Rec."Loan Product Type" <> '137') and (Rec."Loan Product Type" <> '138') and (Rec."Loan Product Type" <> '142') then
//                         if Rec."Details Verified By" <> UserId then
//                             Error('Kindly Verify the Guarantor Details and Payslip Details');
//                     // ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
//                     //MESSAGE('Approved');
//                 end;
//             }

//             action(SendApprovalRequest)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Send A&pproval Request';
//                 //Enabled = NOT OpenApprovalEntriesExist;
//                 Image = SendApprovalRequest;
//                 Promoted = true;
//                 PromotedCategory = Category9;

//                 trigger OnAction()
//                 var
//                     CustomApprovals: Codeunit "Custom Approvals Codeunit";
//                     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     MemberClass: Record "Member Classes";
//                     SegmentCountyDividendSignat: Record "Segment/County/Dividend/Signat";
//                     SendM: Boolean;
//                     Loan: Record Loans;
//                     MemberGuarantor: Record Members;
//                     AppraisaComme: record "Loan Appraisal Comments";
//                     SavinA: Record "Savings Accounts";
//                     producfac: Record "Product Factory";
//                     LoansProcess: Codeunit "Loans Process";
//                     NetAmt: Decimal;
//                     TTops: Decimal;
//                     AmountG: Decimal;
//                     DepositAccount: Record "Savings Accounts";

//                     EDMSFunc: Codeunit "EDMS Functions";
//                 begin
//                     // Verify EDMS
//                     if Rec."Source Aplication" <> Rec."Source Aplication"::BC then begin
//                         EDMSFunc.CheckApplicationHasScannedDocuments(Rec."Loan No.");
//                     end;

//                     //Sms send
//                     Rec.TestField(rec."Sent Back to CRM", false);
//                     Rec.TestField("Loan Account");
//                     Rec.TestField("Disbursement Account No");
//                     Rec.TestField("Disbursement Date");
//                     Rec.TestField("Loan Product Type");
//                     Rec.TestField("Amount To Disburse");
//                     Rec.TestField("Global Dimension 1 Code");
//                     Rec.TestField("Loan Account");
//                     //TESTFIELD("Global Dimension 2 Code");
//                     Rec.TestField("Approved Amount");
//                     Rec.TestField("Disbursement Account No");
//                     //Rec.TestField("Sub Sector Level2");
//                     Rec.TestField("Main Sector");
//                     Rec.TestField("Sub Sector Level1");
//                     SendM := true;
//                     AppraisaComme.Reset();
//                     AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
//                     AppraisaComme.SetRange(Commented, false);
//                     if AppraisaComme.FindFirst() then begin
//                         repeat
//                             AppraisaComme.Commented := true;
//                             AppraisaComme.Modify();
//                         until AppraisaComme.Next() = 0;
//                     end;
//                     if Rec."Loan Appraised By" <> UserId then
//                         Error('Kindly Run the appraisal report');
//                     LoansTopup.Reset();
//                     LoansTopup.SetRange("Loan No.", rec."Loan No.");
//                     if LoansTopup.find('-') then begin
//                         LoansTopup.CalcSums("Total Top Up");
//                         TTops := LoansTopup."Total Top Up";
//                         NetAmt := 0;
//                         NetAmt := LoansProcess.ComputeCharges(rec."Approved Amount", LoanApp."Loan Product Type", LoanApp."Loan No.", 0);
//                         //MESSAGE(FORMAT(NetAmt));
//                         if NetAmt <= 0 then
//                             Error('The approved Amount is not sufficient  to offset the total top ups and loan charges.');
//                     end;

//                     //Check the required deposits
//                     if ProdFac."Ordinary Deposits Multiplier" > 0 then begin
//                         DepositAccount.reset;
//                         DepositAccount.SetRange("Member No.", Rec."Member No.");
//                         DepositAccount.SetRange("Product Type", ProdFac."Loan Appraisal Account Code");
//                         if DepositAccount.Find('-') then begin
//                             DepositAccount.CalcFields(Balance);

//                         end;
//                         if (DepositAccount.balance * ProdFac."Ordinary Deposits Multiplier") < Rec."Approved Amount" then
//                             message('The Maximum qualification as per deposits of %1 is %2.', DepositAccount.balance, (DepositAccount.balance * ProdFac."Ordinary Deposits Multiplier"));
//                     end;

//                     if producfac.Get(Rec."Loan Product Type") then begin
//                         SavinA.Reset();
//                         SavinA.SetRange("Member No.", Rec."Member No.");
//                         SavinA.SetRange("Product Category", SavinA."Product Category"::"BOSA Deposits");
//                         if SavinA.FindFirst() then begin
//                             SavinA.CalcFields(Balance);
//                             if SavinA.Balance < producfac."Minimum Deposit Balance" then
//                                 Error('Member has insufficient deposit balance');
//                         end;
//                     end;
//                     if Rec."Commercial Buyoff" = true then
//                         if Rec."Commercial sent" = true then
//                             Error('This loan is awaiting for Fosa Approval');

//                     LoanGua.Reset;
//                     LoanGua.SetRange(LoanGua."Loan No", Rec."Loan No.");
//                     LoanGua.SetRange("SMS Sent", false);
//                     if LoanGua.FindFirst then begin
//                         Message('SMS Messages have been sent to the guarantors');
//                         SendM := true;
//                     end;

//                     if SendM = true then begin

//                         if Loan.Get(Rec."Loan No.") then begin
//                             LoanGua.Reset;
//                             LoanGua.SetRange(LoanGua."Loan No", Rec."Loan No.");
//                             LoanGua.SetRange("SMS Sent", false);
//                             if LoanGua.Find('-') then begin
//                                 repeat
//                                     // MESSAGE(FORMAT(LoanGua."Member No"));
//                                     if Members.Get(LoanGua."Member No") then begin
//                                         if Loan.Posted = true then
//                                             exit;
//                                         CompInfo.Get;
//                                         MemberGuarantor.Get(LoanGua."Member Guaranteed");

//                                         msg := 'Dear Member, You have guaranteed MNo: '
//                                         + LoanGua."Member Guaranteed" + '-' + MemberGuarantor.Name + ' ' + Loan."Loan Product Type Name" + ' of KES ' +
//                                         Format(Loan."Requested Amount") + '. If in dispute call' + ' ' + CompInfo."Phone No.";

//                                         SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loan."Disbursement Account No"), '', true, 0, false, 'CBS', Loan."Disbursement Account No", 'CBS');
//                                     end;
//                                     LoanGua."SMS Sent" := true;
//                                     LoanGua.Modify;
//                                 until LoanGua.Next = 0;

//                                 //END;
//                             end;
//                             if Members.Get(Loan."Member No.") then begin
//                                 if Loan."SMS Sent" = false then begin

//                                     msg := 'You loan application of ' + ' ' + Loan."Loan Product Type Name" + ' of ' + ' Kes' + Format(Loan."Approved Amount") + ' ' + 'is being processed';

//                                     SendSMS.SendSms(Source::MBANKING, Members."Phone No.", msg, Format(Loan."Disbursement Account No"), '', true, 0, false, 'CBS', Loan."Disbursement Account No", 'CBS');
//                                 end;
//                             end;
//                         end;
//                     end;
//                     //SmsEnd
//                     //Check minimum requirements
//                     Rec.TestField("Recovery Mode");
//                     //For DOD Members
//                     if Mem.Get(Rec."Member No.") then begin
//                         if Mem."Employer Code" = '05' then
//                             Rec.TestField("SAD No.");
//                     end;
//                     if rec."Loan Account" = '' then begin
//                         ProdFac.Get(Rec."Loan Product Type");
//                         if Credit.Get(ProdFac."Account No. Prefix" + rec."Member No." + ProdFac."Account No. Suffix") then
//                             rec."Loan Account" := ProdFac."Account No. Prefix" + rec."Member No." + ProdFac."Account No. Suffix";
//                     end;

//                     LoanApp.Reset;
//                     LoanApp.SetRange(LoanApp."Member No.", Rec."Member No.");
//                     LoanApp.SetRange(LoanApp."Loan Product Type", Rec."Loan Product Type");
//                     LoanApp.SetFilter(LoanApp."Total Loan Balance", '>0');
//                     if LoanApp.Find('-') then begin
//                         LoanApp.CalcFields("Total Loan Balance");
//                         if LoanApp."Total Loan Balance" > LoanApp.Repayment then begin
//                             LoansTopup.Reset;
//                             LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
//                             LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
//                             if not LoansTopup.Find('-') then
//                                 Error('Member has an existing %1 Loan No. %2, Kindly TopUp', Rec."Loan Product Type Name", LoanApp."Loan No.");
//                         end;
//                     end;
//                     LoansTopup.Reset;
//                     LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
//                     if LoansTopup.Find('-') then begin

//                         LoansTopup.CalcSums("Total Top Up");
//                     end;

//                     ValidateReq;
//                     TotalOffset := 0;
//                     GenSetup.Get();
//                     if Mem.Get(Rec."Member No.") then begin
//                         RetirementDate := CalcDate(Format(GenSetup."Max. Member Age"), Mem."Date of Birth");
//                         if Mem."Employer Code" <> '99' then begin
//                             if Mem."From Another Sacco" = false then begin
//                                 ClientAge := HRDates.DetermineAge(Mem."Date of Birth", Today);
//                                 ClientAgePart := CopyStr(ClientAge, 1, 2);
//                                 ClientAgePart := CopyStr(ClientAge, 1, 2);
//                                 Evaluate(ClientAgeValue, ClientAgePart);
//                                 adj := Round((((RetirementDate - Rec."Repayment Start Date") / 365) * 12), 1, '<');
//                                 if adj < Rec.Installments then
//                                     if Rec."Override Loan Qualification" = false then
//                                         Error('This member is ' + ClientAgePart + ' ' + 'yrs' + ',' + 'and will be retiring in' + ' ' + Format(adj) + ' ' + 'Months, Override Loan qaulification with Comments');
//                                 if Mem.Subflag = Mem.Subflag::Defaulter then
//                                     if Rec."Override Loan Qualification" = false then
//                                         Error('The Member is a defaulter, Override loan qualification');
//                             end;
//                         end;
//                     end;
//                     ProdFac.Get(Rec."Loan Product Type");
//                     //Commented for No salary

//                     if ProdFac."Repay Mode" = ProdFac."Repay Mode"::Salary then begin
//                         EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
//                         SalProc.Reset;
//                         SalProc.SetRange("Account No.", Rec."Disbursement Account No");
//                         SalProc.SetRange("Posting Date", EndDateSalo, Today);
//                         SalProc.SetRange(Posted, true);
//                         if SalProc.Find('-') then begin
//                             if SalProc.Count < ProdFac."No. of Salary Times" then
//                                 Error(Text010);

//                         end;
//                     end;
//                     ProdFac.Get(Rec."Loan Product Type");
//                     if ProdFac."Requires Salary Processing" = true then begin
//                         EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
//                         SalProc.Reset;
//                         SalProc.SetRange("Account No.", Rec."Disbursement Account No");
//                         SalProc.SetRange("Posting Date", EndDateSalo, Today);
//                         SalProc.SetRange(Posted, true);
//                         if SalProc.Find('-') then begin
//                             if SalProc.Count < ProdFac."No. of Salary Times" then
//                                 Error(Text010);

//                         end;/* ELSE
//                        ERROR(Text010);*/
//                     end;
//                     Members.Get(Rec."Member No.");
//                     Cust.Reset;
//                     Cust.SetRange("No.", Members."Employer Code");
//                     if Cust.Find('-') then begin
//                         if (Cust."Loan Qualification" = Cust."Loan Qualification"::"Basic Pay") or (Cust."Loan Qualification" = Cust."Loan Qualification"::"Gross Pay") then
//                             if (Rec."Appraisal Parameter Type" = Rec."Appraisal Parameter Type"::"Check Off") or (Rec."Appraisal Parameter Type" = Rec."Appraisal Parameter Type"::Salary) then begin
//                                 AppraisalSalDetails.Reset;
//                                 AppraisalSalDetails.SetRange("Loan No", Rec."Loan No.");
//                                 if not AppraisalSalDetails.Find('-') then
//                                     Error(Text009);
//                                 if (AppraisalSalDetails.Type = AppraisalSalDetails.Type::"Gross Pay") and (AppraisalSalDetails.Amount = 0) then
//                                     Error('Kindly capture Basic Salary information');
//                             end else begin
//                                 RepMethods.Reset;
//                                 RepMethods.SetRange("Loan No.", Rec."Loan No.");
//                                 if RepMethods.Find('-') then begin
//                                     if (RepMethods."Payment Method" <> RepMethods."Payment Method"::"Standing Order(External)") and
//                                       (RepMethods."Payment Method" <> RepMethods."Payment Method"::"Standing Order(Internal)") then
//                                         Error(Text013);
//                                 end;
//                             end;
//                     end else
//                         Error(Text012);



//                     //Check costs
//                     PartialSched.Reset;
//                     PartialSched.SetRange(PartialSched."Loan No.", Rec."Loan No.");
//                     if PartialSched.Find('-') then begin
//                         PartialSched.CalcSums(PartialSched.Amount);
//                         if Rec."Amount To Disburse" + PartialSched.Amount <> Rec."Approved Amount" then
//                             Error(AmtErr);
//                     end;

//                     ///Rec.TestField("Sub Sector Level2");
//                     ProdFac.Get(Rec."Loan Product Type");
//                     if ProdFac."Mortgage Loan" = true then begin
//                         Rec.TestField("Three Months Payslip", true);
//                         //TESTFIELD("Mortgage Protection Policy",TRUE);
//                         //TESTFIELD("Domestic Insurance Cover",TRUE);
//                         Rec.TestField("Employer Introduction Letter", true);
//                         Rec.TestField("Six Months Bank Statement", true);
//                         Rec.TestField("National ID", true);
//                         Rec.TestField("Title/Lease Provided", true);
//                         Rec.TestField("Title/Lease No");
//                         Rec.TestField("ID No.");
//                         Rec.TestField("KRA PIN");
//                         Rec.TestField("KRA PIN Copy", true);
//                         Rec.TestField("Vendor Letter/Sale Agreement", true);
//                         "CheckDisbursementA/CBalance"(Rec."Disbursement Account No");
//                         //IF "Mortgage Insurance Amount"<=0 THEN ERROR('Kindly specify Mortgage Insurance amount');
//                         if Rec."Loan Product Type" = '138' then begin
//                             Rec.TestField("Drawdown Schedule", true);
//                             Rec.TestField("Injury Benefit Insurance", true);
//                         end;
//                     end;


//                     if Rec."Loan Product Type" = '142' then begin
//                         Rec.TestField("Land Valuation Done", true);
//                         Rec.TestField("Sale Agreement", true);
//                         Rec.TestField("20% Payment Slip", true);
//                         Rec.TestField("Title Deed");
//                     end;
//                     //Check if product allows multiple loans and if offset
//                     LoanApp.Reset;
//                     LoanApp.SetRange("Member No.", Rec."Member No.");
//                     LoanApp.SetRange(Posted, true);
//                     LoanApp.SetRange("Loan Product Type", Rec."Loan Product Type");
//                     LoanApp.SetFilter("Outstanding Balance", '>0');
//                     if LoanApp.Find('-') then begin
//                         repeat
//                             if ProdFac.Get(Rec."Loan Product Type") then begin
//                                 if ProdFac."Allow Multiple Running Loans" = false then begin
//                                     LoansTopup.Reset;
//                                     LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
//                                     LoansTopup.SetRange("Loan No.", Rec."Loan No.");
//                                     if not LoansTopup.Find('-') then
//                                         Error('Member already has an existing Loan %1 of same product', LoanApp."Loan No.");

//                                 end;
//                             end;
//                         until LoanApp.Next = 0;
//                     end;
//                     GenSetup.Get;
//                     //Confirm amounts
//                     LoansTopup.Reset;
//                     LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
//                     if LoansTopup.Find('-') then begin
//                         LoansTopup.CalcSums(LoansTopup."Total Top Up");
//                         TotalOffset := LoansTopup."Total Top Up";
//                     end;
//                     LoanApp.Reset;
//                     LoanApp.SetRange("Member No.", Rec."Member No.");
//                     LoanApp.SetFilter("Outstanding Balance", '>0');
//                     LoanApp.SetFilter("Loans Category-SASRA", '%1..%2', GenSetup."Allowed Loan Categories", LoanApp."Loans Category-SASRA"::Loss);
//                     if LoanApp.Find('-') then begin
//                         repeat
//                             if GenSetup."Allowed Loan Categories" <> LoanApp."Loans Category-SASRA"::Loss then begin
//                                 LoansTopup.Reset;
//                                 LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
//                                 if not LoansTopup.Find('-') then begin
//                                     // Error('Member has a loan that is not performing %1', LoanApp."Loan No.");
//                                     if Confirm('Member has a loan that is not performing, Loan no. ' + LoanApp."Loan No." + ' Do you need top up?,') = true then
//                                         exit
//                                 end;
//                             end;
//                         until LoanApp.Next = 0;
//                     end;
//                     ExternalComm.Reset;
//                     ExternalComm.SetRange(ExternalComm."Loan No.", Rec."Loan No.");
//                     if ExternalComm.Find('-') then begin
//                         ExternalComm.CalcSums(ExternalComm.Amount);
//                         TotalOffset := TotalOffset + ExternalComm.Amount;
//                     end;
//                     if TotalOffset >= Rec."Approved Amount" then
//                         Error(Text002, TotalOffset, Rec."Approved Amount");
//                     TotalAssetFin := 0;
//                     AssetFinanceLoan.Reset;
//                     AssetFinanceLoan.SetRange(AssetFinanceLoan."Loan No.", Rec."Loan No.");
//                     if AssetFinanceLoan.Find('-') then begin
//                         AssetFinanceLoan.CalcSums(AssetFinanceLoan.Amount);
//                         TotalAssetFin := TotalAssetFin + AssetFinanceLoan.Amount;
//                     end;
//                     if TotalAssetFin >= Rec."Approved Amount" then
//                         Error(Text014, TotalAssetFin, Rec."Approved Amount");
//                     //ConfirmReyments
//                     LoanRepay := 0;
//                     PaymentMethods.Reset;
//                     PaymentMethods.SetRange(PaymentMethods."Loan No.", Rec."Loan No.");
//                     PaymentMethods.SetRange(PaymentMethods."Member No.", Rec."Member No.");
//                     if PaymentMethods.Find('-') then begin
//                         repeat
//                             LoanRepay := LoanRepay + PaymentMethods.Amount;
//                         until PaymentMethods.Next = 0;
//                     end;
//                     if LoanRepay <> 0 then begin
//                         if LoanRepay <> Rec.Repayment then
//                             Error(ErrMssage);
//                     end;
//                     //
//                     Members.Get(Rec."Member No.");
//                     if Members.Status <> Members.Status::Active then
//                         Error("InactiveErr:");
//                     if Rec."Self Guarantee" = false then begin
//                         if ProdFac.Get(Rec."Loan Product Type") then begin
//                             LoanGua.Reset;
//                             LoanGua.SetRange(LoanGua."Loan No", Rec."Loan No.");
//                             if LoanGua.Find('-') then begin
//                                 LoanGua.CalcSums("Amount Guaranteed");
//                                 AmountG := LoanGua."Amount Guaranteed";
//                             end;
//                             if producfac."Secured Loan" = true then
//                                 if AmountG < Rec."Approved Amount" then
//                                     Error('The loan is not fully secured');
//                         end;
//                     end;
//                     Members.Get(Rec."Member No.");
//                     SegmentCountyDividendSignat.Reset;
//                     SegmentCountyDividendSignat.SetRange(Type, SegmentCountyDividendSignat.Type::Segment);
//                     SegmentCountyDividendSignat.SetRange(Code, Members."Member Segment");
//                     if SegmentCountyDividendSignat.Find('-') then begin
//                         MemberClass.Reset;
//                         MemberClass.SetRange("No.", Members."Member Class");
//                         if MemberClass.FindFirst then begin
//                             //Share Capital
//                             SavAcc.Reset;
//                             SavAcc.SetRange("Member No.", Rec."Member No.");
//                             SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Share Capital");
//                             if SavAcc.Find('-') then begin
//                                 SavAcc.CalcFields("Balance (LCY)");
//                                 if (SavAcc."Balance (LCY)") < MemberClass."Share Capital" then
//                                     Error('Share capital less than Kes %1', MemberClass."Share Capital");
//                             end;
//                         end;
//                     end;
//                     if Rec."Recovery Mode" = Rec."Recovery Mode"::"External STO" then begin
//                         Rec.TestField("Client Bank Code");
//                         Rec.TestField("Client Account No");
//                         Rec.TestField("External STO Effective Date");
//                     end;
//                     CompInfo.Get;
//                     VarVariant := Rec;
//                     if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
//                         CustomApprovals.OnSendDocForApproval(VarVariant);
//                     CurrPage.Close();
//                 end;
//             }
//             action(CancelApprovalRequest)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Cancel Approval Re&quest';
//                 Enabled = OpenApprovalEntriesExist;
//                 Image = Cancel;
//                 Visible = true;
//                 Promoted = true;
//                 PromotedCategory = Category9;

//                 trigger OnAction()
//                 var
//                     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     AppraisaComme: record "Loan Appraisal Comments";
//                 begin
//                     AppraisaComme.Reset();
//                     AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
//                     AppraisaComme.SetRange(Commented, false);
//                     if not AppraisaComme.FindFirst() then
//                         Error('Appraisal Comments Must have a value');
//                     VarVariant := Rec;
//                     CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
//                     CurrPage.Close();
//                 end;
//             }
//             action("Send To Fosa")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Send Document To Fosa';
//                 Promoted = true;
//                 PromotedCategory = Category8;
//                 Enabled = SendBosa;
//                 PromotedIsBig = true;
//                 PromotedOnly = true;
//                 trigger OnAction()
//                 var
//                     myInt: Integer;
//                     SMSSource: Enum "SMS Source";
//                     AppraisaComme: record "Loan Appraisal Comments";
//                 begin

//                     Rec.TestField(Rec.Status, Rec.Status::Open);
//                     Rec.TestField("Commercial Buyoff", true);
//                     rec.TestField("Commercial sent", false);
//                     AppraisaComme.Reset();
//                     AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
//                     AppraisaComme.SetRange(Commented, false);
//                     if not AppraisaComme.FindFirst() then
//                         Error('Appraisal Comments Must have a value');
//                     if Confirm('Do you want to send this document to Fosa') = true then begin
//                         rec."Commercial Approval" := 'Awaiting Fosa Actions';
//                         rec."Commercial sent" := true;
//                         Rec.Modify();
//                         CompInfo.get();
//                         if Members.Get(Rec."Member No.") then begin
//                             msg := 'Dear ' + Members."First Name" + ' your loan has been trasffered to fosa.for further querries kindly call ' + CompInfo."Phone No." + ' .';
//                             SendSMS.SendSms(SMSSource::DMU, Members."Phone No.", msg, Format(Rec."Loan No."), '', true, 0, false, 'CBS', Rec."Loan No.", 'CBS');
//                             Message('Sms sent  Successfully');
//                             AppraisaComme.Reset();
//                             AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
//                             AppraisaComme.SetRange(Commented, false);
//                             if AppraisaComme.FindFirst() then begin
//                                 repeat
//                                     AppraisaComme.Commented := true;
//                                     AppraisaComme.Modify();
//                                 until AppraisaComme.next = 0;
//                             end;
//                         end;
//                     end;
//                     CurrPage.Close();
//                 end;

//             }
//             action(Comments)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = ViewComments;
//                 Promoted = true;
//                 PromotedCategory = Category9;

//                 RunObject = page "Comments List";
//                 RunPageLink = "Header No." = field("Loan No.");
//                 RunPageView = where(Types = CONST(comment));
//             }
//             action("Re-Open Deferred  Loan")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Visible = true;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 Caption = 'Re-Open Document';
//                 PromotedCategory = Category8;
//                 Image = ReOpen;

//                 trigger OnAction()
//                 var
//                     AppraisaComme: Record "Loan Appraisal Comments";
//                 begin

//                     AppraisaComme.Reset();
//                     AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
//                     AppraisaComme.SetRange(Commented, false);
//                     if not AppraisaComme.FindFirst() then
//                         Error('Appraisal Comments Must have a value');

//                     //Rec.TestField(Status, Rec.Status::Deffered);
//                     if (Rec.Status = Rec.Status::Deffered) or (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) then begin
//                         if not Confirm('Are you sure you want to re-open the loan?') then exit;
//                         Rec.Status := Rec.Status::Open;
//                         Rec."Loan Defferal Reason" := '';
//                         rec."Loan Rejection Reason" := '';
//                         Rec.Modify(true);
//                     end;
//                     CurrPage.Close();
//                 end;
//             }
//             action(Archive)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Archive Application';
//                 Image = Archive;
//                 //Visible = RejectVisible;
//                 Promoted = true;
//                 PromotedCategory = Category9;

//                 trigger OnAction()
//                 var
//                     GlobalFunctions: Codeunit "Global Functions";
//                 begin
//                     if Rec.Status = Rec.Status::Archived then
//                         Error(('This record is already in archived state.'));
//                     GlobalFunctions.CommentsManagement(Rec."Loan No.");
//                     if not Rec.posted then begin
//                         if not Confirm('Are you sure you want to archive this record?') then exit;
//                         GlobalFunctions.CancelApprovalManually(Rec.RecordId);
//                         Rec.Status := Rec.Status::Archived;
//                         Rec.Validate(Status);
//                         Rec.Modify(true);
//                         Message('Record archived succsessfully');
//                     end else
//                         Error('You cannot archive a created record');
//                 end;
//             }
//             action(Approvals)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Approvals';
//                 Image = Approvals;
//                 Promoted = true;
//                 PromotedCategory = Category9;

//                 trigger OnAction()
//                 var
//                     //ApprovalEntries: Page "Approval Entries";
//                     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                 begin

//                     ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
//                 end;
//             }
//             action("Change Current user'")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Change Current User';
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                 trigger OnAction()
//                 var
//                     myInt: Integer;
//                 begin
//                     if Rec."Current User" <> '' then begin
//                         Rec."Current User" := UserId;
//                         Rec.WorkTime := CurrentDateTime;
//                         rec.modify();
//                         Message('Changes Updated!');
//                     end;

//                 end;
//             }
//             action("Loan [File]")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Document;
//                 Promoted = true;
//                 PromotedCategory = Category4;

//                 trigger OnAction()
//                 var
//                     DMS: Record EDMS;
//                 begin
//                     DMS.Reset;
//                     DMS.SetRange(DMS.Key, DMS.Key::"Loan File");
//                     if DMS.Find('-') then begin
//                         HyperLink(DMS."url path" + Rec."Loan No.");
//                     end;
//                 end;
//             }
//             separator(Action67)
//             {
//             }
//             action(Statement)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Customer;
//                 Promoted = true;
//                 PromotedCategory = "Report";

//                 trigger OnAction()
//                 begin
//                     CustMembr.Reset;
//                     CustMembr.SetRange(CustMembr."No.", Rec."Member No.");
//                     if CustMembr.Find('-') then
//                         REPORT.Run(Report::"Member Detailed Statement", true, false, CustMembr);
//                 end;
//             }
//             action("Loan Offer Letter")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = OrderPromising;
//                 Promoted = true;
//                 PromotedCategory = "Report";

//                 trigger OnAction()
//                 begin
//                     LoanApp.RESET;
//                     LoanApp.SETRANGE(LoanApp."Loan No.", Rec."Loan No.");
//                     LoanApp.SETRANGE(LoanApp."Member No.", Rec."Member No.");
//                     IF LoanApp.FIND('-') THEN BEGIN
//                         //REPORT.RUN(50101, TRUE, FALSE, LoanApp);
//                         REPORT.RUN(Report::"Loan Offer Letter", true, false, LoanApp);
//                     END;
//                 end;
//             }
//             action(Approves)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     Rec.Status := Rec.Status::Approved;
//                     Rec.Modify(true);
//                 end;
//             }
//             action("Download Appraisal Used")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Note;
//                 Promoted = true;
//                 Visible = AppraisalFile;

//                 trigger OnAction()
//                 var
//                     FromFile: Text[400];
//                     ToFolder: Text[300];
//                     Name: Text;
//                     EDMS: Record EDMS;
//                     url: Text;
//                 begin
//                     EDMS.Reset;
//                     EDMS.SetRange(Key, EDMS.Key::"Appraisal File");
//                     if EDMS.FindFirst then url := EDMS."url path";
//                     FromFile := url + 'appraisal' + Rec."Member No." + Rec."Loan No." + '.pdf';
//                     Name := 'appraisal' + Format(Rec."Member No.") + Format(Rec."Loan No.");
//                     // Download(FromFile, 'Appraisal report', '', 'Text file(*.pdf)|*.pdf', Name);
//                 end;
//             }
//             action("Loan Defferal Reasons")
//             {
//                 ApplicationArea = all;
//                 Image = Note;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 PromotedCategory = Process;
//                 RunObject = page "Loan Defferals";
//                 RunPageLink = "Loan No." = field("Loan No."), "Member No" = field("Member No.");
//             }
//             action("Charge Excemptions.")
//             {
//                 ApplicationArea = all;
//                 Image = Note;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 PromotedCategory = Process;
//                 RunObject = page "Excempted Product Charges";
//                 RunPageLink = "Loan No." = field("Loan No.");//, "Product Code" = field("Loan Product Type");
//                 trigger OnAction()
//                 begin
//                     //Load defaults
//                     ProductCharges.Reset();
//                     ProductCharges.SetRange("Product Code", Rec."Loan Product Type");
//                     ProductCharges.SETRANGE("Charge Type", ProductCharges."Charge Type"::"Top up");
//                     if ProductCharges.find('-') then begin
//                         repeat
//                             ExcemptCharges.reset;
//                             ExcemptCharges.setrange("Loan No.", Rec."Loan No.");
//                             ExcemptCharges.setrange("Charge Code", ProductCharges."Charge Code");
//                             if not ExcemptCharges.find('-') then begin
//                                 ExcemptCharges.Init();
//                                 ExcemptCharges."Loan No." := Rec."Loan No.";
//                                 ExcemptCharges."Charge Code" := ProductCharges."Charge Code";
//                                 ExcemptCharges."Product Code" := Rec."Loan Product Type";
//                                 ExcemptCharges."Charge Description" := ProductCharges."Charge Description";
//                                 ExcemptCharges.Insert;

//                             end;

//                         until ProductCharges.Next = 0;
//                     end;
//                 end;
//             }

//             action("Post Loan")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = PostBatch;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Visible = PostLoan;

//                 trigger OnAction()
//                 begin
//                     ProdFac.Get(Rec."Loan Product Type");
//                     if ProdFac."Shamba Loan" = true then begin
//                         Rec.TestField("Land Valuation Done", true);
//                         Rec.TestField("Sale Agreement", true);
//                         Rec.TestField("20% Payment Slip", true);
//                         Rec.TestField("Title Deed");
//                     end;


//                     Rec.TestField("Recovery Mode");
//                     UserSetup1.Reset;
//                     UserSetup1.SetRange("User ID", UserId);
//                     UserSetup1.SetRange("Credit FOSA Account", true);
//                     if not UserSetup1.Find('-') then Error('Yo do not have permissions to run this process kindly contact your system administrator');
//                     Rec.TestField(Posted, false);
//                     Rec.TestField(Status, Rec.Status::Approved);
//                     if Confirm('Do You want to post this loan of Member No' + '...' + Rec."Member No." + '...' + 'Loan No' + '...' + Rec."Loan No.") then begin
//                         //Posting.PostLoanNormal();

//                         Posting.PostLoanNormal(Rec."Loan No.");
//                         //Send SMS when Topup


//                         if Rec."Hold Installment(s)" then begin
//                             OneMonthInstallment.Init();
//                             OneMonthInstallment."Record No." := Rec."Loan No.";
//                             OneMonthInstallment."Member No." := Rec."Member No.";
//                             OneMonthInstallment."Principal Amount" := Rec."Loan Principle Repayment";
//                             OneMonthInstallment."Interest Amount" := Rec."Loan Interest Repayment";
//                             if Rec."Number Of Installment(s)" > 0 then
//                                 OneMonthInstallment.Total := (Rec."Loan Interest Repayment" + Rec."Loan Principle Repayment") * Rec."Number Of Installment(s)" else
//                                 OneMonthInstallment.Total := Rec."Loan Interest Repayment" + Rec."Loan Principle Repayment";
//                             OneMonthInstallment."Created By" := UserId;
//                             OneMonthInstallment."Funds Status" := OneMonthInstallment."Funds Status"::WithHeld;
//                             OneMonthInstallment."Held Funds Comments" := Rec."Held Funds Comments";
//                             OneMonthInstallment."Entry Date" := CurrentDateTime;
//                             OneMonthInstallment.Insert();
//                         end;
//                         //exit;
//                         LoansTopup.Reset;
//                         LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
//                         if LoansTopup.FindFirst then begin
//                             repeat
//                                 LoanGuar.Reset;
//                                 LoanGuar.SetRange("Loan No", LoansTopup."Loan Top Up");
//                                 LoanGuar.SetRange("Self Guarantee", false);
//                                 if LoanGuar.FindFirst then begin
//                                     if Loans2.Get(LoanGuar."Loan No") then begin
//                                         ProductType := Loans2."Loan Product Type Name";
//                                         AppAmount := Loans2."Approved Amount";
//                                     end;
//                                     repeat
//                                         if Members.Get(LoanGuar."Member No") then
//                                             CompInfo.Get;
//                                     //TICKET:#608 STOP SMS TO GUARANTORS ON CLEARED LOANS
//                                     // msg := 'Dear ' + LoanGuar.Name + ', The ' + ProductType + ' of Ksh. ' + Format(AppAmount) + ', you had guaranteed ' + LoanGuar."Loanee Name" + ' is now fully repaid.';
//                                     // SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loans2."Disbursement Account No"), '', true, 0, false, 'CBS', Loans2."Disbursement Account No", 'CBS');

//                                     until LoanGuar.Next = 0;
//                                 end;
//                             until LoansTopup.Next = 0;
//                         end;



//                         //Set FOSA Savings Account to Frozen

//                         LoanGuar.Reset;
//                         LoanGuar.SetRange(LoanGuar."Loan No", Rec."Loan No.");
//                         LoanGuar.SetFilter("Guarantor Type", '%1', LoanGuar."Guarantor Type"::Collateral);
//                         if LoanGuar.FindFirst then
//                             SavingsAccounts.Reset;
//                         SavingsAccounts.SetRange("Member No.", LoanGuar."Savings Account No./Member No.");
//                         SavingsAccounts.SetRange("Loan Disbursement Account", true);
//                         if SavingsAccounts.FindFirst then begin
//                             SavingsAccounts.Status := SavingsAccounts.Status::Frozen;
//                             SavingsAccounts."Status Change Reason" := 'FROZEN: Refer to Investment Manager';
//                             SavingsAccounts.Modify;
//                         end;
//                         Message('Loan Posted Successfully');
//                     end;
//                     CurrPage.Close();
//                 end;
//             }
//         }

//         area(Processing)
//         {
//             group("EDMS Integration")
//             {
//                 // action("Import")
//                 // {
//                 //     ApplicationArea = All;
//                 //     Caption = 'Import File';
//                 //     Promoted = true;
//                 //     PromotedCategory = Category11;
//                 //     Image = Import;

//                 //     trigger OnAction()
//                 //     var
//                 //         Base64Convert: Codeunit "Base64 Convert";
//                 //         TempBlob: Codeunit "Temp Blob";
//                 //         InStr: InStream;
//                 //         ApplicantMember: Record Members;

//                 //         EDMSFunctions: Codeunit "EDMS Functions";
//                 //         FileName: Text;
//                 //         FileContentsB64: Text;

//                 //         IDNumber: Text;
//                 //         ApplicationType: Label 'LA'; // Loan Application
//                 //         PFNumber: Text;
//                 //     begin
//                 //         if Rec."Loan No." <> '' then begin
//                 //             FileName := EDMSFunctions.PickEDMSFile(TempBlob);

//                 //             TempBlob.CreateInStream(InStr);
//                 //             FileContentsB64 := Base64Convert.ToBase64(InStr);

//                 //             if FileContentsB64 <> '' then begin
//                 //                 ApplicantMember.Reset;

//                 //                 ApplicantMember.SetRange("No.", Rec."Member No.");

//                 //                 if ApplicantMember.FindFirst then begin
//                 //                     if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
//                 //                         IDNumber := ApplicantMember."Primary Identification";
//                 //                     end else
//                 //                         if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
//                 //                             IDNumber := ApplicantMember."Secondary Identification";
//                 //                         end else begin
//                 //                             IDNumber := ApplicantMember."Primary Identification";
//                 //                         end;

//                 //                     if ApplicantMember."Payroll/Staff No." <> '' then begin
//                 //                         PFNumber := ApplicantMember."Payroll/Staff No.";
//                 //                     end else begin
//                 //                         PFNumber := IDNumber;
//                 //                     end;

//                 //                     EDMSFunctions.EDMSLoanFileUpload(
//                 //                       IDNumber,
//                 //                         ApplicantMember.Name,
//                 //                         Rec."Loan Product Type Name",
//                 //                         PfNumber,
//                 //                         ApplicantMember."No.",
//                 //                         Rec."Loan No.",
//                 //                         Rec."Loan No.",
//                 //                         FileName,
//                 //                         FileContentsB64,
//                 //                         false
//                 //                     );
//                 //                 end;
//                 //             end;
//                 //         end else begin
//                 //             Error('Application No. is required for EDMS document upload');
//                 //         end;
//                 //     end;
//                 // }
//                 action("EDMS File List")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = Documents;
//                     Promoted = true;
//                     PromotedCategory = Category11;

//                     RunObject = page "Channel Application Documents";
//                     RunPageLink = "Application No." = field("Loan No.");
//                 }
//             }

//             // group("CRB - Metropol")
//             // {
//             //     action("Report Type 4: [PDF Report]")
//             //     {
//             //         ApplicationArea = All;
//             //         Caption = 'Full Credit Report';
//             //         Promoted = true;
//             //         PromotedCategory = Category13;
//             //         Image = Report;

//             //         RunObject = Page "CRB Metropol PDF Viewer";
//             //         RunPageLink = "Loan No." = field("Loan No.");

//             //         // trigger OnAction()
//             //         // begin
//             //         //     if not confirm('Are you sure you want to get the credit score report of the loan applicant from Metropol?') then begin
//             //         //         Error('Operation cancelled successfully');
//             //         //     end;
//             //         // end;
//             //     }
//             // }
//         }

//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         if Rec."Commercial sent" = true then
//             CurrPage.Editable := false;
//         StatusControl;
//         Rec."Source Unit" := Rec."Source Unit"::BOSA;
//         SendToBosa();

//         CRMControl();
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         Rec."Source Unit" := Rec."Source Unit"::BOSA;
//         UserSet.Reset();
//         UserSet.SetRange(UserSet."User ID", UserId);
//         UserSet.SetRange(UserSet."Member No.", Rec."Member No.");
//         if UserSet.FindFirst() then
//             Error('You cannot process your own loan');
//     end;

//     trigger OnNewRecord(BelowXrec: Boolean)
//     var
//         myInt: Integer;
//     begin
//         CRMControl();
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         if Rec."Commercial sent" = true then
//             CurrPage.Editable := false;
//         SetControlAppearance;
//         StatusControl;
//         SendToBosa;

//         CRMControl();

//         if ProdFac.Get(Rec."Loan Product Type") then begin
//             if ProdFac."Mortgage Loan" = true then
//                 IfMortgage := true
//             else
//                 IfMortgage := false
//         end;

//         if ProdFac.Get(Rec."Loan Product Type") then begin
//             if ProdFac."Mortgage Loan" = true then begin
//                 Members.Get(Rec."Member No.");
//                 if Members."Employer Code" = '99' then
//                     CheckRetirementDate := true
//                 else
//                     CheckRetirementDate := false
//             end;
//         end;

//         if ProdFac.Get(Rec."Loan Product Type") then begin
//             if ProdFac."Mortgage Loan" = true then
//                 IsMortgageLoan := true
//             else
//                 IsMortgageLoan := false;
//             if Rec."Loan Product Type" = '138' then
//                 IfJenga := true
//             else
//                 IfJenga := false;

//         end;
//     end;

//     trigger OnClosePage()
//     begin

//         if Rec."Member No." <> '' then begin
//             if Rec."Current User" = UserId then begin
//                 Rec."Discounted Amount" := 0;
//                 Rec."Current User" := '';
//                 Rec.Modify;
//             end;
//         end;
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         UserSet.Reset();
//         UserSet.SetRange(UserSet."User ID", UserId);
//         UserSet.SetRange(UserSet."Member No.", Rec."Member No.");
//         if UserSet.FindFirst() then
//             Error('You cannot process your own loan');
//         StatusControl;

//     end;

//     trigger OnOpenPage()
//     var
//         membersRec: Record Members;
//         proFac: Record "Product Factory";
//         ShreAmt: Decimal;
//         memebrrec: Record Members;

//         Tominutes: Integer;
//         LoanReqDocs: Record "Loan Required Documents";
//     begin
//         GenSetup.Get();
//         SendToBosa;
//         if Rec."Commercial sent" = true then begin
//             Message('This is a commercial loan awaiting Fosa approvals');
//             CurrPage.Editable := false;
//         end;

//         CRMControl();

//         LoanReqDocs.Reset();
//         LoanReqDocs.SetRange("Loan No.", Rec."Loan No.");
//         LoanReqDocs.SetFilter(LoanReqDocs."Provided ?", '<>%1', LoanReqDocs."Provided ?"::Yes);
//         if LoanReqDocs.FindFirst() then
//             Message('Member has mandary document to be provided');
//         if Rec."Member No." <> '' then begin
//             if rec."Current User" <> UserId then
//                 if Rec."Current User" = '' then begin
//                     Rec."Current User" := UserId;
//                     Rec.WorkTime := CurrentDateTime;
//                     rec.Modify();
//                 end Else
//                     if rec."Current User" <> '' then begin

//                         TestDurat := CurrentDateTime - rec.WorkTime;
//                         if TestDurat < GenSetup."Release Doc Time" then begin
//                             CurrPage.Editable := false;
//                             message('User %1 is operating on the card', Rec."Current User");
//                         end else begin
//                             Rec."Current User" := UserId;
//                             Rec.WorkTime := CurrentDateTime;
//                             rec.Modify();
//                         end;
//                     end;
//         end;
//         memebrrec.Reset();
//         memebrrec.SetRange(memebrrec."No.", Rec."Member No.");
//         if memebrrec.FindFirst() then begin
//             Rec."Member Age" := (ROUND((TODAY - memebrrec."Date of Birth") / 365.2364, 1, '<'));
//             Rec.Modify();
//         end;

//         ShreAmt := 0;
//         proFac.Reset();
//         proFac.SetRange(proFac."Product Category", proFac."Product Category"::"Share Capital");
//         if proFac.FindFirst() then begin
//             if Rec."Member No." <> '' then begin
//                 SavAcc.Reset();
//                 SavAcc.SetRange("Member No.", Rec."Member No.");
//                 SavAcc.setrange("Product Category", SavAcc."Product Category"::"Share Capital");
//                 if SavAcc.FindFirst() then begin
//                     SavAcc.CalcFields(SavAcc.Balance);
//                     if SavAcc.Balance < proFac."Minimum Contribution" then begin
//                         ShreAmt := proFac."Minimum Contribution" - SavAcc.Balance;
//                         Message('Member has a balance of %1 on share capital contribution', Format(ShreAmt));
//                     end;
//                 end;
//             end;
//         end;

//         if rec."Source Unit" = rec."Source Unit"::BOSA then begin
//             if Mem.Get(Rec."Member No.") then begin
//                 RetirementDate := CalcDate(Format(GenSetup."Max. Member Age"), Mem."Date of Birth");
//                 if Mem."Employer Code" <> '99' then begin
//                     if Mem."From Another Sacco" = false then begin
//                         if Mem."Date of Birth" <> 0D then begin
//                             ClientAge := HRDates.DetermineAge(Mem."Date of Birth", Today);
//                             ClientAgePart := CopyStr(ClientAge, 1, 2);
//                             ClientAgePart := CopyStr(ClientAge, 1, 2);
//                             Evaluate(ClientAgeValue, ClientAgePart);
//                             if Rec."Repayment Start Date" <> 0D then
//                                 adj := Round((((RetirementDate - Rec."Repayment Start Date") / 365) * 12), 1, '<');
//                             if adj > 0 then begin
//                                 if adj < Rec.Installments then
//                                     if Rec."Override Loan Qualification" = false then
//                                         Message('This member is ' + ClientAgePart + ' ' + 'yrs' + ',' + ' and will be retiring in' + ' ' + Format(adj) + ' ' + 'Months');
//                             end else
//                                 Message('This member is ' + ClientAgePart + ' ' + 'yrs' + ',' + ' and was suppose to retire' + ' ' + Format(Abs(adj)) + ' ' + 'Months ago')
//                         end;
//                     end;
//                 end;
//             end;
//         end;
//         membersRec.Reset();
//         membersRec.SetRange("No.", rec."Member No.");
//         if membersRec.FindFirst() then
//             Message('The status of this member is %1', membersRec.Subflag);
//         if Rec."Current User" <> UserId then begin
//             UserSet.Reset();
//             UserSet.SetRange(UserSet."User ID", UserId);
//             UserSet.SetRange(UserSet."Member No.", Rec."Member No.");
//             if UserSet.FindFirst() then
//                 Error('You cannot process your own loan');
//         end;

//         StatusControl;
//         Rec."Source Unit" := Rec."Source Unit"::BOSA;
//         if Strlen(Rec."Captured By") <= 50 then begin
//             if UserSetup.Get(Rec."Captured By") then begin
//                 Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
//                 Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
//                 Rec."Responsibility Center" := UserSetup."Responsibility Centre";
//                 Rec.Modify;
//             end;
//         end;

//         if ProdFac.Get(Rec."Loan Product Type") then begin
//             if ProdFac."Mortgage Loan" = true then
//                 IfMortgage := true
//             else
//                 IfMortgage := false;
//             if Rec."Loan Product Type" = '138' then
//                 IfJenga := true
//             else
//                 IfJenga := false;
//         end;

//         if ProdFac.Get(Rec."Loan Product Type") then begin
//             if ProdFac."Mortgage Loan" = true then begin
//                 Members.Get(Rec."Member No.");
//                 if Members."Employer Code" = '99' then
//                     CheckRetirementDate := true
//                 else
//                     CheckRetirementDate := false
//             end;
//         end;
//         if ProdFac.Get(Rec."Loan Product Type") then begin
//             if ProdFac."Mortgage Loan" = true then
//                 IsMortgageLoan := true
//             else
//                 IsMortgageLoan := false;

//         end;

//         if ProdFac.Get(Rec."Loan Product Type") then begin
//             if ProdFac."Shamba Loan" = true then
//                 IsShambaLoan := true
//             else
//                 IsShambaLoan := false;
//         end;
//     end;

//     local procedure CRMControl()
//     begin
//         if Rec."Source Aplication" = Rec."Source Aplication"::CRM then begin
//             if Rec."Sent Back to CRM" then begin
//                 IsNotSentBackToCRM := false;
//             end else begin
//                 IsNotSentBackToCRM := true;
//             end;
//         end else begin
//             IsNotSentBackToCRM := false;
//         end;
//     end;



//     var
//         PageEdit: Boolean;
//         IsNotSentBackToCRM: boolean;
//         IsNotSentBackToMSmart: boolean;
//         Text001: Label 'Status Must Be Open';
//         adj: Integer;
//         pinst: Integer;
//         HRDates: Codeunit "HR Dates 2";
//         ClientAgeValue: Integer;
//         ClientAgePart: Text;
//         ClientAge: Text;
//         ProdMinAgeText: Text;
//         TestDurat: Duration;
//         ProdMinAge: Integer;
//         RetirementDate: Date;
//         Mem: Record Members;
//         UserSet: Record "User Setup";
//         UserSetup: Record "User Setup";
//         CustMembr: Record Members;
//         LoanProcess: Codeunit "Loans Process";
//         UpdateMember: Codeunit "DCS Management";
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         VarVariant: Variant;
//         CustomApprovals: Codeunit "Custom Approvals Codeunit";
//         GetScore: Codeunit "DCS Management";
//         LoansR: Record Loans;
//         LoanAmount: Decimal;
//         InterestRate: Decimal;
//         RepayPeriod: Integer;
//         LBalance: Decimal;
//         RunDate: Date;
//         InstalNo: Decimal;
//         RepayInterval: DateFormula;
//         TotalMRepay: Decimal;
//         LInterest: Decimal;
//         LPrincipal: Decimal;
//         RepayCode: Code[40];
//         GrPrinciple: Integer;
//         GrInterest: Integer;
//         QPrinciple: Decimal;
//         QCounter: Integer;
//         InPeriod: DateFormula;
//         SendBosa: Boolean;
//         InitialInstal: Integer;
//         InitialGraceInt: Integer;
//         RSchedule: Record "Ideal Repayment Schedule";
//         LoanApp: Record Loans;
//         PartialSched: Record "Partial Disbursement Schedule";
//         AmtErr: Label 'Total  partial disbursement Amount PLUS current amount to diburse must be equal to approved amount';
//         AppraisalDetailsSetup: Record "Appraisal Salary Set-up";
//         AppraisalSalDetails: Record "Appraisal Salary Details";
//         LReq: Record "Loan Mandatory Requirements";
//         LoanGua: Record "Loan Guarantors and Security";
//         Coll: Record "Loan Collateral";
//         Found: Boolean;
//         SecErr: Label 'You have not provided neither collateral nor guarantors';
//         SavAcc: Record "Savings Accounts";
//         DepErr: Label 'This member does not have a deposit account';
//         SalErr: Label 'Salary information is expected';
//         ApplDocs: Record "Product Documents";
//         LoanReqDocs: Record "Loan Required Documents";
//         BusinessIncome: Record "Business Income";
//         SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
//         Members: Record Members;
//         LoansTopup: Record "Loans Top up";
//         ExternalComm: Record "Other Commitements Clearance";
//         TotalOffset: Decimal;
//         Text002: Label 'Total offset of %1 is more than approved amount of %2';
//         ProdFac: Record "Product Factory";
//         Text003: Label 'Loan Account is invalid';
//         Vend: Record Vendor;
//         GLAcc: Record "G/L Account";
//         Text004: Label 'The fund is already exhausted';
//         PaymentMethods: Record "Payment Methods";
//         LoanRepay: Decimal;
//         ErrMssage: Label 'Repayment distribution is not equal to the loan repayment amount';
//         Text005: Label 'Amount guaranteed is less than approved amount';
//         Text006: Label 'Minimum number of guarantors not provided. They should be at least %1';
//         Text007: Label 'Both Minimum Guarantors on Max Amt and Max Amt on Guarantors must be defined';
//         Text008: Label 'The number of guarantors expected is less than the expected number of %1 where amount is more than %2';
//         "InactiveErr:": Label 'This member is not active thus cannot qualify for a loan';
//         RepMethods: Record "Payment Methods";
//         CompInfo: Record "Company Information";
//         Text009: Label 'This product requires salary details';
//         EndDateSalo: Date;
//         SalProc: Record "Salary Lines";
//         Text010: Label 'This member does not receive salary through the sacco';
//         Text011: Label 'There are documents to be provided : %1';
//         BusAppr: Record "Financial Appraisal setup";
//         BusApprDet: Record "Business Loan Appraisal";
//         TotalLoans: Decimal;
//         GenSetup: Record "General Set-Up";
//         Cust: Record Customer;
//         Text012: Label 'The employer code is missing';
//         Text013: Label 'Standing order must be provided for this loan';
//         "******************************************************Controls": Integer;
//         ApplicationDetailsEdit: Boolean;
//         DisbursementEdit: Boolean;
//         ApprovedEdit: Boolean;
//         Credit: Record "Credit Accounts";
//         AssetFinanceLoan: Record "Asset Finance Loan";
//         TotalAssetFin: Decimal;
//         Text014: Label 'Total Asset Finance of %1 is more than approved amount of %2';
//         SubSectorLevel2: Code[30];
//         IfMortgage: Boolean;
//         CheckRetirementDate: Boolean;
//         IsMortgageLoan: Boolean;
//         IfJenga: Boolean;
//         ShareBoostingField: Boolean;
//         ShareBoostError: Label 'This member is  Self Employed. Therefore cannot apply for share boosting';
//         Text0015: Label 'This Member Does not fullfill all the conditions';
//         IsShambaLoan: Boolean;
//         LoanGuar: Record "Loan Guarantors and Security";
//         SavingsAccounts: Record "Savings Accounts";
//         Posting: Codeunit "Loans Process";
//         Loans2: Record Loans;
//         ProductType: Text;
//         PAGEEDITABLE: Boolean;
//         EditCom: Boolean;
//         AppAmount: Decimal;
//         UseBatch: Boolean;
//         UserSetup1: Record "User Setup";
//         AppliedAmountEdit: Boolean;
//         SADVisible: Boolean;
//         StandingOrderHeader: Record "Standing Order Header";
//         StandingOrderLines: Record "Standing Order Lines";
//         FoundOne: Boolean;
//         LoanApprove: Boolean;
//         AppraisalFile: Boolean;
//         PostLoan: Boolean;
//         OneMonthInstallment: Record "One Month Installment";
//         SendSMS: Codeunit SendSms;
//         msg: Text;
//         Source: enum "SMS Source";
//         ProductCharges: Record "Loan Product Charges";
//         ExcemptCharges: Record "Excempted Product Charges";

//     local procedure SendToBosa()
//     var
//         myInt: Integer;
//     begin
//         if Rec."Commercial Buyoff" = true then
//             SendBosa := true
//         else
//             SendBosa := false;
//     end;

//     local procedure SetControlAppearance()
//     var
//     // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     begin
//         // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
//         // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
//         if Rec."Captured By" <> USERID THEN
//             PAGEEDITABLE := FALSE;
//     end;

//     local procedure ValidateReq()
//     begin
//         if ProdFac.Get(Rec."Loan Product Type") then begin
//             if CopyStr(ProdFac."Account No. Prefix", 1, 2) <> CopyStr(Rec."Loan Account", 1, 2) then
//                 Error(Text003);
//         end;


//         //Required documents
//         LoanReqDocs.Reset;
//         LoanReqDocs.SetRange("Loan No.", Rec."Loan No.");
//         if LoanReqDocs.Find('-') then begin
//             repeat
//                 if (LoanReqDocs."Provided ?" = LoanReqDocs."Provided ?"::" ") or (LoanReqDocs."Provided ?" = LoanReqDocs."Provided ?"::No) then
//                     Error(Text011, LoanReqDocs.Description);
//             until LoanReqDocs.Next = 0;
//         end;

//         //Check if external funds and confirm if funds are available
//         if ProdFac."Source of Funds" = ProdFac."Source of Funds"::"External Fund" then begin
//             ProdFac.TestField("Source Of Funds No.");
//             if Vend.Get(ProdFac."Source Of Funds No.") then begin
//                 Vend.CalcFields("Balance (LCY)");
//                 if GLAcc.Get(ProdFac."Loan  Account [G/L]") then begin
//                     GLAcc.CalcFields(Balance);
//                 end;

//                 if (GLAcc.Balance + Rec."Approved Amount") > Vend."Balance (LCY)" then
//                     Error(Text004);

//             end;
//         end;
//         LReq.Reset;
//         LReq.SetRange(LReq."Loan No.", Rec."Loan No.");
//         if LReq.Find('-') then begin
//             case LReq."Mandatory Requirement" of

//                 LReq."Mandatory Requirement"::"Business Income":
//                     begin

//                     end;
//                 LReq."Mandatory Requirement"::"Collateral or Guarantors":
//                     begin
//                         Found := false;
//                         LoanGua.Reset;
//                         LoanGua.SetRange(LoanGua."Loan No", Rec."Loan No.");
//                         if LoanGua.Find('-') then
//                             Found := true;

//                         Coll.Reset;
//                         Coll.SetRange(Coll."Loan No.", Rec."Loan No.");
//                         if Coll.Find('-') then
//                             Found := true;

//                         if Found = false then
//                             Error(SecErr);

//                     end;
//                 LReq."Mandatory Requirement"::"Member Deposits":
//                     begin
//                         SavAcc.Reset;
//                         SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits");
//                         SavAcc.SetRange(SavAcc."Member No.", Rec."Member No.");
//                         if not SavAcc.Find('-') then begin
//                             Error(DepErr);
//                         end;

//                     end;
//                 LReq."Mandatory Requirement"::Salary:
//                     begin
//                         AppraisalSalDetails.Reset;
//                         AppraisalSalDetails.SetRange(AppraisalSalDetails."Client Code", Rec."Member No.");
//                         if AppraisalSalDetails.Find('-') then begin
//                             AppraisalSalDetails.CalcSums(AppraisalSalDetails.Amount);
//                             if AppraisalSalDetails.Amount = 0 then
//                                 Error(SalErr);
//                         end else
//                             Error(SalErr);

//                     end;
//             end;
//         end;
//     end;

//     //[Scope('OnPrem')]
//     procedure StatusControl()
//     begin
//         if Rec."Commercial Buyoff" = true then
//             if Rec."Commercial sent" = false then
//                 SendBosa := true
//             else
//                 SendBosa := false;

//         if Rec."Commercial Approval" = 'Fosa Approved' then
//             EditCom := false
//         else
//             EditCom := true;
//         if Rec."Sent Back to CRM" = true then
//             CurrPage.Editable := false;
//         if Rec."Sent Back to M-Smart" = true then
//             CurrPage.Editable := false;
//         if Rec.Posted then AppraisalFile := true;
//         case Rec.Status of
//             Rec.Status::Open:
//                 begin
//                     ApplicationDetailsEdit := true;
//                     DisbursementEdit := true;
//                     ApprovedEdit := false;
//                     AppliedAmountEdit := true;
//                 end;

//             Rec.Status::Pending:
//                 begin
//                     ApplicationDetailsEdit := false;
//                     DisbursementEdit := false;
//                     AppliedAmountEdit := false;
//                     LoanApprove := true;

//                 end;
//             Rec.Status::Rejected:
//                 begin
//                     ApplicationDetailsEdit := false;
//                     DisbursementEdit := false;
//                     AppliedAmountEdit := false;
//                 end;
//             Rec.Status::Approved:
//                 begin
//                     ApprovedEdit := true;
//                     ApplicationDetailsEdit := false;
//                     DisbursementEdit := false;
//                     AppliedAmountEdit := false;
//                     PostLoan := true;
//                 end;
//         end;
//         if Rec."Mode of Disbursement" = Rec."Mode of Disbursement"::"Partial Disbursement" then
//             UseBatch := true else
//             UseBatch := false;

//         if Rec."Member No." <> '' then begin
//             if Members.Get(Rec."Member No.") then
//                 if Members."Employer Code" = '05' then
//                     SADVisible := true;
//         end;
//     end;

//     local procedure "CheckDisbursementA/CBalance"(Account: Code[30])
//     var
//         cashierTransactions: Record "Cashier Transactions";
//         lienAmount: Decimal;
//         saccoAccount: Record "Savings Accounts";
//         Accounttypes: Record "Product Factory";
//         MiniBalance: Decimal;
//         AccountBal: Decimal;
//     begin
//         GenSetup.Get;
//         saccoAccount.Reset;
//         saccoAccount.SetRange(saccoAccount."No.", Account);
//         saccoAccount.SetRange(saccoAccount."Product Type", '505');
//         if saccoAccount.Find('-') then begin
//             Accounttypes.Reset;
//             Accounttypes.SetRange(Accounttypes."Product ID", saccoAccount."Product Type");
//             if Accounttypes.Find('-') then begin
//                 MiniBalance := Accounttypes."Minimum Balance";
//             end;
//             saccoAccount.CalcFields(saccoAccount."Balance (LCY)");
//             saccoAccount.CalcFields(saccoAccount."ATM Transactions");
//             saccoAccount.CalcFields(saccoAccount."Uncleared Cheques");


//             cashierTransactions.Reset;
//             cashierTransactions.SetRange("Account No", saccoAccount."No.");
//             cashierTransactions.SetRange(Posted, true);
//             cashierTransactions.SetRange(Type, cashierTransactions.Type::Lien);
//             cashierTransactions.SetRange("Cheque Status", cashierTransactions."Cheque Status"::Pending);
//             if cashierTransactions.Find('-') then begin
//                 repeat
//                     lienAmount += cashierTransactions.Amount;
//                 until cashierTransactions.Next = 0;
//             end;

//             AccountBal := saccoAccount."Balance (LCY)" - (saccoAccount."ATM Transactions" + saccoAccount."Uncleared Cheques" + MiniBalance + lienAmount);

//             if AccountBal < GenSetup."Mortgage FOSA Min Balance" then Error('Account No %1 balance must be over %2', Rec."Disbursement Account No", GenSetup."Mortgage FOSA Min Balance");
//         end
//     end;

//     local procedure CreateAppraisalBackup(LoanNumber: Code[40]; ReportNumber: Integer)
//     var
//         Loans: Record Loans;
//         EDMS: Record EDMS;
//         url: Text;
//         FilePath: Text;

//         RecRef: RecordRef;
//         BlobOutStream: OutStream;
//         BlobInStream: InStream;
//         Base64Convert: Codeunit "Base64 Convert";
//         TempBlob: Codeunit "Temp Blob";
//     begin
//         Loans.Reset;
//         Loans.SetRange("Loan No.", LoanNumber);
//         if Loans.FindFirst then begin
//             // EDMS.Reset;
//             // EDMS.SetRange(Key, EDMS.Key::"Appraisal File");
//             // if EDMS.FindFirst then begin
//             //     url := EDMS."url path";
//             //     FilePath := url + 'appraisal' + Loans."Member No." + Loans."Loan No." + '.pdf';
//             //     if (Loans.Status = Loans.Status::Open) or (Loans.Status = Loans.Status::Pending) then begin
//             //         if Exists(FilePath) then Erase(FilePath);
//             //         REPORT.SaveAsPdf(ReportNumber, FilePath, Loans);
//             //     end;
//             // end;

//             if (Loans.Status = Loans.Status::Open) or (Loans.Status = Loans.Status::Pending) then begin
//                 TempBlob.CreateOutStream(BlobOutStream, TextEncoding::UTF8);
//                 RecRef.GetTable(Loans);
//                 Report.SaveAs(ReportNumber, '', ReportFormat::Pdf, BlobOutStream, RecRef);
//             end;
//         end;
//     end;
// }

