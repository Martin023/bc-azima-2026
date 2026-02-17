// page 52186220 "Nairobi water Bill"
// {
//     PageType = Card;
//     SourceTable = "Nairobi Water Bill";
//     SourceTableView = WHERE("billed tenants" = CONST(false));

//     layout
//     {
//         area(content)
//         {
//             group("Water billing")
//             {
//                 Caption = 'Water billing';
//                 field(Water; Rec.Water)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Sewer reading';
//                 }
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Billing No.';
//                     Editable = false;
//                 }
//                 field("Sewer charge"; Rec."Sewer charge")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Property No."; Rec."Property No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Meter Category"; Rec."Meter Category")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Water Account"; Rec."Water Account")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Water Description"; Rec."Water Description")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Previous Reading"; Rec."Previous Reading")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Previous Meter reading';
//                     Editable = false;
//                 }
//                 field("Current[Present] reading"; Rec."Current[Present] reading")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Current Meter Reading';
//                 }
//                 field(Consumption; Rec.Consumption)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Consumption';
//                     Editable = false;
//                 }
//                 field("Total Sewer Due"; Rec."Total Sewer Due")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Total Water due"; Rec."Total Water due")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Total Due"; Rec."Total Due")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Bill No."; Rec."Bill No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Property Sequence"; Rec."Property Sequence")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("L/R No."; Rec."L/R No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Meter Reading Date"; Rec."Meter Reading Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Account No.[Bill Account]"; Rec."Account No.[Bill Account]")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total No Of Units"; Rec."Total No Of Units")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Total No. Units[Occupied]';
//                     Editable = false;
//                 }
//                 field("Billing date"; Rec."Billing date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Due Date"; Rec."Due Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Units Total [Water]"; Rec."Units Total [Water]")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Units total [Sewer]"; Rec."Units total [Sewer]")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Meter No."; Rec."Meter No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Meter No';
//                 }
//                 field("billed tenants"; Rec."billed tenants")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//             }
//             part(Control1102755053; "Units Meter Rating")
//             {
//                 SubPageLink = "Property No" = FIELD("Property No."),
//                               "Nairobi Water Bill No" = FIELD("No.");
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
//                         Rec.TestField("Water Account");
//                         Rec.TestField("Water Description");
//                         Rec.TestField("Billing date");
//                         //CHECK THE SELECTED ONES
//                         if Confirm('Do you want to post Nairobi Water Bills?', false) = false then begin exit end;

//                         GenJl.Reset;
//                         GenJl.SetRange(GenJl."Journal Template Name", 'GENERAL');
//                         GenJl.SetRange(GenJl."Journal Batch Name", 'WATER');
//                         if GenJl.Find('+') then begin
//                             LineNo := GenJl."Line No." + 1000;
//                         end
//                         else begin
//                             LineNo := 1000;
//                         end;
//                         GenJl.DeleteAll;
//                         GenJl.Reset;


//                         if Rec."billed tenants" = true then begin
//                             Error('You cannot post more than Once.Water Bill Invoice had already been Posted.');
//                         end;

//                         UnitMeterReading.Reset;
//                         UnitMeterReading.SetRange(UnitMeterReading."Property No", Rec."Property No.");
//                         UnitMeterReading.SetRange(UnitMeterReading."Nairobi Water Bill No", Rec."No.");
//                         if UnitMeterReading.Find('-') then begin

//                             repeat
//                                 L.Reset;
//                                 L.SetRange(L."Property No.", Rec."Property No.");
//                                 if L.Find('-') then begin

//                                     GenJl.Reset;
//                                     GenJl.Init;
//                                     "LineNo." := "LineNo." + 1000;
//                                     GenJl."Journal Template Name" := 'GENERAL';
//                                     GenJl."Journal Batch Name" := 'WATER';
//                                     GenJl."Line No." := "LineNo." + 1000;
//                                     GenJl."Posting Date" := Rec."Billing date";
//                                     GenJl."Document No." := Rec."No.";
//                                     GenJl."Account Type" := GenJl."Account Type"::Customer;
//                                     GenJl."Account No." := UnitMeterReading."Tenant No.";
//                                     GenJl.Validate(GenJl."Account No.");
//                                     GenJl."External Document No." := UnitMeterReading."Tenant No.";
//                                     GenJl.Amount := UnitMeterReading."Total Due";
//                                     GenJl.Validate(GenJl.Amount);
//                                     // GenJl."Transaction Type":=UnitMeterReading."Lease No";
//                                     //GenJl."Transaction Code" := "Water Account";
//                                     GenJl.Description := Rec."Water Description";
//                                     // GenJl."Transaction Name":="Water Description";
//                                     // GenJl."Entry Type":=GenJl."Entry Type"::"0";
//                                     GenJl."Property Code" := UnitMeterReading."Property No";
//                                     GenJl."Tenant No" := UnitMeterReading."Tenant No.";
//                                     GenJl."Shortcut Dimension 1 Code" := UnitMeterReading."Global Dimension 1 Code";
//                                     GenJl.Validate(GenJl."Shortcut Dimension 1 Code");
//                                     GenJl."Shortcut Dimension 2 Code" := UnitMeterReading."Global Dimension 2 Code";
//                                     GenJl.Validate(GenJl."Shortcut Dimension 2 Code");
//                                     GenJl.Insert(true);
//                                     /*
//                                   //BALANCING FIGURES

//                                    "LineNo.":="LineNo."+1000;
//                                    GenJl.INIT;
//                                    GenJl."Journal Template Name":='GENERAL';
//                                    GenJl."Journal Batch Name":='WATER';
//                                    GenJl."Line No.":="LineNo."+1000;
//                                    GenJl."Posting Date":="Billing date";
//                                    GenJl."Document No.":="No.";
//                                    GenJl.VALIDATE(GenJl."Account No.");
//                                    GenJl."External Document No.":=UnitMeterReading."Tenant No.";
//                                    GenJl."Account Type":=GenJl."Account Type"::Vendor;
//                                    GenJl."Account No.":=L."Landlord No.";
//                                    GenJl.Amount:=UnitMeterReading."Total Due"*-1;
//                                    GenJl.VALIDATE(GenJl.Amount);
//                                    GenJl."Lease No":=L."No.";
//                                    GenJl."Transaction Code":="Water Account";
//                                    GenJl.Description:=L."Landlord Name";
//                                    GenJl."Landlord Name":=L."Landlord Name";
//                                    GenJl."Transaction Name":="Water Description";
//                                    GenJl."Entry Type":=GenJl."Entry Type"::" ";
//                                    GenJl."Property Code":="Property No.";
//                                    GenJl."LandLord No.":=L."Landlord No.";
//                                    GenJl."Shortcut Dimension 1 Code":=UnitMeterReading."Global Dimension 1 Code";
//                                    GenJl.VALIDATE(GenJl."Shortcut Dimension 1 Code");
//                                    GenJl."Shortcut Dimension 2 Code":=UnitMeterReading."Global Dimension 2 Code";
//                                    GenJl.VALIDATE(GenJl."Shortcut Dimension 2 Code");
//                                    GenJl.INSERT(TRUE);



//                                    GenJl.INIT;
//                                    "LineNo.":="LineNo."+1000;
//                                    GenJl."Journal Template Name":='GENERAL';
//                                    GenJl."Journal Batch Name":='WATER';
//                                    GenJl."Line No.":="LineNo."+1000;
//                                    GenJl."Posting Date":="Billing date";
//                                    GenJl."Document No.":="No.";
//                                    GenJl."Account Type":=GenJl."Account Type"::Vendor;
//                                    GenJl."Account No.":=L."Landlord No.";
//                                    GenJl.VALIDATE(GenJl."Account No.");
//                                    GenJl."External Document No.":=UnitMeterReading."Tenant No.";
//                                    GenJl.Amount:=UnitMeterReading."Total Due";
//                                    GenJl.VALIDATE(GenJl.Amount);
//                                    GenJl."Lease No":=L."No.";
//                                    GenJl."Transaction Code":="Water Account";
//                                    GenJl."Transaction Name":="Water Description";
//                                    GenJl."Entry Type":=GenJl."Entry Type"::" ";
//                                    GenJl."Property Code":=UnitMeterReading."Property No";
//                                    GenJl."Tenant No":=UnitMeterReading."Tenant No.";
//                                    GenJl."Shortcut Dimension 1 Code":=UnitMeterReading."Global Dimension 1 Code";
//                                    GenJl.VALIDATE(GenJl."Shortcut Dimension 1 Code");
//                                    GenJl."Shortcut Dimension 2 Code":=UnitMeterReading."Global Dimension 2 Code";
//                                    GenJl.VALIDATE(GenJl."Shortcut Dimension 2 Code");
//                                    GenJl.INSERT(TRUE);
//                                                 */
//                                     //BALANCING FIGURES

//                                     "LineNo." := "LineNo." + 1000;
//                                     GenJl.Init;
//                                     GenJl."Journal Template Name" := 'GENERAL';

//                                     GenJl."Journal Batch Name" := 'WATER';
//                                     GenJl."Line No." := "LineNo." + 1000;
//                                     GenJl."Posting Date" := Rec."Billing date";
//                                     GenJl."Document No." := Rec."No.";
//                                     GenJl.Validate(GenJl."Account No.");
//                                     GenJl."External Document No." := UnitMeterReading."Tenant No.";
//                                     GenJl."Account Type" := GenJl."Account Type"::"G/L Account";
//                                     GenJl."Account No." := Rec."Water Account";
//                                     GenJl.Amount := UnitMeterReading."Total Due" * -1;
//                                     GenJl.Validate(GenJl.Amount);
//                                     // GenJl."Transaction Type":=UnitMeterReading."Lease No";
//                                     //GenJl."Transaction Code" := Rec."Water Account";
//                                     GenJl.Description := Rec."Water Description";
//                                     //GenJl."Transaction Name":="Water Description";
//                                     //GenJl."Entry Type":=GenJl."Entry Type"::"0";
//                                     GenJl."Property Code" := UnitMeterReading."Property No";
//                                     //GenJl."LandLord No.":=L."Landlord No.";
//                                     GenJl."Shortcut Dimension 1 Code" := UnitMeterReading."Global Dimension 1 Code";
//                                     GenJl.Validate(GenJl."Shortcut Dimension 1 Code");
//                                     GenJl."Shortcut Dimension 2 Code" := UnitMeterReading."Global Dimension 2 Code";
//                                     GenJl.Validate(GenJl."Shortcut Dimension 2 Code");
//                                     GenJl.Insert(true);
//                                     Rec."billed tenants" := true;
//                                     Rec.Modify;

//                                     // update Previous meter No.
//                                     L.Reset;
//                                     L.SetRange(L."Tenant No.", UnitMeterReading."Tenant No.");
//                                     if L.Find('-') then begin
//                                         repeat

//                                             L."Nairobi Pr Reading" := UnitMeterReading."Previous Reading";
//                                             L."Nairobi Cur Reading" := UnitMeterReading."Current Reading";
//                                             L.Modify;
//                                         until L.Next = 0;
//                                     end;

//                                 end;
//                             until UnitMeterReading.Next = 0;

//                         end;


//                         // POST BATCH
//                         GenJl.Reset;
//                         GenJl.SetRange(GenJl."Journal Template Name", 'GENERAL');
//                         GenJl.SetRange(GenJl."Journal Batch Name", 'WATER');
//                         if GenJl.Find('-') then begin
//                             CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJl);
//                         end;

//                         Message('Batch Posted successfully');

//                     end;
//                 }
//             }
//         }
//     }

//     var
//         NairobiWater: Record "Nairobi Water Bill";
//         LL: Record "Lease Line";
//         IntC: Integer;
//         BL: Record "Lease Bill Lines";
//         SaleHeader: Record "Sales Header";
//         SaleLine: Record "Sales Line";
//         SRSetup: Record "Sales & Receivables Setup";
//         NextNo: Code[20];
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         FType: Text[30];
//         FValue: Integer;
//         UnitMeterReading: Record "Units meter Ratings";
//         SalesHeader: Record "Sales Header";
//         SalesLine: Record "Sales Line";
//         InvDesc: Text[30];
//         NoSeries: Record "No. Series Line";
//         LastNo: Code[20];
//         SaleSetup: Record "Sales & Receivables Setup";
//         "LineNo.": Integer;
//         PostInv: Boolean;
//         SalesSetup: Record "Sales & Receivables Setup";
//         SalesPost: Codeunit "Sales-Post";
//         PostingDateReq: Date;
//         DueDate: Date;
//         Postdate: Date;
//         "Rent Payable": Decimal;
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
//         BillTenant: Record "Bill Units meter Ratings";
//         NaiInv: Integer;
//         GenJl: Record "Gen. Journal Line";
//         L: Record Lease;
//         Posted: Boolean;
//         LineNo: Integer;
// }

