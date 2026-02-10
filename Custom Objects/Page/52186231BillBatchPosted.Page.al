// page 52186231 "Bill Batch Posted"
// {
//     Editable = false;
//     PageType = Card;
//     SourceTable = "Bills Batch";
//     SourceTableView = WHERE(Posted = FILTER(true));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("Batch No."; Rec."Batch No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Batch Name"; Rec."Batch Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Posted; Rec.Posted)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = true;
//                 }
//                 field("No of Billings"; Rec."No of Billings")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Total Amount"; Rec."Total Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Billing Period"; Rec."Billing Period")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             part(Control1102755015; "Lease-Billed")
//             {
//                 SubPageLink = "Batch No" = FIELD("Batch No.");
//                 ApplicationArea = Basic, Suite;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Post Bill Batch")
//             {
//                 Caption = 'Post Bill Batch';
//                 action(Post)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Post';
//                     Enabled = false;
//                     Image = Post;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         if Rec.Posted = true then
//                             Error('The Batch is already posted');
//                         //DELETE JNAL LINE

//                         L.Reset;
//                         L.SetRange(L."Batch No", Rec."Batch No.");
//                         if L.Find('-') then begin
//                             repeat
//                                 if L."No." <> '' then begin
//                                     L.Reset;
//                                     /*L.SETFILTER(L."Next Bill Date",'<=' + FORMAT(TODAY)); */
//                                     if L.FindFirst then begin
//                                         SRSetup.Get();
//                                         repeat

//                                             //   NextNo:=NoSeriesMgt.GetNextNo(SRSetup."Invoice Nos.",TODAY,TRUE);
//                                             GenJl.Reset;
//                                             GenJl.Init;
//                                             "LineNo." := "LineNo." + 1000;
//                                             GenJl."Journal Template Name" := 'GENERAL';
//                                             GenJl."Journal Batch Name" := 'BILLS';
//                                             GenJl."Line No." := "LineNo." + 1000;
//                                             GenJl."Posting Date" := Rec."Posting Date";
//                                             GenJl."Document No." := Rec."Batch No.";
//                                             GenJl."Account Type" := GenJl."Account Type"::Customer;
//                                             GenJl."Account No." := L."Tenant No.";
//                                             GenJl.Validate(GenJl."Account No.");
//                                             GenJl."External Document No." := Rec."Batch No.";
//                                             GenJl.Amount := L."Leased Amount";
//                                             GenJl.Validate(GenJl.Amount);
//                                             GenJl."Property Code" := L."Property No.";
//                                             //GenJl."Transaction Code" := L."Transaction Code";
//                                             GenJl."Tenant No" := L."Tenant No.";
//                                             GenJl."Currency Code" := L."Currency Code";
//                                             //Check amounts from the lines
//                                             //check amounts from lines
//                                             GenJl."Shortcut Dimension 1 Code" := L."Global Dimension 1 Code";
//                                             GenJl.Validate(GenJl."Shortcut Dimension 1 Code");
//                                             GenJl."Shortcut Dimension 2 Code" := L."Global Dimension 2 Code";
//                                             GenJl.Validate(GenJl."Shortcut Dimension 2 Code");
//                                             GenJl.Insert(true);

//                                             //BALANCING FIGURES

//                                             "LineNo." := "LineNo." + 1000;
//                                             GenJl.Init;
//                                             GenJl."Journal Template Name" := 'GENERAL';
//                                             GenJl."Journal Batch Name" := 'BILLS';
//                                             GenJl."Line No." := "LineNo." + 1000;
//                                             GenJl."Posting Date" := Rec."Posting Date";
//                                             GenJl."Document No." := Rec."Batch No.";
//                                             GenJl.Validate(GenJl."Account No.");
//                                             GenJl."External Document No." := Rec."Batch No.";
//                                             GenJl."Account Type" := GenJl."Account Type"::Vendor;
//                                             GenJl."Account No." := L."Landlord No.";
//                                             GenJl.Amount := L."Leased Amount" * -1;
//                                             GenJl.Validate(GenJl.Amount);
//                                             GenJl.Description := L."Property Name";
//                                             GenJl."Currency Code" := L."Currency Code";
//                                             GenJl."Property Code" := L."Property No.";
//                                             //GenJl."Transaction Code" := L."Transaction Code";
//                                             GenJl."Shortcut Dimension 1 Code" := L."Global Dimension 1 Code";
//                                             GenJl.Validate(GenJl."Shortcut Dimension 1 Code");
//                                             GenJl."Shortcut Dimension 2 Code" := L."Global Dimension 2 Code";
//                                             GenJl.Validate(GenJl."Shortcut Dimension 2 Code");
//                                             GenJl.Insert(true);


//                                             // POST VAT AMOUNT
//                                             L.Posted := true;
//                                             L.Modify;

//                                             //get the next billing date
//                                             FValue := L."Billing Frequency Value";
//                                             OL.Reset;
//                                             OL.SetRange(OL."No.", L."No.");
//                                             if OL.Find('-') then begin
//                                                 // if OL."Billing Frequency" = OL."Billing Frequency"::Daily then begin
//                                                 //     FType := 'D';
//                                                 // end
//                                                 // else
//                                                 //     if OL."Billing Frequency" = OL."Billing Frequency"::Weekly then begin
//                                                 //         FType := 'W';
//                                                 //     end
//                                                 //     else
//                                                         if OL."Billing Frequency" = OL."Billing Frequency"::Monthly then begin
//                                                             FType := 'M';
//                                                         end
//                                                         else
//                                                             if OL."Billing Frequency" = OL."Billing Frequency"::Quarterly then begin
//                                                                 FType := 'Q';
//                                                             end
//                                                             else
//                                                                 if OL."Billing Frequency" = OL."Billing Frequency"::Annually then begin
//                                                                     FType := 'Y';
//                                                                 end;
//                                                 OL."Next Bill Date" := CalcDate(Format(FValue) + FType, OL."Next Bill Date");
//                                                 OL.Modify;
//                                             end;

//                                         until L.Next = 0;
//                                     end;
//                                 end;
//                             until L.Next = 0;
//                         end;


//                         // POST BATCH
//                         GenJl.Reset;
//                         GenJl.SetRange(GenJl."Journal Template Name", 'GENERAL');
//                         GenJl.SetRange(GenJl."Journal Batch Name", 'BILLS');
//                         if GenJl.Find('-') then begin
//                             CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJl);

//                         end;

//                         Rec.Posted := true;
//                         Rec.Modify;

//                         Message('Batch Posted successfully');

//                     end;
//                 }
//                 separator(Action1102755020)
//                 {

//                 }
//                 action("Preview Lease")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Preview Lease';
//                     RunObject = Page "Posted Lease-Active";
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         L.Reset;
//                         L.SetRange(L."Batch No", Rec."Batch No.");
//                         if L.Find('-') then;
//                         /*
//                         LoanApp.RESET;
//                         LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubPage.FORM.GetLoanNo);
//                         IF LoanApp.FIND('-') THEN BEGIN
//                         Cust.RESET;
//                         Cust.SETRANGE(Cust."No.",LoanApp."Client Code");
//                         IF Cust.FIND('-') THEN
//                         FORM.RUNMODAL(39004251,Cust);

//                         END;
//                         */

//                     end;
//                 }
//                 action("Print Preview")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Print Preview';
//                 }
//             }
//         }
//     }

//     var
//         L: Record "Leases Billed";
//         LL: Record "Lease Line";
//         IntC: Integer;
//         BL: Record "Lease Bill Lines";
//         SaleHeader: Record "Sales Header";
//         SaleLine: Record "Sales Line";
//         SRSetup: Record "Sales & Receivables Setup";
//         NextNo: Code[20];
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         LineNo: Integer;
//         FType: Text[30];
//         FValue: Integer;
//         NoSeries: Record "No. Series Line";
//         LastNo: Code[20];
//         PostInv: Boolean;
//         PrevInv: Boolean;
//         SaleSetup: Record "Sales & Receivables Setup";
//         SalesPost: Codeunit "Sales-Post";
//         GenJl: Record "Gen. Journal Line";
//         "LineNo.": Integer;
//         AmountTotal: Decimal;
//         OL: Record Lease;
// }

