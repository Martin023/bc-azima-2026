#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185483 "Budgetary Control"
{

    trigger OnRun()
    begin
    end;

    var
        BCSetup: Record "Budgetary Control Setup";
        // DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8] of Code[20];
        BudgetGL: Code[20];
        Text0001: label 'You Have exceeded the Budget by ';
        Text0002: label ' Do you want to Continue?';
        Text0003: label 'There is no Budget allocated to that account. Do you wish to continue?';
        DimCode1: Code[20];
        DimCode2: Code[20];
        BudgetCheckTxt: label 'Budgetary Checking Completed Successfully';


    procedure CheckBudget(var Variant: Variant)
    var
        RecRef: RecordRef;
        PurchaseHeader: Record "Purchase Header";
        PaymentHeader: Record "Payments Header";
        StaffClaim: Record "Staff Claims Header";
        StaffAdvance: Record "Staff Advance Header";
        StaffAdvanceSurr: Record "Staff Advance Surrender Header";
        ImprestHeader: Record "Imprest Header";
        ImprestHeaderSurr: Record "Imprest Surrender Header";
        PaymentsHeaderBoard: Record "Payments Header Board";
    begin
        RecRef.GetTable(Variant);

        case RecRef.Number of
            Database::"Purchase Header":
                begin
                    PurchaseHeader := Variant;
                    CheckPurchase(PurchaseHeader);
                end;
            Database::"Payments Header":
                begin
                    PaymentHeader := Variant;
                    CheckPayments(PaymentHeader);
                end;
            Database::"Staff Claims Header":
                begin
                    StaffClaim := Variant;
                    CheckStaffClaim(StaffClaim);
                end;
            Database::"Staff Advance Header":
                begin
                    StaffAdvance := Variant;
                    CheckStaffAdvance(StaffAdvance);
                end;
            Database::"Staff Advance Surrender Header":
                begin
                    StaffAdvanceSurr := Variant;
                    CheckStaffAdvSurr(StaffAdvanceSurr);
                end;
            Database::"Imprest Header":
                begin
                    ImprestHeader := Variant;
                    CheckImprest(ImprestHeader);
                    //ImprestHeaderSurr := Variant;
                end;
            Database::"Payments Header Board":
                begin
                    PaymentsHeaderBoard := Variant;
                    CheckPVBoard(PaymentsHeaderBoard);
                end;
        /*
            DATABASE::"Imprest surrender Header":
            BEGIN
              ImprestHeaderSurr := Variant;
              CheckImprestSurr(ImprestHeaderSurr);
            END;
        */
        end;

    end;


    procedure CancelBudget(var Variant: Variant)
    var
        RecRef: RecordRef;
        DocumentType: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance;
        PurchaseHeader: Record "Purchase Header";
        PaymentHeader: Record "Payments Header";
        StaffClaim: Record "Staff Claims Header";
        StaffAdvance: Record "Staff Advance Header";
        StaffAdvanceSurr: Record "Staff Advance Surrender Header";
        ImprestHeader: Record "Imprest Header";
        ImprestHeaderSurr: Record "Imprest Surrender Header";
    begin
        RecRef.GetTable(Variant);

        case RecRef.Number of
            Database::"Purchase Header":
                begin
                    PurchaseHeader := Variant;
                    if PurchaseHeader."Document Type" = PurchaseHeader."document type"::Quote then
                        DeleteEntries(Documenttype::Requisition, PurchaseHeader."No.")
                    else
                        if PurchaseHeader."Document Type" = PurchaseHeader."document type"::Order then
                            DeleteEntries(Documenttype::LPO, PurchaseHeader."No.")
                        else
                            if PurchaseHeader."Document Type" = PurchaseHeader."document type"::Invoice then
                                DeleteEntries(Documenttype::PurchInvoice, PurchaseHeader."No.");
                end;
            Database::"Payments Header":
                begin
                    PaymentHeader := Variant;
                    if PaymentHeader."Document Type" = PaymentHeader."document type"::"Payment Voucher" then
                        DeleteEntries(Documenttype::"Payment Voucher", PaymentHeader."No.")
                    else
                        DeleteEntries(Documenttype::PettyCash, PaymentHeader."No.");
                end;
            Database::"Staff Claims Header":
                begin
                    StaffClaim := Variant;
                    DeleteEntries(Documenttype::StaffClaim, StaffClaim."No.");
                end;
            Database::"Staff Advance Header":
                begin
                    StaffAdvance := Variant;
                    DeleteEntries(Documenttype::StaffAdvance, StaffAdvance."No.");
                end;
            Database::"Staff Advance Surrender Header":
                begin
                    StaffAdvanceSurr := Variant;
                    DeleteEntries(Documenttype::StaffAdvance, StaffAdvanceSurr.No);
                end;
            Database::"Imprest Header":
                begin
                    ImprestHeader := Variant;
                    DeleteEntries(Documenttype::Imprest, ImprestHeader."No.");
                end;
        /*
            DATABASE::"Imprest surrender Header":
            BEGIN
              ImprestHeaderSurr := Variant;
              DeleteEntries(DocumentType::Imprest,ImprestHeaderSurr.No);
            END;
        */
        end;
        ReverseandUncommitt(Variant);

    end;


    procedure ReverseBudget(var Variant: Variant)
    var
        RecRef: RecordRef;
        DocumentType: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance;
        PurchaseHeader: Record "Purchase Header";
        PaymentHeader: Record "Payments Header";
        StaffClaim: Record "Staff Claims Header";
        StaffAdvance: Record "Staff Advance Header";
        StaffAdvanceSurr: Record "Staff Advance Surrender Header";
        ImprestHeader: Record "Imprest Header";
        ImprestHeaderSurr: Record "Imprest Surrender Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Purchase Header":
                begin
                    PurchaseHeader := Variant;
                    if PurchaseHeader."Document Type" = PurchaseHeader."document type"::Quote then
                        ReverseEntries(Documenttype::Requisition, PurchaseHeader."No.")
                    else
                        if PurchaseHeader."Document Type" = PurchaseHeader."document type"::Order then
                            OrderCommittmentReversal(Documenttype::LPO, PurchaseHeader."No.")
                        else
                            if PurchaseHeader."Document Type" = PurchaseHeader."document type"::Invoice then
                                ReverseEntries(Documenttype::PurchInvoice, PurchaseHeader."No.");
                end;
            Database::"Payments Header":
                begin
                    PaymentHeader := Variant;
                    if PaymentHeader."Document Type" = PaymentHeader."document type"::"Payment Voucher" then
                        ReverseEntries(Documenttype::"Payment Voucher", PaymentHeader."No.")
                    else
                        ReverseEntries(Documenttype::PettyCash, PaymentHeader."No.");
                end;
            Database::"Staff Claims Header":
                begin
                    StaffClaim := Variant;
                    ReverseEntries(Documenttype::StaffClaim, StaffClaim."No.");
                end;
            Database::"Staff Advance Header":
                begin
                    StaffAdvance := Variant;
                    ReverseEntries(Documenttype::StaffAdvance, StaffAdvance."No.");
                end;
            Database::"Staff Advance Surrender Header":
                begin
                    StaffAdvanceSurr := Variant;
                    ReverseEntries(Documenttype::StaffAdvance, StaffAdvanceSurr.No);
                end;
            Database::"Imprest Header":
                begin
                    ImprestHeader := Variant;
                    ReverseEntries(Documenttype::Imprest, ImprestHeader."No.");
                end;
            Database::"Imprest Surrender Header":
                begin
                    ImprestHeaderSurr := Variant;
                    ReverseEntries(Documenttype::Imprest, ImprestHeaderSurr.No);
                end;
        end;
        ReverseandUncommitt(Variant);
    end;


    procedure CheckPurchase(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "FA Depreciation Book";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
        GLAccount: Record "G/L Account";
        dimSetEntry: Record "Dimension Set Entry";
    begin
        BCSetup.Reset;
        if BCSetup.Get() then begin
            if not BCSetup.Mandatory then begin
                if not Confirm('Budgetary Control is not Mandatory. Do you wish to continue checking the budget?', true) then begin
                    Message('Budget Checking process was aborted');
                    exit;
                end;
            end;

            //check if the dates are within the specified range in relation to the payment header table
            if (PurchHeader."Document Date" < BCSetup."Current Budget Start Date") then begin
                Error('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3', PurchHeader."Document Date",
                BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
            end
            else begin
                if (PurchHeader."Document Date" > BCSetup."Current Budget End Date") then begin
                    Error('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3', PurchHeader."Document Date",
                    BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                end;
            end;

            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");
            //Get Commitment Lines
            if Commitments.Find('+') then
                EntryNo := Commitments."Line No.";

            //get the lines related to the payment header
            PurchLine.Reset;
            PurchLine.SetRange(PurchLine."Document Type", PurchHeader."Document Type");
            PurchLine.SetRange(PurchLine."Document No.", PurchHeader."No.");
            if PurchLine.FindFirst then begin
                repeat
                    //check the type of account in the payments line
                    //Item
                    if PurchLine.Type = PurchLine.Type::Item then begin
                        Item.Reset;
                        if not Item.Get(PurchLine."No.") then
                            Error('Item Does not Exist');

                        Item.TestField("Item G/L Budget Account");
                        BudgetGL := Item."Item G/L Budget Account";
                    end;
                    // Fixed Asset
                    if PurchLine.Type = PurchLine.Type::"Fixed Asset" then begin
                        FixedAssetsDet.Reset;
                        FixedAssetsDet.SetRange(FixedAssetsDet."FA No.", PurchLine."No.");
                        if FixedAssetsDet.Find('-') then begin
                            FixedAssetsDet.TestField(FixedAssetsDet."FA Posting Group");
                            FAPostingGRP.Reset;
                            FAPostingGRP.SetRange(FAPostingGRP.Code, FixedAssetsDet."FA Posting Group");
                            if FAPostingGRP.Find('-') then begin
                                if PurchLine."FA Posting Type" = PurchLine."fa posting type"::Maintenance then begin
                                    BudgetGL := FAPostingGRP."Maintenance Expense Account";
                                    if BudgetGL = '' then
                                        Error('Ensure Fixed Asset No %1 has the Maintenance G/L Account', PurchLine."No.");
                                end else begin
                                    BudgetGL := FAPostingGRP."Acquisition Cost Account";
                                    if BudgetGL = '' then
                                        Error('Ensure Fixed Asset No %1 has the Acquisition G/L Account', PurchLine."No.");
                                end;
                            end;
                        end;
                    end;

                    if PurchLine.Type = PurchLine.Type::"G/L Account" then begin
                        BudgetGL := PurchLine."No.";
                    end;

                    //End Checking Account in Payment Line
                    //For End Total Budgeting
                    //For End Total Budgeting -TMEA
                    if BCSetup."Use Totaling Account" then begin
                        GLAcc.Get(BudgetGL);
                        if GLAcc."Budget Control Account" <> '' then
                            BudgetGL := GLAcc."Budget Control Account"
                        else
                            Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
                    end;
                    //End (End Total Budget)

                    //check the votebook now
                    FirstDay := Dmy2date(1, Date2dmy(PurchHeader."Document Date", 2), Date2dmy(PurchHeader."Document Date", 3));
                    CurrMonth := Date2dmy(PurchHeader."Document Date", 2);
                    if CurrMonth = 12 then begin
                        LastDay := Dmy2date(1, 1, Date2dmy(PurchHeader."Document Date", 3) + 1);
                        LastDay := CalcDate('-1D', LastDay);
                    end
                    else begin
                        CurrMonth := CurrMonth + 1;
                        LastDay := Dmy2date(1, CurrMonth, Date2dmy(PurchHeader."Document Date", 3));
                        LastDay := CalcDate('-1D', LastDay);
                    end;
                    //check the summation of the budget and actuals in the database
                    ActualsAmount := 0;
                    BudgetAmount := 0;

                    GLAcc.Reset;
                    GLAcc.SetRange(GLAcc."No.", BudgetGL);
                    GLAcc.SetRange(GLAcc."Date Filter", BCSetup."Current Budget Start Date", LastDay);
                    GLAcc.SetRange(GLAcc."Budget Filter", BCSetup."Current Budget Code");
                    //GLAcc.SetRange("Global Dimension 2 Filter", PurchLine."Shortcut Dimension 2 Code");
                    //GLAcc.SetRange(GLAcc."Dimension Set ID Filter", PurchLine."Dimension Set ID");
                    if GLAcc.FindFirst() then begin
                        GLAcc.CalcFields(GLAcc."Budgeted Amount", GLAcc."Net Change");
                        ActualsAmount := GLAcc."Net Change";
                        BudgetAmount := GLAcc."Budgeted Amount";
                    end else
                        Error('g/l not found');

                    Commitments.Reset();
                    Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                    Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                    Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                    Commitments.SetRange(Commitments."Dimension Set ID", PurchLine."Dimension Set ID");
                    Commitments.CalcSums(Commitments.Amount);
                    CommitmentAmount := Commitments.Amount;

                    //check if there is any budget
                    if (BudgetAmount <= 0) then begin
                        Error('Budgeted Amount in %1 is %2 ', GLAcc."No.", BudgetAmount);
                    end;
                    // else if not confirm('Budgeted Amount in %1 is %2 in Dept: %3 Do you wish to continue?', false, GLAcc."No.", BudgetAmount, PurchLine."Shortcut Dimension 2 Code") then
                    //         error('Budgetary Checking Process Aborted');


                    //check if the actuals plus the amount is greater then the budget amount
                    if ((CommitmentAmount + PurchLine."Outstanding Amount (LCY)") > BudgetAmount) and
                    (BCSetup."Allow OverExpenditure" = false) then begin
                        Error('The Amount On Document No %1  %2 %3  Exceeds The Budget By %4',
                        PurchLine."Document No.", PurchLine.Type, PurchLine."No.",
                          Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PurchLine."Outstanding Amount (LCY)"))));
                    end else begin
                        Commitments.Reset;
                        if Commitments.Find('+') then
                            EntryNo := Commitments."Line No.";

                        Commitments.Init;
                        EntryNo += 1;
                        Commitments."Line No." := EntryNo;
                        Commitments."Commitment Date" := Today;
                        Commitments."Posting Date" := PurchHeader."Document Date";

                        // Updtate budgeting params
                        if (PurchHeader.DocApprovalType = PurchHeader.Docapprovaltype::Purchase) and (PurchHeader."Document Type" = PurchHeader."document type"::Invoice) then
                            Commitments."Document Type" := Commitments."document type"::PurchInvoice
                        else
                            if (PurchHeader.DocApprovalType = PurchHeader.Docapprovaltype::Requisition) and (PurchHeader."Document Type" = PurchHeader."Document Type"::Quote) then
                                Commitments."Document Type" := Commitments."document type"::Requisition
                            else
                                Error('Document Type was Not Found. Kindly contact your system Administrator');

                        Commitments."Document No." := PurchHeader."No.";
                        Commitments.Amount := PurchLine."Outstanding Amount (LCY)";
                        Commitments."Month Budget" := BudgetAmount;
                        Commitments."Month Actual" := ActualsAmount;
                        Commitments.Committed := true;
                        Commitments."Committed By" := UserId;
                        Commitments."Committed Date" := PurchHeader."Document Date";
                        Commitments."G/L Account No." := BudgetGL;
                        Commitments."Committed Time" := Time;
                        //Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                        Commitments.Validate("Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 1 Code");
                        Commitments.Validate("Shortcut Dimension 2 Code", PurchLine."Shortcut Dimension 2 Code");
                        Commitments.Validate("Shortcut Dimension 3 Code", ShortcutDimCode[3]);
                        Commitments.Validate("Shortcut Dimension 4 Code", ShortcutDimCode[4]);
                        Commitments."Dimension Set ID" := PurchLine."Dimension Set ID";
                        Commitments.Committed := true;
                        Commitments.Budget := BCSetup."Current Budget Code";
                        Commitments.Type := Commitments.Type::Vendor;
                        Commitments."Vendor/Cust No." := PurchHeader."Buy-from Vendor No.";
                        Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                        Commitments."Actual Source" := BCSetup."Actual Source";
                        Commitments."Document Line No." := PurchLine."Line No.";
                        //Added for Totalling Accounts
                        Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                        Commitments.Insert;

                        //Tag the Purchase Line as Committed
                        PurchLine.Committed := true;
                        PurchLine.Modify;
                        //End Tagging PurchLines as Committed
                    end;

                until PurchLine.Next = 0;
            end;
            Message(BudgetCheckTxt)
        end
        else
            Error('Budgetary Control Setup Not Found. Kindly Setup Budgetary Control to perform this operation');
    end;


    procedure CheckDelegatePayments(DelegatesPayment: Record "Delegates Payment"): Text
    var
        PayLine: Record "Delegate Payment Line";
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
    begin
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.Reset;
        BCSetup.Get();
        if BCSetup.Mandatory then//budgetary control is mandatory
          begin
            //check if the dates are within the specified range in relation to the payment header table
            if (DelegatesPayment."Document Date" < BCSetup."Current Budget Start Date") then begin
                Error('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', DelegatesPayment."Document Date",
                BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
            end
            else
                if (DelegatesPayment."Document Date" > BCSetup."Current Budget End Date") then begin
                    Error('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', DelegatesPayment."Document Date",
                    BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                end;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");


            //Get Commitment Lines
            if Commitments.Find('+') then
                EntryNo := Commitments."Line No.";

            //get the lines related to the payment header
            PayLine.Reset;
            PayLine.SetRange(PayLine.code, DelegatesPayment.Code);
            //PayLine.SetRange(PayLine."Account Type", PayLine."account type"::"G/L Account");
            //PayLine.SetRange(PayLine."Budgetary Control A/C", true);
            if PayLine.FindFirst then begin
                repeat
                    //check the votebook now
                    FirstDay := Dmy2date(1, Date2dmy(DelegatesPayment."Document Date", 2), Date2dmy(DelegatesPayment."Document Date", 3));
                    CurrMonth := Date2dmy(DelegatesPayment."Document Date", 2);
                    if CurrMonth = 12 then begin
                        LastDay := Dmy2date(1, 1, Date2dmy(DelegatesPayment."Document Date", 3) + 1);
                        LastDay := CalcDate('-1D', LastDay);
                    end
                    else begin
                        CurrMonth := CurrMonth + 1;
                        LastDay := Dmy2date(1, CurrMonth, Date2dmy(DelegatesPayment."Document Date", 3));
                        LastDay := CalcDate('-1D', LastDay);
                    end;

                    BudgetGL := PayLine."Allowances G/L";

                    //For End Total Budgeting -TMEA
                    if BCSetup."Use Totaling Account" then begin
                        GLAcc.Get(BudgetGL);
                        if GLAcc."Budget Control Account" <> '' then
                            BudgetGL := GLAcc."Budget Control Account"
                        else
                            Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
                    end;
                    //End (End Total Budget)

                    //check the summation of the budget and actuals in the database
                    ActualsAmount := 0;
                    BudgetAmount := 0;

                    GLAcc.Reset;
                    GLAcc.SetRange("No.", BudgetGL);
                    GLAcc.SetRange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
                    GLAcc.SetRange("Budget Filter", BCSetup."Current Budget Code");
                    //GLAcc.SetRange("Dimension Set ID Filter", PayLine."Dimension Set ID");
                    GLAcc.SetRange("Global Dimension 2 Filter", DelegatesPayment."Global Dimension 2 Code");
                    if GLAcc.Find('-') then begin
                        GLAcc.CalcFields("Budgeted Amount", "Net Change");
                        ActualsAmount := GLAcc."Net Change";
                        BudgetAmount := GLAcc."Budgeted Amount";
                    end;

                    //get the committments
                    CommitmentAmount := 0;
                    Commitments.Reset;
                    Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                    Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                    Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                    //Commitments.SetRange(Commitments."Dimension Set ID", PayLine."Dimension Set ID");
                    Commitments.SetRange("Shortcut Dimension 2 Code", DelegatesPayment."Global Dimension 2 Code");
                    Commitments.CalcSums(Commitments.Amount);
                    CommitmentAmount := Commitments.Amount;

                    //MyVar := FORMAT(PayLine."Line No.") +'|'+ FORMAT(ActualsAmount)  +'|'+ FORMAT(BudgetAmount)  +'|'+ FORMAT(CommitmentAmount);
                    //IF ShowResults THEN EXIT(MyVar);

                    //check if there is any budget
                    if (BudgetAmount <= 0) and not (BCSetup."Allow OverExpenditure") then begin
                        Error('No Budget To Check Against');
                    end else begin
                        if (BudgetAmount <= 0) then begin
                            if not Confirm(Text0003, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;
                    end;

                    //check if the actuals plus the amount is greater then the budget amount
                    if ((CommitmentAmount + PayLine.Amount + ActualsAmount) > BudgetAmount)
                    and not (BCSetup."Allow OverExpenditure") then begin
                        Error('The Amount Voucher No %1  %2   Exceeds The Budget By %3',
                        PayLine.Code,

                        PayLine."Allowance Code",
                        Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine.Amount))));
                    end else begin
                        //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                        if ((CommitmentAmount + PayLine.Amount + ActualsAmount) > BudgetAmount) then begin
                            if not Confirm(Text0001 +
                            Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine.Amount)))
                            + Text0002, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;

                        Commitments.Reset;
                        Commitments.Init;
                        EntryNo += 1;
                        Commitments."Line No." := EntryNo;
                        Commitments."Commitment Date" := Today;
                        Commitments."Posting Date" := DelegatesPayment."Document Date";
                        // if PaymentHeader."Payment Type" = PaymentHeader."payment type"::Normal then
                        //     Commitments."Document Type" := Commitments."document type"::"Payment Voucher"
                        // else
                        Commitments."Document Type" := Commitments."document type"::"Delegate Payment";
                        Commitments."Document No." := DelegatesPayment.Code;
                        Commitments.Amount := PayLine.Amount;
                        Commitments."Month Budget" := BudgetAmount;
                        Commitments."Month Actual" := ActualsAmount;
                        Commitments.Committed := true;
                        Commitments."Committed By" := UserId;
                        Commitments."Committed Date" := DelegatesPayment."Document Date";
                        Commitments."G/L Account No." := BudgetGL;
                        Commitments."Committed Time" := Time;
                        //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                        Commitments.Validate("Shortcut Dimension 1 Code", PayLine."Global Dimension 1 Code");
                        Commitments.Validate("Shortcut Dimension 2 Code", PayLine."Global Dimension 2 Code");
                        Commitments."Dimension Set ID" := PayLine."Dimension Set ID";
                        Commitments.Budget := BCSetup."Current Budget Code";
                        Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                        Commitments."Actual Source" := BCSetup."Actual Source";
                        //Commitments."Document Line No." := PayLine."Line No.";
                        //Added for Totalling Accounts
                        Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                        Commitments."Shortcut Dimension 2 Code" := DelegatesPayment."Global Dimension 2 Code";
                        Commitments.Insert;
                        // MESSAGE('Done');
                        //Tag the Payment Line as Committed
                        PayLine.Committed := true;
                        PayLine.Modify;
                        //End Tagging Payment Lines as Committed
                    end;

                until PayLine.Next = 0;
            end;
            Message(BudgetCheckTxt)
        end
        else//budget control not mandatory
          begin

        end;
    end;

    procedure CheckPayments(var PaymentHeader: Record "Payments Header"): Text
    var
        PayLine: Record "Payment Line";
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
    begin
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.Reset;
        BCSetup.Get();
        //if BCSetup.Mandatory then//budgetary control is mandatory
        begin
            //check if the dates are within the specified range in relation to the payment header table
            if (PaymentHeader.Date < BCSetup."Current Budget Start Date") then begin
                Error('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', PaymentHeader.Date,
                BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
            end
            else
                if (PaymentHeader.Date > BCSetup."Current Budget End Date") then begin
                    Error('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', PaymentHeader.Date,
                    BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                end;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");


            //Get Commitment Lines
            if Commitments.Find('+') then
                EntryNo := Commitments."Line No.";

            //get the lines related to the payment header
            PayLine.Reset;
            PayLine.SetRange(PayLine.No, PaymentHeader."No.");
            PayLine.SetRange(PayLine."Account Type", PayLine."account type"::"G/L Account");
            //PayLine.SetRange(PayLine."Budgetary Control A/C", true);
            if PayLine.FindFirst then begin
                // CheckBudgetfirst
                repeat
                    if CheckIfPVIsBudgeted(PayLine) then begin
                        //check the votebook now
                        FirstDay := Dmy2date(1, Date2dmy(PaymentHeader.Date, 2), Date2dmy(PaymentHeader.Date, 3));
                        CurrMonth := Date2dmy(PaymentHeader.Date, 2);
                        if CurrMonth = 12 then begin
                            LastDay := Dmy2date(1, 1, Date2dmy(PaymentHeader.Date, 3) + 1);
                            LastDay := CalcDate('-1D', LastDay);
                        end
                        else begin
                            CurrMonth := CurrMonth + 1;
                            LastDay := Dmy2date(1, CurrMonth, Date2dmy(PaymentHeader.Date, 3));
                            LastDay := CalcDate('-1D', LastDay);
                        end;

                        BudgetGL := PayLine."Account No.";

                        //For End Total Budgeting -TMEA
                        if BCSetup."Use Totaling Account" then begin
                            GLAcc.Get(BudgetGL);
                            if GLAcc."Budget Control Account" <> '' then
                                BudgetGL := GLAcc."Budget Control Account"
                            else
                                Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
                        end;
                        //End (End Total Budget)

                        //check the summation of the budget and actuals in the database
                        ActualsAmount := 0;
                        BudgetAmount := 0;
                        GLAcc.Reset;
                        GLAcc.SetRange("No.", BudgetGL);
                        GLAcc.setrange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
                        GLAcc.SetRange("Budget Filter", BCSetup."Current Budget Code");
                        //GLAcc.SetRange("Dimension Set ID Filter", PayLine."Dimension Set ID");

                        if PayLine."Shortcut Dimension 2 Code" <> '' then
                            GLAcc.SetRange("Global Dimension 2 Filter", PayLine."Shortcut Dimension 2 Code")
                        else
                            GLAcc.SetRange("Global Dimension 2 Filter", PaymentHeader."Shortcut Dimension 2 Code");
                        if GLAcc.Find('-') then begin
                            //GLAcc.Validate("Budgeted Amount");
                            GLAcc.CalcFields("Budgeted Amount", "Net Change");
                            ActualsAmount := GLAcc."Net Change";
                            BudgetAmount := GLAcc."Budgeted Amount";
                        end;

                        //get the committments
                        CommitmentAmount := 0;
                        Commitments.Reset;
                        Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                        Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                        Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                        Commitments.SetRange(Commitments."Dimension Set ID", PayLine."Dimension Set ID");
                        if PayLine."Shortcut Dimension 2 Code" <> '' then
                            Commitments.Setrange("Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code")
                        else
                            Commitments.Setrange("Shortcut Dimension 2 Code", PaymentHeader."Shortcut Dimension 2 Code");
                        Commitments.CalcSums(Commitments.Amount);
                        CommitmentAmount := Commitments.Amount;

                        //MyVar := FORMAT(PayLine."Line No.") +'|'+ FORMAT(ActualsAmount)  +'|'+ FORMAT(BudgetAmount)  +'|'+ FORMAT(CommitmentAmount);
                        //IF ShowResults THEN EXIT(MyVar);

                        //check if there is any budget
                        if (BudgetAmount <= 0) and not (BCSetup."Allow OverExpenditure") then begin
                            Error('The total amount exceeds the budgeted amount and overexpediture is not  in Bugdetary Control Setup');
                        end else begin
                            if (BudgetAmount <= 0) then begin
                                if not Confirm(Text0003, true) then begin
                                    Error('Budgetary Checking Process Aborted');
                                end;
                            end;
                        end;

                        //check if the actuals plus the amount is greater then the budget amount
                        if ((CommitmentAmount + PayLine."NetAmount LCY") > BudgetAmount)
                        and not (BCSetup."Allow OverExpenditure") then begin
                            Error('The Amount Voucher No %1  type %2 line no. %3  Exceeds The Budget By %4',
                            PayLine.No,
                            PayLine.Type,
                            PayLine."Line No.",
                            Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."NetAmount LCY"))));
                        end else begin
                            //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                            if ((CommitmentAmount + PayLine."NetAmount LCY" + ActualsAmount) > BudgetAmount) then begin
                                if not Confirm(Text0001 +
                                Format(Abs(BudgetAmount - (CommitmentAmount + PayLine."NetAmount LCY")))
                                + Text0002, true) then begin
                                    Error('Budgetary Checking Process Aborted');
                                end;
                            end;

                            Commitments.Reset;
                            Commitments.Init;
                            EntryNo += 1;
                            Commitments."Line No." := EntryNo;
                            Commitments."Commitment Date" := Today;
                            Commitments."Posting Date" := PaymentHeader.Date;
                            if PaymentHeader."Payment Type" = PaymentHeader."payment type"::Normal then
                                Commitments."Document Type" := Commitments."document type"::"Payment Voucher"
                            else
                                Commitments."Document Type" := Commitments."document type"::PettyCash;
                            Commitments."Document No." := PaymentHeader."No.";
                            Commitments.Amount := PayLine."NetAmount LCY";
                            Commitments."Month Budget" := BudgetAmount;
                            Commitments."Month Actual" := ActualsAmount;
                            Commitments.Committed := true;
                            Commitments."Committed By" := UserId;
                            Commitments."Committed Date" := PaymentHeader.Date;
                            Commitments."G/L Account No." := BudgetGL;
                            Commitments."Committed Time" := Time;
                            //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                            if PayLine."Shortcut Dimension 2 Code" <> '' then
                                Commitments.Validate("Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code")
                            else
                                Commitments.Validate("Shortcut Dimension 2 Code", PaymentHeader."Shortcut Dimension 2 Code");

                            if PayLine."Global Dimension 1 Code" <> '' then
                                Commitments.Validate("Shortcut Dimension 1 Code", PayLine."Global Dimension 1 Code")
                            else
                                Commitments.Validate("Shortcut Dimension 1 Code", PaymentHeader."Global Dimension 1 Code");

                            Commitments."Dimension Set ID" := PayLine."Dimension Set ID";
                            Commitments.Budget := BCSetup."Current Budget Code";
                            Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                            Commitments."Actual Source" := BCSetup."Actual Source";
                            Commitments."Document Line No." := PayLine."Line No.";
                            //Added for Totalling Accounts
                            Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                            Commitments.Insert;
                            // MESSAGE('Done');
                            //Tag the Payment Line as Committed
                            PayLine.Committed := true;
                            PayLine.Modify;
                            //End Tagging Payment Lines as Committed
                        end;
                    end;
                until PayLine.Next = 0;

                // Alert to show remaining budget
                Message('Total Budgeted amount is %1 and the current remaining budget as at this month is %2 in the budget: %3 for Dept: %4', BudgetAmount, Format(BudgetAmount - CommitmentAmount - ActualsAmount), BCSetup."Current Budget Code", PayLine."Shortcut Dimension 2 Code");

            end
            else begin

                error('No lines available for Budget Check');
                exit;
            end;
            Message(BudgetCheckTxt)
        end
        //else//budget control not mandatory

    end;

    procedure CheckPayments1(var PaymentHeader: Record "Fosa Payments Header"): Text
    var
        PayLine: Record "FOSA Payment Line";
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
    begin
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.Reset;
        BCSetup.Get();
        //check if the dates are within the specified range in relation to the payment header table
        if (PaymentHeader.Date < BCSetup."Current Budget Start Date") then begin
            Error('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', PaymentHeader.Date,
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end
        else
            if (PaymentHeader.Date > BCSetup."Current Budget End Date") then begin
                Error('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', PaymentHeader.Date,
                BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
            end;
        //Is budget Available
        CheckIfBlocked(BCSetup."Current Budget Code");

        //Get Commitment Lines
        Commitments.Reset();
        if Commitments.Find('+') then
            EntryNo := Commitments."Line No.";


        //get the lines related to the payment header
        if PaymentHeader."Account Type" = PaymentHeader."Account Type"::"G/L Account" then begin

            BudgetGL := PaymentHeader."Account No.";

            if CheckIfFOSAPVIsBudgeted(PaymentHeader) then begin
                FirstDay := Dmy2date(1, Date2dmy(PaymentHeader.Date, 2), Date2dmy(PaymentHeader.Date, 3));
                CurrMonth := Date2dmy(PaymentHeader.Date, 2);
                if CurrMonth = 12 then begin
                    LastDay := Dmy2date(1, 1, Date2dmy(PaymentHeader.Date, 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end
                else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := Dmy2date(1, CurrMonth, Date2dmy(PaymentHeader.Date, 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;

                if BCSetup."Use Totaling Account" then begin
                    GLAcc.Get(BudgetGL);
                    if GLAcc."Budget Control Account" <> '' then
                        BudgetGL := GLAcc."Budget Control Account"
                    else
                        Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
                end;


                //For End Total Budgeting -TMEA

                //End (End Total Budget)

                //check the summation of the budget and actuals in the database
                ActualsAmount := 0;
                BudgetAmount := 0;

                GLAcc.Reset;
                GLAcc.SetRange("No.", BudgetGL);
                GLAcc.SetRange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
                GLAcc.SetRange("Budget Filter", BCSetup."Current Budget Code");
                //GLAcc.SetRange("Dimension Set ID Filter", PayLine."Dimension Set ID");
                if PayLine."Shortcut Dimension 2 Code" <> '' then
                    GLAcc.SetRange("Global Dimension 2 Filter", PayLine."Shortcut Dimension 2 Code")
                else
                    GLAcc.SetRange("Global Dimension 2 Filter", PaymentHeader."Shortcut Dimension 2 Code");
                //GLAcc.SetRange("Global Dimension 2 Filter", PayLine."Shortcut Dimension 2 Code");
                if GLAcc.Find('-') then begin
                    GLAcc.CalcFields("Budgeted Amount", "Net Change");
                    ActualsAmount := GLAcc."Net Change";
                    BudgetAmount := GLAcc."Budgeted Amount";
                end;

                //
                //get the committments
                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                Commitments.SetRange(Commitments."Dimension Set ID", PayLine."Dimension Set ID");

                if PayLine."Shortcut Dimension 2 Code" <> '' then
                    Commitments.Setrange("Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code")
                else
                    Commitments.Setrange("Shortcut Dimension 2 Code", PaymentHeader."Shortcut Dimension 2 Code");
                //Commitments.setrange("Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                //MyVar := FORMAT(PayLine."Line No.") +'|'+ FORMAT(ActualsAmount)  +'|'+ FORMAT(BudgetAmount)  +'|'+ FORMAT(CommitmentAmount);
                //IF ShowResults THEN EXIT(MyVar);
                Message('Total Budgeted amount is %1 and the current remaining budget as at the current month is %2 in Budget: %3 for Dept :%4', format(BudgetAmount), Format(BudgetAmount - CommitmentAmount - ActualsAmount), BCSetup."Current Budget Code", PaymentHeader."Shortcut Dimension 2 Code");

                // sum Amount un the lines
                PayLine.Reset;
                PayLine.SetRange(PayLine.No, PaymentHeader."No.");
                if PayLine.FindFirst then begin
                    Payline.CalcSums(PayLine.Amount);
                end;
                if (BudgetAmount <= 0) and not (BCSetup."Allow OverExpenditure") then begin
                    Error('No Budget To Check Against');
                end else begin
                    if (BudgetAmount <= 0) then begin
                        if not Confirm(Text0003, true) then begin
                            Error('Budgetary Checking Process Aborted');
                        end;
                    end;
                end;

                //check if the actuals plus the amount is greater then the budget amount
                if ((CommitmentAmount + PayLine.Amount + ActualsAmount) > BudgetAmount)
                and not (BCSetup."Allow OverExpenditure") then begin
                    Error('The Amount Voucher No %1 type %2 line no. %3  Exceeds The Budget By %4',
                    PayLine.No,
                    PayLine.Type,
                    PayLine."Line No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine.Amount))));
                end else begin
                    //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                    if ((CommitmentAmount + PayLine.Amount + ActualsAmount) > BudgetAmount) then begin
                        if not Confirm(Text0001 +
                        Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine.Amount)))
                        + Text0002, true) then begin
                            Error('Budgetary Checking Process Aborted');
                        end;
                    end;

                    PayLine.Reset;
                    PayLine.SetRange(PayLine.No, PaymentHeader."No.");
                    if PayLine.FindFirst then begin
                        repeat
                            //check the votebook now
                            //check if there is any budget
                            Commitments.Reset;
                            Commitments.Init;
                            EntryNo += 1;
                            Commitments."Line No." := EntryNo;
                            Commitments."Commitment Date" := Today;
                            Commitments."Posting Date" := PaymentHeader.Date;
                            Commitments."Document Type" := Commitments."document type"::"Fosa PV";
                            Commitments."Document No." := PaymentHeader."No.";
                            Commitments.Amount := PayLine.Amount;
                            Commitments."Month Budget" := BudgetAmount;
                            Commitments."Month Actual" := ActualsAmount;
                            Commitments.Committed := true;
                            Commitments."Committed By" := UserId;
                            Commitments."Committed Date" := PaymentHeader.Date;
                            Commitments."G/L Account No." := BudgetGL;
                            Commitments."Committed Time" := Time;
                            if PayLine."Shortcut Dimension 2 Code" <> '' then
                                Commitments.Validate("Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code")
                            else
                                Commitments.Validate("Shortcut Dimension 2 Code", PaymentHeader."Shortcut Dimension 2 Code");

                            if PayLine."Global Dimension 1 Code" <> '' then
                                Commitments.Validate("Shortcut Dimension 1 Code", PayLine."Global Dimension 1 Code")
                            else
                                Commitments.Validate("Shortcut Dimension 1 Code", PaymentHeader."Global Dimension 1 Code");

                            // Commitments.Validate("Shortcut Dimension 1 Code", PayLine."Global Dimension 1 Code");
                            // Commitments.Validate("Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
                            Commitments."Dimension Set ID" := PayLine."Dimension Set ID";
                            Commitments.Budget := BCSetup."Current Budget Code";
                            Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                            Commitments."Actual Source" := BCSetup."Actual Source";
                            Commitments."Document Line No." := PayLine."Line No.";
                            //Added for Totalling Accounts
                            Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                            Commitments.Insert;
                            // MESSAGE('Done');
                            //Tag the Payment Line as Committed
                            PayLine.Committed := true;
                            PayLine.Modify;
                        //End Tagging Payment Lines as Committed
                        until PayLine.Next = 0;
                    end
                    else begin
                        Message('There are no lines to check');
                        exit;
                    end;
                    Message(BudgetCheckTxt);
                end;
            end;
        end;
    end;

    // procedure CheckBulkBudget(var PaymentHeader: record "Payments Header"): Decimal
    // var
    //     Payline: record "Payment Line";
    // begin
    //     Payline.Reset;
    //     Payline.setrange(No, PaymentHeader."No.");
    //     if Payline.findfirst then begin
    //         repeat
    //         Payline.
    //         until Payline.next = 0;
    //     end;

    // end;

    procedure CheckImprest(var ImprestHeader: Record "Imprest Header")
    var
        PayLine: Record "Imprest Lines";
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
    begin
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.Reset;
        BCSetup.Get();
        if BCSetup.Mandatory then//budgetary control is mandatory
          begin
            //check if the dates are within the specified range in relation to the payment header table
            if (ImprestHeader.Date < BCSetup."Current Budget Start Date") then begin
                Error('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader.Date,
                BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
            end
            else
                if (ImprestHeader.Date > BCSetup."Current Budget End Date") then begin
                    Error('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader.Date,
                    BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");

                end;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");

            //Get Commitment Lines
            if Commitments.Find('+') then
                EntryNo := Commitments."Line No.";

            //get the lines related to the payment header
            PayLine.Reset;
            PayLine.SetRange(PayLine.No, ImprestHeader."No.");
            // PayLine.SetRange(PayLine."Budgetary Control A/C", true);
            if PayLine.FindFirst then begin
                repeat
                    //check the votebook now
                    FirstDay := Dmy2date(1, Date2dmy(ImprestHeader.Date, 2), Date2dmy(ImprestHeader.Date, 3));
                    CurrMonth := Date2dmy(ImprestHeader.Date, 2);
                    if CurrMonth = 12 then begin
                        LastDay := Dmy2date(1, 1, Date2dmy(ImprestHeader.Date, 3) + 1);
                        LastDay := CalcDate('-1D', LastDay);
                    end
                    else begin
                        CurrMonth := CurrMonth + 1;
                        LastDay := Dmy2date(1, CurrMonth, Date2dmy(ImprestHeader.Date, 3));
                        LastDay := CalcDate('-1D', LastDay);
                    end;

                    //The GL Account
                    BudgetGL := PayLine."Account No:";

                    //For End Total Budgeting -TMEA
                    if BCSetup."Use Totaling Account" then begin
                        GLAcc.Get(BudgetGL);
                        if GLAcc."Budget Control Account" <> '' then
                            BudgetGL := GLAcc."Budget Control Account"
                        else
                            Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
                    end;
                    //End (End Total Budget)

                    //check the summation of the budget and actuals in the database
                    ActualsAmount := 0;
                    BudgetAmount := 0;

                    GLAcc.Reset;
                    GLAcc.SetRange("No.", BudgetGL);
                    GLAcc.SetRange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
                    GLAcc.SetRange("Budget Filter", BCSetup."Current Budget Code");
                    //GLAcc.SetRange("Dimension Set ID Filter", PayLine."Dimension Set ID");
                    GLAcc.SetRange("Global Dimension 2 Filter", PayLine."Shortcut Dimension 2 Code");
                    if GLAcc.Find('-') then begin
                        GLAcc.CalcFields("Budgeted Amount", "Net Change");
                        ActualsAmount := GLAcc."Net Change";
                        BudgetAmount := GLAcc."Budgeted Amount";
                    end;

                    //get the committments
                    CommitmentAmount := 0;
                    Commitments.Reset;
                    Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                    Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                    Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                    Commitments.SetRange(Commitments."Dimension Set ID", PayLine."Dimension Set ID");
                    Commitments.setrange("Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
                    Commitments.CalcSums(Commitments.Amount);
                    CommitmentAmount := Commitments.Amount;


                    //    Message('Total Budgeted amount is %1 and the current remaining budget as at the current month is %2 in Budget: %3 for Dept :%4', format(BudgetAmount), Format(BudgetAmount - CommitmentAmount- ActualsAmount), BCSetup."Current Budget Code", PayLine."Shortcut Dimension 2 Code");

                    //check if there is any budget
                    if (BudgetAmount <= 0) and not (BCSetup."Allow OverExpenditure") then begin
                        Error('No Budget To Check Against');
                    end else begin
                        if (BudgetAmount <= 0) then begin
                            if not Confirm(Text0003, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;
                    end;

                    //check if the actuals plus the amount is greater then the budget amount
                    if ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount)
                    and not (BCSetup."Allow OverExpenditure") then begin
                        Error('The Amount Voucher No %1 type  %2 line no. %3  Exceeds The Budget By %4',
                        PayLine.No, 'Staff Imprest', PayLine.No,
                          Format(Abs(BudgetAmount - (CommitmentAmount + PayLine."Amount LCY"))));
                    end else begin
                        //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                        if ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount) then begin
                            if not Confirm(Text0001 +
                            Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."Amount LCY")))
                            + Text0002, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;

                        Commitments.Reset;
                        Commitments.Init;
                        EntryNo += 1;
                        Commitments."Line No." := EntryNo;
                        Commitments."Commitment Date" := Today;
                        Commitments."Posting Date" := ImprestHeader.Date;
                        Commitments."Document Type" := Commitments."document type"::Imprest;
                        Commitments."Document No." := ImprestHeader."No.";
                        Commitments.Amount := PayLine."Amount LCY";
                        Commitments."Month Budget" := BudgetAmount;
                        Commitments."Month Actual" := ActualsAmount;
                        Commitments.Committed := true;
                        Commitments."Committed By" := UserId;
                        Commitments."Committed Date" := ImprestHeader.Date;
                        Commitments."G/L Account No." := BudgetGL;
                        Commitments."Committed Time" := Time;
                        //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                        Commitments.Validate("Shortcut Dimension 1 Code", PayLine."Global Dimension 1 Code");
                        Commitments.Validate("Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
                        Commitments."Dimension Set ID" := PayLine."Dimension Set ID";
                        Commitments.Budget := BCSetup."Current Budget Code";
                        Commitments.Type := ImprestHeader."Account Type";
                        Commitments."Vendor/Cust No." := ImprestHeader."Account No.";
                        Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                        Commitments."Actual Source" := BCSetup."Actual Source";
                        Commitments."Document Line No." := PayLine."Line No.";
                        //Added for Totalling Accounts
                        Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                        Commitments.Insert;
                        //Tag the Imprest Line as Committed
                        PayLine.Committed := true;
                        PayLine.Modify;
                        //End Tagging Imprest Lines as Committed
                    end;

                until PayLine.Next = 0;
            end;
            Message(BudgetCheckTxt)
        end
        else//budget control not mandatory
          begin

        end;
    end;

    procedure CheckBoardPayments(var BoardPaymentHeader: Record "Board members")
    var
        BoardPayLines: Record "PR Board Transactions";
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
        GenSetUp: record "General Set-Up";

    begin
        GenSetUp.Reset();
        GenSetUp.get();
        GenSetUp.TestField("Board Salaries Account");
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.Reset;
        BCSetup.Get();

        if BCSetup.Mandatory then//budgetary control is mandatory
          begin
            //check if the dates are within the specified range in relation to the payment header table
            if (BoardPaymentHeader.Date < BCSetup."Current Budget Start Date") then begin
                Error('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', BoardPaymentHeader.Date,
                BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
            end
            else
                if (BoardPaymentHeader.Date > BCSetup."Current Budget End Date") then begin
                    Error('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', BoardPaymentHeader.Date,
                    BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                end;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");

            if BoardPaymentHeader."Board Retainer" > 0 then begin
                //     BoardPayLines.Reset;
                // BoardPayLines.SetRange(BoardPayLines."No.", ImprestHeader."No.");
                // BoardPayLines.SetRange(BoardPayLines."Budgetary Control A/C", true)
                if Commitments.Find('+') then
                    EntryNo := Commitments."Line No.";

                FirstDay := Dmy2date(1, Date2dmy(BoardPaymentHeader.Date, 2), Date2dmy(BoardPaymentHeader.Date, 3));
                CurrMonth := Date2dmy(BoardPaymentHeader.Date, 2);
                if CurrMonth = 12 then begin
                    LastDay := Dmy2date(1, 1, Date2dmy(BoardPaymentHeader.Date, 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end
                else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := Dmy2date(1, CurrMonth, Date2dmy(BoardPaymentHeader.Date, 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;

                // Check Board Retainer Budget
                BudgetGL := GenSetUp."Board Salaries Account";
                if BCSetup."Use Totaling Account" then begin
                    GLAcc.Get(BudgetGL);
                    if GLAcc."Budget Control Account" <> '' then
                        BudgetGL := GLAcc."Budget Control Account"
                    else
                        Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
                end;
                // Check budgert Acct
                GLAcc.Reset;
                GLAcc.SetRange("No.", BudgetGL);
                GLAcc.SetRange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
                GLAcc.SetRange("Budget Filter", BCSetup."Current Budget Code");
                //GLAcc.SetRange("Dimension Set ID Filter", BoardPaymentHeader."Dimension Set ID");
                GLAcc.SetRange("Global Dimension 2 Filter", BoardPaymentHeader."Global Dimension 2 Code");
                if GLAcc.Find('-') then begin
                    GLAcc.CalcFields("Budgeted Amount", "Net Change");
                    ActualsAmount := GLAcc."Net Change";
                    BudgetAmount := GLAcc."Budgeted Amount";
                end;

                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                Commitments.SetRange(Commitments."Dimension Set ID", BoardPaymentHeader."Dimension Set ID");
                Commitments.setrange(Commitments."Document Type", Commitments."document type"::"Board Retainer");
                Commitments.setrange("Shortcut Dimension 2 Code", BoardPaymentHeader."Global Dimension 2 Code");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;


                if ((CommitmentAmount + BoardPaymentHeader."Board Retainer" + ActualsAmount) > BudgetAmount)
                   and not (BCSetup."Allow OverExpenditure") then begin
                    Error('The Amount Voucher No %1  %2  Exceeds The Budget By %4',
                    BoardPaymentHeader."No.",
                    //BoardPaymentHeader.Type,
                    BoardPaymentHeader."Member No.",
                    Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + BoardPaymentHeader."Board Retainer"))));
                end else begin
                    //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                    if ((CommitmentAmount + BoardPaymentHeader."Board Retainer" + ActualsAmount) > BudgetAmount) then begin
                        if not Confirm(Text0001 +
                        Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + BoardPaymentHeader."Board Retainer")))
                        + Text0002, true) then begin
                            Error('Budgetary Checking Process Aborted');
                        end;
                    end;

                    Commitments.Reset;
                    Commitments.Init;
                    EntryNo += 1;
                    Commitments."Line No." := EntryNo;
                    Commitments."Commitment Date" := Today;
                    Commitments."Posting Date" := BoardPaymentHeader.Date;
                    Commitments."Document Type" := Commitments."document type"::"Board Retainer";
                    Commitments."Document No." := BoardPaymentHeader."No.";
                    Commitments.Amount := BoardPaymentHeader."Board Retainer";
                    Commitments."Month Budget" := BudgetAmount;
                    Commitments."Month Actual" := ActualsAmount;
                    Commitments.Committed := true;
                    Commitments."Committed By" := UserId;
                    Commitments."Committed Date" := BoardPaymentHeader.Date;
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Committed Time" := Time;
                    //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                    Commitments.Validate("Shortcut Dimension 1 Code", BoardPaymentHeader."Global Dimension 1 Code");
                    Commitments.Validate("Shortcut Dimension 2 Code", BoardPaymentHeader."Global Dimension 2 Code");
                    Commitments."Dimension Set ID" := BoardPaymentHeader."Dimension Set ID";
                    Commitments.Budget := BCSetup."Current Budget Code";
                    Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                    Commitments."Actual Source" := BCSetup."Actual Source";
                    //Commitments."Document Line No." := BoardPaymentHeader."Member No.";
                    //Added for Totalling Accounts
                    Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                    Commitments.Insert;

                    BoardPaymentHeader.Committed := true;
                    BoardPaymentHeader.Modify;
                    //End Tagging Payment Lines as Committed
                end;
            end;

            //get the lines related to the Board payment header
            //Reinitailise Vars
            BudgetGL := '';
            ActualsAmount := 0;
            BudgetAmount := 0;
            CommitmentAmount := 0;

            BoardPayLines.Reset;
            BoardPayLines.SetRange("No.", BoardPaymentHeader."No.");
            // BoardPayLines
            // BoardPayLines.SetRange()
            //PayLine.SetRange(PayLine."Account Type", PayLine."account type"::"G/L Account");
            //PayLine.SetRange(PayLine."Budgetary Control A/C", true);

            if BoardPayLines.FindFirst then begin
                repeat
                    BudgetGL := '';
                    //check the votebook now
                    FirstDay := Dmy2date(1, Date2dmy(BoardPayLines.Date, 2), Date2dmy(BoardPayLines.Date, 3));
                    CurrMonth := Date2dmy(BoardPayLines.Date, 2);
                    if CurrMonth = 12 then begin
                        LastDay := Dmy2date(1, 1, Date2dmy(BoardPayLines.Date, 3) + 1);
                        LastDay := CalcDate('-1D', LastDay);
                    end
                    else begin
                        CurrMonth := CurrMonth + 1;
                        LastDay := Dmy2date(1, CurrMonth, Date2dmy(BoardPayLines.Date, 3));
                        LastDay := CalcDate('-1D', LastDay);
                    end;

                    BudgetGL := BoardPayLines."G/L Accounts";

                    //For End Total Budgeting -TMEA
                    if BCSetup."Use Totaling Account" then begin
                        GLAcc.Get(BudgetGL);
                        if GLAcc."Budget Control Account" <> '' then
                            BudgetGL := GLAcc."Budget Control Account"
                        else
                            Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
                    end;
                    //End (End Total Budget)

                    //check the summation of the budget and actuals in the database
                    ActualsAmount := 0;
                    BudgetAmount := 0;

                    GLAcc.Reset;
                    GLAcc.SetRange("No.", BudgetGL);
                    GLAcc.SetRange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
                    GLAcc.SetRange("Budget Filter", BCSetup."Current Budget Code");
                    //GLAcc.SetRange("Dimension Set ID Filter", BoardPayLines."Dimension Set ID");
                    GLAcc.SetRange("Global Dimension 2 Filter", BoardPayLines."Global Dimension 2 Code");
                    if GLAcc.Find('-') then begin
                        GLAcc.CalcFields("Budgeted Amount", "Net Change");
                        ActualsAmount := GLAcc."Net Change";
                        BudgetAmount := GLAcc."Budgeted Amount";
                    end;

                    //get the committments
                    CommitmentAmount := 0;
                    Commitments.Reset;
                    Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                    Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                    Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                    Commitments.SetRange(Commitments."Dimension Set ID", BoardPayLines."Dimension Set ID");
                    Commitments.SetRange("Document Type", Commitments."document type"::"Board Earnings");
                    //Commitments.SetRange("Payment Code", BoardPayLines.Code);
                    Commitments.CalcSums(Commitments.Amount);

                    CommitmentAmount := Commitments.Amount;

                    //MyVar := FORMAT(PayLine."Line No.") +'|'+ FORMAT(ActualsAmount)  +'|'+ FORMAT(BudgetAmount)  +'|'+ FORMAT(CommitmentAmount);
                    //IF ShowResults THEN EXIT(MyVar);

                    //check if there is any budget
                    if (BudgetAmount <= 0) and not (BCSetup."Allow OverExpenditure") then begin
                        Error('No Budget To Check Against');
                    end else begin
                        if (BudgetAmount <= 0) then begin
                            if not Confirm(Text0003, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;
                    end;

                    //check if the actuals plus the amount is greater then the budget amount
                    if ((CommitmentAmount + BoardPayLines.Amount + ActualsAmount) > BudgetAmount)
                    and not (BCSetup."Allow OverExpenditure") then begin
                        Error('The Amount Voucher No %1  %2  Exceeds The Budget By %3',
                        BoardPayLines."No.",
                        //BoardPayLines.Type,
                        BoardPayLines."Line No",
                        Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + BoardPayLines.Amount))));
                    end else begin
                        //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                        if ((CommitmentAmount + BoardPayLines.Amount + ActualsAmount) > BudgetAmount) then begin
                            if not Confirm(Text0001 +
                            Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + BoardPayLines.Amount))) +
                            Text0002, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;

                        Commitments.Reset;
                        Commitments.Init;
                        EntryNo += 1;
                        Commitments."Line No." := EntryNo;
                        Commitments."Commitment Date" := Today;
                        Commitments."Posting Date" := BoardPayLines.Date;
                        Commitments."Document Type" := Commitments."document type"::"Board Earnings";
                        Commitments."Document No." := BoardPayLines."No.";
                        Commitments.Amount := BoardPayLines.Amount;
                        Commitments."Month Budget" := BudgetAmount;
                        Commitments."Month Actual" := ActualsAmount;
                        Commitments.Committed := true;
                        Commitments."Committed By" := UserId;
                        Commitments."Committed Date" := BoardPayLines.Date;
                        Commitments."G/L Account No." := BudgetGL;
                        Commitments."Committed Time" := Time;
                        //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                        Commitments.Validate("Shortcut Dimension 1 Code", BoardPayLines."Global Dimension 1 Code");
                        Commitments.Validate("Shortcut Dimension 2 Code", BoardPayLines."Global Dimension 2 Code");
                        Commitments."Dimension Set ID" := BoardPayLines."Dimension Set ID";
                        Commitments.Budget := BCSetup."Current Budget Code";
                        Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                        Commitments."Actual Source" := BCSetup."Actual Source";
                        Commitments."Document Line No." := BoardPayLines."Line No";
                        commitments."Payment Code" := BoardPayLines.Code;
                        //Added for Totalling Accounts
                        Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                        Commitments.Insert;
                        // MESSAGE('Done');
                        //Tag the Payment Line as Committed
                        BoardPayLines.Committed := true;
                        BoardPayLines.Modify;
                        //End Tagging Payment Lines as Committed
                    end;

                until BoardPayLines.Next = 0;
            end;
            Message(BudgetCheckTxt)
        end
        else//budget control not mandatory
          begin
            error('No lines available for Budget Check');
        end;
    end;


    procedure ReverseEntries(DocumentType: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance; DocNo: Code[20])
    var
        Commitments: Record Committment;
        EntryNo: Integer;
        CommittedLines: Record Committment;
    begin
        //Get Commitment Lines
        Commitments.Reset;
        if Commitments.Find('+') then
            EntryNo := Commitments."Line No.";



        CommittedLines.Reset;
        CommittedLines.SetRange(CommittedLines."Document Type", DocumentType);
        CommittedLines.SetRange(CommittedLines."Document No.", DocNo);
        CommittedLines.SetRange(CommittedLines.Committed, true);
        if CommittedLines.Find('-') then begin
            repeat
                Commitments.Reset;
                Commitments.Init;
                EntryNo += 1;
                Commitments."Line No." := EntryNo;
                Commitments."Commitment Date" := Today;
                Commitments."Posting Date" := CommittedLines."Posting Date";
                Commitments."Document Type" := CommittedLines."Document Type";
                Commitments."Document No." := CommittedLines."Document No.";
                Commitments.Amount := -CommittedLines.Amount;
                Commitments."Month Budget" := CommittedLines."Month Budget";
                Commitments."Month Actual" := CommittedLines."Month Actual";
                Commitments.Committed := false;
                Commitments."Committed By" := UserId;
                Commitments."Committed Date" := CommittedLines."Committed Date";
                Commitments."G/L Account No." := CommittedLines."G/L Account No.";
                Commitments."Committed Time" := Time;
                //     Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                Commitments."Shortcut Dimension 1 Code" := CommittedLines."Shortcut Dimension 1 Code";
                Commitments."Shortcut Dimension 2 Code" := CommittedLines."Shortcut Dimension 2 Code";
                Commitments."Shortcut Dimension 3 Code" := CommittedLines."Shortcut Dimension 3 Code";
                Commitments."Shortcut Dimension 4 Code" := CommittedLines."Shortcut Dimension 4 Code";
                Commitments."Dimension Set ID" := CommittedLines."Dimension Set ID";
                Commitments.Budget := CommittedLines.Budget;
                Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                Commitments."Actual Source" := BCSetup."Actual Source";
                Commitments."Document Line No." := CommittedLines."Document Line No.";
                //Added for Totalling Accounts
                Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                Commitments.Insert;

            until CommittedLines.Next = 0;
        end;
    end;


    procedure CheckFundsAvailability(Payments: Record "Payments Header")
    var
        BankAcc: Record "Bank Account";
        "Current Source A/C Bal.": Decimal;
    begin
        //get the source account balance from the database table
        BankAcc.Reset;
        BankAcc.SetRange(BankAcc."No.", Payments."Paying Bank Account");
        BankAcc.SetRange(BankAcc."Bank Type", BankAcc."bank type"::Cash);
        if BankAcc.FindFirst then begin
            BankAcc.CalcFields(BankAcc.Balance);
            "Current Source A/C Bal." := BankAcc.Balance;
            if ("Current Source A/C Bal." - Payments."Total Net Amount") < 0 then begin
                Error('The transaction will result in a negative balance in the BANK ACCOUNT. %1:%2', BankAcc."No.",
                BankAcc.Name);
            end;
        end;
    end;

    procedure CheckFundsAvailability1(Payments: Record "Fosa Payments Header")
    var
        BankAcc: Record "Bank Account";
        "Current Source A/C Bal.": Decimal;
    begin
        //get the source account balance from the database table
        BankAcc.Reset;
        BankAcc.SetRange(BankAcc."No.", Payments."Paying Bank Account");
        BankAcc.SetRange(BankAcc."Bank Type", BankAcc."bank type"::Cash);
        if BankAcc.FindFirst then begin
            BankAcc.CalcFields(BankAcc.Balance);
            "Current Source A/C Bal." := BankAcc.Balance;
            if ("Current Source A/C Bal." - Payments."Total Net Amount") < 0 then begin
                Error('The transaction will result in a negative balance in the BANK ACCOUNT. %1:%2', BankAcc."No.",
                BankAcc.Name);
            end;
        end;
    end;

    procedure UpdateAnalysisView()
    var
        UpdateAnalysisView: Codeunit "Update Analysis View";
        BudgetaryControl: Record "Budgetary Control Setup";
        AnalysisView: Record "Analysis View";
    begin
        //Update Budget Lines
        if BudgetaryControl.Get then begin
            if BudgetaryControl."Actual Source" = BudgetaryControl."actual source"::"Analysis View Entry" then begin
                if BudgetaryControl."Analysis View Code" = '' then
                    Error('The Analysis view code can not be blank in the budgetary control setup');
            end;
            if BudgetaryControl."Analysis View Code" <> '' then begin
                AnalysisView.Reset;
                AnalysisView.SetRange(AnalysisView.Code, BudgetaryControl."Analysis View Code");
                // if AnalysisView.Find('-') then
                //     UpdateAnalysisView.UpdateAnalysisView_Budget(AnalysisView);  //analysis not updating budget
                //UpdateAnalysisView.RUN(AnalysisView);                      //updated 2015 correct analysis code
            end;
        end;
    end;


    procedure UpdateDim(DimCode: Code[20]; DimValueCode: Code[20])
    var
        GLBudgetDim: Integer;
    begin
        //In 2013 this is not applicable table 361 not supported
        /*IF DimCode = '' THEN
          EXIT;
        WITH GLBudgetDim DO BEGIN
          IF GET(Rec."Entry No.",DimCode) THEN
            DELETE;
          IF DimValueCode <> '' THEN BEGIN
            INIT;
            "Entry No." := Rec."Entry No.";
            "Dimension Code" := DimCode;
            "Dimension Value Code" := DimValueCode;
            INSERT;
          END;
        END; */

    end;


    procedure CheckIfBlocked(BudgetName: Code[20])
    var
        GLBudgetName: Record "G/L Budget Name";
    begin
        GLBudgetName.Get(BudgetName);
        GLBudgetName.TestField(Blocked, false);
    end;


    procedure CheckStaffClaim(var ImprestHeader: Record "Staff Claims Header")
    var
        PayLine: Record "Staff Claim Lines";
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
        GLAccount: Record "G/L Account";
    begin
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.Reset;
        BCSetup.Get();
        // if BCSetup.Mandatory then//budgetary control is mandatory
        //   begin
        //check if the dates are within the specified range in relation to the payment header table
        if (ImprestHeader.Date < BCSetup."Current Budget Start Date") then begin
            Error('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader.Date,
            BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
        end
        else
            if (ImprestHeader.Date > BCSetup."Current Budget End Date") then begin
                Error('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader.Date,
                BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");

            end;
        //Is budget Available
        CheckIfBlocked(BCSetup."Current Budget Code");

        //Get Commitment Lines
        if Commitments.Find('+') then
            EntryNo := Commitments."Line No.";

        //get the lines related to the payment header
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, ImprestHeader."No.");
        PayLine.SetRange(PayLine."Budgetary Control A/C", true);
        if PayLine.FindFirst then begin
            repeat
                //check the votebook now
                FirstDay := Dmy2date(1, Date2dmy(ImprestHeader.Date, 2), Date2dmy(ImprestHeader.Date, 3));
                CurrMonth := Date2dmy(ImprestHeader.Date, 2);
                if CurrMonth = 12 then begin
                    LastDay := Dmy2date(1, 1, Date2dmy(ImprestHeader.Date, 3) + 1);
                    LastDay := CalcDate('-1D', LastDay);
                end
                else begin
                    CurrMonth := CurrMonth + 1;
                    LastDay := Dmy2date(1, CurrMonth, Date2dmy(ImprestHeader.Date, 3));
                    LastDay := CalcDate('-1D', LastDay);
                end;

                //If Budget is annual then change the Last day
                if BCSetup."Budget Check Criteria" = BCSetup."budget check criteria"::"Whole Year" then
                    LastDay := BCSetup."Current Budget End Date";

                //The GL Account
                BudgetGL := PayLine."Account No:";

                //For End Total Budgeting -TMEA
                if BCSetup."Use Totaling Account" then begin
                    GLAcc.Get(BudgetGL);
                    if GLAcc."Budget Control Account" <> '' then
                        BudgetGL := GLAcc."Budget Control Account"
                    else
                        Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
                end;
                //End (End Total Budget)

                //check the summation of the budget and actuals in the database
                ActualsAmount := 0;
                BudgetAmount := 0;

                GLAcc.Reset;
                GLAcc.SetRange("No.", BudgetGL);
                GLAcc.SetRange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
                GLAcc.SetRange("Budget Filter", BCSetup."Current Budget Code");
                GLAcc.SetRange("Dimension Set ID Filter", PayLine."Dimension Set ID");
                GLAcc.SetRange("Global Dimension 2 Filter", PayLine."Shortcut Dimension 2 Code");
                if GLAcc.Find('-') then begin
                    GLAcc.CalcFields("Budgeted Amount", "Net Change");
                    ActualsAmount := GLAcc."Net Change";
                    BudgetAmount := GLAcc."Budgeted Amount";
                end;

                //get the committments
                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                Commitments.SetRange(Commitments."Dimension Set ID", PayLine."Dimension Set ID");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                Message('Total Budgeted amount is %1 and the current remaining budget as at the current month is %2 in Budget: %3 for Dept :%4', format(BudgetAmount), Format(BudgetAmount - CommitmentAmount - ActualsAmount), BCSetup."Current Budget Code", PayLine."Shortcut Dimension 2 Code");


                //check if there is any budget
                if (BudgetAmount <= 0) and not (BCSetup."Allow OverExpenditure") then begin
                    Error('The Account %1 has no budget to check against/ Does not have a budget for Dept: %2', BudgetGL, PayLine."Shortcut Dimension 2 Code");
                end else begin
                    if (BudgetAmount <= 0) then begin
                        if not Confirm(Text0003, true) then begin
                            Error('Budgetary Checking Process Aborted');
                        end;
                    end;
                end;

                //check if the actuals plus the amount is greater then the budget amount
                if ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount)
                and not (BCSetup."Allow OverExpenditure") then begin
                    Error('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                    PayLine.No, 'Staff Imprest', PayLine.No,
                      Format(Abs(BudgetAmount - (CommitmentAmount + PayLine."Amount LCY"))));
                end else begin
                    //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                    if ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount) then begin
                        if not Confirm(Text0001 +
                        Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."Amount LCY")))
                        + Text0002, true) then begin
                            Error('Budgetary Checking Process Aborted');
                        end;
                    end;

                    Commitments.Reset;
                    Commitments.Init;
                    EntryNo += 1;
                    Commitments."Line No." := EntryNo;
                    Commitments."Commitment Date" := Today;
                    Commitments."Posting Date" := ImprestHeader.Date;
                    Commitments."Document Type" := Commitments."document type"::StaffClaim;
                    Commitments."Document No." := ImprestHeader."No.";
                    Commitments.Amount := PayLine."Amount LCY";
                    Commitments."Month Budget" := BudgetAmount;
                    Commitments."Month Actual" := ActualsAmount;
                    Commitments.Committed := true;
                    Commitments."Committed By" := UserId;
                    Commitments."Committed Date" := ImprestHeader.Date;
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Committed Time" := Time;
                    // Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                    Commitments.Validate("Shortcut Dimension 1 Code", PayLine."Global Dimension 1 Code");
                    Commitments.Validate("Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
                    Commitments."Dimension Set ID" := PayLine."Dimension Set ID";
                    Commitments.Budget := BCSetup."Current Budget Code";
                    Commitments.Type := ImprestHeader."Account Type";
                    Commitments."Vendor/Cust No." := ImprestHeader."Account No.";
                    Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                    Commitments."Actual Source" := BCSetup."Actual Source";
                    Commitments."Document Line No." := PayLine."Line No.";
                    //Added for Totalling Accounts
                    Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                    Commitments.Insert;
                    //Tag the Imprest Line as Committed
                    PayLine.Committed := true;
                    PayLine.Modify;
                    //End Tagging Imprest Lines as Committed
                end;

            until PayLine.Next = 0;
        end;
        Message(BudgetCheckTxt)
    end;


    procedure CheckStaffAdvance(var ImprestHeader: Record "Staff Advance Header")
    var
        PayLine: Record "Staff Advance Lines";
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
        GLAccount: Record "G/L Account";
    begin
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.Reset;
        BCSetup.Get();
        if BCSetup.Mandatory then//budgetary control is mandatory
          begin
            //check if the dates are within the specified range in relation to the payment header table
            if (ImprestHeader.Date < BCSetup."Current Budget Start Date") then begin
                Error('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader.Date,
                BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
            end
            else
                if (ImprestHeader.Date > BCSetup."Current Budget End Date") then begin
                    Error('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader.Date,
                    BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");

                end;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");

            //Get Commitment Lines
            if Commitments.Find('+') then
                EntryNo := Commitments."Line No.";

            //get the lines related to the payment header
            PayLine.Reset;
            PayLine.SetRange(PayLine.No, ImprestHeader."No.");
            PayLine.SetRange(PayLine."Budgetary Control A/C", true);
            if PayLine.FindFirst then begin
                repeat
                    //check the votebook now
                    FirstDay := Dmy2date(1, Date2dmy(ImprestHeader.Date, 2), Date2dmy(ImprestHeader.Date, 3));
                    CurrMonth := Date2dmy(ImprestHeader.Date, 2);
                    if CurrMonth = 12 then begin
                        LastDay := Dmy2date(1, 1, Date2dmy(ImprestHeader.Date, 3) + 1);
                        LastDay := CalcDate('-1D', LastDay);
                    end
                    else begin
                        CurrMonth := CurrMonth + 1;
                        LastDay := Dmy2date(1, CurrMonth, Date2dmy(ImprestHeader.Date, 3));
                        LastDay := CalcDate('-1D', LastDay);
                    end;

                    //If Budget is annual then change the Last day
                    if BCSetup."Budget Check Criteria" = BCSetup."budget check criteria"::"Whole Year" then
                        LastDay := BCSetup."Current Budget End Date";

                    //The GL Account
                    BudgetGL := PayLine."Account No:";

                    //For End Total Budgeting -TMEA
                    if BCSetup."Use Totaling Account" then begin
                        GLAcc.Get(BudgetGL);
                        if GLAcc."Budget Control Account" <> '' then
                            BudgetGL := GLAcc."Budget Control Account"
                        else
                            Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
                    end;
                    //End (End Total Budget)

                    //check the summation of the budget and actuals in the database
                    ActualsAmount := 0;
                    BudgetAmount := 0;

                    GLAcc.Reset;
                    GLAcc.SetRange("No.", BudgetGL);
                    GLAcc.SetRange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
                    GLAcc.SetRange("Budget Filter", BCSetup."Current Budget Code");
                    GLAcc.SetRange("Dimension Set ID Filter", PayLine."Dimension Set ID");
                    if GLAcc.Find('-') then begin
                        GLAcc.CalcFields("Budgeted Amount", "Net Change");
                        ActualsAmount := GLAcc."Net Change";
                        BudgetAmount := GLAcc."Budgeted Amount";
                    end;

                    //get the committments
                    CommitmentAmount := 0;
                    Commitments.Reset;
                    Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                    Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                    Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                    Commitments.SetRange(Commitments."Dimension Set ID", PayLine."Dimension Set ID");
                    Commitments.CalcSums(Commitments.Amount);
                    CommitmentAmount := Commitments.Amount;



                    //check if there is any budget
                    if (BudgetAmount <= 0) and not (BCSetup."Allow OverExpenditure") then begin
                        Error('No Budget To Check Against');
                    end else begin
                        if (BudgetAmount <= 0) then begin
                            if not Confirm(Text0003, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;
                    end;
                    /*
                    MESSAGE('BudgetAmount'+FORMAT(BudgetAmount));
                    MESSAGE('ActualsAmount'+FORMAT(ActualsAmount));
                    MESSAGE('CommitmentAmount'+FORMAT(CommitmentAmount));
                    MESSAGE('PayLine."Amount LCY"'+FORMAT(PayLine."Amount LCY"));
                     */
                    //check if the actuals plus the amount is greater then the budget amount
                    if ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount)
                    and not (BCSetup."Allow OverExpenditure") then begin
                        Error('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                        PayLine.No, 'Staff Imprest', PayLine.No,
                          Format(Abs(BudgetAmount - (ActualsAmount + CommitmentAmount + PayLine."Amount LCY"))));
                    end else begin
                        //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                        if ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount) then begin
                            if not Confirm(Text0001 +
                            Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."Amount LCY")))
                            + Text0002, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;

                        Commitments.Reset;
                        Commitments.Init;
                        EntryNo += 1;
                        Commitments."Line No." := EntryNo;
                        Commitments."Commitment Date" := Today;
                        Commitments."Posting Date" := ImprestHeader.Date;
                        Commitments."Document Type" := Commitments."document type"::StaffAdvance;
                        Commitments."Document No." := ImprestHeader."No.";
                        Commitments.Amount := PayLine."Amount LCY";
                        Commitments."Month Budget" := BudgetAmount;
                        Commitments."Month Actual" := ActualsAmount;
                        Commitments.Committed := true;
                        Commitments."Committed By" := UserId;
                        Commitments."Committed Date" := ImprestHeader.Date;
                        Commitments."G/L Account No." := BudgetGL;
                        Commitments."Committed Time" := Time;
                        //   Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                        Commitments.Validate("Shortcut Dimension 1 Code", PayLine."Global Dimension 1 Code");
                        Commitments.Validate("Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
                        Commitments."Dimension Set ID" := PayLine."Dimension Set ID";
                        Commitments.Budget := BCSetup."Current Budget Code";
                        Commitments.Type := ImprestHeader."Account Type";
                        Commitments."Vendor/Cust No." := ImprestHeader."Account No.";
                        Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                        Commitments."Actual Source" := BCSetup."Actual Source";
                        Commitments."Document Line No." := PayLine."Line No.";
                        //Added for Totalling Accounts
                        Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                        Commitments.Insert;
                        //Tag the Imprest Line as Committed
                        PayLine.Committed := true;
                        PayLine.Modify;
                        //End Tagging Imprest Lines as Committed
                    end;

                until PayLine.Next = 0;
            end;
            Message(BudgetCheckTxt)
        end
        else//budget control not mandatory
          begin

        end;

    end;


    procedure CheckStaffAdvSurr(var ImprestHeader: Record "Staff Advance Surrender Header")
    var
        PayLine: Record "Staff Advanc Surrender Details";
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
    begin
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.Reset;
        BCSetup.Get();
        if BCSetup.Mandatory then//budgetary control is mandatory
          begin
            //check if the dates are within the specified range in relation to the payment header table
            if (ImprestHeader."Surrender Date" < BCSetup."Current Budget Start Date") then begin
                Error('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader."Surrender Date",
                BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
            end
            else
                if (ImprestHeader."Surrender Date" > BCSetup."Current Budget End Date") then begin
                    Error('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader."Surrender Date",
                    BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");

                end;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");

            //Get Commitment Lines
            if Commitments.Find('+') then
                EntryNo := Commitments."Line No.";

            //get the lines related to the payment header
            PayLine.Reset;
            PayLine.SetRange(PayLine."Surrender Doc No.", ImprestHeader.No);
            PayLine.SetRange(PayLine."Budgetary Control A/C", true);
            if PayLine.FindFirst then begin
                repeat
                    //check the votebook now
                    FirstDay := Dmy2date(1, Date2dmy(ImprestHeader."Surrender Date", 2), Date2dmy(ImprestHeader."Surrender Date", 3));
                    CurrMonth := Date2dmy(ImprestHeader."Surrender Date", 2);
                    if CurrMonth = 12 then begin
                        LastDay := Dmy2date(1, 1, Date2dmy(ImprestHeader."Surrender Date", 3) + 1);
                        LastDay := CalcDate('-1D', LastDay);
                    end
                    else begin
                        CurrMonth := CurrMonth + 1;
                        LastDay := Dmy2date(1, CurrMonth, Date2dmy(ImprestHeader."Surrender Date", 3));
                        LastDay := CalcDate('-1D', LastDay);
                    end;

                    //The GL Account
                    BudgetGL := PayLine."Account No:";

                    //For End Total Budgeting -TMEA
                    if BCSetup."Use Totaling Account" then begin
                        GLAcc.Get(BudgetGL);
                        if GLAcc."Budget Control Account" <> '' then
                            BudgetGL := GLAcc."Budget Control Account"
                        else
                            Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
                    end;
                    //End (End Total Budget)

                    //check the summation of the budget and actuals in the database
                    ActualsAmount := 0;
                    BudgetAmount := 0;

                    GLAcc.Reset;
                    GLAcc.SetRange("No.", BudgetGL);
                    GLAcc.SetRange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
                    GLAcc.SetRange("Budget Filter", BCSetup."Current Budget Code");
                    GLAcc.SetRange("Dimension Set ID Filter", PayLine."Dimension Set ID");
                    if GLAcc.Find('-') then begin
                        GLAcc.CalcFields("Budgeted Amount", "Net Change");
                        ActualsAmount := GLAcc."Net Change";
                        BudgetAmount := GLAcc."Budgeted Amount";
                    end;

                    //get the committments
                    CommitmentAmount := 0;
                    Commitments.Reset;
                    Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                    Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                    Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                    Commitments.SetRange(Commitments."Dimension Set ID", PayLine."Dimension Set ID");
                    Commitments.CalcSums(Commitments.Amount);
                    CommitmentAmount := Commitments.Amount;



                    //check if there is any budget
                    if (BudgetAmount <= 0) and not (BCSetup."Allow OverExpenditure") then begin
                        Error('No Budget To Check Against');
                    end else begin
                        if (BudgetAmount <= 0) then begin
                            if not Confirm(Text0003, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;
                    end;

                    //check if the actuals plus the amount is greater then the budget amount
                    if ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount)
                    and not (BCSetup."Allow OverExpenditure") then begin
                        Error('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                        PayLine."Surrender Doc No.", 'Staff Imprest', PayLine."Surrender Doc No.",
                          Format(Abs(BudgetAmount - (CommitmentAmount + PayLine."Amount LCY"))));
                    end else begin
                        //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                        if ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount) then begin
                            if not Confirm(Text0001 +
                            Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."Amount LCY")))
                            + Text0002, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;

                        Commitments.Reset;
                        Commitments.Init;
                        EntryNo += 1;
                        Commitments."Line No." := EntryNo;
                        Commitments."Commitment Date" := Today;
                        Commitments."Posting Date" := ImprestHeader."Surrender Date";
                        Commitments."Document Type" := Commitments."document type"::StaffSurrender;
                        Commitments."Document No." := ImprestHeader.No;
                        Commitments.Amount := PayLine."Amount LCY";
                        Commitments."Month Budget" := BudgetAmount;
                        Commitments."Month Actual" := ActualsAmount;
                        Commitments.Committed := true;
                        Commitments."Committed By" := UserId;
                        Commitments."Committed Date" := ImprestHeader."Surrender Date";
                        Commitments."G/L Account No." := BudgetGL;
                        Commitments."Committed Time" := Time;
                        //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                        Commitments.Validate("Shortcut Dimension 1 Code", PayLine."Shortcut Dimension 1 Code");
                        Commitments.Validate("Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
                        Commitments."Dimension Set ID" := PayLine."Dimension Set ID";
                        Commitments.Budget := BCSetup."Current Budget Code";
                        Commitments.Type := ImprestHeader."Account Type";
                        Commitments."Vendor/Cust No." := ImprestHeader."Account No.";
                        Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                        Commitments."Actual Source" := BCSetup."Actual Source";
                        Commitments."Document Line No." := PayLine."Line No.";
                        //Added for Totalling Accounts
                        Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                        Commitments.Insert;
                        //Tag the Imprest Line as Committed
                        PayLine.Committed := true;
                        PayLine.Modify;
                        //End Tagging Imprest Lines as Committed
                    end;

                until PayLine.Next = 0;
            end;
            Message(BudgetCheckTxt)
        end
        else//budget control not mandatory
          begin

        end;
    end;


    procedure CheckPVBoard(var PaymentHeader: Record "Payments Header Board"): Text
    var
        PayLine: Record "Payment Line Board";
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
    begin
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.Reset;
        BCSetup.Get();
        if BCSetup.Mandatory then//budgetary control is mandatory
          begin
            //check if the dates are within the specified range in relation to the payment header table
            if (PaymentHeader."Transaction Date" < BCSetup."Current Budget Start Date") then begin
                Error('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', PaymentHeader."Transaction Date",
                BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
            end
            else
                if (PaymentHeader."Transaction Date" > BCSetup."Current Budget End Date") then begin
                    Error('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', PaymentHeader."Transaction Date",
                    BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                end;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");


            //Get Commitment Lines
            if Commitments.Find('+') then
                EntryNo := Commitments."Line No.";

            //get the lines related to the payment header
            PayLine.Reset;
            PayLine.SetRange(PayLine."Document No", PaymentHeader."Transaction No.");
            // PayLine.SETRANGE(PayLine."G/L Account No.", PayLine."Account Type"::"G/L Account");
            PayLine.SETRANGE(PayLine."Budgetary Control A/C", TRUE);
            if PayLine.FindFirst then begin
                repeat
                    //check the votebook now
                    FirstDay := Dmy2date(1, Date2dmy(PaymentHeader."Transaction Date", 2), Date2dmy(PaymentHeader."Transaction Date", 3));
                    CurrMonth := Date2dmy(PaymentHeader."Transaction Date", 2);
                    if CurrMonth = 12 then begin
                        LastDay := Dmy2date(1, 1, Date2dmy(PaymentHeader."Transaction Date", 3) + 1);
                        LastDay := CalcDate('-1D', LastDay);
                    end
                    else begin
                        CurrMonth := CurrMonth + 1;
                        LastDay := Dmy2date(1, CurrMonth, Date2dmy(PaymentHeader."Transaction Date", 3));
                        LastDay := CalcDate('-1D', LastDay);
                    end;

                    // Check Bugdetary Control Account for the earnings/Deductions
                    CheckBoardDeductions(PayLine);

                    BudgetGL := PayLine."G/L Account No.";

                    //For End Total Budgeting -TMEA
                    if BCSetup."Use Totaling Account" then begin
                        GLAcc.Get(BudgetGL);
                        if GLAcc."Budget Control Account" <> '' then
                            BudgetGL := GLAcc."Budget Control Account"
                        else
                            Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
                    end;
                    //End (End Total Budget)

                    //check the summation of the budget and actuals in the database
                    ActualsAmount := 0;
                    BudgetAmount := 0;

                    GLAcc.Reset;
                    GLAcc.SetRange("No.", BudgetGL);
                    GLAcc.SetRange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
                    GLAcc.SetRange("Budget Filter", BCSetup."Current Budget Code");
                    GLAcc.SetRange("Dimension Set ID Filter", PayLine."Dimension Set ID");
                    if GLAcc.Find('-') then begin
                        GLAcc.CalcFields("Budgeted Amount", "Net Change");
                        ActualsAmount := GLAcc."Net Change";
                        BudgetAmount := GLAcc."Budgeted Amount";
                    end;

                    //get the committments
                    CommitmentAmount := 0;
                    Commitments.Reset;
                    Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                    Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                    Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                    Commitments.SetRange(Commitments."Dimension Set ID", PayLine."Dimension Set ID");
                    Commitments.CalcSums(Commitments.Amount);
                    CommitmentAmount := Commitments.Amount;

                    //MyVar := FORMAT(PayLine."Line No.") +'|'+ FORMAT(ActualsAmount)  +'|'+ FORMAT(BudgetAmount)  +'|'+ FORMAT(CommitmentAmount);
                    //IF ShowResults THEN EXIT(MyVar);

                    //check if there is any budget
                    if (BudgetAmount <= 0) and not (BCSetup."Allow OverExpenditure") then begin
                        Error('No Budget To Check Against');
                    end else begin
                        if (BudgetAmount <= 0) then begin
                            if not Confirm(Text0003, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;
                    end;

                    //check if the actuals plus the amount is greater then the budget amount
                    if ((CommitmentAmount + PayLine."Net Amount" + ActualsAmount) > BudgetAmount)
                    and not (BCSetup."Allow OverExpenditure") then begin
                        Error('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                        PayLine."Document No", PayLine."Member No.", PayLine."G/L Account No.",
                          Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."Net Amount"))));
                    end else begin
                        //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                        if ((CommitmentAmount + PayLine."Net Amount" + ActualsAmount) > BudgetAmount) then begin
                            if not Confirm(Text0001 +
                            Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."Net Amount")))
                            + Text0002, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;

                        Commitments.Reset;
                        Commitments.Init;
                        EntryNo += 1;
                        Commitments."Line No." := EntryNo;
                        Commitments."Commitment Date" := Today;
                        Commitments."Posting Date" := PaymentHeader."Transaction Date";
                        Commitments."Document Type" := Commitments."document type"::"Payment Voucher";
                        Commitments."Document No." := PaymentHeader."Transaction No.";
                        Commitments.Amount := PayLine."Net Amount";
                        Commitments."Month Budget" := BudgetAmount;
                        Commitments."Month Actual" := ActualsAmount;
                        Commitments.Committed := true;
                        Commitments."Committed By" := UserId;
                        Commitments."Committed Date" := PaymentHeader."Transaction Date";
                        Commitments."G/L Account No." := BudgetGL;
                        Commitments."Committed Time" := Time;
                        //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                        Commitments.Validate("Shortcut Dimension 1 Code", PayLine."Shortcut Dimension 1 Code");
                        Commitments.Validate("Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
                        Commitments."Dimension Set ID" := PayLine."Dimension Set ID";
                        Commitments.Budget := BCSetup."Current Budget Code";
                        Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                        Commitments."Actual Source" := BCSetup."Actual Source";
                        //Commitments."Document Line No.":=PayLine."Line No.";
                        //Added for Totalling Accounts
                        Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                        Commitments.Insert;
                        PayLine.Committed := true;
                        PayLine.Modify;
                    end;
                until PayLine.Next = 0;
            end else
                Message('This account does not have any budgetary controls');
            Message(BudgetCheckTxt)
        end
        else//budget control not mandatory
          begin

        end;
    end;

    local procedure CheckBoardDeductions(var PaymentLines: Record "Payment Line Board")
    var
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
        BoardEarnings: record "PR Board Transactions";
        PaymentHeader: Record "Payments Header Board";
    begin
        PaymentHeader.Get(PaymentLines."Document No");
        BoardEarnings.reset;
        BoardEarnings.SETRANGE(BoardEarnings."Payment No.", PaymentLines."Document No");
        BoardEarnings.SETRANGE(BoardEarnings."No.", PaymentLines."Member No.");
        if BoardEarnings.FindFirst() then begin
            repeat
                GLAcc.Get(BoardEarnings."G/L Accounts");
                BudgetGL := GLAcc."Budget Control Account";
                if GLAcc."Budget Control Account" <> '' then
                    BudgetGL := GLAcc."Budget Control Account"
                else
                    Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);

                ActualsAmount := 0;
                BudgetAmount := 0;

                GLAcc.Reset;
                GLAcc.SetRange("No.", BudgetGL);
                GLAcc.SetRange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
                GLAcc.SetRange("Budget Filter", BCSetup."Current Budget Code");
                //GLAcc.SetRange("Dimension Set ID Filter", BoardEarnings."Dimension Set ID");
                if GLAcc.Find('-') then begin
                    GLAcc.CalcFields("Budgeted Amount", "Net Change");
                    ActualsAmount := GLAcc."Net Change";
                    BudgetAmount := GLAcc."Budgeted Amount";
                end;

                //get the committments
                CommitmentAmount := 0;
                Commitments.Reset;
                Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                //Commitments.SetRange(Commitments."Dimension Set ID", BoardEarnings."Dimension Set ID");
                Commitments.CalcSums(Commitments.Amount);
                CommitmentAmount := Commitments.Amount;

                //MyVar := FORMAT(PayLine."Line No.") +'|'+ FORMAT(ActualsAmount)  +'|'+ FORMAT(BudgetAmount)  +'|'+ FORMAT(CommitmentAmount);
                //IF ShowResults THEN EXIT(MyVar);

                //check if there is any budget
                if (BudgetAmount <= 0) and not (BCSetup."Allow OverExpenditure") then begin
                    Error('No Budget To Check Against');
                end else begin
                    if (BudgetAmount <= 0) then begin
                        if not Confirm(Text0003, true) then begin
                            Error('Budgetary Checking Process Aborted');
                        end;
                    end;
                end;

                //check if the actuals plus the amount is greater then the budget amount
                if ((CommitmentAmount + BoardEarnings.Amount + ActualsAmount) > BudgetAmount)
                and not (BCSetup."Allow OverExpenditure") then begin
                    Error('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                    BoardEarnings.Code, BoardEarnings."No.", BoardEarnings."G/L Accounts",
                      Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + BoardEarnings.Amount))));
                end else begin
                    //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                    if ((CommitmentAmount + BoardEarnings.Amount + ActualsAmount) > BudgetAmount) then begin
                        if not Confirm(Text0001 +
                        Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + BoardEarnings.Amount)))
                        + Text0002, true) then begin
                            Error('Budgetary Checking Process Aborted');
                        end;
                    end;

                    Commitments.Reset;
                    Commitments.Init;
                    EntryNo += 1;
                    Commitments."Line No." := EntryNo;
                    Commitments."Commitment Date" := Today;
                    Commitments."Posting Date" := PaymentHeader."Transaction Date";
                    Commitments."Document Type" := Commitments."document type"::"Payment Voucher";
                    Commitments."Document No." := PaymentHeader."Transaction No.";
                    Commitments.Amount := BoardEarnings.Amount;
                    Commitments."Month Budget" := BudgetAmount;
                    Commitments."Month Actual" := ActualsAmount;
                    Commitments.Committed := true;
                    Commitments."Committed By" := UserId;
                    Commitments."Committed Date" := PaymentHeader."Transaction Date";
                    Commitments."G/L Account No." := BudgetGL;
                    Commitments."Committed Time" := Time;
                    //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                    Commitments.Validate("Shortcut Dimension 1 Code", PaymentLines."Shortcut Dimension 1 Code");
                    Commitments.Validate("Shortcut Dimension 2 Code", PaymentLines."Shortcut Dimension 2 Code");
                    Commitments."Dimension Set ID" := PaymentLines."Dimension Set ID";
                    Commitments.Budget := BCSetup."Current Budget Code";
                    Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                    Commitments."Actual Source" := BCSetup."Actual Source";
                    //Commitments."Document Line No.":=PayLine."Line No.";
                    //Added for Totalling Accounts
                    Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                    Commitments.Insert;
                    BoardEarnings.Committed := true;
                    BoardEarnings.Modify;
                end;
            until BoardEarnings.Next = 0;
        end;
    end;


    procedure CheckPVDelegate(var PaymentHeader: Record "Payments Header Delegates"): Text
    var
        PayLine: Record "Payment Line Delegate";
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
    begin
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.Reset;
        BCSetup.Get();
        if BCSetup.Mandatory then//budgetary control is mandatory
          begin
            //check if the dates are within the specified range in relation to the payment header table
            if (PaymentHeader."Transaction Date" < BCSetup."Current Budget Start Date") then begin
                Error('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', PaymentHeader."Transaction Date",
                BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
            end
            else
                if (PaymentHeader."Transaction Date" > BCSetup."Current Budget End Date") then begin
                    Error('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', PaymentHeader."Transaction Date",
                    BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
                end;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");


            //Get Commitment Lines
            if Commitments.Find('+') then
                EntryNo := Commitments."Line No.";

            //get the lines related to the payment header
            PayLine.Reset;
            PayLine.SetRange(PayLine."Document No", PaymentHeader."Transaction No.");
            //PayLine.SETRANGE(PayLine."Account Type",PayLine."Account Type"::"G/L Account");
            //PayLine.SETRANGE(PayLine."Budgetary Control A/C",TRUE);
            if PayLine.FindFirst then begin
                repeat
                    //check the votebook now
                    FirstDay := Dmy2date(1, Date2dmy(PaymentHeader."Transaction Date", 2), Date2dmy(PaymentHeader."Transaction Date", 3));
                    CurrMonth := Date2dmy(PaymentHeader."Transaction Date", 2);
                    if CurrMonth = 12 then begin
                        LastDay := Dmy2date(1, 1, Date2dmy(PaymentHeader."Transaction Date", 3) + 1);
                        LastDay := CalcDate('-1D', LastDay);
                    end
                    else begin
                        CurrMonth := CurrMonth + 1;
                        LastDay := Dmy2date(1, CurrMonth, Date2dmy(PaymentHeader."Transaction Date", 3));
                        LastDay := CalcDate('-1D', LastDay);
                    end;

                    BudgetGL := PayLine."G/L Account No.";

                    //For End Total Budgeting -TMEA
                    if BCSetup."Use Totaling Account" then begin
                        GLAcc.Get(BudgetGL);
                        if GLAcc."Budget Control Account" <> '' then
                            BudgetGL := GLAcc."Budget Control Account"
                        else
                            Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
                    end;
                    //End (End Total Budget)

                    //check the summation of the budget and actuals in the database
                    ActualsAmount := 0;
                    BudgetAmount := 0;

                    GLAcc.Reset;
                    GLAcc.SetRange("No.", BudgetGL);
                    GLAcc.SetRange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
                    GLAcc.SetRange("Budget Filter", BCSetup."Current Budget Code");
                    GLAcc.SetRange("Dimension Set ID Filter", PayLine."Dimension Set ID");
                    if GLAcc.Find('-') then begin
                        GLAcc.CalcFields("Budgeted Amount", "Net Change");
                        ActualsAmount := GLAcc."Net Change";
                        BudgetAmount := GLAcc."Budgeted Amount";
                    end;

                    //get the committments
                    CommitmentAmount := 0;
                    Commitments.Reset;
                    Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
                    Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
                    Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
                    Commitments.SetRange(Commitments."Dimension Set ID", PayLine."Dimension Set ID");
                    Commitments.CalcSums(Commitments.Amount);
                    CommitmentAmount := Commitments.Amount;

                    //MyVar := FORMAT(PayLine."Line No.") +'|'+ FORMAT(ActualsAmount)  +'|'+ FORMAT(BudgetAmount)  +'|'+ FORMAT(CommitmentAmount);
                    //IF ShowResults THEN EXIT(MyVar);

                    //check if there is any budget
                    if (BudgetAmount <= 0) and not (BCSetup."Allow OverExpenditure") then begin
                        Error('No Budget To Check Against');
                    end else begin
                        if (BudgetAmount <= 0) then begin
                            if not Confirm(Text0003, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;
                    end;

                    //check if the actuals plus the amount is greater then the budget amount
                    if ((CommitmentAmount + PayLine."Net Amount" + ActualsAmount) > BudgetAmount)
                    and not (BCSetup."Allow OverExpenditure") then begin
                        Error('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                        PayLine."Document No", PayLine."Member No.", PayLine."G/L Account No.",
                          Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."Net Amount"))));
                    end else begin
                        //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                        if ((CommitmentAmount + PayLine."Net Amount" + ActualsAmount) > BudgetAmount) then begin
                            if not Confirm(Text0001 +
                            Format(Abs(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."Net Amount")))
                            + Text0002, true) then begin
                                Error('Budgetary Checking Process Aborted');
                            end;
                        end;

                        Commitments.Reset;
                        Commitments.Init;
                        EntryNo += 1;
                        Commitments."Line No." := EntryNo;
                        Commitments."Commitment Date" := Today;
                        Commitments."Posting Date" := PaymentHeader."Transaction Date";
                        Commitments."Document Type" := Commitments."document type"::"Payment Voucher";
                        Commitments."Document No." := PaymentHeader."Transaction No.";
                        Commitments.Amount := PayLine."Net Amount";
                        Commitments."Month Budget" := BudgetAmount;
                        Commitments."Month Actual" := ActualsAmount;
                        Commitments.Committed := true;
                        Commitments."Committed By" := UserId;
                        Commitments."Committed Date" := PaymentHeader."Transaction Date";
                        Commitments."G/L Account No." := BudgetGL;
                        Commitments."Committed Time" := Time;
                        //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                        Commitments.Validate("Shortcut Dimension 1 Code", PayLine."Shortcut Dimension 1 Code");
                        Commitments.Validate("Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
                        Commitments."Dimension Set ID" := PayLine."Dimension Set ID";
                        Commitments.Budget := BCSetup."Current Budget Code";
                        Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
                        Commitments."Actual Source" := BCSetup."Actual Source";
                        //Commitments."Document Line No.":=PayLine."Line No.";
                        //Added for Totalling Accounts
                        Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                        Commitments.Insert;
                        // MESSAGE('Done');
                        //Tag the Payment Line as Committed
                        PayLine.Committed := true;
                        PayLine.Modify;
                        //End Tagging Payment Lines as Committed
                    end;

                until PayLine.Next = 0;
            end;
            Message(BudgetCheckTxt)
        end
        else//budget control not mandatory
          begin
            Message('Budgetary Control Not Mandatory');
        end;
    end;


    procedure GetLineAmountToReverse(DocumentType: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance,StaffSurrender; DocNo: Code[20]; DocLineNo: Integer) TotalAmount: Decimal
    var
        LPO: Record "Purchase Line";
        QtyToInvoice: Decimal;
    begin
        if DocumentType = Documenttype::LPO then begin
            LPO.Reset;
            LPO.SetRange(LPO."Document Type", LPO."document type"::Order);
            LPO.SetRange(LPO."Document No.", DocNo);
            LPO.SetRange(LPO."Line No.", DocLineNo);
            if LPO.Find('-') then begin
                //Take care of reversal which might not
                if LPO."Qty. to Invoice" <> 0 then
                    QtyToInvoice := LPO."Qty. to Invoice"
                else
                    QtyToInvoice := LPO."Outstanding Quantity";

                if LPO."VAT %" = 0 then
                    TotalAmount := QtyToInvoice * LPO."Direct Unit Cost"
                else
                    TotalAmount := ROUND((QtyToInvoice * LPO."Direct Unit Cost") * ((LPO."VAT %" + 100) / 100), 0.00001)

            end;
        end;
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterPostPurchaseDoc', '', false, false)]

    // procedure ReverseOrdersFromInv(var Sender: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20])
    // var
    //     DocumentType: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance;
    //     PurchRecptLines: Record "Purch. Rcpt. Line";
    //     Commitment: Codeunit "Journal Post Successful";
    //     PurchInvLine: Record "Purch. Inv. Line";
    //     PurchInvHeader: Record "Purch. Inv. Header";
    //     PurchLines: Record "Purchase Line";
    //     PurchInvHeader1: Record "Purch. Inv. Header";
    // begin
    //     /*
    //     PurchInvLine.RESET;
    //     PurchInvLine.SETRANGE(PurchInvLine."Document No.",PurchInvHdrNo);
    //     IF PurchInvLine.FINDSET THEN
    //     REPEAT
    //         IF PurchInvLine.Type<>PurchInvLine.Type::" " THEN
    //         BEGIN
    //           DocumentType:=DocumentType::LPO;
    //           PurchInvHeader.GET(PurchInvHdrNo);
    //           ReverseOrderEntriesFromInvoice(DocumentType,PurchInvHeader."Order No.",PurchInvLine."Line No.",
    //           (PurchInvLine."Unit Cost (LCY)"*PurchInvLine.Quantity ));
    //         END;
    //     UNTIL PurchInvLine.NEXT=0;

    //     //Post Commitment Reversals Here
    //     IF  Sender."Document Type"=Sender."Document Type"::Order THEN BEGIN
    //       DocumentType:=DocumentType::LPO;
    //       ReverseEntries(DocumentType,Sender."No.");
    //     END
    //     ELSE IF  Sender."Document Type"=Sender."Document Type"::Invoice THEN BEGIN
    //       DocumentType:=DocumentType::PurchInvoice;
    //       ReverseEntries(DocumentType,Sender."No.");
    //     END;
    //     */
    //     if PurchInvHeader.Get(PurchInvHdrNo) then
    //         if PurchInvHeader."Order No." <> '' then begin
    //             //direct invoice from order reverse LPO
    //             PurchInvLine.Reset;
    //             PurchInvLine.SetRange(PurchInvLine."Document No.", PurchInvHdrNo);
    //             if PurchInvLine.FindSet then
    //                 repeat
    //                     DocumentType := Documenttype::LPO;
    //                     ReverseEntriesLines(DocumentType, PurchInvHeader."Order No.", PurchInvLine."Line No.", PurchInvLine."Unit Cost (LCY)" * PurchInvLine.Quantity);
    //                 until PurchInvLine.Next = 0;
    //         end
    //         else begin
    //             PurchInvLine.Reset;
    //             PurchInvLine.SetRange(PurchInvLine."Document No.", PurchInvHdrNo);
    //             PurchInvLine.SetFilter(PurchInvLine."Receipt No.", '<>%1', '');
    //             if PurchInvLine.FindSet then begin
    //                 repeat
    //                     //invoice created from Get receipt Lines, reverse LPO
    //                     PurchRecptLines.Reset;
    //                     PurchRecptLines.SetRange(PurchRecptLines."Document No.", PurchInvLine."Receipt No.");
    //                     PurchRecptLines.SetRange(PurchRecptLines."Line No.", PurchInvLine."Receipt Line No.");
    //                     if PurchRecptLines.FindSet then begin
    //                         DocumentType := Documenttype::LPO;
    //                         ReverseEntriesLines(DocumentType, PurchRecptLines."Order No.", PurchRecptLines."Order Line No.", PurchInvLine."Unit Cost (LCY)" * PurchInvLine.Quantity);
    //                     end
    //                 until PurchInvLine.Next = 0;
    //             end
    //             else begin
    //                 //direct invoice created, reverse Invoice
    //                 DocumentType := Documenttype::PurchInvoice;
    //                 PurchInvHeader1.Get(PurchInvHdrNo);
    //                 ReverseEntries(DocumentType, PurchInvHeader1."Pre-Assigned No.");
    //             end
    //         end;
    //     //End Post Commitment Reversals

    // end;


    procedure ReverseEntriesLines(DocumentType: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance; DocNo: Code[20]; LineNo: Integer; Amount: Decimal)
    var
        Commitments: Record Committment;
        EntryNo: Integer;
        CommittedLines: Record Committment;
    begin
        //Get Commitment Lines
        Commitments.Reset;
        if Commitments.FindLast then
            EntryNo := Commitments."Line No.";

        CommittedLines.Reset;
        CommittedLines.SetRange(CommittedLines."Document Type", DocumentType);
        CommittedLines.SetRange(CommittedLines."Document No.", DocNo);
        CommittedLines.SetRange(CommittedLines."Document Line No.", LineNo);
        CommittedLines.SetRange(CommittedLines.Committed, true);
        if CommittedLines.Find('-') then begin
            Commitments.Reset;
            Commitments.Init;
            EntryNo += 1;
            Commitments."Line No." := EntryNo;
            Commitments."Commitment Date" := Today;
            Commitments."Posting Date" := CommittedLines."Posting Date";
            Commitments."Document Type" := CommittedLines."Document Type";
            Commitments."Document No." := CommittedLines."Document No.";
            Commitments.Amount := -Amount;
            Commitments."Month Budget" := CommittedLines."Month Budget";
            Commitments."Month Actual" := CommittedLines."Month Actual";
            Commitments.Committed := false;
            Commitments."Committed By" := UserId;
            Commitments."Committed Date" := CommittedLines."Committed Date";
            Commitments."G/L Account No." := CommittedLines."G/L Account No.";
            Commitments."Committed Time" := Time;
            //Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
            Commitments."Shortcut Dimension 1 Code" := CommittedLines."Shortcut Dimension 1 Code";
            Commitments."Shortcut Dimension 2 Code" := CommittedLines."Shortcut Dimension 2 Code";
            Commitments."Shortcut Dimension 3 Code" := CommittedLines."Shortcut Dimension 3 Code";
            Commitments."Shortcut Dimension 4 Code" := CommittedLines."Shortcut Dimension 4 Code";
            Commitments."Dimension Set ID" := CommittedLines."Dimension Set ID";
            Commitments.Budget := CommittedLines.Budget;
            Commitments."Document Line No." := CommittedLines."Document Line No.";
            Commitments."Budget Check Criteria" := CommittedLines."Budget Check Criteria";
            Commitments."Actual Source" := CommittedLines."Actual Source";
            //Added for Totalling Accounts
            Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
            Commitments.Insert;
        end;
    end;


    // procedure ReverseOrdersReversal("No.": Code[20])
    // var
    //     PurchLines: Record "Purchase Line";
    //     DocumentType: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance;
    //     PurchRecptLines: Record "Purch. Rcpt. Line";
    //     DeleteCommitment: Record Committment;
    // begin
    //     PurchLines.Reset;
    //     PurchLines.SetRange(PurchLines."Document Type", PurchLines."document type"::Invoice);
    //     PurchLines.SetRange(PurchLines."Document No.", "No.");
    //     if PurchLines.Find('-') then begin
    //         repeat
    //             if PurchLines.Type <> PurchLines.Type::" " then begin
    //                 //Get Details of Order from Receipt lines
    //                 PurchRecptLines.Reset;
    //                 PurchRecptLines.SetRange(PurchRecptLines."Document No.", PurchLines."Receipt No.");
    //                 PurchRecptLines.SetRange(PurchRecptLines."Line No.", PurchLines."Receipt Line No.");
    //                 if PurchRecptLines.Find('-') then begin
    //                     DeleteCommitment.Reset;
    //                     DeleteCommitment.SetRange(DeleteCommitment."Document Type", DeleteCommitment."document type"::LPO);
    //                     DeleteCommitment.SetRange(DeleteCommitment."Document No.", PurchRecptLines."Order No.");
    //                     DeleteCommitment.SetRange(DeleteCommitment."Document Line No.", PurchRecptLines."Order Line No.");
    //                     DeleteCommitment.SetRange(DeleteCommitment.Committed, false);
    //                     DeleteCommitment.DeleteAll;

    //                 end;
    //             end;
    //         until PurchLines.Next = 0;
    //     end;
    // end;


    // procedure OrderCommittment(var PurchHeader: Record "Purchase Header")
    // var
    //     PurchLine: Record "Purchase Line";
    //     Commitments: Record Committment;
    //     Amount: Decimal;
    //     GLAcc: Record "G/L Account";
    //     Item: Record Item;
    //     FirstDay: Date;
    //     LastDay: Date;
    //     CurrMonth: Integer;
    //     Budget: Record "Analysis View Budget Entry";
    //     BudgetAmount: Decimal;
    //     Actuals: Record "Analysis View Entry";
    //     ActualsAmount: Decimal;
    //     CommitmentAmount: Decimal;
    //     FixedAssetsDet: Record "Fixed Asset";
    //     FAPostingGRP: Record "FA Posting Group";
    //     EntryNo: Integer;
    //     GLAccount: Record "G/L Account";
    // begin
    //     //get the budget control setup first to determine if it mandatory or not
    //     BCSetup.Reset;
    //     BCSetup.Get();

    //     begin
    //         //check if the dates are within the specified range in relation to the payment header table
    //         if (PurchHeader."Document Date" < BCSetup."Current Budget Start Date") then begin
    //             Error('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3', PurchHeader."Document Date",
    //             BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
    //         end
    //         else
    //             if (PurchHeader."Document Date" > BCSetup."Current Budget End Date") then begin
    //                 Error('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3', PurchHeader."Document Date",
    //                 BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");

    //             end;
    //         //Is budget Available
    //         CheckIfBlocked(BCSetup."Current Budget Code");
    //         //Get Commitment Lines
    //         if Commitments.Find('+') then
    //             EntryNo := Commitments."Line No.";

    //         //get the lines related to the payment header
    //         PurchLine.Reset;
    //         PurchLine.SetRange(PurchLine."Document Type", PurchHeader."Document Type");
    //         PurchLine.SetRange(PurchLine."Document No.", PurchHeader."No.");
    //         if PurchLine.FindFirst then begin
    //             repeat
    //                 if PurchLine.Type <> PurchLine.Type::" " then begin

    //                     //check the type of account in the payments line
    //                     //Item
    //                     if PurchLine.Type = PurchLine.Type::Item then begin
    //                         Item.Reset;
    //                         if not Item.Get(PurchLine."No.") then
    //                             Error('Item Does not Exist');

    //                         Item.TestField("Item G/L Budget Account");
    //                         BudgetGL := Item."Item G/L Budget Account";
    //                     end;

    //                     if PurchLine.Type = PurchLine.Type::"Fixed Asset" then begin
    //                         FixedAssetsDet.Reset;
    //                         FixedAssetsDet.SetRange(FixedAssetsDet."No.", PurchLine."No.");
    //                         if FixedAssetsDet.Find('-') then begin
    //                             FAPostingGRP.Reset;
    //                             FAPostingGRP.SetRange(FAPostingGRP.Code, FixedAssetsDet."FA Posting Group");
    //                             if FAPostingGRP.Find('-') then
    //                                 if PurchLine."FA Posting Type" = PurchLine."fa posting type"::Maintenance then begin
    //                                     BudgetGL := FAPostingGRP."Maintenance Expense Account";
    //                                     if BudgetGL = '' then
    //                                         Error('Ensure Fixed Asset No %1 has the Maintenance G/L Account', PurchLine."No.");
    //                                 end else begin
    //                                     if PurchLine."FA Posting Type" = PurchLine."fa posting type"::"Acquisition Cost" then begin
    //                                         BudgetGL := FAPostingGRP."Acquisition Cost Account";
    //                                         if BudgetGL = '' then
    //                                             Error('Ensure Fixed Asset No %1 has the Acquisition G/L Account', PurchLine."No.");
    //                                     end;
    //                                     //To Accomodate any Additional Item under Custom 1 and Custom 2
    //                                     // if PurchLine."FA Posting Type" = PurchLine."fa posting type"::"3" then begin
    //                                     //     BudgetGL := FAPostingGRP."Custom 2 Account";
    //                                     //     if BudgetGL = '' then
    //                                     //         Error('Ensure Fixed Asset No %1 has the %2 G/L Account', PurchLine."No.",
    //                                     //         FAPostingGRP."Custom 1 Account");
    //                                     // end;

    //                                     // if PurchLine."FA Posting Type" = PurchLine."fa posting type"::"4" then begin
    //                                     //     BudgetGL := FAPostingGRP."Custom 2 Account";
    //                                     //     if BudgetGL = '' then
    //                                     //         Error('Ensure Fixed Asset No %1 has the %2 G/L Account', PurchLine."No.",
    //                                     //         FAPostingGRP."Custom 1 Account");
    //                                     // end;
    //                                     //To Accomodate any Additional Item under Custom 1 and Custom 2

    //                                 end;
    //                         end;
    //                     end;

    //                     if PurchLine.Type = PurchLine.Type::"G/L Account" then begin
    //                         BudgetGL := PurchLine."No.";
    //                         if GLAcc.Get(PurchLine."No.") then
    //                             GLAcc.TestField("Budget Controlled", true);
    //                     end;

    //                     //For End Total Budgeting -TMEA
    //                     if BCSetup."Use Totaling Account" then begin
    //                         GLAcc.Get(BudgetGL);
    //                         if GLAcc."Budget Control Account" <> '' then
    //                             BudgetGL := GLAcc."Budget Control Account"
    //                         else
    //                             Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
    //                     end;
    //                     //End (End Total Budget)

    //                     //End Checking Account in Payment Line

    //                     //END ADDING CONFIRMATION
    //                     Commitments.Reset;
    //                     Commitments.Init;
    //                     EntryNo += 1;
    //                     Commitments."Line No." := EntryNo;
    //                     Commitments."Commitment Date" := Today;
    //                     Commitments."Posting Date" := PurchHeader."Document Date";
    //                     if PurchHeader.DocApprovalType = PurchHeader.Docapprovaltype::Purchase then
    //                         Commitments."Document Type" := Commitments."document type"::LPO
    //                     else
    //                         Commitments."Document Type" := Commitments."document type"::Requisition;

    //                     if PurchHeader."Document Type" = PurchHeader."document type"::Invoice then
    //                         Commitments."Document Type" := Commitments."document type"::PurchInvoice;

    //                     Commitments."Document No." := PurchHeader."No.";
    //                     Commitments.Amount := PurchLine."Outstanding Amount (LCY)";
    //                     Commitments."Month Budget" := BudgetAmount;
    //                     Commitments."Month Actual" := ActualsAmount;
    //                     Commitments.Committed := true;
    //                     Commitments."Committed By" := UserId;
    //                     Commitments."Committed Date" := PurchHeader."Document Date";
    //                     Commitments."G/L Account No." := BudgetGL;
    //                     Commitments."Committed Time" := Time;
    //                     //Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
    //                     Commitments."Shortcut Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
    //                     Commitments."Shortcut Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
    //                     Commitments."Shortcut Dimension 3 Code" := ShortcutDimCode[3];
    //                     Commitments."Shortcut Dimension 4 Code" := ShortcutDimCode[4];
    //                     Commitments."Dimension Set ID" := PurchLine."Dimension Set ID";
    //                     Commitments.Budget := BCSetup."Current Budget Code";
    //                     Commitments.Type := Commitments.Type::Vendor;
    //                     Commitments."Vendor/Cust No." := PurchHeader."Buy-from Vendor No.";
    //                     Commitments."Budget Check Criteria" := BCSetup."Budget Check Criteria";
    //                     Commitments."Actual Source" := BCSetup."Actual Source";
    //                     Commitments."Document Line No." := PurchLine."Line No.";
    //                     //Added for Totalling Accounts
    //                     Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
    //                     Commitments.Insert;
    //                     //Tag the Purchase Line as Committed
    //                     PurchLine.Committed := true;
    //                     PurchLine.Modify;
    //                     //End Tagging PurchLines as Committed
    //                 end;

    //             until PurchLine.Next = 0;
    //         end;
    //     end
    // end;


    procedure OrderCommittmentReversal(DocumentType: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance; DocNo: Code[20])
    var
        Commitments: Record Committment;
        EntryNo: Integer;
        CommittedLines: Record Committment;
        Purchline: Record "Purchase Line";
        PRFLine: Record "Purchase Line";
        PRFHeader: Record "Purchase Header";
    begin
        //Get Commitment Lines
        Commitments.Reset;
        if Commitments.Find('+') then
            EntryNo := Commitments."Line No.";

        Purchline.Reset;
        Purchline.SetRange(Purchline."Document Type", Purchline."document type"::Order);
        Purchline.SetRange(Purchline."Document No.", DocNo);
        if Purchline.FindSet then
            repeat
                CommittedLines.Reset;
                CommittedLines.SetRange(CommittedLines."Document Type", CommittedLines."document type"::Requisition);
                CommittedLines.SetRange(CommittedLines."Document No.", Purchline."Requisition No");
                CommittedLines.SetRange(CommittedLines."Document Line No.", Purchline."Requisition Line No.");
                CommittedLines.SetRange(CommittedLines.Committed, true);
                if CommittedLines.FindSet then begin
                    Commitments.Reset;
                    Commitments.Init;
                    EntryNo += 1;
                    Commitments."Line No." := EntryNo;
                    Commitments."Commitment Date" := Today;
                    Commitments."Posting Date" := CommittedLines."Posting Date";
                    Commitments."Document Type" := CommittedLines."Document Type";
                    Commitments."Document No." := CommittedLines."Document No.";
                    Commitments.Amount := -Purchline."Outstanding Amount (LCY)";
                    Commitments."Month Budget" := CommittedLines."Month Budget";
                    Commitments."Month Actual" := CommittedLines."Month Actual";
                    Commitments.Committed := false;
                    Commitments."Committed By" := UserId;
                    Commitments."Committed Date" := CommittedLines."Committed Date";
                    Commitments."G/L Account No." := CommittedLines."G/L Account No.";
                    Commitments."Committed Time" := Time;
                    //Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                    Commitments."Shortcut Dimension 1 Code" := CommittedLines."Shortcut Dimension 1 Code";
                    Commitments."Shortcut Dimension 2 Code" := CommittedLines."Shortcut Dimension 2 Code";
                    Commitments."Shortcut Dimension 3 Code" := CommittedLines."Shortcut Dimension 3 Code";
                    Commitments."Shortcut Dimension 4 Code" := CommittedLines."Shortcut Dimension 4 Code";
                    Commitments."Dimension Set ID" := CommittedLines."Dimension Set ID";
                    Commitments.Budget := CommittedLines.Budget;
                    Commitments."Document Line No." := CommittedLines."Document Line No.";
                    Commitments."Budget Check Criteria" := CommittedLines."Budget Check Criteria";
                    Commitments."Actual Source" := CommittedLines."Actual Source";
                    //Added for Totalling Accounts
                    Commitments."Based on Totaling Account" := BCSetup."Use Totaling Account";
                    Commitments."Order No." := Purchline."Document No.";
                    Commitments.Insert;
                end;
                PRFLine.Reset;
                PRFLine.SetRange(PRFLine."Document Type", PRFLine."document type"::Quote);
                PRFLine.SetRange(PRFLine."Document No.", Purchline."Requisition No");
                PRFLine.SetRange(PRFLine."Line No.", Purchline."Requisition Line No.");
                if PRFLine.FindSet then begin
                    PRFLine."Qty Ordered" += Purchline.Quantity;
                    PRFLine."Qty UnOrdered" -= Purchline.Quantity;
                    PRFLine.Modify;
                end;
                PRFHeader.Reset;
                PRFHeader.SetRange(PRFHeader."Document Type", PRFHeader."document type"::Quote);
                PRFHeader.SetRange(PRFHeader."No.", Purchline."Requisition No");
                if PRFHeader.FindFirst then begin
                    PRFLine.Reset;
                    PRFLine.SetRange(PRFLine."Document Type", PRFLine."document type"::Quote);
                    PRFLine.SetRange(PRFLine."Document No.", PRFHeader."No.");
                    PRFLine.CalcSums(PRFLine.Quantity, PRFLine."Qty Ordered");
                    if PRFLine.Quantity = PRFLine."Qty Ordered" then begin
                        PRFHeader.Copied := true;
                        PRFHeader.Modify;
                    end;
                end;
            until Purchline.Next = 0;
    end;

    local procedure "***"()
    begin
    end;


    procedure CompareTotalReq(FromPurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        OrderReqBuffer: Record "Order/Req Buffer";
        PurchHeader: Record "Purchase Header";
        CompTotalReqErr: label 'Requisition %1 has an outstanding quantity of %2';
    begin
        OrderReqBuffer.Reset;
        OrderReqBuffer.SetRange(OrderReqBuffer.UserID, UserId);
        if OrderReqBuffer.Find('-') then
            OrderReqBuffer.DeleteAll;

        PurchLine.Reset;
        PurchLine.SetRange(PurchLine."Document Type", FromPurchHeader."Document Type");
        PurchLine.SetRange(PurchLine."Document No.", FromPurchHeader."No.");
        if PurchLine.Find('-') then begin
            repeat
                if PurchLine.Type <> PurchLine.Type::" " then begin
                    if not OrderReqBuffer.Get(PurchLine."Requisition No") then begin
                        OrderReqBuffer.Init;
                        OrderReqBuffer.RequisitionNo := PurchLine."Requisition No";
                        OrderReqBuffer."Requisition Line No." := PurchLine."Requisition Line No.";
                        OrderReqBuffer.OrderNo := FromPurchHeader."No.";
                        OrderReqBuffer.UserID := UserId;
                        OrderReqBuffer.Insert;
                    end;
                end;

                //Do Comparisons Here
                OrderReqBuffer.Reset;
                OrderReqBuffer.SetRange(OrderReqBuffer.OrderNo, FromPurchHeader."No.");
                OrderReqBuffer.SetRange(OrderReqBuffer."Requisition Line No.", PurchLine."Requisition Line No.");
                if OrderReqBuffer.Find('-') then begin
                    repeat
                        OrderReqBuffer.CalcFields(OrderReqBuffer.TotalsOnOrder);
                        OrderReqBuffer.CalcFields(OrderReqBuffer.TotalsOnArchiveOrder);
                        OrderReqBuffer.CalcFields(OrderReqBuffer.TotalonReq);
                        if OrderReqBuffer.TotalsOnOrder > OrderReqBuffer.TotalonReq then
                            Error(CompTotalReqErr, OrderReqBuffer.RequisitionNo,
                                  OrderReqBuffer.TotalonReq - (OrderReqBuffer.TotalsOnOrder - PurchLine.Quantity) - OrderReqBuffer.TotalsOnArchiveOrder);
                    /*//use the qty ordered and unordered fields instead undercommittmentreversal
                          //Update the requisition as copied here
                           PurchHeader.RESET;
                           PurchHeader.SETRANGE(PurchHeader."No.",OrderReqBuffer.RequisitionNo);
                           IF PurchHeader.FIND('-') THEN BEGIN
                              PurchHeader.Copied:=TRUE;
                              PurchHeader.MODIFY;
                           END;
                    */
                    until OrderReqBuffer.Next = 0;
                end;
            until PurchLine.Next = 0;
        end;
        //
        /*
         OrderReqBuffer.RESET;
         OrderReqBuffer.SETRANGE(OrderReqBuffer.UserID,USERID);
         IF OrderReqBuffer.FIND('-') THEN
            OrderReqBuffer.DELETEALL;

         PurchLine.RESET;
         PurchLine.SETRANGE(PurchLine."Document Type","Document Type");
         PurchLine.SETRANGE(PurchLine."Document No.","No.");
         IF PurchLine.FIND('-') THEN BEGIN
            REPEAT
             IF PurchLine.Type<>PurchLine.Type::" " THEN BEGIN
                IF NOT OrderReqBuffer.GET(PurchLine."Manual Requisition No") THEN BEGIN
                  OrderReqBuffer.INIT;
                  OrderReqBuffer.RequisitionNo:=PurchLine."Manual Requisition No";
                  OrderReqBuffer.OrderNo:="No.";
                  OrderReqBuffer.UserID:=USERID;
                  OrderReqBuffer.INSERT;
                END;
             END;
           UNTIL PurchLine.NEXT=0;
           //Do Comparisons Here
             OrderReqBuffer.RESET;
             OrderReqBuffer.SETRANGE(OrderReqBuffer.OrderNo,"No.");
             IF OrderReqBuffer.FIND('-') THEN BEGIN
              REPEAT
                 OrderReqBuffer.CALCFIELDS(OrderReqBuffer.TotalsonOrder);
                 OrderReqBuffer.CALCFIELDS(OrderReqBuffer.TotalonReq);
                 IF OrderReqBuffer.TotalsonOrder>OrderReqBuffer.TotalonReq THEN
                    ERROR(Txt001,OrderReqBuffer.OrderNo,OrderReqBuffer.TotalsonOrder,OrderReqBuffer.RequisitionNo,
                    OrderReqBuffer.TotalonReq);
            //Update the requisition as copied here
             PurchHeader.RESET;
             PurchHeader.SETRANGE(PurchHeader."No.",OrderReqBuffer.RequisitionNo);
             IF PurchHeader.FIND('-') THEN BEGIN
                PurchHeader.Copied:=TRUE;
                PurchHeader.MODIFY;
             END;

              UNTIL OrderReqBuffer.NEXT=0;
             END;
         END;
      */

    end;


    procedure DeleteEntries(DocumentType: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance; DocNo: Code[20])
    var
        Commitments: Record Committment;
        EntryNo: Integer;
        CommittedLines: Record Committment;
        PurchLines: Record "Purchase Line";
        PrfHeader: Record "Purchase Header";
        PRFLine: Record "Purchase Line";
    begin
        //Get Commitment Lines
        CommittedLines.Reset;
        CommittedLines.SetRange(CommittedLines."Document Type", DocumentType);
        CommittedLines.SetRange(CommittedLines."Document No.", DocNo);
        CommittedLines.SetRange(CommittedLines.Committed, true);
        if CommittedLines.FindSet then
            CommittedLines.DeleteAll;

        if DocumentType = Documenttype::LPO then //delete the requisition reversals created
          begin
            PurchLines.Reset;
            PurchLines.SetRange(PurchLines."Document Type", PurchLines."document type"::Order);
            PurchLines.SetRange(PurchLines."Document No.", DocNo);
            if PurchLines.FindSet then
                repeat
                    CommittedLines.Reset;
                    CommittedLines.SetRange(CommittedLines."Document Type", CommittedLines."document type"::Requisition);
                    CommittedLines.SetRange(CommittedLines."Document No.", PurchLines."Requisition No");
                    CommittedLines.SetRange(CommittedLines."Order No.", PurchLines."Document No.");
                    CommittedLines.SetRange(CommittedLines.Committed, false);
                    if CommittedLines.FindSet then
                        CommittedLines.DeleteAll;

                    PRFLine.Reset;
                    PRFLine.SetRange(PRFLine."Document Type", PRFLine."document type"::Quote);
                    PRFLine.SetRange(PRFLine."Document No.", PurchLines."Requisition No");
                    PRFLine.SetRange(PRFLine."Line No.", PurchLines."Requisition Line No.");
                    if PRFLine.FindSet then begin
                        PRFLine."Qty Ordered" -= PurchLines.Quantity;
                        PRFLine."Qty UnOrdered" += PurchLines.Quantity;
                        PRFLine.Modify;
                    end;

                    PrfHeader.Reset;
                    PrfHeader.SetRange(PrfHeader."Document Type", PrfHeader."document type"::Quote);
                    PrfHeader.SetRange(PrfHeader."No.", PurchLines."Requisition No");
                    if PrfHeader.FindFirst then begin
                        PrfHeader.Copied := false;
                        PrfHeader.Modify;
                    end;
                until PurchLines.Next = 0;
        end;
    end;

    local procedure ReverseandUncommitt(var Variant: Variant)
    var
        RecRef: RecordRef;
        PurchaseHeader: Record "Purchase Header";
        PurchaseLines: Record "Purchase Line";
        PaymentHeader: Record "Payments Header";
        PaymentLines: Record "Payment Line";
        ImprestHeader: Record "Imprest Header";
        ImprestLines: Record "Imprest Lines";
        AdvanceHeader: Record "Staff Advance Header";
        AdvanceLines: Record "Staff Advance Lines";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        ImprestSurrenderLines: Record "Imprest Surrender Details";
        AdvanceSurrenderHeader: Record "Staff Advance Surrender Header";
        AdvanceSurrenderLines: Record "Staff Advanc Surrender Details";
        StaffClaimHeader: Record "Staff Claims Header";
        StaffClaimLines: Record "Staff Claim Lines";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Purchase Header":
                begin
                    PurchaseHeader := Variant;
                    PurchaseLines.Reset;
                    PurchaseLines.SetRange(PurchaseLines."Document Type", PurchaseHeader."Document Type");
                    PurchaseLines.SetRange(PurchaseLines."Document No.", PurchaseHeader."No.");
                    PurchaseLines.SetRange(PurchaseLines.Committed, true);
                    if PurchaseLines.FindSet then
                        repeat
                            PurchaseLines.Committed := false;
                            PurchaseLines.Modify;
                        until PurchaseLines.Next = 0;
                end;
            Database::"Payments Header":
                begin
                    PaymentHeader := Variant;
                    PaymentLines.Reset;
                    PaymentLines.SetRange(PaymentLines.No, PaymentHeader."No.");
                    PaymentLines.SetRange(PaymentLines.Committed, true);
                    if PaymentLines.FindSet then
                        repeat
                            PaymentLines.Committed := false;
                            PaymentLines.Modify;
                        until PaymentLines.Next = 0;
                end;
            Database::"Imprest Header":
                begin
                    ImprestHeader := Variant;
                    ImprestLines.Reset;
                    ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
                    ImprestLines.SetRange(ImprestLines.Committed, true);
                    if ImprestLines.FindSet then
                        repeat
                            ImprestLines.Committed := false;
                            ImprestLines.Modify;
                        until ImprestLines.Next = 0;
                end;
            Database::"Staff Advance Header":
                begin
                    AdvanceHeader := Variant;
                    AdvanceLines.Reset;
                    AdvanceLines.SetRange(AdvanceLines.No, AdvanceHeader."No.");
                    AdvanceLines.SetRange(AdvanceLines.Committed, true);
                    if AdvanceLines.FindSet then
                        repeat
                            AdvanceLines.Committed := false;
                            AdvanceLines.Modify;
                        until AdvanceLines.Next = 0;
                end;
            Database::"Staff Claims Header":
                begin
                    StaffClaimHeader := Variant;
                    StaffClaimLines.Reset;
                    StaffClaimLines.SetRange(StaffClaimLines.No, StaffClaimHeader."No.");
                    StaffClaimLines.SetRange(StaffClaimLines.Committed, true);
                    if StaffClaimLines.FindSet then
                        repeat
                            StaffClaimLines.Committed := false;
                            StaffClaimLines.Modify;
                        until StaffClaimLines.Next = 0;
                end;
            Database::"Staff Advance Surrender Header":
                begin
                    AdvanceSurrenderHeader := Variant;
                    AdvanceSurrenderLines.Reset;
                    AdvanceSurrenderLines.SetRange(AdvanceSurrenderLines."Surrender Doc No.", AdvanceSurrenderHeader.No);
                    AdvanceSurrenderLines.SetRange(AdvanceSurrenderLines.Committed, true);
                    if AdvanceSurrenderLines.FindSet then
                        repeat
                            AdvanceSurrenderLines.Committed := false;
                            AdvanceSurrenderLines.Modify;
                        until AdvanceSurrenderLines.Next = 0;
                end;
        end
    end;


    procedure CheckDocumentIsComplete(var Variant: Variant)
    var
        RecRef: RecordRef;
        PurchaseHeader: Record "Purchase Header";
        PurchaseLines: Record "Purchase Line";
        PaymentHeader: Record "Payments Header";
        PaymentLines: Record "Payment Line";
        ImprestHeader: Record "Imprest Header";
        ImprestLines: Record "Imprest Lines";
        AdvanceHeader: Record "Staff Advance Header";
        AdvanceLines: Record "Staff Advance Lines";
        ImprestSurrenderHeader: Record "Imprest Surrender Header";
        ImprestSurrenderLines: Record "Imprest Surrender Details";
        AdvanceSurrenderHeader: Record "Staff Advance Surrender Header";
        AdvanceSurrenderLines: Record "Staff Advanc Surrender Details";
        StaffClaimHeader: Record "Staff Claims Header";
        StaffClaimLines: Record "Staff Claim Lines";
        CheckBudgetErr: label 'Document %1 contains lines that are not committed, ensure check budget is included in the document workflow';
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            /*
            DATABASE::"Purchase Header":
              BEGIN
                PurchaseHeader := Variant;
                PurchaseLines.RESET;
                PurchaseLines.SETRANGE(PurchaseLines."Document No.",PurchaseHeader."No.");
                PurchaseLines.SETFILTER(PurchaseLines.Type,'<>%1',PurchaseLines.Type::" ");
                PurchaseLines.SETRANGE(PurchaseLines.Committed,FALSE);
                IF PurchaseLines.FINDSET THEN
                  ERROR(CheckBudgetErr,PurchaseHeader."No.");
              END;
            */
            Database::"Payments Header":
                begin
                    PaymentHeader := Variant;
                    PaymentLines.Reset;
                    PaymentLines.SetRange(PaymentLines.No, PaymentHeader."No.");
                    PaymentLines.SetRange(PaymentLines.Committed, false);
                    if PaymentLines.FindSet then
                        Error(CheckBudgetErr, PaymentHeader."No.");
                end;
            Database::"Imprest Header":
                begin
                    ImprestHeader := Variant;
                    ImprestLines.Reset;
                    ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
                    ImprestLines.SetRange(ImprestLines.Committed, false);
                    if ImprestLines.FindSet then
                        Error(CheckBudgetErr, ImprestHeader."No.");
                end;
            Database::"Staff Advance Header":
                begin
                    AdvanceHeader := Variant;
                    AdvanceLines.Reset;
                    AdvanceLines.SetRange(AdvanceLines.No, AdvanceHeader."No.");
                    AdvanceLines.SetRange(AdvanceLines.Committed, false);
                    if AdvanceLines.FindSet then
                        Error(CheckBudgetErr, AdvanceHeader."No.");
                end;
            Database::"Staff Claims Header":
                begin
                    StaffClaimHeader := Variant;
                    StaffClaimLines.Reset;
                    StaffClaimLines.SetRange(StaffClaimLines.No, StaffClaimHeader."No.");
                    StaffClaimLines.SetRange(StaffClaimLines.Committed, false);
                    if StaffClaimLines.FindSet then
                        Error(CheckBudgetErr, StaffClaimHeader."No.");
                end;
            Database::"Staff Advance Surrender Header":
                begin
                    AdvanceSurrenderHeader := Variant;
                    AdvanceSurrenderLines.Reset;
                    AdvanceSurrenderLines.SetRange(AdvanceSurrenderLines."Surrender Doc No.", AdvanceSurrenderHeader.No);
                    AdvanceSurrenderLines.SetRange(AdvanceSurrenderLines.Committed, false);
                    if AdvanceSurrenderLines.FindSet then
                        Error(CheckBudgetErr, AdvanceSurrenderHeader.No);
                end;
        end

    end;

    local procedure "****"()
    begin
    end;


    procedure PaneMgt(Variant: Variant; ShowResults: Integer): Decimal
    var
        RecRef: RecordRef;
        PayLine: Record "Payment Line";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        Item: Record Item;
        BudgetGLAccount: Code[20];
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        GLAcc: Record "G/L Account";
        StaffClaimLines: Record "Staff Claim Lines";
        StaffAdvanceLines: Record "Staff Advance Lines";
        StaffAdvancSurrenderDetails: Record "Staff Advanc Surrender Details";
        ImprestLines: Record "Imprest Lines";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Payment Line":
                begin
                    PayLine := Variant;
                    exit(PaneMgtCalculations(ShowResults, PayLine.Date, PayLine."Dimension Set ID", PayLine."Account No."));
                end;
            Database::"Staff Claim Lines":
                begin
                    StaffClaimLines := Variant;
                    exit(PaneMgtCalculations(ShowResults, StaffClaimLines."Date Taken", StaffClaimLines."Dimension Set ID", StaffClaimLines."Account No:"));
                end;
            Database::"Staff Advance Lines":
                begin
                    StaffAdvanceLines := Variant;
                    exit(PaneMgtCalculations(ShowResults, StaffAdvanceLines."Date Taken", StaffAdvanceLines."Dimension Set ID", StaffAdvanceLines."Account No:"));
                end;
            Database::"Staff Advanc Surrender Details":
                begin
                    StaffAdvancSurrenderDetails := Variant;
                    exit(PaneMgtCalculations(ShowResults, StaffAdvancSurrenderDetails."Date Issued", StaffAdvancSurrenderDetails."Dimension Set ID", StaffAdvancSurrenderDetails."Account No:"));
                end;
            Database::"Imprest Lines":
                begin
                    ImprestLines := Variant;
                    exit(PaneMgtCalculations(ShowResults, ImprestLines."Date Taken", ImprestLines."Dimension Set ID", ImprestLines."Account No:"));
                end;
            Database::"Purchase Line":
                begin
                    PurchaseLine := Variant;
                    PurchaseHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.");
                    if PurchaseLine.Type = PurchaseLine.Type::Item then begin
                        Item.Reset;
                        if not Item.Get(PurchaseLine."No.") then
                            Error('Item Does not Exist');
                        Item.TestField("Item G/L Budget Account");
                        BudgetGLAccount := Item."Item G/L Budget Account";
                    end;

                    if PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" then begin
                        FixedAssetsDet.Reset;
                        FixedAssetsDet.SetRange(FixedAssetsDet."No.", PurchaseLine."No.");
                        if FixedAssetsDet.Find('-') then begin
                            //FixedAssetsDet.CALCFIELDS(FixedAssetsDet."FA Posting Group");
                            FAPostingGRP.Reset;
                            FAPostingGRP.SetRange(FAPostingGRP.Code, FixedAssetsDet."FA Posting Group");
                            if FAPostingGRP.Find('-') then begin
                                if PurchaseLine."FA Posting Type" = PurchaseLine."fa posting type"::Maintenance then begin
                                    BudgetGLAccount := FAPostingGRP."Maintenance Expense Account";
                                    if BudgetGLAccount = '' then
                                        Error('Ensure Fixed Asset No %1 has the Maintenance G/L Account', PurchaseLine."No.");
                                end else begin
                                    BudgetGLAccount := FAPostingGRP."Acquisition Cost Account";
                                    if BudgetGLAccount = '' then
                                        Error('Ensure Fixed Asset No %1 has the Acquisition G/L Account', PurchaseLine."No.");
                                end;
                            end;
                        end;
                    end;

                    if PurchaseLine.Type = PurchaseLine.Type::"G/L Account" then begin
                        BudgetGLAccount := PurchaseLine."No.";
                        if GLAcc.Get(PurchaseLine."No.") then
                            GLAcc.TestField(GLAcc."Budget Controlled", true);
                    end;
                    exit(PaneMgtCalculations(ShowResults, PurchaseHeader."Document Date", PurchaseLine."Dimension Set ID", BudgetGLAccount));
                end;
        end;
    end;

    local procedure PaneMgtCalculations(ShowResults: Integer; DocumentDate: Date; DimSetID: Integer; BudgetGLAccount: Code[20]): Decimal
    var
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
    begin
        if DocumentDate = 0D then exit;
        BCSetup.Get();
        //check the votebook now
        FirstDay := Dmy2date(1, Date2dmy(DocumentDate, 2), Date2dmy(DocumentDate, 3));
        CurrMonth := Date2dmy(DocumentDate, 2);
        if CurrMonth = 12 then begin
            LastDay := Dmy2date(1, 1, Date2dmy(DocumentDate, 3) + 1);
            LastDay := CalcDate('-1D', LastDay);
        end
        else begin
            CurrMonth := CurrMonth + 1;
            LastDay := Dmy2date(1, CurrMonth, Date2dmy(DocumentDate, 3));
            LastDay := CalcDate('-1D', LastDay);
        end;

        BudgetGL := BudgetGLAccount;

        //For End Total Budgeting -TMEA
        if BCSetup."Use Totaling Account" then begin
            GLAcc.Get(BudgetGL);
            if GLAcc."Budget Control Account" <> '' then
                BudgetGL := GLAcc."Budget Control Account"
            else
                Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
        end;
        //End (End Total Budget)

        BudgetAmount := 0;
        ActualsAmount := 0;

        GLAcc.Reset;
        GLAcc.SetRange("No.", BudgetGL);
        GLAcc.SetRange("Date Filter", BCSetup."Current Budget Start Date", LastDay);
        GLAcc.SetRange("Budget Filter", BCSetup."Current Budget Code");
        GLAcc.SetRange("Dimension Set ID Filter", DimSetID);
        if GLAcc.Find('-') then begin
            GLAcc.CalcFields("Budgeted Amount", "Net Change");
            BudgetAmount := GLAcc."Budgeted Amount";
            ActualsAmount := GLAcc."Net Change";
        end;
        if ShowResults = 0 then exit(BudgetAmount);

        if ShowResults = 1 then exit(ActualsAmount);

        //get the committments
        CommitmentAmount := 0;
        Commitments.Reset;
        Commitments.SetRange(Commitments.Budget, BCSetup."Current Budget Code");
        Commitments.SetRange(Commitments."G/L Account No.", BudgetGL);
        Commitments.SetRange(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
        Commitments.SetRange(Commitments."Dimension Set ID", DimSetID);
        Commitments.CalcSums(Commitments.Amount);
        CommitmentAmount := Commitments.Amount;
        if ShowResults = 2 then exit(CommitmentAmount);
    end;

    procedure CheckIfAccountIsBudgeted(PurchLine: Record "Purchase Line"): Boolean
    var

        Item: record Item;
        FixedAssetsDet: Record "FA Depreciation Book";
        FAPostingGRP: Record "FA Posting Group";
        GLAcc: Record "G/L Account";
        BudgetGLACC: Code[20];
    begin
        BCSetup.Get();

        if PurchLine.Type = PurchLine.Type::Item then begin
            Item.Reset;
            if not Item.Get(PurchLine."No.") then
                Error('Item Does not Exist');

            Item.TestField("Item G/L Budget Account");
            BudgetGLACC := Item."Item G/L Budget Account";
        end;
        // Fixed Asset
        if PurchLine.Type = PurchLine.Type::"Fixed Asset" then begin
            FixedAssetsDet.Reset;
            FixedAssetsDet.SetRange(FixedAssetsDet."FA No.", PurchLine."No.");
            if FixedAssetsDet.Find('-') then begin
                FixedAssetsDet.TestField(FixedAssetsDet."FA Posting Group");
                FAPostingGRP.Reset;
                FAPostingGRP.SetRange(FAPostingGRP.Code, FixedAssetsDet."FA Posting Group");
                if FAPostingGRP.Find('-') then begin
                    if PurchLine."FA Posting Type" = PurchLine."fa posting type"::Maintenance then begin
                        BudgetGLACC := FAPostingGRP."Maintenance Expense Account";
                        if BudgetGLACC = '' then
                            Error('Ensure Fixed Asset No %1 has the Maintenance G/L Account', PurchLine."No.");
                    end else begin
                        BudgetGLACC := FAPostingGRP."Acquisition Cost Account";
                        if BudgetGL = '' then
                            Error('Ensure Fixed Asset No %1 has the Acquisition G/L Account', PurchLine."No.");
                    end;
                end;
            end;
        end;

        if PurchLine.Type = PurchLine.Type::"G/L Account" then begin
            BudgetGLACC := PurchLine."No.";
        end;

        //End Checking Account in Payment Line
        //For End Total Budgeting
        //For End Total Budgeting -TMEA
        if BCSetup."Use Totaling Account" then begin
            GLAcc.Get(BudgetGLACC);
            if GLAcc."Budget Control Account" <> '' then
                BudgetGLACC := GLAcc."Budget Control Account"
            else
                Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
        end;

        GLAcc.Get(BudgetGLACC);

        if GLAcc."Budget Controlled" then
            exit(true);
    end;

    procedure CheckIfPVIsBudgeted(PaymentLine: Record "Payment Line"): Boolean
    var
        Item: record Item;
        FixedAssetsDet: Record "FA Depreciation Book";
        FAPostingGRP: Record "FA Posting Group";
        GLAcc: Record "G/L Account";
        BudgetGLACC: Code[20];
    begin
        BCSetup.Get();

        BudgetGL := PaymentLine."Account No.";

        if BCSetup."Use Totaling Account" then begin
            GLAcc.Get(BudgetGL);
            if GLAcc."Budget Control Account" <> '' then
                BudgetGLACC := GLAcc."Budget Control Account"
            else
                Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
        end
        else
            BudgetGLACC := BudgetGL;

        GLAcc.Get(BudgetGLACC);

        if GLAcc."Budget Controlled" then
            exit(true)
        else
            exit(false);
    end;

    procedure CheckIfFOSAPVIsBudgeted(FOSAPaymentH: Record "Fosa Payments Header"): Boolean
    var
        GLAcc: Record "G/L Account";
        BudgetGLACC: Code[20];
    begin
        BCSetup.Get();
        BudgetGL := FOSAPaymentH."Account No.";

        //For End Total Budgeting -TMEA
        if BCSetup."Use Totaling Account" then begin
            GLAcc.Get(BudgetGL);
            if GLAcc."Budget Control Account" <> '' then
                BudgetGL := GLAcc."Budget Control Account"
            else
                Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
        end;

        //End Checking Account in Payment Line
        //For End Total Budgeting
        //For End Total Budgeting -TMEA
        if BCSetup."Use Totaling Account" then begin
            GLAcc.Get(BudgetGLACC);
            if GLAcc."Budget Control Account" <> '' then
                BudgetGLACC := GLAcc."Budget Control Account"
            else
                Error('G/L Account %1 is not mapped to a budget control account', BudgetGL);
        end
        else
            BudgetGLACC := BudgetGL;

        GLAcc.Get(BudgetGLACC);

        if GLAcc."Budget Controlled" then
            exit(true)
        else
            exit(false);
    end;
}
