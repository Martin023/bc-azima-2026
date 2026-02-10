// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185657 "Process BDE Payments"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem("BDE Management Header"; "BDE Management Header")
//         {
//             column(ReportForNavId_1; 1)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 GeneralSetUp.Get;

//                 anagement.Reset;
//                 anagement.SetRange("Processin g   Date", EndDate);
//                 if BDEManagement.Find('-') then
//                     BDEManagement.DeleteAll;

//                 //*******New Loans
//                 BDEManagementLines.Reset;
//                 BDEManagementLines.SetRange("Header No",
//                 BDEManagementLines.SetRange("Header No", "BDE Management Header"."No.");
//                 //BDEManagementLines.SETRANGE("Product Type",Loans."Loan Product Type");
//                 if  repeat
//                         TotalAmount := 0;
//                 TotalAmount := 0;
//                 Loans.Reset;
//                 Loans.SetRange("Relation Officer", " BDE  Mana gement Header"."Employee No");
//                 Loans.SetRange("Loan Produc StartDate, Date, Date, entLines."Product Type");
//                                 Loans.SetRange("Disburs emen t Da te", StartDate, EndDate);
//                 Loans.SetRange("Loan BDE Paid", false);
//                 if      repeat

//                                 TotalAmount := TotalAmount + TotalAmount + TotalAmount +
//                             //To = 0;
//                             LoansCount := ount := ount := Next=0;
//             end;



//                             BDEManagement.Reset;
//                       if    EntryNo := No := No := ement.Find(' + 1;
//                         if TotalAmount <> nt <> nt <> Management."Entry No"+1;
//                                             if TotalAmount<>0 then be > TotalAmount then
//                                             if BDEManagementL EntryNo,  EntryNo,  EntryN 1,  >TotalA 1, unt then 1,  / 100) *  / 100) * TotalAmount, LoansCount, EndDate, ansCount, EndDate,   
//                             else begin
//                                 AboveTarget := TotalAmount - TotalAmount - TotalAmount - 
//                                 ComissionLoans := AboveTarget * AboveTarget * AboveTarget * Managemen / Lines."Indivi / ual Target"; / 
//                                                     Comission EntryNo, bo EntryNo, *( En 1, yNo, etUp. 1, DE Loan Ab 1, e Targe / 100) * TotalAmount) + ComissionLoans, LoansCount, EndDate, , LoansCount, EndDate, e,    
//                             end;
//                         end;
//                     // END;

//        = 0; = 0; = 0;
//             until BDEManagementLines.Next=0;
//                   end;

//                 ///********New Members
//                 SavingsAccounts.Reset;   
//                 SavingsAccounts.SetRange("Recruited By","BDE Manageme   nt Header"."Employee No");
//                 SavingsAccounts.SetRange("Loan Disbursement A StartDate, , , ue);
//                 SavingsAccounts.SetRange("Registration Date",StartDate,EndDate);
//                 if  MembersCount :=  :=  := ts.Find('-') then begin
//                   MembersCount:=SavingsAccounts.Count;


//                         BDEManagement.Reset;
//                   if    EntryNo := No := No := ement.Find(' + 1
//                     else
//                         EntryNo := 1;

//        EntryNo,  2,  * MembersCount, MembersCount EntryNo, No,    2,  * MembersCo 2, t, MembersCount, EndDate,   * MembersCount, MembersCount, EndDate,  
//                   GenerateBuffer(BDEManagement,EntryNo,SavingsAccounts."No.",2,GeneralSetUp."BDE New Member Comission"*MembersCount,MembersCount,EndDate,"BDE Management Header"."Employee No",SavingsAccounts."Product Type");

//                   end;

//                 //*********New ATM Applications
//                 ATMApplications.Reset;   
//                 ATMApplications.SetRange("Sales Agent","BDE  StartDate, , ,  Header"."Employee No");
//                 ATMApplications.SetRange("Applic   ation Date",StartDate,EndDate);
//                 ATMApplications.SetRange(Status,ATMApplications.Status::Approved);
//                 if  ATMNumbers :=  :=  := ions.Find('-') then begin
//                   ATMNumbers:=ATMApplications.Count;



//                         BDEManagement.Reset;
//                   if    EntryNo := No := No := ement.Find(' + 1
//                     else
//                         EntryNo := 1;
//                           EntryNo:=1;
//                        end; EntryNo,  2,  * MembersCount, MembersCount, EndDate,  
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             { 
//                 field(StartDate; StartDate)
//                 { 
//                     ApplicationArea = Basic;
//                     Caption = 'Start Date';
//                 } 
//                 field(EndDate; EndDate)
//                 { 
//                     ApplicationArea = Basic;
//                     Caption = 'End Date';
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin =  = 
//         if (StartDate = 0D) or (EndDate = 0D) then Error(Err001);
//     end; =  = 

//     var
//         Loans: Record 52185729;
//         SavingsAccounts: Record "Savings Accounts";
//         LoansProcess: Codeunit "Loans Process";
//         TotalAmount: Decimal;
//         StartDate: Date;
//         EndDate: Date;
//         Err001: label 'Please specify the period';
//         MembersCount: Integer;
//         ATMApplications: Record 52185850;
//         ATMNumbers: Integer;
//         BDEManagement: Record 52186130;
//         GeneralSetUp: Record 52185689;
//         EntryNo: Integer;
//         BDEManagementLines: Record 52186129;
//         AboveTarget: Decimal;
//         ComissionLoans: Decimal;
//         LoansCount: Integer;

//     local procedure GenerateBuffer(BDEManagementBuffer: Record 52186130; EntryNo: Integer; AccountNo: Code[20]; BDEType: Option " ",Credit,Savings,ATM; SoldAmount: Decimal; NoSold: Decimal; BDEDate: Date; BDENo: Code[20]; ProductTypeCode: Code[20])
//     begin        
//         be  gin
//               BDEManagementBuffer.Init; := EntryNo;
//                 BDEManagementBuffer."Entry N := EntryNo;
//                 BDEManagementBuffer."Acc : := EntryNo;
//                 BDEManagementBuffer.Ty := BD := AccountNo;
//                 BDEManagementBuffer. := BDEType;
//                 BDEManagementBuffer."N := SoldAmount;
//                 BDEManagementBuffer."Proc := NoSold;
//                 BDEManagementBuffer."BDE No := BD := BDEDate;
//                 BDEManagementBuffer."Prod := BDENo;
//             BDEManagementBuffer.Insert; := ProductTypeCode;
//           end;
//     end;
// }
