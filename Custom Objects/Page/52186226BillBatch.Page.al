// page 52186226 "Bill Batch"
// {
//     DeleteAllowed = false;
//     PageType = Card;
//     SourceTable = "Bills Batch";
//     SourceTableView = WHERE(Posted = CONST(false));

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
//                     ToolTip = 'The date by which the transaction belongs to[transaction period]';
//                 }
//                 field(Posted; Rec.Posted)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
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
//                     Image = Post;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin

//                         //new posting process (single entry)
//                         //new posting
//                         //Get the month of the posting date
//                         MNTH := Format(Date2DMY(Rec."Billing Period", 2));
//                         if MNTH = '1' then
//                             M := 'January';
//                         if MNTH = '2' then
//                             M := 'February';
//                         if MNTH = '3' then
//                             M := 'March';
//                         if MNTH = '4' then
//                             M := 'April';
//                         if MNTH = '5' then
//                             M := 'May';
//                         if MNTH = '6' then
//                             M := 'June';
//                         if MNTH = '7' then
//                             M := 'July';
//                         if MNTH = '8' then
//                             M := 'August';
//                         if MNTH = '9' then
//                             M := 'September';
//                         if MNTH = '10' then
//                             M := 'October';
//                         if MNTH = '11' then
//                             M := 'November';
//                         if MNTH = '12' then
//                             M := 'December';


//                         if Rec.Posted = true then
//                             Error('The Batch is already posted');

//                         // DELETE ANY LINE ITEM THAT MAY BE PRESENT
//                         GenJl.Reset;
//                         GenJl.SetRange(GenJl."Journal Template Name", 'GENERAL');
//                         GenJl.SetRange(GenJl."Journal Batch Name", 'BILLS');
//                         GenJl.DeleteAll;

//                         L.Reset;
//                         L.SetRange(L."Batch No", Rec."Batch No.");
//                         if L.Find('-') then begin
//                             repeat
//                                 L.TestField(L.Description);
//                                 GenJl.Reset;
//                                 GenJl.Init;

//                                 "LineNo." := "LineNo." + 1000;
//                                 GenJl."Journal Template Name" := 'GENERAL';
//                                 GenJl."Journal Batch Name" := 'BILLS';
//                                 GenJl."Line No." := "LineNo." + 1000;
//                                 GenJl."Posting Date" := Rec."Posting Date";
//                                 GenJl."Document No." := Format(L.InvoiceNo);
//                                 GenJl."Account Type" := GenJl."Account Type"::Customer;
//                                 GenJl."Account No." := L."Tenant No.";
//                                 GenJl.Validate(GenJl."Account No.");
//                                 GenJl."External Document No." := Rec."Batch No.";
//                                 GenJl.Amount := Round(L."Total Incl. VAT", 1, '=');
//                                 GenJl.Validate(GenJl.Amount);
//                                 //capture VAT in GL
//                                 GenJl."VAT Amount" := L."Leased VAT Amount";
//                                 GenJl."Lease No" := L."No.";
//                                 GenJl."Property Code" := L."Property No.";
//                                 // GenJl."Transaction Code" := L."Transaction Code";
//                                 GenJl."Tenant No" := L."Tenant No.";

//                                 //use remarks on description
//                                 if Rec."Use Remarks" = false then begin
//                                     //GET THE DESCRIPTION FOR THE BILLING
//                                     OL.Reset;
//                                     OL.SetRange(OL."No.", L."No.");
//                                     if OL.Find('-') then begin
//                                         // if OL."Billing Frequency" = OL."Billing Frequency"::Daily then begin
//                                         //     BMODE := 'Daily';
//                                         // end else
//                                             if OL."Billing Frequency" = OL."Billing Frequency"::Monthly then begin
//                                                 BMODE := 'Month';
//                                             end else
//                                                 if OL."Billing Frequency" = OL."Billing Frequency"::Quarterly then begin
//                                                     BMODE := 'Quarter';
//                                                 end else
//                                                     if OL."Billing Frequency" = OL."Billing Frequency"::Annually then begin
//                                                         BMODE := 'Year';
//                                                     end else
//                                                         if OL."Billing Frequency" = OL."Billing Frequency"::"Semi Annually" then begin
//                                                             BMODE := 'Semi Year';

//                                                         end;
//                                     end;
//                                     GenJl.Description := L.Description + ' for the ' + BMODE + ' starting ' + M + L."Tenant No.";
//                                 end else begin
//                                     GenJl.Description := Rec."Batch Name" + '' + L."Tenant No.";
//                                 end;
//                                 GenJl."Lease No" := L."No.";
//                                 GenJl."Currency Code" := L."Currency Code";
//                                 //check amounts from lines
//                                 GenJl."Shortcut Dimension 1 Code" := L."Global Dimension 1 Code";
//                                 GenJl.Validate(GenJl."Shortcut Dimension 1 Code");
//                                 GenJl."Shortcut Dimension 2 Code" := L."Global Dimension 2 Code";
//                                 GenJl.Validate(GenJl."Shortcut Dimension 2 Code");
//                                 GenJl.Insert(true);

//                                 //BALANCING FIGURES
//                                 "LineNo." := "LineNo." + 1000;
//                                 GenJl.Init;
//                                 GenJl."Journal Template Name" := 'GENERAL';
//                                 GenJl."Journal Batch Name" := 'BILLS';
//                                 GenJl."Line No." := "LineNo." + 1000;
//                                 GenJl."Posting Date" := Rec."Posting Date";
//                                 GenJl."Document No." := Format(L.InvoiceNo);
//                                 GenJl.Validate(GenJl."Account No.");
//                                 GenJl."External Document No." := Rec."Batch No.";


//                                 if (L."Transaction Code" = '001') or (L."Transaction Code" = '002') or (L."Transaction Code" = '003') or (L."Transaction Code" = '004')
//                                   or (L."Transaction Code" = '005') then begin
//                                     LL.Reset;
//                                     LL.SetRange(LL."Lease No.", L."No.");
//                                     if LL.Find('-') then begin
//                                         charge.Reset;
//                                         charge.SetRange(charge.Code, L."Transaction Code");
//                                         if charge.Find('-') then begin
//                                             GenJl."Account Type" := GenJl."Account Type"::"G/L Account";
//                                             GenJl."Account No." := charge."Account No.";
//                                         end;
//                                     end;
//                                     GenJl.Amount := Round(L."Leased Amount", 1, '=') * -1;
//                                     GenJl.Validate(GenJl.Amount);
//                                     GenJl."Lease No" := L."No.";

//                                     //use remarks on description
//                                     if Rec."Use Remarks" = false then begin
//                                         //GET THE DESCRIPTION FOR THE BILLING
//                                         OL.Reset;
//                                         OL.SetRange(OL."No.", L."No.");
//                                         if OL.Find('-') then begin
//                                             // if OL."Billing Frequency" = OL."Billing Frequency"::Daily then begin
//                                             //     BMODE := 'Daily';
//                                             // end else
//                                                 if OL."Billing Frequency" = OL."Billing Frequency"::Monthly then begin
//                                                     BMODE := 'Month';
//                                                 end else
//                                                     if OL."Billing Frequency" = OL."Billing Frequency"::Quarterly then begin
//                                                         BMODE := 'Quarter';
//                                                     end else
//                                                         if OL."Billing Frequency" = OL."Billing Frequency"::Annually then begin
//                                                             BMODE := 'Year';
//                                                         end else
//                                                             if OL."Billing Frequency" = OL."Billing Frequency"::"Semi Annually" then begin
//                                                                 BMODE := 'Semi Year';


//                                                             end;
//                                         end;
//                                         GenJl.Description := L.Description + ' for the ' + BMODE + ' starting ' + M + L."Tenant No.";
//                                     end else begin
//                                         GenJl.Description := Rec."Batch Name" + '' + L."Tenant No.";
//                                     end;
//                                     GenJl."Currency Code" := L."Currency Code";
//                                     GenJl."Property Code" := L."Property No.";
//                                     // GenJl."Transaction Code" := L."Transaction Code";
//                                     GenJl."Shortcut Dimension 1 Code" := L."Global Dimension 1 Code";
//                                     GenJl.Validate(GenJl."Shortcut Dimension 1 Code");
//                                     GenJl."Shortcut Dimension 2 Code" := L."Global Dimension 2 Code";
//                                     GenJl.Validate(GenJl."Shortcut Dimension 2 Code");
//                                     GenJl.Insert(true);


//                                     LL.Reset;
//                                     LL.SetRange(LL."Lease No.", L."No.");
//                                     LL.SetRange(LL."Charge No.", L."Transaction Code");
//                                     if LL.Find('-') then begin
//                                         repeat
//                                             if L."Leased VAT Amount" <> 0 then begin

//                                                 //rent,parking,signage,excess service charge(VAT)
//                                                 if (L."Transaction Code" = '001') or (L."Transaction Code" = '002') or (L."Transaction Code" = '003') or
//                                                  (L."Transaction Code" = '004') or (L."Transaction Code" = '005') then begin
//                                                     "LineNo." := "LineNo." + 1000;
//                                                     GenJl.Init;
//                                                     GenJl."Journal Template Name" := 'GENERAL';
//                                                     GenJl."Journal Batch Name" := 'BILLS';
//                                                     GenJl."Line No." := "LineNo." + 1000;
//                                                     GenJl."Posting Date" := Rec."Posting Date";
//                                                     GenJl."Document No." := Format(L.InvoiceNo);
//                                                     GenJl."External Document No." := Rec."Batch No.";
//                                                     GenJl."Account Type" := GenJl."Account Type"::"G/L Account";
//                                                     charge.Reset;
//                                                     charge.SetRange(charge.Code, LL."Charge No.");
//                                                     if charge.Find('-') then
//                                                         GenJl."Account No." := charge."VAT Account";
//                                                     GenJl.Validate(GenJl."Account No.");
//                                                     GenJl.Amount := Round(LL."VAT Amount", 1, '=') * -1;
//                                                     GenJl.Validate(GenJl.Amount);

//                                                     if (L."Transaction Code" = '003') then begin
//                                                         GenJl.Description := 'VAT on Rent Charge';
//                                                     end else
//                                                         if (L."Transaction Code" = '104') then begin
//                                                             GenJl.Description := 'VAT on Parking';
//                                                         end else
//                                                             if (L."Transaction Code" = '109') then begin
//                                                                 GenJl.Description := 'VAT on Signage';
//                                                             end else
//                                                                 if (L."Transaction Code" = '110') then begin
//                                                                     GenJl.Description := 'VAT on Excess Service Charge';
//                                                                 end else
//                                                                     if (L."Transaction Code" = '001') then begin
//                                                                         GenJl.Description := 'VAT on Service Charge';
//                                                                     end;
//                                                     GenJl."Currency Code" := L."Currency Code";
//                                                     // GenJl."Transaction Code" := L."Transaction Code";
//                                                     //GenJl."Bal. Account Type":=GenJl."Bal. Account Type"::Vendor;
//                                                     //GenJl."Bal. Account No.":=L."Landlord No.";
//                                                     //GenJl.VALIDATE(GenJl."Bal. Account No.");
//                                                     GenJl."Shortcut Dimension 1 Code" := L."Global Dimension 1 Code";
//                                                     GenJl.Validate(GenJl."Shortcut Dimension 1 Code");
//                                                     GenJl."Shortcut Dimension 2 Code" := L."Global Dimension 2 Code";
//                                                     GenJl.Validate(GenJl."Shortcut Dimension 2 Code");
//                                                 end;
//                                                 GenJl.Insert(true);
//                                             end;
//                                         until LL.Next = 0;
//                                     end;
//                                 end;
//                                 // POST VAT AMOUNT

//                                 //get the next billing date
//                                 FValue := 1;
//                                 OL.Reset;
//                                 OL.SetRange(OL."No.", L."No.");
//                                 if OL.Find('-') then begin
//                                     // if OL."Billing Frequency" = OL."Billing Frequency"::Daily then begin
//                                     //     FType := 'D';
//                                     // end
//                                     // else
//                                     //     if OL."Billing Frequency" = OL."Billing Frequency"::Weekly then begin
//                                     //         FType := 'W';
//                                     //     end
//                                     //     else
//                                             if OL."Billing Frequency" = OL."Billing Frequency"::Monthly then begin
//                                                 FType := 'M';
//                                             end
//                                             else
//                                                 if OL."Billing Frequency" = OL."Billing Frequency"::Quarterly then begin
//                                                     FType := 'Q';
//                                                 end
//                                                 else
//                                                     if OL."Billing Frequency" = OL."Billing Frequency"::Annually then begin
//                                                         FType := 'Y';
//                                                     end
//                                                     else
//                                                         if OL."Billing Frequency" = OL."Billing Frequency"::"Semi Annually" then begin
//                                                             FType := '6M';
//                                                         end;

//                                     if OL.FirstBilling = false then begin
//                                         //OL."Last Bill Date":=CALCDATE(FORMAT(FValue)+FType,L."Last Bill Date");
//                                         OL."Next Bill Date" := CalcDate(Format(FValue) + FType, L."Next Bill Date");
//                                         OL.Modify;
//                                     end else
//                                         if OL.FirstBilling = true then begin
//                                             OL."Last Bill Date" := CalcDate(Format(FValue) + FType, L."Last Bill Date");
//                                             OL."Next Bill Date" := CalcDate(Format(FValue) + FType, L."Next Bill Date");
//                                             OL.FirstBilling := true;
//                                             OL.Modify;
//                                         end;
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

//                         //tick the leases billed as posted
//                         L.Reset;
//                         L.SetRange(L."Batch No", Rec."Batch No.");
//                         if L.Find('-') then begin
//                             repeat
//                                 L.Posted := true;
//                                 L.Modify;
//                             until L.Next = 0;
//                         end;

//                         Rec.Posted := true;
//                         Rec.Modify;

//                         Message('Batch Posted successfully')
//                         //end of posting
//                         //end of new posting process


//                         //////////////////////////////////////////////////////new////////////////////////////////
//                         /*
//                         //new posting process (single entry)
//                          //new posting
//                         GeneralSetup.RESET;
//                         IF GeneralSetup.FIND('-')THEN BEGIN
//                         GeneralSetup.TESTFIELD(GeneralSetup."Prepayment Account");
//                         END;
                        
//                          //Get the month of the posting date
//                         MNTH:=FORMAT(DATE2DMY("Posting Date",2));
//                         IF MNTH='1' THEN
//                         M:='January';
//                         IF MNTH='2' THEN
//                         M:='February';
//                         IF MNTH='3' THEN
//                         M:='March';
//                         IF MNTH='4' THEN
//                         M:='April';
//                         IF MNTH='5' THEN
//                         M:='May';
//                         IF MNTH='6' THEN
//                         M:='June';
//                         IF MNTH='7' THEN
//                         M:='July';
//                         IF MNTH='8' THEN
//                         M:='August';
//                         IF MNTH='9' THEN
//                         M:='September';
//                         IF MNTH='10' THEN
//                         M:='October';
//                         IF MNTH='11' THEN
//                         M:='November';
//                         IF MNTH='12' THEN
//                         M:='December';
                        
                        
//                         IF Posted=TRUE THEN
//                         ERROR('The Batch is already posted');
                        
//                         // DELETE ANY LINE ITEM THAT MAY BE PRESENT
//                         GenJl.RESET;
//                         GenJl.SETRANGE(GenJl."Journal Template Name",'GENERAL');
//                         GenJl.SETRANGE(GenJl."Journal Batch Name",'BILLS');
//                         GenJl.DELETEALL;
//                         //Debit Prepayment Account
//                         L.RESET;
//                         L.SETRANGE(L."Batch No","Batch No.");
//                         IF L.FIND('-') THEN BEGIN
                        
//                         REPEAT
//                         L.TESTFIELD(L.Description);
//                               GenJl.RESET;
//                               GenJl.INIT;
//                                     "LineNo.":="LineNo."+1000;
//                                     GenJl."Journal Template Name":='GENERAL';
//                                     GenJl."Journal Batch Name":='BILLS';
//                                     GenJl."Line No.":="LineNo."+1000;
//                                     GenJl."Posting Date":="Posting Date";
//                                     GenJl."Document No.":=FORMAT(L.InvoiceNo);
//                                     GenJl."Account Type":=GenJl."Account Type"::"G/L Account";
//                                     GenJl."Currency Code":= L."Currency Code";
//                                     GenJl.VALIDATE(GenJl."Currency Code");
//                                     //get prepayment account from setup
//                                     GeneralSetup.RESET;
//                                     IF GeneralSetup.FIND('-')THEN BEGIN
//                                     GenJl."Account No.":=GeneralSetup."Prepayment Account";
//                                     END;
//                                     //GenJl.VALIDATE(GenJl."Account No.");
//                                     GenJl."External Document No.":="Batch No.";
//                                     GenJl.Amount:=L."Total Incl. VAT";
//                                     GenJl.VALIDATE(GenJl.Amount);
//                                     //capture VAT in GL
//                                     GenJl."VAT Amount":=L."Leased VAT Amount";
//                                     //GenJl."Transaction Type":=L."No.";
//                                     GenJl."Property Code":=L."Property No.";
//                                     GenJl."Transaction Code":=L."Transaction Code";
//                                     //GenJl."Transaction Name":= L."Transaction Name";
//                                     GenJl."Tenant No":=L."Tenant No.";
                        
                        
//                          //use remarks on description
//                          IF "Use Remarks"=FALSE THEN BEGIN
//                                      //GET THE DESCRIPTION FOR THE BILLING
//                                    OL.RESET;
//                                    OL.SETRANGE(OL."No.",L."No.");
//                                    IF OL.FIND('-')THEN BEGIN
//                                    IF OL."Billing Frequency"=OL."Billing Frequency"::Daily THEN BEGIN
//                                    BMODE:='Daily';
//                                    END ELSE IF OL."Billing Frequency"=OL."Billing Frequency"::Monthly THEN BEGIN
//                                    BMODE:='Month';
//                                    END ELSE IF OL."Billing Frequency"=OL."Billing Frequency"::Quarterly THEN BEGIN
//                                    BMODE:='Quarter';
//                                    END ELSE IF OL."Billing Frequency"=OL."Billing Frequency"::Annually THEN BEGIN
//                                    BMODE:='Year';
//                                    END ELSE IF OL."Billing Frequency"=OL."Billing Frequency"::"Semi Annually" THEN BEGIN
//                                    BMODE:='Semi Year';
                        
//                                    END;
//                                    END;
//                                     GenJl.Description:=L.Description+' for the '+BMODE+ ' starting '+M+L."Tenant No.";
//                            END ELSE  BEGIN
//                           GenJl.Description:="Batch Name"+''+L."Tenant No.";
//                         END;
                        
                        
//                                     //addition details
//                                     //GenJl."Property Name":=L."Property Name";
//                                     //GenJl."Transaction Type":=L."No.";
//                                     //GenJl."L.R No.":=L."L.R. No.";
//                                     //Check amounts from the lines
//                                     //check amounts from lines
//                                     GenJl."Shortcut Dimension 1 Code":=L."Global Dimension 1 Code";
//                                     GenJl.VALIDATE(GenJl."Shortcut Dimension 1 Code");
//                                     GenJl."Shortcut Dimension 2 Code":=L."Global Dimension 2 Code";
//                                     GenJl.VALIDATE(GenJl."Shortcut Dimension 2 Code");
//                                     GenJl.INSERT(TRUE);
                        
//                                    //Credit Income for one month
                        
//                                    "LineNo.":="LineNo."+1000;
//                                     GenJl.INIT;
//                                     GenJl."Journal Template Name":='GENERAL';
//                                     GenJl."Journal Batch Name":='BILLS';
//                                     GenJl."Line No.":="LineNo."+1000;
//                                     GenJl."Posting Date":="Posting Date";
//                                     GenJl."Currency Code":= L."Currency Code";
//                                     GenJl.VALIDATE(GenJl."Currency Code");
//                                     GenJl."Document No.":=FORMAT(L.InvoiceNo);
//                                     GenJl."Account No.":=L."G/L Account";
//                                     //GenJl.VALIDATE(GenJl."Account No.");
//                                     GenJl."External Document No.":="Batch No.";
//                                     GenJl.Amount:=(L."Leased Amount")*-1;
//                                     GenJl.VALIDATE(GenJl.Amount);
//                                     //GenJl."Transaction Type":=L."No.";
//                                     //addition details
//                                     {GenJl."Property Name":=L."Property Name";
//                                     GenJl."L.R No.":=L."L.R. No.";
//                                     GenJl."Landlord Name":=L."Landlord Name";
//                                     GenJl."Tenant Name":=L."Tenant Name";}
                        
                        
//                         //use remarks on description
//                          IF "Use Remarks"=FALSE THEN BEGIN
//                             //GET THE DESCRIPTION FOR THE BILLING
//                                    OL.RESET;
//                                    OL.SETRANGE(OL."No.",L."No.");
//                                    IF OL.FIND('-')THEN BEGIN
//                                    IF OL."Billing Frequency"=OL."Billing Frequency"::Daily THEN BEGIN
//                                    BMODE:='Daily';
//                                    END ELSE IF OL."Billing Frequency"=OL."Billing Frequency"::Monthly THEN BEGIN
//                                    BMODE:='Month';
//                                    END ELSE IF OL."Billing Frequency"=OL."Billing Frequency"::Quarterly THEN BEGIN
//                                    BMODE:='Quarter';
//                                    END ELSE IF OL."Billing Frequency"=OL."Billing Frequency"::Annually THEN BEGIN
//                                    BMODE:='Year';
//                                    END ELSE IF OL."Billing Frequency"=OL."Billing Frequency"::"Semi Annually" THEN BEGIN
//                                    BMODE:='Semi Year';
                        
                        
//                                    END;
//                                    END;
//                                    GenJl.Description:=L.Description;
//                                  END ELSE  BEGIN
//                                  GenJl.Description:="Batch Name"+''+L."Tenant No.";
//                                  END;
//                                     //GenJl."Entry Type":=GenJl."Entry Type"::"1";
//                                     GenJl."Property Code":=L."Property No.";
//                                     GenJl."Transaction Code":=L."Transaction Code";
//                                     //GenJl."Transaction Name":= L."Transaction Name";
//                                     //GenJl."LandLord No.":=L."Landlord No.";
//                                     GenJl."Shortcut Dimension 1 Code":=L."Global Dimension 1 Code";
//                                     GenJl.VALIDATE(GenJl."Shortcut Dimension 1 Code");
//                                     GenJl."Shortcut Dimension 2 Code":=L."Global Dimension 2 Code";
//                                     GenJl.VALIDATE(GenJl."Shortcut Dimension 2 Code");
//                                     GenJl.INSERT(TRUE);
                        
                        
//                                 //Credit VAT for the charges in one month
                        
//                                      LL.RESET;
//                                      LL.SETRANGE(LL."Lease No.",L."No.");
//                                      LL.SETRANGE(LL."Charge No.",L."Transaction Code");
//                                      IF LL.FIND('-') THEN BEGIN
//                                       REPEAT
//                                       IF L."Leased VAT Amount"<>0 THEN BEGIN
                        
//                                       //rent,parking,signage,excess service charge(VAT)
//                                       IF (L."Transaction Code"='001') OR  (L."Transaction Code"='002')OR (L."Transaction Code"='003')OR
//                                        (L."Transaction Code"='004') OR(L."Transaction Code"='005') THEN BEGIN
//                                         "LineNo.":="LineNo."+1000;
//                                          GenJl.INIT;
//                                          GenJl."Journal Template Name":='GENERAL';
//                                          GenJl."Journal Batch Name":='BILLS';
//                                          GenJl."Line No.":="LineNo."+1000;
//                                          GenJl."Posting Date":="Posting Date";
//                                          GenJl."Currency Code":= L."Currency Code";
//                                          GenJl.VALIDATE(GenJl."Currency Code");
//                                          GenJl."Document No.":=FORMAT(L.InvoiceNo);
//                                          GenJl."External Document No.":="Batch No.";
//                                          GenJl."Account Type":=GenJl."Account Type"::"G/L Account";
//                                          charge.RESET;
//                                          charge.SETRANGE(charge.Code,LL."Charge No.");
//                                          IF charge.FIND('-') THEN
//                                          GenJl."Account No.":=charge."VAT Account";
//                                          //GenJl.VALIDATE(GenJl."Account No.");
//                                          GenJl.Amount:=L."Leased VAT Amount"*-1;
//                                          GenJl.VALIDATE(GenJl.Amount);
//                                          //GenJl."Transaction Type":=L."No.";
//                                           //addition details
//                                          //GenJl."Property Name":=L."Property Name";
//                                          GenJl."Property Code":=L."Property No.";
//                                          //GenJl."L.R No.":=L."L.R. No.";
//                                          //GenJl."Landlord Name":=L."Landlord Name";
//                                          //GenJl."Tenant Name":=L."Tenant Name";
//                                          IF (L."Transaction Code"='001') THEN BEGIN
//                                          GenJl.Description:='VAT on Rent Vatable';
//                                          END ELSE IF (L."Transaction Code"='003')THEN BEGIN
//                                          GenJl.Description:='VAT on Rent';
//                                          END ELSE IF (L."Transaction Code"='004')THEN BEGIN
//                                          GenJl.Description:='VAT on Deposit';
//                                          END ELSE IF (L."Transaction Code"='110') THEN BEGIN
//                                          GenJl.Description:='VAT on Excess Service Charge';
//                                          END ELSE IF (L."Transaction Code"='004') THEN BEGIN
//                                          GenJl.Description:='VAT on Service Charge';
//                                          END;
//                                          //GenJl."Entry Type":=GenJl."Entry Type"::"1";
//                                          GenJl."Transaction Code":=L."Transaction Code";
//                                         // GenJl."LandLord No.":=L."Landlord No.";
//                                          GenJl."Shortcut Dimension 1 Code":=L."Global Dimension 1 Code";
//                                          GenJl.VALIDATE(GenJl."Shortcut Dimension 1 Code");
//                                          GenJl."Shortcut Dimension 2 Code":=L."Global Dimension 2 Code";
//                                          GenJl.VALIDATE(GenJl."Shortcut Dimension 2 Code");
//                                          END;
//                                        GenJl.INSERT(TRUE);
//                                        END;
//                                       UNTIL LL.NEXT=0;
//                                      END;
                        
//                         // POST VAT AMOUNT
                        
//                                 //get the next billing date
//                                   FValue:=1;
//                                   OL.RESET;
//                                   OL.SETRANGE(OL."No.",L."No.");
//                                   IF OL.FIND('-') THEN BEGIN
//                                 IF OL.Prepayment=FALSE THEN BEGIN
//                                 IF OL."Billing Frequency"=OL."Billing Frequency"::Daily THEN
//                                   BEGIN
//                                     FType:='D';
//                                   END
//                                 ELSE IF OL."Billing Frequency"=OL."Billing Frequency"::Weekly THEN
//                                   BEGIN
//                                     FType:='W';
//                                   END
//                                 ELSE IF OL."Billing Frequency"=OL."Billing Frequency"::Monthly THEN
//                                   BEGIN
//                                     FType:='M';
//                                   END
//                                 ELSE IF OL."Billing Frequency"=OL."Billing Frequency"::Quarterly THEN
//                                   BEGIN
//                                     FType:='Q';
//                                   END
//                                 ELSE IF OL."Billing Frequency"=OL."Billing Frequency"::Annually THEN
//                                   BEGIN
//                                     FType:='Y';
//                                   END
//                                 ELSE IF OL."Billing Frequency"=OL."Billing Frequency"::"Semi Annually" THEN
//                                   BEGIN
//                                     FType:='6M';
//                                   END;
//                                 END ELSE
//                                  FType:='M';
                        
//                                   IF OL.FirstBilling=FALSE THEN BEGIN
//                                 //OL."Last Bill Date":=CALCDATE(FORMAT(FValue)+FType,L."Last Bill Date");
//                                 OL."Next Bill Date":=CALCDATE(FORMAT(FValue)+FType,L."Next Bill Date");
//                                 OL.MODIFY;
//                                 END  ELSE IF OL.FirstBilling=TRUE THEN BEGIN
//                                 OL."Last Bill Date":=CALCDATE(FORMAT(FValue)+FType,L."Last Bill Date");
//                                 OL."Next Bill Date":=CALCDATE(FORMAT(FValue)+FType,L."Next Bill Date");
//                                 OL.FirstBilling:=TRUE;
//                                 OL.MODIFY;
//                                 END;
//                                 END;
                        
//                           UNTIL L.NEXT=0;
                        
//                         END;
                        
                        
//                         // POST BATCH
//                         GenJl.RESET;
//                         GenJl.SETRANGE(GenJl."Journal Template Name",'GENERAL');
//                         GenJl.SETRANGE(GenJl."Journal Batch Name",'BILLS');
//                         IF GenJl.FIND('-') THEN BEGIN
//                         CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJl);
//                         END;
                        
//                         //tick the leases billed as posted
//                         L.RESET;
//                         L.SETRANGE(L."Batch No","Batch No.");
//                         IF L.FIND('-') THEN BEGIN
//                         REPEAT
//                         L.Posted:=TRUE;
//                         L.MODIFY;
//                         UNTIL L.NEXT=0;
//                         END;
                        
                        
//                         Posted:=TRUE;
//                         MODIFY;
//                         MESSAGE('Batch Posted successfully')
//                         //end of posting
//                         //end of new posting process
//                         */

//                     end;
//                 }
//                 action("Suggest Lines")
//                 {
//                     ApplicationArea = Basic, Suite;

//                     trigger OnAction()
//                     begin
//                         LeaseLine.SuggestBatchLines();
//                     end;
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
//         charge: Record Charges;
//         LLInv: Record "Lease Line Invoices";
//         EntryNo: Integer;
//         INV: Record "Invt. Posting Buffer";
//         TA: Decimal;
//         VT: Decimal;
//         INC: Decimal;
//         BMODE: Text[30];
//         MNTH: Text[30];
//         M: Text[30];
//         LL2: Record "Lease Line";
//         GeneralSetup: Record "General Setup";
//         LeaseLine: Record "Lease Line";
// }

