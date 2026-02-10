// page 52186693 "Expired Transactions"
// {
//     Editable = false;
//     PageType = List;
//     SourceTable = "Reverse ATM Expired Trans";
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;


//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Trace ID"; Rec."Trace ID")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Account Number"; Rec."Account Number")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Amount; Rec.Amount)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Name; Rec.Name)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Actioned; Rec.Actioned)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action("Reverse Transactions")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = ReverseLines;
//                 Promoted = true;

//                 trigger OnAction()
//                 var
//                     SkyPermissions: Record "Sky Permissions";
//                     ATMTransactions: Record "ATM Transactions";
//                 begin
//                     SkyPermissions.Reset;
//                     SkyPermissions.SetRange("User ID", UserId);
//                     SkyPermissions.SetRange("Reverse Sky Transactions", true);
//                     if not SkyPermissions.FindFirst then begin
//                         Error('You do not have the permission to Reverse Mpesa Transactions');
//                     end;


//                     if Confirm('Are you sure you want Reverse all this transactions?') then begin
//                         ReverseATMExpiredTrans.Reset;
//                         ReverseATMExpiredTrans.SetRange(Actioned, false);
//                         if ReverseATMExpiredTrans.FindSet then begin
//                             repeat

//                                 ReverseWithdrawalRequest(ReverseATMExpiredTrans."Trace ID");

//                                 ReverseATMExpiredTrans.Actioned := true;
//                                 ReverseATMExpiredTrans.Modify;

//                             until ReverseATMExpiredTrans.Next = 0;
//                         end;
//                         Message('Done');
//                     end;
//                 end;
//             }
//             action("Import Transactions")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Import;
//                 Promoted = true;
//                 ////RunObject = XMLport "Import Expired Transactions";
//             }
//         }
//     }

//     var
//         Source: Enum "SMS Source";
//         ReverseATMExpiredTrans: Record "Reverse ATM Expired Trans";

//     //[Scope('OnPrem')]
//     procedure ReverseWithdrawalRequest(TraceID: Code[30]): Boolean
//     var
//         SaccoFee: Decimal;
//         VendorCommission: Decimal;
//         TotalCharge: Decimal;
//         SavAcc: Record "Savings Accounts";
//         SaccoAccount: Code[20];
//         VendorAccount: Code[20];
//         MpesaTrans: Record "Sky Transactions";
//         TransAmt: Decimal;
//         BUser: Record "Banking User Template";
//         JTemplate: Code[10];
//         JBatch: Code[10];
//         DocNo: Code[20];
//         PDate: Date;
//         AcctType: Enum "Gen. Journal Account Type";
//         BalAccType: Enum "Gen. Journal Account Type";
//         TransType: Enum "Transaction Types";
//         AccNo: Code[20];
//         BalAccNo: Code[20];
//         ExtDoc: Code[20];
//         LoanNo: Code[20];
//         Dim1: Code[10];
//         Dim2: Code[10];
//         SystCreated: Boolean;
//         RunBal: Decimal;
//         AccBal: Decimal;
//         Loans: Record Loans;
//         IntAmt: Decimal;
//         PrAmt: Decimal;
//         ATMTrans: Record "ATM Transactions";
//         SafcomAcc: Code[20];
//         SafcomFee: Decimal;
//         MobileWithdrawalsBuffer: Record "ATM Transactions";
//         Msg: Text;
//         HMember: Record Members;
//         FName: Text;
//         SkyMbanking: Codeunit "Sky Mbanking";
//     begin
//         MobileWithdrawalsBuffer.Reset;
//         MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer."Trace ID", TraceID);
//         MobileWithdrawalsBuffer.SetRange(MobileWithdrawalsBuffer.Source, MobileWithdrawalsBuffer.Source::"M-PESA");
//         MobileWithdrawalsBuffer.SetRange(Posted, false);
//         MobileWithdrawalsBuffer.SetRange(Reversed, false);
//         if MobileWithdrawalsBuffer.Find('-') then begin

//             MobileWithdrawalsBuffer.Posted := true;
//             MobileWithdrawalsBuffer."Posting Date" := Today;
//             MobileWithdrawalsBuffer.Reversed := true;
//             MobileWithdrawalsBuffer.Description := 'Reversal due to expired transaction';

//             MobileWithdrawalsBuffer."Customer Names" := CopyStr('Reversed By:HARAMBEESACCO\MBANKING', 1, 100);
//             MobileWithdrawalsBuffer.Modify;

//             if SavAcc.Get(MobileWithdrawalsBuffer."Account No") then begin
//                 HMember.Get(SavAcc."Member No.");
//                 FName := HMember."First Name";
//                 if FName = '' then
//                     FName := HMember."Middle Name";
//                 Msg := 'Dear ' + SkyMbanking.FirstName(FName) + ',' + SkyMbanking.NewLine + 'Your transaction of KES ' + Format(MobileWithdrawalsBuffer.Amount) +
//                 ' has expired. Please try again later.' + SkyMbanking.NewLine + 'REF: ' + MobileWithdrawalsBuffer."Trace ID";
//                 SendSMS.SendSms(Source::MBANKING, SavAcc."Transactional Mobile No", msg, Format(MpesaTrans."Transaction ID"), '', true, 0, false, 'CBS', SavAcc."Transactional Mobile No", 'CBS');
//             end;
//         end;
//         // ELSE BEGIN
//         //    MobileWithdrawalsBuffer.RESET;
//         //    MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Trace ID",EntryCode);
//         //    MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer.Source,MobileWithdrawalsBuffer.Source::"M-PESA");
//         //    //MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer."Account No",SavAcc."No.");
//         //    //MobileWithdrawalsBuffer.SETRANGE(MobileWithdrawalsBuffer.Amount,Amount);
//         //    MobileWithdrawalsBuffer.SETRANGE(Posted,TRUE);
//         //    MobileWithdrawalsBuffer.SETRANGE(Reversed,TRUE);
//         //    IF MobileWithdrawalsBuffer.FIND('-') THEN BEGIN
//         //
//         //        IF SavAcc.GET(MobileWithdrawalsBuffer."Account No") THEN BEGIN
//         //            HMember.GET(SavAcc."Member No.");
//         //            FName:=HMember."First Name";
//         //            IF FName='' THEN
//         //              FName := HMember."Middle Name";
//         //            Msg := 'Dear '+FirstName(FName)+','+NewLine+'The '+MobileWithdrawalsBuffer.Description+' of KES '+FORMAT(MobileWithdrawalsBuffer.Amount)+
//         //            ' was unsuccessful. Please try again later'+NewLine+'REF: '+MobileWithdrawalsBuffer."Trace ID";
//         //            SendSms(Source::MBANKING,SavAcc."Transactional Mobile No",Msg,SavAcc."No.",'',TRUE,Priority,FALSE);
//         //        END;
//         //
//         //        EXIT(TRUE);
//         //    END
//         // END;
//     end;

//     var
//     SendSMS: Codeunit SendSms;
//     msg: Text;
// }

