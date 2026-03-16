// page 52185936 "Bank Pay In Slip Confirmation"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = Document;
//     SourceTable = "Bank Slip";
//     SourceTableView = WHERE(Status = CONST(Confirmation),
//                             Posted = CONST(false),
//                             Vaulted = CONST(false));
//     ApplicationArea = Basic, Suite;
//     usagecategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 Editable = true;
//                 field(No; Rec.No)
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Date; Rec.Date)
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Bank Slip No."; Rec."Bank Slip No.")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Document Date"; Rec."Document Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 label(Control1102758031)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     CaptionClass = Text19044997;
//                     ShowCaption = false;
//                     Style = Standard;
//                     StyleExpr = TRUE;
//                 }
//                 field("Source Dimension 1 Code"; Rec."Source Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         Rec."Source Dimension 1 Name" := GetDimensionName(Rec."Source Dimension 1 Code", 1);
//                     end;
//                 }
//                 field("Source Dimension 1 Name"; Rec."Source Dimension 1 Name")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Source Dimension 2 Code"; Rec."Source Dimension 2 Code")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                     trigger OnValidate()
//                     begin
//                         Rec."Source Dimension 2 Name" := GetDimensionName(Rec."Source Dimension 2 Code", 2);
//                     end;
//                 }
//                 field("Source Dimension 2 Name"; Rec."Source Dimension 2 Name")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("From Bank Code"; Rec."From Bank Code")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 label(Control1102758032)
//                 {
//                     CaptionClass = Text19029207;
//                     ShowCaption = false;
//                     Style = Standard;
//                     StyleExpr = TRUE;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("From Account Name"; Rec."From Account Name")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Destination Dimension 1 Code"; Rec."Destination Dimension 1 Code")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;

//                     trigger OnValidate()
//                     begin
//                         Rec."Destination Dimension 1 Name" := GetDimensionName(Rec."Destination Dimension 1 Code", 1);
//                     end;
//                 }
//                 field("Destination Dimension 1 Name"; Rec."Destination Dimension 1 Name")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Destination Dimension 2 Code"; Rec."Destination Dimension 2 Code")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                     trigger OnValidate()
//                     begin
//                         Rec."Destination Dimension 2 Name" := GetDimensionName(Rec."Destination Dimension 2 Code", 2);
//                     end;
//                 }
//                 label(Control1102755004)
//                 {
//                     CaptionClass = Text19075215;
//                     ShowCaption = false;
//                     Style = Standard;
//                     StyleExpr = TRUE;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Return Remarks"; Rec."Return Remarks")
//                 {
//                     MultiLine = true;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Destination Dimension 2 Name"; Rec."Destination Dimension 2 Name")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("To Bank Code"; Rec."To Bank Code")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("To Account Name"; Rec."To Account Name")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Amount; Rec.Amount)
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Confirmed Amount"; Rec."Confirmed Amount")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             part(Control1102758005; "Bank Pay In Line Confirmation")
//             {
//                 SubPageLink = No = FIELD(No);
//                 ApplicationArea = Basic, Suite;
//             }
//             label(Control1102758006)
//             {
//                 CaptionClass = Text19005631;
//                 ShowCaption = false;
//                 Style = Standard;
//                 StyleExpr = TRUE;
//                 ApplicationArea = Basic, Suite;
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Post)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Post';
//                 Image = Post;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin

//                     //get the source account balance from the database table
//                     BankAcc.Reset;
//                     BankAcc.SetRange(BankAcc."No.", Rec."From Bank Code");
//                     BankAcc.SetRange(BankAcc."Bank Type", BankAcc."Bank Type"::Cash);
//                     if BankAcc.FindFirst then begin
//                         BankAcc.CalcFields(BankAcc."Balance (LCY)");
//                         Rec."Current Source A/C Bal." := BankAcc."Balance (LCY)";
//                         if (Rec."Current Source A/C Bal." - Rec.Amount) < 0 then begin
//                             Error('The transaction will result in a negative balance in a CASH ACCOUNT.');
//                         end;
//                     end;

//                     Rec.CalcFields("Confirmed Amount");
//                     if Rec."Confirmed Amount" = 0 then begin
//                         Error('Please ensure Amount Confirmed is not equal to zero');
//                     end;

//                     if Rec.Amount = 0 then begin
//                         Error('Please ensure Amount to Transfer is entered');
//                     end;

//                     /*Check if the amount in the line is equal to the header amount*/
//                     LineAmount := 0;
//                     BPL.Reset;
//                     BPL.SetRange(BPL.No, Rec.No);
//                     BPL.SetRange(BPL.Select, true);
//                     if BPL.Find('-') then begin
//                         repeat
//                             LineAmount := LineAmount + BPL.Amount;
//                         until BPL.Next = 0;
//                     end;
//                     Rec.CalcFields("Confirmed Amount");
//                     BPL.Reset;
//                     BPL.SetRange(BPL.No, Rec.No);
//                     BPL.SetRange(BPL.Select, true);
//                     if BPL.Find('-') then begin
//                         repeat
//                             if BPL.Type = BPL.Type::Cheque then begin
//                                 if BPL."Cheque No" = '' then begin
//                                     Error('Please ensure that the cheque number in all the deposit lines are entered');
//                                 end;
//                             end;
//                         until BPL.Next = 0;
//                     end;

//                     if LineAmount <> Rec."Confirmed Amount" then begin
//                         Error('Confirmed Amount Must Be Equal to Deposit Details');
//                     end;

//                     CashierLinks.Reset;
//                     CashierLinks.SetRange(CashierLinks.UserID, UserId);
//                     Rec."Pay In Bank Template Name" := CashierLinks."Bank Pay In Journal Template";
//                     Rec."Pay In Bank Journal Batch" := CashierLinks."Bank Pay In Journal Batch";
//                     /*Check if the user's batch has any records within it*/
//                     GenJnlLine.Reset;
//                     GenJnlLine.SetRange(GenJnlLine."Journal Template Name", Rec."Pay In Bank Template Name");
//                     GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", Rec."Pay In Bank Journal Batch");
//                     GenJnlLine.DeleteAll;

//                     LineNo := 1000;
//                     BPL.Reset;
//                     BPL.SetRange(BPL.No, Rec.No);
//                     BPL.SetRange(BPL.Select, true);
//                     BPL.SetRange(BPL.Posted, false);
//                     if BPL.Find('-') then begin
//                         repeat
//                             /*Insert the new lines to be updated*/
//                             GenJnlLine.Init;
//                             /*Insert the lines*/
//                             GenJnlLine."Line No." := LineNo + 1;
//                             GenJnlLine."Source Code" := 'PAYMENTJNL';
//                             GenJnlLine."Journal Template Name" := Rec."Pay In Bank Template Name";
//                             GenJnlLine."Journal Batch Name" := Rec."Pay In Bank Journal Batch";
//                             GenJnlLine."Posting Date" := Rec.Date;
//                             GenJnlLine."Document No." := Rec.No;
//                             GenJnlLine."Document Date" := Rec."Document Date";
//                             GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
//                             GenJnlLine."Account No." := Rec."To Bank Code";
//                             GenJnlLine.Validate(GenJnlLine."Account No.");
//                             GenJnlLine."External Document No." := BPL."Bank Slip No.";
//                             if BPL.Type = BPL.Type::Cheque then begin
//                                 GenJnlLine.Description := CopyStr(Format(BPL.Type) + ':' + BPL."Cheque No" + ':' + BPL."Drawers Name", 1, 50);
//                             end
//                             else begin
//                                 GenJnlLine.Description := 'Cash: Deposit Slip No.:' + BPL."Bank Slip No." + ':';
//                             end;
//                             GenJnlLine."Shortcut Dimension 1 Code" := Rec."Destination Dimension 1 Code";
//                             GenJnlLine."Shortcut Dimension 2 Code" := Rec."Destination Dimension 2 Code";
//                             GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
//                             GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
//                             GenJnlLine.Amount := BPL.Amount;
//                             GenJnlLine.Validate(GenJnlLine.Amount);
//                             GenJnlLine.Insert;
//                             LineNo := LineNo + 1;

//                             GenJnlLine.Init;
//                             /*Insert the lines*/
//                             GenJnlLine."Line No." := LineNo + 1;
//                             GenJnlLine."Source Code" := 'PAYMENTJNL';
//                             GenJnlLine."Journal Template Name" := Rec."Pay In Bank Template Name";
//                             GenJnlLine."Journal Batch Name" := Rec."Pay In Bank Journal Batch";
//                             GenJnlLine."Posting Date" := Rec.Date;
//                             GenJnlLine."Document No." := Rec.No;
//                             GenJnlLine."Document Date" := Rec."Document Date";
//                             GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
//                             GenJnlLine."Account No." := Rec."From Bank Code";
//                             GenJnlLine.Validate(GenJnlLine."Account No.");
//                             GenJnlLine."External Document No." := BPL."Bank Slip No.";
//                             if BPL.Type = BPL.Type::Cheque then begin
//                                 GenJnlLine.Description := CopyStr(Format(BPL.Type) + ':' + BPL."Cheque No" + ':' + BPL."Drawers Name", 1, 50);
//                             end
//                             else begin
//                                 GenJnlLine.Description := 'Cash: Deposit Slip No.:' + BPL."Bank Slip No." + ':';
//                             end;

//                             GenJnlLine."Shortcut Dimension 1 Code" := Rec."Source Dimension 1 Code";
//                             GenJnlLine."Shortcut Dimension 2 Code" := Rec."Source Dimension 2 Code";
//                             GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
//                             GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
//                             GenJnlLine.Amount := -BPL.Amount;
//                             GenJnlLine.Validate(GenJnlLine.Amount);
//                             GenJnlLine.Insert;

//                             LineNo := LineNo + 1;
//                             BPL.Posted := true;
//                             BPL."Posted By" := UserId;
//                             BPL."Posted Date" := Today;
//                             BPL."Posted Time" := Time;
//                             //BPL."Posted Machine":=ENVIRON('COMPUTERNAME');
//                             BPL.Modify;

//                         until BPL.Next = 0;

//                         CODEUNIT.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnlLine);

//                         BPL.Reset;
//                         BPL.SetRange(BPL.No, Rec.No);
//                         BPL.SetRange(BPL.Posted, true);
//                         BPL.SetRange(BPL.Vaulted, false);
//                         if BPL.FindFirst then begin
//                             repeat
//                                 BPL.Vaulted := true;
//                                 BPL.Modify;
//                             until BPL.Next = 0;
//                         end;

//                         Rec.CalcFields("Confirmed Amount");
//                         if Rec."Confirmed Amount" = Rec.Amount then begin
//                             Rec.Posted := true;
//                             Rec."Date Posted" := Today;
//                             Rec."Time Posted" := Time;
//                             Rec."Posted By" := UserId;
//                             Rec.Vaulted := true;
//                             Rec.Modify;
//                         end;

//                         Message('The Journal Has Been Posted Successfully');
//                     end;

//                 end;
//             }
//             action("&Send Back")
//             {
//                 Caption = '&Send Back';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ApplicationArea = Basic, Suite;
//                 trigger OnAction()
//                 begin
//                     if Confirm('Do you wish to send the Bank Deposit Slip Back?', false) = false then exit;
//                     Rec.TestField("Return Remarks");
//                     Rec.Status := Rec.Status::New;
//                     Rec.Modify;
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         //check if the user has been setup as a cashier in relation to bank pay in slips
//         CashierLinks.Reset;
//         CashierLinks.SetRange(CashierLinks.UserID, UserId);
//         if CashierLinks.Find('-') then begin
//             if (CashierLinks."Bank Pay In Journal Template" = '') or (CashierLinks."Bank Pay In Journal Batch" = '') then begin
//                 Error('Sorry you have not been fully setup as a Pay In Bank Slip user. Contact the System Administrator');
//             end;
//         end
//         else begin
//             Error('Sorry you have not been setup as a Cash Office User');
//         end;
//     end;

//     var
//         GenJnlLine: Record "Gen. Journal Line";
//         DefaultBatch: Record "Gen. Journal Batch";
//         CashierLinks: Record "Cash Office User Template";
//         RecPayTypes: Record "Receipts and Payment Types";
//         LineNo: Integer;
//         LineAmount: Decimal;
//         BPL: Record "Bank Slip Line";
//         BankAcc: Record "Bank Account";
//         Text19044997: Label 'Source Details';
//         Text19029207: Label 'Receiving Details';
//         Text19075215: Label 'Remarks';
//         Text19005631: Label 'Enter Deposit Details Below';

//     //[Scope('OnPrem')]
//     procedure GetDimensionName(var "Code": Code[20]; DimNo: Integer) Name: Text[60]
//     var
//         GLSetup: Record "General Ledger Setup";
//         DimVal: Record "Dimension Value";
//     begin
//         /*Get the global dimension 1 and 2 from the database*/
//         Name := '';

//         GLSetup.Reset;
//         GLSetup.Get();

//         DimVal.Reset;
//         DimVal.SetRange(DimVal.Code, Code);

//         if DimNo = 1 then begin
//             DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 1 Code");
//         end
//         else
//             if DimNo = 2 then begin
//                 DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 2 Code");
//             end;
//         if DimVal.Find('-') then begin
//             Name := DimVal.Name;
//         end;

//     end;
// }

