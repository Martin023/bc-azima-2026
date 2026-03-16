// page 52186208 "Posted Bill Unit Meter Ratings"
// {
//     //       GenJl.RESET;
//     //       GenJl.INIT;
//     //             "LineNo.":="LineNo."+1000;
//     //             GenJl."Journal Template Name":='GENERAL';
//     //             GenJl."Journal Batch Name":='BILLS';
//     //             GenJl."Line No.":="LineNo."+1000;
//     //             GenJl."Posting Date":="Posting Date";
//     //             GenJl."Document No.":="Batch No."+' '+FORMAT(L.LineNo);
//     //             GenJl."Account Type":=GenJl."Account Type"::Customer;
//     //             GenJl."Account No.":=L."Tenant No.";
//     //             GenJl.VALIDATE(GenJl."Account No.");
//     //             GenJl."External Document No.":="Batch No.";
//     //             GenJl.Amount:=L."Leased Amount";
//     //             GenJl.VALIDATE(GenJl.Amount);
//     //             GenJl."Lease No":=L."No.";
//     //             GenJl."Property Code":=L."Property No.";
//     //             GenJl."Transaction Code":=L."Transaction Code";
//     //             GenJl."Tenant No":=L."Tenant No.";
//     //             //addition details
//     //             GenJl."Property Name":=L."Property Name";
//     //             GenJl."L.R No.":=L."L.R. No.";
//     //             GenJl."Landlord Name":=L."Landlord Name";
//     //             GenJl."Tenant Name":=L."Tenant Name";
//     //             GenJl."Entry Type":=GenJl."Entry Type"::Income;
//     //             GenJl."Currency Code":=L."Currency Code";
//     //             //Check amounts from the lines
//     //             //check amounts from lines
//     //             GenJl."Shortcut Dimension 1 Code":=L."Global Dimension 1 Code";
//     //             GenJl.VALIDATE(GenJl."Shortcut Dimension 1 Code");
//     //             GenJl."Shortcut Dimension 2 Code":=L."Global Dimension 2 Code";
//     //             GenJl.VALIDATE(GenJl."Shortcut Dimension 2 Code");
//     //             GenJl.INSERT(TRUE);
//     // 
//     //            //BALANCING FIGURES
//     // 
//     //            "LineNo.":="LineNo."+1000;
//     //             GenJl.INIT;
//     //             GenJl."Journal Template Name":='GENERAL';
//     //             GenJl."Journal Batch Name":='BILLS';
//     //             GenJl."Line No.":="LineNo."+1000;
//     //             GenJl."Posting Date":="Posting Date";
//     //             GenJl."Document No.":="Batch No."+' '+FORMAT(L.LineNo);;
//     //             GenJl.VALIDATE(GenJl."Account No.");
//     //             GenJl."External Document No.":="Batch No.";
//     //             GenJl."Account Type":=GenJl."Account Type"::Vendor;
//     //             GenJl."Account No.":=L."Landlord No.";
//     //             GenJl.Amount:=L."Leased Amount"*-1;
//     //             GenJl.VALIDATE(GenJl.Amount);
//     //             GenJl."Lease No":=L."No.";
//     //             //addition details
//     //             GenJl."Property Name":=L."Property Name";
//     //             GenJl."L.R No.":=L."L.R. No.";
//     //             GenJl."Landlord Name":=L."Landlord Name";
//     //             GenJl."Tenant Name":=L."Tenant Name";
//     //             GenJl.Description:=L."Property Name";
//     //             GenJl."Currency Code":=L."Currency Code";
//     //             GenJl."Entry Type":=GenJl."Entry Type"::Income;
//     //             GenJl."Property Code":=L."Property No.";
//     //             GenJl."Transaction Code":=LL."Charge No.";
//     //             GenJl."LandLord No.":=L."Landlord No.";
//     //             GenJl."Shortcut Dimension 1 Code":=L."Global Dimension 1 Code";
//     //             GenJl.VALIDATE(GenJl."Shortcut Dimension 1 Code");
//     //             GenJl."Shortcut Dimension 2 Code":=L."Global Dimension 2 Code";
//     //             GenJl.VALIDATE(GenJl."Shortcut Dimension 2 Code");
//     //           GenJl.INSERT(TRUE);

//     Editable = false;
//     PageType = Card;
//     SourceTable = "Bill Units meter Ratings";
//     SourceTableView = WHERE(Posted = CONST(true));

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1102755000)
//             {
//                 ShowCaption = false;
//                 field("B/Hole water bill No."; Rec."B/Hole water bill No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Invoice No."; Rec."Invoice No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Tenant No."; Rec."Tenant No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("G/L Description"; Rec."G/L Description")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Property No"; Rec."Property No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Floor Code"; Rec."Floor Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Unit Code"; Rec."Unit Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Meter No"; Rec."Meter No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Previous Reading"; Rec."Previous Reading")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Current Reading"; Rec."Current Reading")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Consumption; Rec.Consumption)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Date Of Billing"; Rec."Date Of Billing")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total Due"; Rec."Total Due")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group(Functions)
//             {
//                 Caption = 'Functions';
//                 Visible = false;
//                 action("Select All")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Select All';

//                     trigger OnAction()
//                     begin
//                         repeat
//                             Rec.Select := true;
//                             Rec.Modify;
//                         until Rec.Next = 0;
//                     end;
//                 }
//                 action("Unselect All")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Unselect All';

//                     trigger OnAction()
//                     begin
//                         repeat
//                             Rec.Select := false;
//                             Rec.Modify;
//                         until Rec.Next = 0;
//                     end;
//                 }
//             }
//             action(Post)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Post';
//                 Image = Post;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Visible = false;

//                 trigger OnAction()
//                 begin

//                     GenJl.Reset;
//                     GenJl.SetRange(GenJl."Journal Template Name", 'GENERAL');
//                     GenJl.SetRange(GenJl."Journal Batch Name", 'WATER');
//                     if GenJl.Find('+') then begin
//                         LineNo := GenJl."Line No." + 1000;
//                     end
//                     else begin
//                         LineNo := 1000;
//                     end;
//                     GenJl.DeleteAll;
//                     GenJl.Reset;

//                     if Rec.Posted = true then begin
//                         Error('You cannot post more than Once.Water Bill Invoice had already been Posted.');
//                     end;
//                     repeat
//                         L.Reset;
//                         L.SetRange(L."Property No.", Rec."Property No");
//                         if L.Find('-') then begin
//                             GenJl.Reset;
//                             GenJl.Init;
//                             "LineNo." := "LineNo." + 1000;
//                             GenJl."Journal Template Name" := 'GENERAL';
//                             GenJl."Journal Batch Name" := 'WATER';
//                             GenJl."Line No." := "LineNo." + 1000;
//                             GenJl."Posting Date" := Today;
//                             GenJl."Document No." := Rec."Property No" + ' ' + Format(Rec."Meter No");
//                             GenJl."Account Type" := GenJl."Account Type"::Customer;
//                             GenJl."Account No." := Rec."Tenant No.";
//                             GenJl.Validate(GenJl."Account No.");
//                             GenJl."External Document No." := Rec."Tenant No.";
//                             GenJl.Amount := Rec."Total Due";
//                             GenJl.Validate(GenJl.Amount);
//                             // GenJl."Transaction Type":=L."No.";
//                             //GenJl."Entry Type":=GenJl."Entry Type"::"0";
//                             GenJl."Property Code" := Rec."Property No";
//                             GenJl."Tenant No" := Rec."Tenant No.";
//                             GenJl."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
//                             GenJl.Validate(GenJl."Shortcut Dimension 1 Code");
//                             GenJl."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
//                             GenJl.Validate(GenJl."Shortcut Dimension 2 Code");
//                             GenJl.Insert(true);

//                             //BALANCING FIGURES

//                             "LineNo." := "LineNo." + 1000;
//                             GenJl.Init;
//                             GenJl."Journal Template Name" := 'GENERAL';
//                             GenJl."Journal Batch Name" := 'WATER';
//                             GenJl."Line No." := "LineNo." + 1000;
//                             GenJl."Posting Date" := Today;
//                             GenJl."Document No." := Rec."Property No" + ' ' + Format(Rec."Meter No");
//                             GenJl.Validate(GenJl."Account No.");
//                             GenJl."External Document No." := Rec."Tenant No.";
//                             GenJl."Account Type" := GenJl."Account Type"::Vendor;
//                             GenJl."Account No." := L."Landlord No.";
//                             GenJl.Amount := Rec."Total Due" * -1;
//                             GenJl.Validate(GenJl.Amount);
//                             //GenJl."Transaction Type":=L."No.";
//                             //GenJl."Entry Type":=GenJl."Entry Type"::"0";
//                             GenJl."Property Code" := Rec."Property No";
//                             //GenJl."LandLord No.":=L."Landlord No.";
//                             GenJl."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
//                             GenJl.Validate(GenJl."Shortcut Dimension 1 Code");
//                             GenJl."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
//                             GenJl.Validate(GenJl."Shortcut Dimension 2 Code");
//                             GenJl.Insert(true);



//                             GenJl.Init;
//                             "LineNo." := "LineNo." + 1000;
//                             GenJl."Journal Template Name" := 'GENERAL';
//                             GenJl."Journal Batch Name" := 'WATER';
//                             GenJl."Line No." := "LineNo." + 1000;
//                             GenJl."Posting Date" := Today;
//                             GenJl."Document No." := Rec."Property No" + ' ' + Format(Rec."Meter No");
//                             GenJl."Account Type" := GenJl."Account Type"::Vendor;
//                             GenJl."Account No." := L."Landlord No.";
//                             GenJl.Validate(GenJl."Account No.");
//                             GenJl."External Document No." := Rec."Tenant No.";
//                             GenJl.Amount := Rec."Total Due";
//                             GenJl.Validate(GenJl.Amount);
//                             // GenJl."Transaction Type":=L."No.";
//                             //GenJl."Entry Type":=GenJl."Entry Type"::"0";
//                             GenJl."Property Code" := Rec."Property No";
//                             GenJl."Tenant No" := Rec."Tenant No.";
//                             GenJl."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
//                             GenJl.Validate(GenJl."Shortcut Dimension 1 Code");
//                             GenJl."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
//                             GenJl.Validate(GenJl."Shortcut Dimension 2 Code");
//                             GenJl.Insert(true);

//                             //BALANCING FIGURES

//                             "LineNo." := "LineNo." + 1000;
//                             GenJl.Init;
//                             GenJl."Journal Template Name" := 'GENERAL';
//                             GenJl."Journal Batch Name" := 'WATER';
//                             GenJl."Line No." := "LineNo." + 1000;
//                             GenJl."Posting Date" := Today;
//                             GenJl."Document No." := Rec."Property No" + ' ' + Format(Rec."Meter No");
//                             GenJl.Validate(GenJl."Account No.");
//                             GenJl."External Document No." := Rec."Tenant No.";
//                             GenJl."Account Type" := GenJl."Account Type"::"G/L Account";
//                             GenJl."Account No." := Rec."G/L Account";
//                             GenJl.Amount := Rec."Total Due" * -1;
//                             GenJl.Validate(GenJl.Amount);
//                             //GenJl."Transaction Type":=L."No.";
//                             //GenJl."Entry Type":=GenJl."Entry Type"::"0";
//                             GenJl."Property Code" := Rec."Property No";
//                             //GenJl."LandLord No.":=L."Landlord No.";
//                             //GenJl."Bal. Account Type":=GenJl."Bal. Account Type"::Vendor;
//                             //GenJl."Bal. Account No.":=L."Landlord No.";
//                             //GenJl.VALIDATE(GenJl."Bal. Account No.");
//                             GenJl."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
//                             GenJl.Validate(GenJl."Shortcut Dimension 1 Code");
//                             GenJl."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
//                             GenJl.Validate(GenJl."Shortcut Dimension 2 Code");
//                             GenJl.Insert(true);
//                         end;
//                     until Rec.Next = 0;

//                     // POST BATCH
//                     GenJl.Reset;
//                     GenJl.SetRange(GenJl."Journal Template Name", 'GENERAL');
//                     GenJl.SetRange(GenJl."Journal Batch Name", 'WATER');
//                     if GenJl.Find('-') then begin
//                         CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJl);

//                     end;
//                     Rec.Posted := true;
//                     Rec.Modify;
//                     Message('Batch Posted successfully');
//                 end;
//             }
//         }
//     }

//     var
//         SalesHeader: Record "Sales Header";
//         SalesLine: Record "Sales Line";
//         InvDesc: Text[30];
//         NoSeries: Record "No. Series Line";
//         LastNo: Code[20];
//         SaleSetup: Record "Sales & Receivables Setup";
//         LineNo: Integer;
//         PostInv: Boolean;
//         SalesSetup: Record "Sales & Receivables Setup";
//         SalesPost: Codeunit "Sales-Post";
//         PostingDateReq: Date;
//         DueDate: Date;
//         Postdate: Date;
//         FirstDate: Date;
//         LastDate: Date;
//         Total: Decimal;
//         NoSeriesNo: Integer;
//         Date: Date;
//         Cust: Record Customer;
//         RegNo: Integer;
//         DocDate: Date;
//         PrevInv: Boolean;
//         InvPrevNo: Integer;
//         LastMonth1: Date;
//         LastMonth2: Date;
//         NQBeginDate: Date;
//         NQEndDate: Date;
//         Test: Integer;
//         "NextNo.": Integer;
//         NextPeriod: Date;
//         CompInfo: Record "Company Information";
//         MonthTo: Text[30];
//         Year: Text[30];
//         VAT: Decimal;
//         TotalVAT: Decimal;
//         BillUnit: Record "Bill Units meter Ratings";
//         GenJl: Record "Gen. Journal Line";
//         L: Record Lease;
//         "LineNo.": Integer;
// }

