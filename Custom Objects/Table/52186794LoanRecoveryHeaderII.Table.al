table 52186794 "Loan Recovery Header II"
{
    DrillDownPageID = "Posted Loan Recovery Header II";
    LookupPageID = "Posted Loan Recovery Header II";

    fields
    {
        field(1; "No."; Code[50])
        {
            trigger OnValidate()
            begin
                // if xRec."No." <> xRec."No." then begin
                //     CreditNosSeries.Get;
                //     NoSeriesMgt.TestManual(CreditNosSeries."Loan Recovery");
                //     "No. Series" := '';
                // end;
            end;
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Members;

            trigger OnValidate()
            Var
                FOSAAccount: Record "Savings Accounts";
            begin
                if "No." = '' then begin
                    CreditNosSeries.Get;
                    CreditNosSeries.TestField(CreditNosSeries."Loan Recovery II");
                    "No." := NoSeriesMgt.GetNextNo(CreditNosSeries."Loan Recovery II");
                    // NoSeriesMgt.InitSeries(CreditNosSeries."Loan Recovery II", xRec."No. Series", 0D, "No.", "No. Series");
                end;

                CalcFields(Name);
                "All FOSA Loans" := GetFosaLoanBalances();
                "Loan No." := '';
                "Principle Balance" := 0;
                "Interest Balance" := 0;
                "Total Balance" := 0;
                "Account Balance" := 0;
                "Prorated Funds" := 0;

                LoanRecoveryLines.Reset();
                LoanRecoveryLines.SetRange("Header No.", Rec."No.");
                if LoanRecoveryLines.FindFirst() then LoanRecoveryLines.DeleteAll();

                LoanReappotionmentLines.Reset();
                LoanReappotionmentLines.SetRange("Header No.", Rec."No.");
                if LoanReappotionmentLines.FindFirst() then LoanReappotionmentLines.DeleteAll();

            end;
        }
        field(3; Name; Text[80])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Members.name where("No." = field("Member No.")));
        }

        field(4; "Entered By"; Code[50])
        {
        }
        field(5; Status; enum "Workflow Status Main Flags")
        {

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if (xRec.Status = Status::Deffered) and (Rec.Status = Status::Approved) then Error('This record cannot be approved. Please reaopen it first');

                if (Rec.Status = Status::Rejected) or (Rec.Status = Status::Deffered) then
                    GlobalFunctions.CommentsManagement(Rec."No.");
            end;
        }

        field(6; "No. Series"; Code[20])
        {
        }
        field(7; Action; Option)
        {
            OptionMembers = " ",Recovered,Reversed,Reappotioned;
        }
        field(8; "Loan No."; Code[30])
        {
            TableRelation = if ("Recovery Type" = const("Recovery and Attachment")) Loans."Loan No." where("Member No." = field("Member No."))
            else
            if ("Recovery Type" = const(Reappotionment)) Loans."Loan No." where("Outstanding Balance" = const(0), "Member No." = field("Member No."));

            trigger OnValidate()
            begin
                if "Recovery Type" = "Recovery Type"::"Recovery and Attachment" then begin
                    LoanRecoveryLines.Reset();
                    LoanRecoveryLines.SetRange("Header No.", Rec."No.");
                    if LoanRecoveryLines.FindFirst() then LoanRecoveryLines.DeleteAll();

                    GetLoanBalances("Loan No.", "Interest Balance", "Principle Balance", "Total Balance");
                end;
            end;
        }
        field(9; "Interest Balance"; Decimal)
        {
            trigger OnValidate()
            begin
                "Total Balance" := "Interest Balance" + "Principle Balance";
            end;
        }
        field(10; "Principle Balance"; Decimal)
        {
            trigger OnValidate()
            begin
                "Total Balance" := "Interest Balance" + "Principle Balance";
            end;
        }
        field(11; "Total Balance"; Decimal)
        {

        }

        field(19; "Account to Use"; Code[30])
        {
            TableRelation = "Product Factory"."Product ID" where("Product Class Type" = const(Savings));

            trigger OnValidate()
            begin
                if ProductFactory.Get("Account to Use") then begin
                    "Account Name" := ProductFactory."Product Description";

                    SavingsAccounts.Reset();
                    SavingsAccounts.SetRange("Product Type", ProductFactory."Product ID");
                    SavingsAccounts.SetRange("Member No.", Rec."Member No.");
                    if SavingsAccounts.FindFirst() then begin
                        "Account Number" := SavingsAccounts."No.";
                        if ("Recovery Type" = "Recovery Type"::Reappotionment) or ("Recovery Type" = "Recovery Type"::"Recovery and Attachment") then begin
                            "Account Balance" := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                        end;
                    end;
                end;
            end;
        }
        field(29; "Account Name"; Text[50])
        {

        }
        field(18; "Account Number"; Code[30])
        {
            TableRelation = "Savings Accounts"."No.";
        }
        field(12; "Account Balance"; Decimal)
        {
            Caption = 'Account Balance';
        }

        field(13; "Prorated Funds"; Decimal)
        {

            Caption = 'Prorated Balance';

        }
        field(30; "Amount To Use"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Recovery Type" = "Recovery Type"::Reappotionment then begin
                    if "Amount To Use" > "Account Balance" then Error('Amount to use cannot be greater than the account balance');
                    if "Amount To Use" <= 0 then Error('Amount to use must be greater than 0');
                    ServiceGuarantorLoans();
                end
            end;
        }
        field(31; "Total Attached Recoverable"; Decimal)
        {
            Description = 'This field will carry all the amount that will be cleared as part of the loanee previously attached loans and are in default';
        }

        field(14; "Posting Date"; Date)
        {
        }
        field(15; "Recovery Type"; Option)
        {
            OptionMembers = " ","Recovery and Attachment",Reversal,Reappotionment;

            trigger OnValidate()
            begin
                LoanRecoveryLines.Reset();
                LoanRecoveryLines.SetRange("Header No.", Rec."No.");
                if LoanRecoveryLines.FindSet() then LoanRecoveryLines.DeleteAll();

                LoanReappotionmentLines.Reset();
                LoanReappotionmentLines.SetRange("Header No.", Rec."No.");
                if LoanReappotionmentLines.FindSet() then LoanReappotionmentLines.DeleteAll();
            end;
        }
        field(16; "Detach Recovery No"; Code[20])
        {
            Enabled = true;
            TableRelation = "Loan Recovery Header II"."No." WHERE("Member No." = FIELD("Member No."), "Recovery Type" = const("Recovery and Attachment"), Action = const(Recovered), "Header Reversed" = const(false));
            trigger OnValidate()
            var
                LoanRecoveryHeader: Record "Loan Recovery Header II";
                CreditLedgerEntry: Record "Credit Ledger Entry";
            begin
                Rec."Loan No." := '';

                if ("Recovery Type" = Rec."Recovery Type"::Reappotionment) or ("Recovery Type" = Rec."Recovery Type"::Reversal) then begin
                    CreditLedgerEntry.Reset();
                    CreditLedgerEntry.SetRange("Document No.", Rec."Detach Recovery No");
                    CreditLedgerEntry.SetRange(Reversed, true);
                    if CreditLedgerEntry.FindFirst() then
                        Error('This header has already been reversed');
                end;

                if "Recovery Type" = Rec."Recovery Type"::Reappotionment then begin
                    if LoanRecoveryHeader.Get("Detach Recovery No") then begin
                        Rec."Loan No." := LoanRecoveryHeader."Loan No.";
                        Validate("Loan No.");
                        Rec.Modify();
                    end;
                    "All FOSA Loans" := GetFosaLoanBalances();
                end;

                if "Recovery Type" = Rec."Recovery Type"::Reversal then begin
                    GenerateReversalLines(Rec);
                end;
            end;
        }
        field(17; "Detachment Reason"; Option)
        {
            OptionMembers = " ","Repaying correctly","Refinanced internally","CEO/Credit MGR Approved","Under Investigation","Clearing in full",Deceased,"Repaying Partially";
        }


        field(20; "Header Reversed"; Boolean)
        {
            Editable = false;
            Description = 'Defines if this particular header has been revesed by another header to avoid second reversals';
        }
        field(21; "Reversed By Header No"; Code[50])
        {
            TableRelation = "Loan Recovery Header"."No.";
            Editable = false;
            Description = 'Stores the header no that was involved in reversing this one';
        }
        field(22; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No.")));
        }
        field(23; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No.")));
        }
        field(24; "Case Line No"; Integer)
        {
            Editable = false;
            TableRelation = "DMU Case Forwarding Lines"."Entry No";
        }
        field(25; "From Case Module"; Boolean)
        {
            Editable = false;
        }
        field(26; "Global Dimension 1 Code"; Code[50])
        {
            Caption = 'Activity Code';
            Editable = false;
        }
        field(27; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Branch Code';
            Editable = false;
        }
        field(28; "Responsibility Center"; Code[30])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(32; "FOSA Balance"; Decimal)
        {
        }
        field(33; "Loan SASRA Status"; Enum "Loan Sasra categories")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("SASRA Categorization"."Loans Category-SASRA" where("Loan No." = field("Loan No.")));
        }
        field(34; "Days In Arrears"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("SASRA Categorization"."Days In Arreas" where("Loan No." = field("Loan No.")));
        }
        field(35; "Amount in Arrears"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("SASRA Categorization"."Days In Arreas" where("Loan No." = field("Loan No.")));
        }
        field(36; "All FOSA Loans"; Decimal)
        {
        }
        field(37; "Amount Attached"; Decimal)
        {
        }
        field(38; "Total Amount Attached"; Decimal)
        {

        }
        field(39; "Flag Member Account"; Text[250])
        {

        }
        field(40; "Recover Attached Loan"; Boolean)
        {

        }

        field(41; "Available For Reappotionment"; Decimal)
        {
        }
        field(42; "Nullified"; Boolean)
        {
            Editable = false;
        }
        field(43; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(44; "Allow Zero Reversal"; Boolean)
        {

        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {

    }
    trigger OnInsert()
    var
        UserSetUp: Record "User Setup";
        SubModule: Enum "Sub Module";
    begin
        if "No." = '' then begin
            CreditNosSeries.Get;
            CreditNosSeries.TestField(CreditNosSeries."Loan Recovery II");
            "No." := NoSeriesMgt.GetNextNo(CreditNosSeries."Loan Recovery II");
            // NoSeriesMgt.InitSeries(CreditNosSeries."Loan Recovery II", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Entered By" := UserId;
        GeneralSetUp.Get;

        UserSetUp.Reset();
        UserSetUp.SetRange("User ID", UserId);
        if UserSetUp.FindFirst() then begin
            UserSetUp.TestField("Global Dimension 1 Code");
            UserSetUp.TestField("Global Dimension 2 Code");
            UserSetUp.TestField("Responsibility Centre");
            Rec."Responsibility Center" := UserSetUp."Responsibility Centre";
            Rec."Global Dimension 1 Code" := UserSetUp."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetUp."Global Dimension 2 Code";
        end;

        GlobalFunctions.InsertUserTasks(DepartMent::DMU, SubModule::"Loan Recovery", Rec."No.", UserId);
    end;

    procedure GetLoanBalances(LoanNo: Code[30]; Var OutInt: Decimal; var OutBal: Decimal; var TotalBal: Decimal)
    var
        Loans: Record Loans;
        LoanProcess: Codeunit "Loans Process";
    begin
        if Loans.Get(LoanNo) then begin
            Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
            OutBal := Loans."Outstanding Balance";
            OutInt := Loans."Outstanding Interest" + Round(Loans."Daily Interest", 0.01);
            if Loans."Outstanding Interest" < 0 then OutInt := 0;

            TotalBal := Round(OutBal + OutInt, 0.01);
        end;
    end;

    procedure GetFosaLoanBalances(): Decimal
    Var
        FOSALoans: Record Loans;
        TotalBalances: Decimal;
        Oi: Decimal;
        ob: Decimal;
        tb: Decimal;
    begin
        FOSALoans.Reset();
        FOSALoans.SetRange("Member No.", "Member No.");
        FOSALoans.SetRange("Source Unit", FOSALoans."Source Unit"::FOSA);
        if FOSALoans.FindFirst() then begin
            repeat
                GetLoanBalances(FOSALoans."Loan No.", oi, ob, tb);
                TotalBalances += tb;
            until FOSALoans.Next() = 0;
        end;
        exit(TotalBalances);
    end;

    local procedure ServiceGuarantorLoans()
    var
        OriginalRecoveryLines: Record "Loan Recovery Lines II";
        LoanGuarantors: Record "Loan Guarantors and Security";
        AvailableGuarantorsCount: Integer;
        TotalGuaranteedAmount: Decimal;
        AmountToTransaferToGuarantor: Decimal;
        BOSAAccount: Record "Savings Accounts";
        GuarantorLoan: Record Loans;
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
        MoneyToFOSA: Decimal;

        GuarantorBosaAcc: Record "Savings Accounts";
        GuarantorMemAcc: Record Members;
        AttachGuarantor: Boolean;

        InterestPortion: Decimal;
        PrinciplePortion: Decimal;
        CreditLedgerEntry: Record "Credit Ledger Entry";

        InterestDues: Decimal;

        Counter: Integer;
        AmouuntTrasfered: Decimal;
    begin
        Rec.TestField("Detach Recovery No");
        LoanReappotionmentLines.Reset();
        LoanReappotionmentLines.SetRange("Header No.", Rec."No.");
        if LoanReappotionmentLines.FindFirst() then LoanReappotionmentLines.DeleteAll();

        OriginalRecoveryLines.Reset();
        OriginalRecoveryLines.SetRange("Header No.", Rec."Detach Recovery No");
        OriginalRecoveryLines.SetRange("Recovery Type", OriginalRecoveryLines."Recovery Type"::"Guarantor Attachment");
        OriginalRecoveryLines.SetFilter("Original Attached Amount", '>0');
        if OriginalRecoveryLines.Find('-') then begin
            repeat
                AvailableGuarantorsCount += 1;
                TotalGuaranteedAmount += OriginalRecoveryLines."Original Attached Amount";
            until OriginalRecoveryLines.Next() = 0;
        end;

        Counter := 0;
        AmouuntTrasfered := 0;
        OriginalRecoveryLines.Reset();
        OriginalRecoveryLines.SetRange("Header No.", Rec."Detach Recovery No");
        OriginalRecoveryLines.SetRange("Recovery Type", OriginalRecoveryLines."Recovery Type"::"Guarantor Attachment");
        OriginalRecoveryLines.SetFilter("Original Attached Amount", '>0');
        if OriginalRecoveryLines.Find('-') then begin
            repeat
                OutInt := 0;
                OutBal := 0;
                TotalBal := 0;

                Counter += 1;
                AmountToTransaferToGuarantor := 0;
                AmountToTransaferToGuarantor := (OriginalRecoveryLines."Original Attached Amount" / TotalGuaranteedAmount) * ("Amount To Use");
                AmountToTransaferToGuarantor := Round(AmountToTransaferToGuarantor, 0.01, '=');

                if (Counter = AvailableGuarantorsCount) then begin
                    AmountToTransaferToGuarantor := "Amount To Use" - AmouuntTrasfered;
                end;

                AmouuntTrasfered += AmountToTransaferToGuarantor;


                CreditLedgerEntry.Reset();
                CreditLedgerEntry.SetFilter("Document No.", '<>%1', OriginalRecoveryLines."Header No.");
                CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::"Interest Due");
                CreditLedgerEntry.SetRange("Loan No", OriginalRecoveryLines."Loan No.");
                CreditLedgerEntry.SetRange(Reversed, false);
                if CreditLedgerEntry.FindFirst() then begin
                    CreditLedgerEntry.CalcSums(Amount);
                    InterestDues := CreditLedgerEntry.Amount;
                    InterestDues := Abs(InterestDues);
                end;

                if AmountToTransaferToGuarantor > OriginalRecoveryLines."Original Attached Amount" + InterestDues then
                    AmountToTransaferToGuarantor := OriginalRecoveryLines."Original Attached Amount" + InterestDues;

                //Get Loan Balance and determini if money will go to FOSA
                TotalBal := 0;
                MoneyToFOSA := 0;
                if GuarantorLoan.Get(OriginalRecoveryLines."Loan No.") then begin
                    GetLoanBalances(OriginalRecoveryLines."Loan No.", OutInt, OutBal, TotalBal);
                end;

                MoneyToFOSA := AmountToTransaferToGuarantor - TotalBal;
                if MoneyToFOSA <= 0 then MoneyToFOSA := 0;

                InterestPortion := OutInt;
                if InterestPortion > AmountToTransaferToGuarantor then
                    InterestPortion := AmountToTransaferToGuarantor;

                PrinciplePortion := AmountToTransaferToGuarantor - (InterestPortion + MoneyToFOSA);

                if PrinciplePortion < 0 then PrinciplePortion := 0;

                LoanReappotionmentLines.Init();
                LoanReappotionmentLines."Header No." := Rec."No.";
                LoanReappotionmentLines."Defaulter Loan No." := Rec."Loan No.";
                LoanReappotionmentLines."Appotionment Amount" := AmountToTransaferToGuarantor;
                LoanReappotionmentLines."Guarantor Member No." := OriginalRecoveryLines."Member No.";
                LoanReappotionmentLines."BOSA Account No." := LoanGuarantors."Savings Account No./Member No.";
                LoanReappotionmentLines."Guarantor Loan No." := OriginalRecoveryLines."Loan No.";
                LoanReappotionmentLines."Guarantor Name" := OriginalRecoveryLines."Member Name";
                LoanReappotionmentLines."Loan Balance" := TotalBal;
                LoanReappotionmentLines."Money To FOSA" := MoneyToFOSA;
                LoanReappotionmentLines."Interest Portion" := InterestPortion;
                LoanReappotionmentLines."Principle Portion" := PrinciplePortion;
                LoanReappotionmentLines."Innitial Attachment Amount" := OriginalRecoveryLines."Original Attached Amount";
                LoanReappotionmentLines.Insert(true);

            until OriginalRecoveryLines.Next() = 0;
        end;
    end;

    procedure GenerateReversalLines(LoanRecoveryHeader: Record "Loan Recovery Header II")
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
        SavingsLedgerEntry: Record "Savings Ledger Entry";

        ReversalLines: Record "Loan Reversal Lines II";
        InnitialAttachmentHeader: Record "Loan Recovery Header II";
        InitialRecoveryLines: Record "Loan Recovery Lines II";
        ReappotionmentHeaders: Record "Loan Recovery Header II";
        ReappotionmentLines: Record "Loan Reapotionment Lines II";

        HeaderNo: Code[30];
        DefMno: Code[30];
        DefLoanNo: Code[30];
        RefundType: Option "Deposits Refund","Guarantor Refund";
        IntAttachedAmt: Decimal;
        PrAttachedAmt: Decimal;
        AttachedAmt: Decimal;
        OpenLnBal: Decimal;
        GuarantorMno: Code[30];
        GuarantorLnNo: code[30];
        GuarIntBal: Decimal;
        GuarPrBal: Decimal;
        IntAccrued: Decimal;
        IntPaidGuar: Decimal;
        PrPaidGuar: Decimal;
        IntRefund: Decimal;
        PrRefund: Decimal;
        FOSAReapp: Decimal;
        FOSARefund: Decimal;
        IntToDefLn: Decimal;
        PrToDefLn: Decimal;
        TotalToDefLn: Decimal;

        TotalBal: Decimal;
        AllInterestsPaid: Decimal;
        AllInterestsDues: Decimal;
        AllPrinciplesPaid: Decimal;

        AddAmount: Boolean;
        GuarantorLoan: Record Loans;
    begin
        ReversalLines.reset();
        ReversalLines.SetRange("Header No.", LoanRecoveryHeader."No.");
        if ReversalLines.FindFirst() then ReversalLines.DeleteAll();

        HeaderNo := LoanRecoveryHeader."No.";
        DefMno := LoanRecoveryHeader."Member No.";
        InnitialAttachmentHeader.Get(LoanRecoveryHeader."Detach Recovery No");
        DefLoanNo := InnitialAttachmentHeader."Loan No.";

        "Loan No." := DefLoanNo;

        InitialRecoveryLines.Reset();
        InitialRecoveryLines.SetRange("Header No.", InnitialAttachmentHeader."No.");
        InitialRecoveryLines.SetFilter("Recovery Type", '<>%1', InitialRecoveryLines."Recovery Type"::"Attached Loan Recovery");
        if InitialRecoveryLines.Find('-') then begin
            repeat

                IntAttachedAmt := 0;
                PrAttachedAmt := 0;
                AttachedAmt := 0;
                OpenLnBal := 0;
                GuarantorMno := '';
                GuarantorLnNo := '';
                GuarIntBal := 0;
                GuarPrBal := 0;
                IntAccrued := 0;
                IntRefund := 0;
                PrRefund := 0;
                IntPaidGuar := 0;
                PrPaidGuar := 0;
                AllInterestsPaid := 0;
                FOSAReapp := 0;
                IntToDefLn := 0;
                PrToDefLn := 0;
                TotalToDefLn := 0;
                AllInterestsDues := 0;
                AllPrinciplesPaid := 0;
                TotalBal := 0;

                RefundType := RefundType::"Guarantor Refund";
                if InitialRecoveryLines."Recovery Type" = InitialRecoveryLines."Recovery Type"::"Deposits Recovery" then
                    RefundType := RefundType::"Deposits Refund";


                AttachedAmt := InitialRecoveryLines."Original Attached Amount";
                GuarantorMno := InitialRecoveryLines."Member No.";
                GuarantorLnNo := InitialRecoveryLines."Loan No.";
                OpenLnBal := InitialRecoveryLines."Opening Loan Balance";

                // GetLoanBalances(GuarantorLnNo, GuarIntBal, GuarPrBal, TotalBal);
                if GuarantorLoan.Get(InitialRecoveryLines."Loan No.") then begin
                    GuarantorLoan.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                    GuarIntBal := GuarantorLoan."Outstanding Interest" + GuarantorLoan."Daily Interest";
                    GuarPrBal := GuarantorLoan."Outstanding Balance";
                    TotalBal := GuarIntBal + GuarPrBal;
                end;

                ReappotionmentHeaders.Reset();
                ReappotionmentHeaders.SetRange("Member No.", LoanRecoveryHeader."Member No.");
                ReappotionmentHeaders.SetRange("Loan No.", InnitialAttachmentHeader."Loan No.");
                ReappotionmentHeaders.SetRange(Action, ReappotionmentHeaders.Action::Reappotioned);
                ReappotionmentHeaders.SetRange("Header Reversed", false);
                if ReappotionmentHeaders.FindFirst() then begin
                    repeat
                        AddAmount := true;

                        CreditLedgerEntry.Reset();
                        CreditLedgerEntry.SetRange("Document No.", ReappotionmentHeaders."No.");
                        if CreditLedgerEntry.FindFirst() then begin
                            if CreditLedgerEntry.Reversed then
                                AddAmount := false;
                        end else begin
                            SavingsLedgerEntry.Reset();
                            SavingsLedgerEntry.SetRange("Document No.", ReappotionmentHeaders."No.");
                            if SavingsLedgerEntry.FindFirst() then begin
                                if SavingsLedgerEntry.Reversed then
                                    AddAmount := false;
                            end;
                        end;

                        ReappotionmentLines.Reset();
                        ReappotionmentLines.SetRange("Header No.", ReappotionmentHeaders."No.");
                        ReappotionmentLines.SetRange("Guarantor Loan No.", InitialRecoveryLines."Loan No.");
                        if ReappotionmentLines.FindFirst() then begin
                            repeat
                                if AddAmount then begin

                                    FOSAReapp += ReappotionmentLines."Money To FOSA";
                                end;
                            until ReappotionmentLines.Next() = 0;
                        end;
                    until ReappotionmentHeaders.Next() = 0;
                end;


                PrToDefLn := GuarPrBal;
                IntToDefLn := GuarIntBal;

                TotalToDefLn := IntToDefLn + PrToDefLn;

                InsertLoanReversalLines(HeaderNo, DefMno, DefLoanNo, RefundType, IntAttachedAmt, PrAttachedAmt, AttachedAmt, OpenLnBal, GuarantorMno, GuarantorLnNo, GuarIntBal, GuarPrBal,
                                        IntAccrued, IntPaidGuar, PrPaidGuar, IntRefund, PrRefund, FOSAReapp, FOSARefund, IntToDefLn, PrToDefLn, TotalToDefLn);
            until InitialRecoveryLines.Next() = 0;
        end;
    end;

    procedure InsertLoanReversalLines(HeaderNo: Code[30]; DefMno: Code[30]; DefLoanNo: Code[30]; RefundType: Option "Deposits Refund","Guarantor Refund";
    IntAttachedAmt: Decimal; PrAttachedAmt: Decimal; AttachedAmt: Decimal; OpenLnBal: Decimal; GuarantorMno: Code[30]; GuarantorLnNo: code[30]; GuarIntBal: Decimal; GuarPrBal: Decimal;
    IntAccrued: Decimal; IntPaidGuar: Decimal; PrPaidGuar: Decimal; IntRefund: Decimal; PrRefund: Decimal; FOSAReapp: Decimal; FOSARefund: Decimal;
    IntToDefLn: Decimal; PrToDefLn: Decimal; TotalToDefLn: Decimal)
    var
        ReversalLines: Record "Loan Reversal Lines II";
    begin
        ReversalLines.Init();
        ReversalLines."Header No." := HeaderNo;
        ReversalLines."Defaulter Member No." := DefMno;
        ReversalLines."Defaulter Loan No" := DefLoanNo;
        ReversalLines."Refund Type" := RefundType;
        ReversalLines."Interest Attached Amount" := IntAttachedAmt;
        ReversalLines."Principle Attached Amount" := PrAttachedAmt;
        ReversalLines."Attached Amount" := AttachedAmt;
        ReversalLines."Opening Loan Balance" := OpenLnBal;
        ReversalLines."Guarantor Member No." := GuarantorMno;
        ReversalLines."Guarantor Loan No" := GuarantorLnNo;
        ReversalLines."Guarantor Interest Balance" := GuarIntBal;
        ReversalLines."Guarantor Principal Balance" := GuarPrBal;
        ReversalLines."Interests Accrued" := IntAccrued;
        ReversalLines."Interest Paid By Guarantor" := IntPaidGuar;
        ReversalLines."Principle Paid By Guarantor" := PrPaidGuar;
        ReversalLines."FOSA Reappotionments" := FOSAReapp;
        ReversalLines."Interest Refund" := IntRefund;
        ReversalLines."Principle Refund" := PrRefund;
        ReversalLines."Total FOSA Refund" := FOSARefund;
        ReversalLines."Total Int To Defaulter" := IntToDefLn;
        ReversalLines."Total Pr To Defaulter" := PrToDefLn;
        ReversalLines."Total Loan To Defaulter" := TotalToDefLn;
        ReversalLines.Insert(true);
    end;

    var
        ProductFactory: Record "Product Factory";
        CreditNosSeries: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Members: Record Members;
        Loans: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        LoanAmount: Decimal;
        InterestAmount: Decimal;
        LRHeader: Record "Loan Recovery Header";
        GeneralSetUp: Record "General Set-Up";
        DetachNoEnabled: Boolean;
        DetachReasonEnabled: Boolean;
        LoanRecoveryLines: Record "Loan Recovery Lines II";
        LoanReappotionmentLines: Record "Loan Reapotionment Lines II";
        SubDepartments: Enum "Sub Module";
        GlobalFunctions: Codeunit "Global Functions";
        InterestToGuarantors: Decimal;
        PrincipleToGuarantors: Decimal;
        DepartMent: Enum "Responsibility Center Enum";

}
