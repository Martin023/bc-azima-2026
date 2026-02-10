// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185820 "Convert WIP to FA"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Convert WIP to FA.rdl';

//     dataset
//     {
//         dataitem(FAWIP; Job)
//         {
//             CalcFields = "FA No.", "Usage (Cost)";
//             DataItemTableView = sorting("No.") where(Type = const(WIP));
//             RequestFilterFields = "No.";
//             RequestFilterHeading = 'FA WIP Filter';
//             column(ReportForNavId_2; 2)
//             {
//             }
//             dataitem("Job Task"; "Job Task")
//             {
//                 // CalcFields = "Usage (Total Cost)", "Amount Posted to FA";
//                 DataItemLink = "Job No." = field("No.");
//                 DataItemTableView = sorting("Job No.", "Job Task No.") where("Job Task Type" = const(Posting));
//                 column(ReportForNavId_1; 1)
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin

//                     // FACost := "Job Task"."Usage (Total Cost)" - "Amount Posted to FA";
//                     TotalFACost := TotalFACost + FACost;
//                     //"Amount Posted to FA" := "Amount Posted to FA"  + FACost;

//                     if FACost = 0 then
//                         CurrReport.Skip;

//                     if not FAAccountCreated then
//                         FAAccountCreated := true;


//                     JobPlanningLine.Reset;
//                     JobPlanningLine.SetRange("Job No.", "Job Task"."Job No.");
//                     JobPlanningLine.SetRange("Job Task No.", "Job Task"."Job Task No.");
//                     //JobPlanningLine.MODIFYALL(Transferred,TRUE);
//                     //JobPlanningLine."Transferred Date" := FAPstgDate;

//                     //MODIFY;
//                 end;

//                 trigger OnPostDataItem()
//                 begin

//                     if FAPosting = Faposting::New then
//                         CreateFAGLJnl
//                     else begin
//                         AddFAWIPAllocationCostNew;
//                         //IF NOT FixedAmountAllocation THEN
//                         //  IF TotalAllocatedFACost <> TotalFACost THEN
//                         //    ERROR(Text011,ABS(TotalAllocatedFACost - TotalFACost));
//                     end;

//                     CreateBalacingGLJnl;

//                     if JnlTransferred then
//                         Message(Text005, LoopCounter)
//                     else
//                         Message(Text007);
//                 end;

//                 trigger OnPreDataItem()
//                 begin

//                     if JobTaskFilter <> '' then
//                         "Job Task".SetFilter("Job Task"."Job Task No.", JobTaskFilter);

//                     //Check for selected FA - must be the one created from the WIP
//                     FAAccountCreated := false;

//                     FAWIP.Get("Job Task".GetRangeMin("Job Task"."Job No."));
//                     FAWIP.TestField(Blocked, FAWIP.Blocked::" ");
//                     FAWIP.TestField(Type, FAWIP.Type::WIP);

//                     case FAPosting of
//                         Faposting::New:
//                             begin
//                                 FAWIP.TestField("FA Class Code");
//                                 FAWIP.TestField("FA Subclass Code");
//                                 FAWIP.TestField("Expected FA Quantity");
//                                 FAWIP.TestField("Depreciation Book Code");
//                                 FAWIP.TestField("FA Posting Group");
//                                 FAWIP.TestField("FA Quantity to Register");
//                                 FAWIP.TestField("FA Description");
//                                 FAWIP.TestField("FA Location Code");
//                             end;
//                         Faposting::"Add to Existing FA":
//                             begin
//                                 //    IF NOT FAWIP.AllocationLineExist THEN  //**changes
//                                 //      ERROR(Text009);
//                                 //    FAWIP.CheckAllocation;
//                             end;
//                     end;
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 FAWIP.TestField(Type, Type::WIP);
//             end;

//             trigger OnPreDataItem()
//             begin

//                 //JobTaskFilter := GETFILTER("Job Task Filter");
//                 if FAWIP.GetRangeMin(FAWIP."No.") <> FAWIP.GetRangemax(FAWIP."No.") then
//                     Error(Text001);

//                 //fawip.TESTFIELD("Job Posting Group");
//                 //FAWIPJobPostingGrp.GET(FAWIP."Job Posting Group");
//                 //FAWIPJobPostingGrp.TESTFIELD(FAWIPJobPostingGrp."WIP Costs Account");
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field(FAPosting; FAPosting)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'FA Posting';

//                     trigger OnValidate()
//                     begin
//                         if FAPosting = Faposting::New then begin
//                             FAWIPJob.Get(FAWIP.GetFilter(FAWIP."No."));
//                             FAWIPJob.CalcFields("FA No.");
//                             if FAWIPJob."FA No." <> '' then Error('An asset for this WIP already exists, a new asset can not be created for the WIP, select Add to exisiting asset.');
//                         end
//                     end;
//                 }
//                 field(FAPstgDate; FAPstgDate)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'FA Posting Date';
//                 }
//                 field(FadepStartingDate; FadepStartingDate)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'FA Dep. Starting Date';
//                 }
//                 field(PostingDescription; PostingDescription)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Posting Description';
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

//     trigger OnPostReport()
//     begin
//         ClearAll;
//     end;

//     trigger OnPreReport()
//     begin

//         if FAPstgDate = 0D then
//             Error(Text000, GenJnlLine.FieldCaption("FA Posting Date"));

//         if FadepStartingDate = 0D then
//             Error(Text000, FADeprBook.FieldCaption("Depreciation Starting Date"));

//         if PostingDescription = '' then
//             Error(Text004);

//         if FAPosting = 0 then
//             Error(Text010);

//         FAAccountCreated := false;

//         FASetup.Get;
//         //FASetup.TESTFIELD("Work In Progress Acct");//**changes

//         GLSetup.Get;
//         //GLSetup.TESTFIELD("Amount Rounding Account No.");//**changes
//         Clear(GenJnlLine);
//         Clear(GenJnlLine2);
//         DocumentNo := //NoSeriesMgtTryGetNextNo(GenJnlBatch."No. Series", FAPstgDate);
//         // if not SourceCodeRec.Get(Text008) then begin
//         //     SourceCodeRec.Init;
//         //     SourceCodeRec.Code := Text008;
//         //     SourceCodeRec.Description := 'FA WIP Journal';
//         //     SourceCodeRec.Insert;
//         // end;
//     end;

//     var
//         FA: Record "Fixed Asset";
//         FADeprBook: Record "FA Depreciation Book";
//         GenJnlLine: Record "Gen. Journal Line";
//         GenJnlLine2: Record "Gen. Journal Line";
//         JobPlanningLine: Record "Job Planning Line";
//         FASetup: Record "FA Setup";
//         GenJnlBatch: Record "Gen. Journal Batch";
//         GLSetup: Record "General Ledger Setup";
//         SourceCodeRec: Record "Source Code";
//         DefaultDim: Record "Default Dimension";
//         //NoSeriesMgt: Codeunit NoSeriesManagement;
//         FAPosting: Option " ",New,"Add to Existing FA";
//         PostingDescription: Text[50];
//         JobTaskFilter: Text[250];
//         FAAccountCreated: Boolean;
//         FixedAmountAllocation: Boolean;
//         FAPstgDate: Date;
//         FadepStartingDate: Date;
//         FACost: Decimal;
//         TotalFACost: Decimal;
//         TotalAllocatedFACost: Decimal;
//         LoopCounter: Integer;
//         DocumentNo: Code[20];
//         TotalAmountTransfered: Decimal;
//         JnlTransferred: Boolean;
//         FAWIPJob: Record Job;
//         FAWIPJobPostingGrp: Record "Job Posting Group";
//         Text000: label '%1 must be specified on the option tab.';
//         Text001: label 'Only one WIP account can be specified for the function.';
//         Text002: label 'Are you sure you want to create %1 account for %2 item?';
//         Text003: label 'Function Alborted.';
//         Text004: label 'Posting description must be specified on the option tab';
//         Text005: label '%1 journal lines successfully created.';
//         Text006: label 'Rounding amount for trasfer of FA Wip %1 ';
//         Text007: label 'Function successfully run but no FA account or journal created.';
//         Text008: label 'FAWIPJNL';
//         Text009: label 'No FA WIP Allocation found.';
//         Text010: label 'FA posting mst be specified on the option tab.';
//         Text011: label 'Total Allocation cost not correct. There is difference of %1 on the posted FA WIP and the allocated total\Contact Your System Administrator for Assistance.  ';
//         Text012: label 'Nothing to process.';
//         FAJournalSetup: Record "FA Journal Setup";


//     procedure CreateFAGLJnl()
//     begin
//         LoopCounter := LoopCounter + 1;
//         if FAAccountCreated then
//             CreateFixedAsset;

//         FAWIP.Status := FAWIP.Status::Completed;
//         FAWIP."No. of FA Created" := FAWIP."FA Quantity to Register";
//         FAWIP.Modify;
//     end;


//     procedure AddFAWIPAllocationCost()
//     begin
//         /*
//         IF NOT JnlTransferred THEN BEGIN
//           CLEAR(FAWIPAllocation);
//           FAWIPAllocation.SETRANGE("WIP No.",FAWIP."No.");
//           FAWIPAllocation.SETRANGE(Status,FAWIPAllocation.Status::"Initial Entry");
//           FAWIPAllocation.SETFILTER(Amount,'<>%1',0);
//           IF FAWIPAllocation.FINDFIRST THEN
//             FixedAmountAllocation := TRUE
//           ELSE BEGIN
//             CLEAR(FAWIPAllocation);
//             FAWIPAllocation.SETRANGE("WIP No.",FAWIP."No.");
//             FAWIPAllocation.SETRANGE(Status,FAWIPAllocation.Status::"Initial Entry");
//             FAWIPAllocation.SETFILTER("Allocation %",'<>%1',0);
//             IF NOT FAWIPAllocation.FINDFIRST THEN
//               ERROR(Text012);
//             FixedAmountAllocation := FALSE;
//           END;
//           LoopCounter := 1;
//           REPEAT
//             FAWIPAllocation.TESTFIELD("FA No.");
//             GenJnlLine.INIT;
//             GenJnlLine."Posting Date" := FAPstgDate;
//             GenJnlLine."FA Posting Date" := FAPstgDate;
//             GenJnlLine."Journal Template Name" := GenJnlBatch."Journal Template Name";
//             GenJnlLine."Journal Batch Name" := GenJnlBatch.Name;
//             GenJnlLine."FA Posting Type" := GenJnlLine."FA Posting Type"::"Acquisition Cost";
//             GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Fixed Asset";
//             GenJnlLine."Document No." := DocumentNo;
//             GenJnlLine."Account No." := '';
//             GenJnlLine."Bal. Account Type" := 0;
//             GenJnlLine."Bal. Account No." := '';
//             GenJnlLine."Source Code" := Text008;
//             GenJnlLine."FA WIP No." := FAWIP."No.";
//             GenJnlLine."Line No." := 10000 * LoopCounter;
//             IF FixedAmountAllocation THEN BEGIN
//               FAWIPAllocation.TESTFIELD(Amount);
//               FAWIPAllocation.TESTFIELD("Allocation %",0);
//               GenJnlLine.VALIDATE(Amount,FAWIPAllocation.Amount);
//             END ELSE BEGIN
//               FAWIPAllocation.TESTFIELD("Allocation %");
//               FAWIPAllocation.TESTFIELD(Amount,0);
//               GenJnlLine.VALIDATE(Amount,TotalFACost * FAWIPAllocation."Allocation %" / 100);
//             END;
//             GenJnlLine.VALIDATE("Account No.",FAWIPAllocation."FA No.");

//             FA.GET(FAWIPAllocation."FA No.");

//             GenJnlLine.Description := PostingDescription;
//             GenJnlLine."Truck No." := FAWIPAllocation."Vehicle No.";
//             GenJnlLine.VALIDATE("Shortcut Dimension 1 Code",FA."Global Dimension 1 Code");
//             GenJnlLine.VALIDATE("Shortcut Dimension 2 Code",FA."Global Dimension 2 Code");
//             GenJnlLine.INSERT;

//             //Copy Dimension to Line Dimension
//             CopyDimToJnlDim;

//             TotalAmountTransfered := TotalAmountTransfered + GenJnlLine.Amount;
//             TotalAllocatedFACost := TotalAllocatedFACost + GenJnlLine.Amount;

//             FAWIPAllocation.Status := FAWIPAllocation.Status::Posted;
//             FAWIPAllocation.MODIFY;
//             JnlTransferred := TRUE;
//             //FAAccountCreated := TRUE;
//             LoopCounter := LoopCounter + 1;
//           UNTIL FAWIPAllocation.NEXT(1) = 0
//         END;
//         */

//     end;


//     procedure AddFAWIPAllocationCostNew()
//     var
//         WIPTasks: Record "Job Task";
//     begin
//         Clear(GenJnlLine);
//         FAJournalSetup.Get(FAWIP."Depreciation Book Code", UserId);
//         GenJnlBatch.Get(FAJournalSetup."Gen. Jnl. Template Name", FAJournalSetup."Gen. Jnl. Batch Name");
//         GenJnlBatch.TestField("No. Series");

//         GenJnlLine.Reset;
//         GenJnlLine.SetRange(GenJnlLine."Journal Template Name", GenJnlBatch."Journal Template Name");
//         GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", GenJnlBatch.Name);
//         GenJnlLine.DeleteAll;
//         if not JnlTransferred then begin
//             LoopCounter := 1;
//             WIPTasks.Reset;
//             WIPTasks.SetRange(WIPTasks."Job No.", FAWIP."No.");
//             WIPTasks.SetRange(WIPTasks."Amount Posted to FA", 0);
//             WIPTasks.SetFilter(WIPTasks."Usage (Total Cost)", '>%1', 0);
//             if WIPTasks.FindSet then
//                 repeat
//                     FAWIP.TestField("FA No.");
//                     GenJnlLine.Init;
//                     GenJnlLine."Posting Date" := FAPstgDate;
//                     GenJnlLine."FA Posting Date" := FAPstgDate;
//                     GenJnlLine."Journal Template Name" := GenJnlBatch."Journal Template Name";
//                     GenJnlLine."Journal Batch Name" := GenJnlBatch.Name;
//                     GenJnlLine."FA Posting Type" := GenJnlLine."fa posting type"::"Acquisition Cost";
//                     GenJnlLine."Account Type" := GenJnlLine."account type"::"Fixed Asset";
//                     GenJnlLine."Document No." := DocumentNo;
//                     GenJnlLine."Account No." := '';
//                     GenJnlLine."Source Code" := Text008;
//                     GenJnlLine."Job No." := FAWIP."No.";
//                     GenJnlLine."Line No." := 10000 * LoopCounter;
//                     WIPTasks.CalcFields("Usage (Total Cost)");
//                     WIPTasks.TestField(WIPTasks."Usage (Total Cost)");
//                     GenJnlLine.Validate(Amount, WIPTasks."Usage (Total Cost)");
//                     GenJnlLine.Validate("Account No.", FAWIP."FA No.");

//                     FA.Get(FAWIP."FA No.");

//                     GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
//                     //get the wip account
//                     FAWIPJob.Get(FAWIP."No.");
//                     FAWIPJobPostingGrp.Get(FAWIPJob."Job Posting Group");
//                     GenJnlLine.Validate("Bal. Account No.", FAWIPJobPostingGrp."WIP Costs Account");

//                     GenJnlLine.Description := PostingDescription;
//                     GenJnlLine."Job Task No." := WIPTasks."Job Task No.";
//                     GenJnlLine.Validate("Shortcut Dimension 1 Code", FA."Global Dimension 1 Code");
//                     GenJnlLine.Validate("Shortcut Dimension 2 Code", FA."Global Dimension 2 Code");
//                     GenJnlLine.Insert;

//                     //Copy Dimension to Line Dimension
//                     CopyDimToJnlDim;

//                     //TotalAmountTransfered := TotalAmountTransfered + GenJnlLine.Amount;
//                     //TotalAllocatedFACost := TotalAllocatedFACost + GenJnlLine.Amount;

//                     JnlTransferred := true;
//                     //FAAccountCreated := TRUE;
//                     LoopCounter := LoopCounter + 1;
//                 until WIPTasks.Next = 0
//         end;
//     end;


//     procedure CreateFixedAsset()
//     begin
//         if not Confirm(Text002, false, FA.TableCaption, FAWIP."FA Quantity to Register") then
//             Error(Text003);
//         for LoopCounter := 1 to FAWIP."FA Quantity to Register" do begin
//             //Create Header
//             Clear(FA);
//             Clear(FADeprBook);
//             FAWIP.TestField("FA Posting Group");
//             FA.Init;
//             FA."No." := '';
//             FA.Description := FAWIP."FA Description";
//             FA."Search Description" := UpperCase(FAWIP."FA Description");
//             FA."Description 2" := FAWIP."FA Description 2";
//             FA."FA Subclass Code" := FAWIP."FA Subclass Code";
//             FA."FA Class Code" := FAWIP."FA Class Code";
//             FA."Global Dimension 1 Code" := FAWIP."Global Dimension 1 Code";
//             FA."Global Dimension 2 Code" := FAWIP."Global Dimension 2 Code";
//             FA."WIP No." := FAWIP."No.";
//             FA."Vendor No." := FAWIP."WIP Vendor";
//             FA."Maintenance Vendor No." := FAWIP."WIP Vendor";
//             FA."FA Location Code" := FAWIP."FA Location Code";
//             FA.Insert(true);

//             FAWIP.TestField("FA Posting Group");
//             //  FA.VALIDATE("Default FA Posting Group",FAWIP."FA Posting Group"); //**changes
//             FAWIP.Modify;

//             //Create Line - Dep. Book
//             FADeprBook.Init;
//             FADeprBook."FA No." := FA."No.";
//             FADeprBook."Depreciation Book Code" := FAWIP."Depreciation Book Code";
//             FADeprBook."FA Posting Group" := FAWIP."FA Posting Group";
//             FADeprBook."Depreciation Method" := FAWIP."Depreciation Method";
//             FADeprBook."Straight-Line %" := FAWIP."Straight-Line %";
//             FADeprBook."Depreciation Starting Date" := FadepStartingDate;
//             FADeprBook.Insert(true);
//             //Create Journal

//             FAJournalSetup.Get(FAWIP."Depreciation Book Code", UserId);
//             GenJnlBatch.Get(FAJournalSetup."Gen. Jnl. Template Name", FAJournalSetup."Gen. Jnl. Batch Name");
//             GenJnlBatch.TestField("No. Series");

//             GenJnlLine.Reset;
//             GenJnlLine.SetRange(GenJnlLine."Journal Template Name", GenJnlBatch."Journal Template Name");
//             GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", GenJnlBatch.Name);
//             GenJnlLine.DeleteAll;

//             Clear(GenJnlLine);
//             GenJnlLine.Init;
//             GenJnlLine."Posting Date" := FAPstgDate;
//             GenJnlLine."FA Posting Date" := FAPstgDate;
//             GenJnlLine."Journal Template Name" := GenJnlBatch."Journal Template Name";
//             GenJnlLine."Journal Batch Name" := GenJnlBatch.Name;
//             GenJnlLine."FA Posting Type" := GenJnlLine."fa posting type"::"Acquisition Cost";
//             GenJnlLine."Account Type" := GenJnlLine."account type"::"Fixed Asset";
//             GenJnlLine."Document No." := DocumentNo;
//             //  GenJnlLine."FA WIP No." := FAWIP."No.";
//             GenJnlLine."Account No." := '';
//             GenJnlLine."Bal. Account Type" := 0;
//             GenJnlLine."Bal. Account No." := '';
//             GenJnlLine."Source Code" := Text008;
//             GenJnlLine."Line No." := 10000 * LoopCounter;
//             GenJnlLine.Insert;
//             GenJnlLine.Validate(Amount, TotalFACost / FAWIP."FA Quantity to Register");
//             GenJnlLine.Validate("Account No.", FA."No.");
//             GenJnlLine."Shortcut Dimension 1 Code" := FA."Global Dimension 1 Code";
//             GenJnlLine."Shortcut Dimension 2 Code" := FA."Global Dimension 2 Code";
//             GenJnlLine.Description := PostingDescription;
//             TotalAmountTransfered := TotalAmountTransfered + GenJnlLine.Amount;
//             JnlTransferred := true;
//             //  GenJnlLine."FA WIP No." := FAWIP."No.";
//             CopyDimToJnlDim;
//             GenJnlLine.Modify;
//         end;
//         LoopCounter := LoopCounter + 1;
//     end;


//     procedure CreateBalacingGLJnl()
//     begin
//         FAJournalSetup.Get(FAWIP."Depreciation Book Code", UserId);
//         GenJnlBatch.Get(FAJournalSetup."Gen. Jnl. Template Name", FAJournalSetup."Gen. Jnl. Batch Name");
//         GenJnlBatch.TestField("No. Series");

//         if TotalAmountTransfered <> 0 then begin
//             //Insert Balancing account
//             Clear(GenJnlLine);
//             GenJnlLine.Init;
//             GenJnlLine."Posting Date" := FAPstgDate;
//             GenJnlLine."FA Posting Date" := 0D;
//             GenJnlLine."Journal Template Name" := GenJnlBatch."Journal Template Name";
//             GenJnlLine."Journal Batch Name" := GenJnlBatch.Name;
//             GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
//             //get the wip account
//             FAWIPJob.Get(FAWIP."No.");
//             FAWIPJobPostingGrp.Get(FAWIPJob."Job Posting Group");
//             GenJnlLine.Validate("Account No.", FAWIPJobPostingGrp."WIP Costs Account");
//             //GenJnlLine.VALIDATE("Account No.",FASetup."Work In Progress Acct");     //**changes
//             GenJnlLine.Description := PostingDescription;
//             GenJnlLine."Line No." := 10000 * LoopCounter;
//             GenJnlLine.Validate(Amount, -TotalFACost);
//             GenJnlLine."Document No." := DocumentNo;
//             GenJnlLine."Source Code" := Text008;
//             //  GenJnlLine."WIP Transfer Entry" := TRUE;//**changes
//             GenJnlLine."Bal. Account Type" := 0;
//             GenJnlLine."Bal. Account No." := '';
//             GenJnlLine."Bal. Account No." := '';
//             GenJnlLine."Bal. Account Type" := 0;
//             GenJnlLine."Gen. Bus. Posting Group" := '';
//             GenJnlLine."Gen. Prod. Posting Group" := '';
//             GenJnlLine."VAT Bus. Posting Group" := '';
//             GenJnlLine."VAT Prod. Posting Group" := '';
//             //  GenJnlLine."FA WIP No." := FAWIP."No."; //**changes
//             GenJnlLine."Job No." := "Job Task"."Job No.";
//             GenJnlLine."Job Task No." := "Job Task"."Job Task No.";
//             if FAAccountCreated then
//                 GenJnlLine.Insert;
//             /*
//               //Insert line for rounding error if exist
//               IF TotalAmountTransfered - TotalFACost <> 0 THEN BEGIN
//                 GenJnlLine2.INIT;
//                 GenJnlLine2 := GenJnlLine;
//                 GenJnlLine2."Line No." := GenJnlLine2."Line No." + 10000;
//                 GenJnlLine2.VALIDATE("Account No.",GLSetup."Amount Rounding Account No.");
//                 GenJnlLine2.VALIDATE(Amount,-(TotalAmountTransfered - TotalFACost));
//                 GenJnlLine2.Description := STRSUBSTNO(Text006,FAWIP."No.");
//                 IF FAAccountCreated THEN
//                   GenJnlLine2.INSERT;
//               END;
//             *///**changes
//         end;

//     end;


//     procedure CopyDimToJnlDim()
//     begin
//         /*
//         CLEAR(DefaultDim);
//         FA.TESTFIELD("No.");
//         DefaultDim.SETRANGE("Table ID",DATABASE::"Fixed Asset");
//         DefaultDim.SETRANGE("No.",FA."No.");
//         IF NOT DefaultDim.FINDFIRST THEN
//           EXIT;

//         REPEAT
//           JnlLineDim."Table ID" := DATABASE::"Fixed Asset";
//           JnlLineDim."Journal Template Name" := GenJnlLine."Journal Template Name";
//           JnlLineDim."Journal Batch Name" := GenJnlLine."Journal Batch Name";
//           JnlLineDim."Journal Line No." := GenJnlLine."Line No.";
//           JnlLineDim."Dimension Code" := DefaultDim."Dimension Code";
//           JnlLineDim."Dimension Value Code" := DefaultDim."Dimension Value Code";
//           IF JnlLineDim.INSERT THEN;
//         UNTIL DefaultDim.NEXT(1) = 0;
//         */

//     end;
// }
