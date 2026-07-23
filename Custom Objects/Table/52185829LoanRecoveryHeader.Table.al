table 52185829 "Loan Recovery Header"
{
    DrillDownPageID = "Posted Loan Recovery Header";
    LookupPageID = "Posted Loan Recovery Header";

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
                Members.Get("Member No.");
                if Rec."Recovery Type" = Rec."Recovery Type"::"Recovery and Attachment" then
                    if not CheckIfMemebrIsADefaluter(Members) then Message('This member is not a defaulter');

                // if "No." = '' then begin
                //     CreditNosSeries.Get;
                //     CreditNosSeries.TestField(CreditNosSeries."Loan Recovery");
                //     NoSeriesMgt.InitSeries(CreditNosSeries."Loan Recovery", xRec."No. Series", 0D, "No.", "No. Series");
                // end;

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

                "FOSA Balance" := 0;

                FOSAAccount.Reset();
                FOSAAccount.SetRange("Member No.", "Member No.");
                FOSAAccount.SetRange("Product Category", FOSAAccount."Product Category"::"FOSA Account");
                IF FOSAAccount.FindFirst() THEN begin
                    "FOSA Balance" := FOSAAccount.GetAvailableBalance(FOSAAccount."No.");
                end;

                if "Recovery Type" = Rec."Recovery Type"::"Recovery and Attachment" then begin
                    RecoveryHeader.Reset();
                    RecoveryHeader.SetRange("Member No.", Rec."Member No.");
                    RecoveryHeader.SetRange(Action, Action::" ");
                    RecoveryHeader.SetFilter(Status, '', Rec.Status::Deffered, Rec.Status::Open, Rec.Status::Pending);
                    RecoveryHeader.SetRange("Recover Attached Loan", true);
                    // if RecoveryHeader.Find('-') then begin
                    //     Error('This member has another recovery header %1 with status %2 which has a an attached loan to be recovered. Please post it first',);
                    // end;
                end;

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
            TableRelation = if ("Recovery Type" = const("Recovery and Attachment")) Loans."Loan No." where("Outstanding Balance" = filter(> 0), "Member No." = field("Member No."))
            else
            if ("Recovery Type" = const(Reappotionment)) Loans."Loan No." where("Outstanding Balance" = const(0), "Member No." = field("Member No."));

            trigger OnValidate()
            var
                TotalLoansBalances: Decimal;
                OutInt: Decimal;
                OutBal: Decimal;
                TotalBal: Decimal;
                Loans: Record Loans;
                ProductFactory: Record "Product Factory";
                GuarantorLoan: Record Loans;
                LoansProcess: Codeunit "Loans Process";
                DaysInArrears: Integer;
                RunLoan: Boolean;
                RecoveryAmount: Decimal;
                SavingsProduct: Record "Product Factory";
                DepositsToInterest: Decimal;
                DepositsToPrinciple: Decimal;
                OriginalHeader: Record "Loan Recovery Header";
                FosaAccount: Record "Savings Accounts";
                UnpostedHeaders: Record "Loan Recovery Header";
                UnpostedHeadersAmt: Decimal;
            begin
                LoanRecoveryLines.Reset();
                LoanRecoveryLines.SetRange("Header No.", Rec."No.");
                if LoanRecoveryLines.FindFirst() then LoanRecoveryLines.DeleteAll();

                "Account Balance" := 0;
                "Prorated Funds" := 0;
                "Amount To Use" := 0;
                "Total Attached Recoverable" := 0;
                "Prorate Deposits" := false;

                Loans.Get("Loan No.");

                if Rec."Recovery Type" = Rec."Recovery Type"::"Recovery and Attachment" then
                    if not CheckIfLoanIsADefaluted(Loans) then Message('This loan is not defaulted');

                if not ProductFactory.Get(Loans."Loan Product Type") then Message(Loans."Loan No." + ' does not have a valid loan product type');

                "Account to Use" := ProductFactory."Recovery Product";
                if not SavingsProduct.Get(ProductFactory."Recovery Product") then Message(ProductFactory."Product ID" + ' does not have a valid recovery product');
                "Account Name" := SavingsProduct."Product Description";

                FosaAccount.Reset();
                FosaAccount.SetRange("Member No.", "Member No.");
                FosaAccount.SetRange("Product Category", FosaAccount."Product Category"::"FOSA Account");
                if FosaAccount.FindFirst() then begin
                    "FOSA Balance" := FosaAccount.GetAvailableBalance(FosaAccount."No.");
                end;

                if Rec."Recovery Type" = Rec."Recovery Type"::"Recovery and Attachment" then begin

                    GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);

                    "Interest Balance" := OutInt;
                    "Principle Balance" := OutBal;
                    "Total Balance" := Round(TotalBal, 0.01);
                    if "Total Balance" <= 0 then Error('This loan has 0 balance');

                    if ProductFactory."Recovery Creteria" = ProductFactory."Recovery Creteria"::" " then
                        Error('This loan doesn''t have a recovery creteria');
                    //Work on shares and fosa
                    if ProductFactory."Recovery Creteria" <> ProductFactory."Recovery Creteria"::"Guarantors Only" then begin
                        if ProductFactory."Recovery Product" = '' then Message('Recovery product is empty on ' + ProductFactory."Product ID");

                        SavingsAccounts.Reset();
                        SavingsAccounts.SetRange("Member No.", Rec."Member No.");
                        SavingsAccounts.SetRange("Product Type", ProductFactory."Recovery Product");
                        if SavingsAccounts.FindFirst() then begin

                            "Account Balance" := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                            "Account Number" := SavingsAccounts."No.";

                            if "Account Balance" <= 0 then
                                Message('Member''s account doesn''t have any balance');
                        end;

                        //Subtract any guarantor loan that is not performing or watch
                        if "Recover Attached Loan" then begin
                            GuarantorLoan.Reset();
                            GuarantorLoan.SetRange("Member No.", Rec."Member No.");
                            GuarantorLoan.SetFilter("Loan Product Type", 'D*');
                            GuarantorLoan.SetFilter("Outstanding Balance", '>0');
                            GuarantorLoan.SetRange("Recovery Product", ProductFactory."Recovery Product");
                            if GuarantorLoan.Find('-') then begin
                                repeat
                                    if "Account Balance" > 0 then begin
                                        GuarantorLoan.CalcFields("Days In Arrears");
                                        DaysInArrears := GuarantorLoan."Days In Arrears";

                                        //if DaysInArrears > 30 then begin
                                        //Insert loan for recovery
                                        TotalBal := 0;
                                        RecoveryAmount := 0;
                                        OutInt := 0;
                                        OutBal := 0;
                                        GetLoanBalances(GuarantorLoan."Loan No.", OutInt, OutBal, TotalBal);

                                        if OutInt > 0 then begin
                                            if OutInt > "Account Balance" then
                                                OutInt := "Account Balance";
                                            "Account Balance" -= OutInt;
                                        end;
                                        if "Account Balance" < 0 then "Account Balance" := 0;

                                        if OutBal > 0 then begin
                                            if OutBal > "Account Balance" then
                                                OutBal := "Account Balance";
                                            "Account Balance" -= OutBal;
                                        end;
                                        if "Account Balance" < 0 then "Account Balance" := 0;

                                        "Total Attached Recoverable" += OutInt + OutBal;
                                        RecoveryAmount := "Total Attached Recoverable";
                                        InsertRecoveryLines(Rec."Account Number", Rec."No.", RecoveryAmount, GuarantorLoan."Loan No.", "Total Attached Recoverable",
                                        LoanRecoveryLines."Recovery Type"::"Attached Loan Recovery", OutBal, OutInt);

                                        //end;
                                    end;
                                until GuarantorLoan.Next() = 0;
                            end;
                        end;
                        rec."Amount To Use" := "Account Balance";
                        if "Amount To Use" > "Total Balance" then "Amount To Use" := "Total Balance";

                    end;

                    if Rec."Recovery Type" = Rec."Recovery Type"::"Recovery and Attachment" then begin
                        if "Amount To Use" > 0 then begin

                            if "Amount To Use" > "Interest Balance" then begin //Deposits greater than interest
                                DepositsToInterest := "Interest Balance";
                                DepositsToPrinciple := "Amount To Use" - DepositsToInterest;
                                InterestToGuarantors := 0;
                                PrincipleToGuarantors := "Total Balance" - "Amount To Use";
                            end else begin //Deposits less than interest
                                DepositsToInterest := "Amount To Use";
                                DepositsToPrinciple := 0;
                                InterestToGuarantors := "Interest Balance" - "Amount To Use";
                                PrincipleToGuarantors := "Principle Balance";
                            end;

                            if ProductFactory."Recovery Creteria" <> ProductFactory."Recovery Creteria"::"Guarantors Only" then
                                InsertRecoveryLines(Rec."Account Number", Rec."No.", "Amount To Use", '', 0, LoanRecoveryLines."Recovery Type"::"Deposits Recovery",
                                                    DepositsToPrinciple, DepositsToInterest);
                        end else begin
                            InterestToGuarantors := "Interest Balance";
                            PrincipleToGuarantors := "Principle Balance";
                        end;


                        if ProductFactory."Recovery Creteria" = ProductFactory."Recovery Creteria"::"Guarantors Only" then begin
                            InterestToGuarantors := "Interest Balance";
                            PrincipleToGuarantors := "Principle Balance";
                        end;

                        if ProductFactory."Recovery Creteria" <> ProductFactory."Recovery Creteria"::"Shares Only" then
                            AppotionGuarantors();
                    end;
                end;

                if Rec."Recovery Type" = Rec."Recovery Type"::Reappotionment then begin
                    PrefillGuarantorAttachmentsDetails();
                    ProductFactory.TestField("Recovery Product");
                    SavingsAccounts.Reset();
                    SavingsAccounts.SetRange("Member No.", Rec."Member No.");
                    SavingsAccounts.SetRange("Product Type", ProductFactory."Recovery Product");
                    if SavingsAccounts.FindFirst() then begin
                        if SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.") > 0 then begin
                            "Account Balance" := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                            "Account Number" := SavingsAccounts."No.";
                        end else
                            Error('Member''s account doesn''t have any balance');
                    end;

                    UnpostedHeaders.Reset();
                    UnpostedHeaders.SetRange("Member No.", Rec."Member No.");
                    UnpostedHeaders.SetRange(Action, Rec.Action::" ");
                    UnpostedHeaders.SetFilter(Status, '<>%1', Status::Rejected);
                    UnpostedHeaders.SetFilter("No.", '<>%1', Rec."No.");
                    if UnpostedHeaders.FindFirst() then begin
                        repeat
                            UnpostedHeadersAmt += UnpostedHeaders."Amount To Use";
                        until UnpostedHeaders.Next() = 0;
                    end;

                    "Available For Reappotionment" := "Account Balance" - UnpostedHeadersAmt;

                    if "Available For Reappotionment" <= 0 then "Available For Reappotionment" := 0;

                    "Amount To Use" := "Available For Reappotionment";
                    if "Amount To Use" > GetMaxAmountToUseOnReappotionment() then
                        "Amount To Use" := GetMaxAmountToUseOnReappotionment;

                    IF "Amount To Use" <= 0 then "Amount To Use" := 0;

                    Validate("Amount To Use");

                    //Get Loan Balance at attachment
                    if OriginalHeader.Get(Rec."Detach Recovery No") then begin
                        "Total Balance" := OriginalHeader."Total Balance";
                    end;

                    // ServiceGuarantorLoans();
                end;
            end;
        }
        field(9; "Interest Balance"; Decimal)
        {

        }
        field(10; "Principle Balance"; Decimal)
        {

        }
        field(11; "Total Balance"; Decimal)
        {
            DecimalPlaces = 2;
        }

        field(19; "Account to Use"; Code[30])
        {
        }
        field(29; "Account Name"; Text[50])
        {
            // TableRelation = "Responsibility CenterBR";
        }
        field(18; "Account Number"; Code[30])
        {
            TableRelation = "Savings Accounts"."No.";
            Editable = false;
        }
        field(12; "Account Balance"; Decimal)
        {
            Caption = 'Deposits Balance';
        }

        field(13; "Prorated Funds"; Decimal)
        {
            Caption = 'Prorated Deposits';

        }
        field(30; "Amount To Use"; Decimal)
        {
            MinValue = 0;
            trigger OnValidate()
            var
                Loans: Record Loans;
                ProductFactory: Record "Product Factory";
                DepositsToInterest: Decimal;
                DepositsToPrinciple: Decimal;
            begin
                if "Recovery Type" = "Recovery Type"::Reappotionment then begin
                    if "Amount To Use" > GetMaxAmountToUseOnReappotionment() then
                        "Amount To Use" := GetMaxAmountToUseOnReappotionment;
                    IF "Amount To Use" <= 0 then "Amount To Use" := 0;
                end;

                LoanRecoveryLines.Reset();
                LoanRecoveryLines.SetRange("Header No.", Rec."No.");
                LoanRecoveryLines.SetFilter("Recovery Type", '<>%1', LoanRecoveryLines."Recovery Type"::"Attached Loan Recovery");
                if LoanRecoveryLines.FindFirst() then LoanRecoveryLines.DeleteAll();

                LoanReappotionmentLines.Reset();
                LoanReappotionmentLines.SetRange("Header No.", Rec."No.");
                if LoanReappotionmentLines.FindFirst() then LoanReappotionmentLines.DeleteAll();

                Loans.Get("Loan No.");
                ProductFactory.Get(Loans."Loan Product Type");

                if "Recovery Type" = "Recovery Type"::Reappotionment then begin
                    if "Amount To Use" > "Available For Reappotionment" then
                        Error('Amount to use cannot be greater than the account balance');
                end else
                    if "Amount To Use" > "Account Balance" then Error('Amount to use cannot be greater than the account balance');

                if Rec."Recovery Type" = Rec."Recovery Type"::"Recovery and Attachment" then begin
                    if "Amount To Use" > 0 then begin

                        if "Amount To Use" > "Total Balance" then
                            "Amount To Use" := "Total Balance";

                        if "Amount To Use" > "Interest Balance" then begin //Deposits greater than interest
                            DepositsToInterest := "Interest Balance";
                            DepositsToPrinciple := "Amount To Use" - DepositsToInterest;
                            InterestToGuarantors := 0;
                            PrincipleToGuarantors := "Total Balance" - "Amount To Use";
                        end else begin //Deposits less than interest
                            DepositsToInterest := "Amount To Use";
                            DepositsToPrinciple := 0;
                            InterestToGuarantors := "Interest Balance" - "Amount To Use";
                            PrincipleToGuarantors := "Principle Balance";
                        end;
                        if ProductFactory."Recovery Creteria" <> ProductFactory."Recovery Creteria"::"Guarantors Only" then
                            InsertRecoveryLines(Rec."Account Number", Rec."No.", "Amount To Use", '', 0, LoanRecoveryLines."Recovery Type"::"Deposits Recovery",
                            DepositsToPrinciple, DepositsToInterest);
                    end else begin
                        InterestToGuarantors := "Interest Balance";
                        PrincipleToGuarantors := "Principle Balance";
                    end;

                    if ProductFactory."Recovery Creteria" <> ProductFactory."Recovery Creteria"::"Shares Only" then
                        AppotionGuarantors();
                end;

                if Rec."Recovery Type" = Rec."Recovery Type"::Reappotionment then begin
                    ServiceGuarantorLoans();
                end;
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
                "Loan No." := '';
                "Principle Balance" := 0;
                "Interest Balance" := 0;
                "Total Balance" := 0;
                "Account Balance" := 0;
                "Prorated Funds" := 0;

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
            TableRelation = "Loan Recovery Header"."No." WHERE("Member No." = FIELD("Member No."), "Recovery Type" = const("Recovery and Attachment"), Action = const(Recovered), "Header Reversed" = const(false));
            trigger OnValidate()
            var
                LoanRecoveryHeader: Record "Loan Recovery Header";
                CreditLedgerEntry: Record "Credit Ledger Entry";
                AccountingPeriod: Record "Accounting Period";
                FiscalYearStart: Date;
                FiscalYearEnd: Date;
                PostingDate: Date;
            begin
                // Get the posting date of the selected entry
                if LoanRecoveryHeader.Get("Detach Recovery No") then
                    PostingDate := LoanRecoveryHeader."Posting Date";


                // Retrieve fiscal year boundaries
                AccountingPeriod.Reset();
                AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
                AccountingPeriod.setrange(Closed, false);
                AccountingPeriod.SETFILTER("Starting Date", '..%1', PostingDate);
                if AccountingPeriod.FINDFIRST then begin
                    FiscalYearStart := AccountingPeriod."Starting Date";
                    if AccountingPeriod.NEXT <> 0 then
                        FiscalYearEnd := AccountingPeriod."Starting Date" - 1
                    else
                        FiscalYearEnd := DMY2DATE(31, 12, DATE2DMY(TODAY, 3)); // fallback

                    if (PostingDate < FiscalYearStart) or (PostingDate > FiscalYearEnd) then
                        Error('Selected entry''s posting date must be within the current fiscal year (%1 to %2).',
                            Format(FiscalYearStart), Format(FiscalYearEnd));
                end;

                Rec."Loan No." := '';
                if "Recovery Type" = Rec."Recovery Type"::Reappotionment then begin
                    if LoanRecoveryHeader.Get("Detach Recovery No") then begin
                        Rec."Loan No." := LoanRecoveryHeader."Loan No.";
                        Validate("Loan No.");
                        Rec.Modify();
                    end;
                end;

                if "Recovery Type" = Rec."Recovery Type"::Reversal then begin
                    InsertReversalLines(Rec);
                end;

                if ("Recovery Type" = Rec."Recovery Type"::Reappotionment) or ("Recovery Type" = Rec."Recovery Type"::Reversal) then begin
                    CreditLedgerEntry.Reset();
                    CreditLedgerEntry.SetRange("Document No.", Rec."Detach Recovery No");
                    CreditLedgerEntry.SetRange(Reversed, true);
                    if CreditLedgerEntry.FindFirst() then
                        Error('This header has already been reversed');
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
            Editable = false;
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
            Editable = false;
        }
        field(37; "Amount Attached"; Decimal)
        {
            Editable = false;
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
            Editable = false;
        }
        field(42; "Nullified"; Boolean)
        {
            Editable = false;
        }
        field(43; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(44; "Auto Assign Task"; Boolean)
        {
            Editable = false;
        }
        field(45; "SMS Header No"; Code[50])
        {
            Editable = false;
        }
        field(46; "Case Forwarding No"; Code[30])
        {
            Editable = false;
        }
        field(47; "Disbursement Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Disbursement Date" where("Loan No." = field("Loan No.")));
        }
        field(48; "Source Unit"; Enum "Source Unit")
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Source Unit" where("Loan No." = field("Loan No.")));
        }
        field(49; "Prorate Deposits"; Boolean)
        {
            trigger OnValidate()
            var
                TotalLoansBalances: Decimal;
                DepositsToInterest: Decimal;
                DepositsToPrinciple: Decimal;
                ProductFactory: record "Product Factory";
            begin
                if Rec."Recovery Type" = Rec."Recovery Type"::"Recovery and Attachment" then begin
                    TotalLoansBalances := 0;
                    LoanRecoveryLines.Reset();
                    LoanRecoveryLines.SetRange("Header No.", Rec."No.");
                    if LoanRecoveryLines.FindFirst() then LoanRecoveryLines.DeleteAll();

                    if rec."Prorate Deposits" then begin
                        Loans.Reset();
                        Loans.SetLoadFields("Member No.", "Outstanding Balance");
                        Loans.SetRange("Member No.", Rec."Member No.");
                        Loans.SetAutoCalcFields("Total Balance");
                        Loans.SetFilter("Total Balance", '>0');
                        // Loans.SetRange("Recovery Product", ProductFactory."Recovery Product");
                        // Loans.SetRange("Loan Recovery No.", '');
                        //Loans.SetRange("Mobile Loan", false);
                        if Loans.findset() then begin
                            repeat
                                TotalLoansBalances += Loans."Total Balance";
                            until Loans.Next() = 0;
                        end;

                        //TotalLoansBalances -= ("Total Attached Recoverable");//Subtract amounts to be cleared
                        "Prorated Funds" := "Account Balance";
                        if TotalLoansBalances > 0 then
                            "Prorated Funds" := Round((("Total Balance" / TotalLoansBalances) * "Account Balance"), 1, '>');

                        if "Prorated Funds" > "Account Balance" then
                            "Prorated Funds" := "Account Balance";

                        if "Prorated Funds" > "Total Balance" then
                            "Prorated Funds" := "Total Balance";

                        "Amount To Use" := "Prorated Funds";

                    end
                    else begin
                        "Amount To Use" := "Account Balance";
                    end;
                    rec.Validate("Amount To Use");
                end;
            end;
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

        if Rec."Recovery Type" = Rec."Recovery Type"::"Recovery and Attachment" then begin
            if Rec."No." = '' then begin
                CreditNosSeries.Get;
                CreditNosSeries.TestField(CreditNosSeries."Loan Attachment");
                Rec."No." := NoSeriesMgt.GetNextNo(CreditNosSeries."Loan Attachment");
                // NoSeriesMgt.InitSeries(CreditNosSeries."Loan Attachment", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
            end;
        end;
        if Rec."Recovery Type" = Rec."Recovery Type"::Reappotionment then begin
            if Rec."No." = '' then begin
                CreditNosSeries.Get;
                CreditNosSeries.TestField(CreditNosSeries."Loan Reappotionment");
                Rec."No." := NoSeriesMgt.GetNextNo(CreditNosSeries."Loan Reappotionment");
                // NoSeriesMgt.InitSeries(CreditNosSeries."Loan Reappotionment", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
            end;
        end;
        if Rec."Recovery Type" = Rec."Recovery Type"::Reversal then begin
            if Rec."No." = '' then begin
                CreditNosSeries.Get;
                CreditNosSeries.TestField(CreditNosSeries."Loan Reversal");
                Rec."No." := NoSeriesMgt.GetNextNo(CreditNosSeries."Loan Reversal");
                // NoSeriesMgt.InitSeries(CreditNosSeries."Loan Reversal", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
            end;
        end;

        // if "Auto Assign Task" then begin
        //     if not GlobalFunctions.AreUsersPresent(DepartMent::DMU, SubDepartments::"Loan Recovery") then
        //         Error('There are no users present for module loan recovery');
        //     GlobalFunctions.AssignUserTasks(DepartMent::DMU, SubDepartments::"Loan Recovery", "No.");
        // end else begin
        //     if not GlobalFunctions.IsCurrentUserPresent(DepartMent::DMU, SubDepartments::"Loan Recovery", UserId) then
        //         Error('You are not currently listed as the present user to perform this task');
        //     GlobalFunctions.InsertUserTasks(DepartMent::DMU, SubModule::"Loan Recovery", Rec."No.", UserId);
        // end;


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

    procedure GetLoanBalances(LoanNo: Code[30]; var TotalBal: Decimal)
    var
        Loans: Record Loans;
        LoanProcess: Codeunit "Loans Process";
        OutInt: Decimal;
        OutBal: Decimal;
    begin
        if Loans.Get(LoanNo) then begin
            Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
            OutBal := Loans."Outstanding Balance";
            OutInt := Loans."Outstanding Interest" + Round(Loans."Daily Interest", 0.01);
            if Loans."Outstanding Interest" < 0 then OutInt := 0;

            TotalBal := Round(OutBal + OutInt, 0.01);
        end;
    end;

    procedure GetIntBalance(LoanNo: Code[30]; var OutInt: Decimal)
    var
        Loans: Record Loans;
        LoanProcess: Codeunit "Loans Process";
    begin
        if Loans.Get(LoanNo) then begin
            Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
            OutInt := Loans."Outstanding Interest" + Round(Loans."Daily Interest", 0.01);
            if Loans."Outstanding Interest" < 0 then OutInt := 0;

        end;
    end;


    local procedure AppotionGuarantors()
    var
        LoanGuarantors: Record "Loan Guarantors and Security";
        AvailableGuarantorsCount: Integer;
        TotalGuaranteedAmount: Decimal;

        AmountToTransaferToGuarantor: Decimal;
        PrincipleToTransaferToGuarantor: Decimal;
        InterestToTransaferToGuarantor: Decimal;

        Counter: Integer;
        GuarantorBosaAcc: Record "Savings Accounts";
        GuarantorMemAcc: Record Members;
        AttachGuarantor: Boolean;

        InterestRemainder: Decimal;
        PrincipleRemainder: Decimal;

        GuarantorBosaAccNo: Code[50];

        IntModRemainder: Decimal;
        PrModRemainder: Decimal;

        IntShare: Decimal;
        PrShare: Decimal;
    begin
        LoanGuarantors.Reset();
        LoanGuarantors.SetRange("Loan No", Rec."Loan No.");
        LoanGuarantors.SetRange(Substituted, false);
        LoanGuarantors.SetRange("Guarantor Type", LoanGuarantors."Guarantor Type"::Guarantor);
        LoanGuarantors.SetRange("Self Guarantee", false);
        if LoanGuarantors.FindFirst() then begin
            repeat

                AttachGuarantor := true;
                if GuarantorBosaAcc.Get(LoanGuarantors."Savings Account No./Member No.") then begin
                    if GuarantorMemAcc.Get(GuarantorBosaAcc."Member No.") then begin
                        if (GuarantorMemAcc.Status = GuarantorMemAcc.Status::Deceased) or
                        (GuarantorMemAcc.Status = GuarantorMemAcc.Status::Closed) or
                        (GuarantorMemAcc.Subflag = GuarantorMemAcc.Subflag::Withdrawal) or
                        (GuarantorMemAcc.Subflag = GuarantorMemAcc.Subflag::"Pending Withdrawal") then
                            AttachGuarantor := false;
                    end;
                end;

                if LoanGuarantors."Amount Guaranteed" <= 0 then
                    AttachGuarantor := false;

                if AttachGuarantor then begin
                    AvailableGuarantorsCount += 1;
                    TotalGuaranteedAmount += LoanGuarantors."Amount Guaranteed";
                end;
            until LoanGuarantors.Next() = 0;
        end;

        Rec.CalcFields("Source Unit");

        // if Rec."Source Unit" = Rec."Source Unit"::FOSA then begin
        //     IntModRemainder := Rec."Interest Balance" mod AvailableGuarantorsCount;
        //     PrModRemainder := Rec."Principle Balance" mod AvailableGuarantorsCount;

        //     Rec."Interest Balance" -= IntModRemainder;
        //     Rec."Principle Balance" -= PrModRemainder;

        //     IntShare := Rec."Interest Balance" / AvailableGuarantorsCount;
        //     PrShare := Rec."Principle Balance" / AvailableGuarantorsCount;
        // end;



        Counter := 0;
        PrincipleRemainder := PrincipleToGuarantors;
        InterestRemainder := InterestToGuarantors;
        LoanGuarantors.Reset();
        LoanGuarantors.SetRange("Loan No", Rec."Loan No.");
        LoanGuarantors.SetRange(Substituted, false);
        LoanGuarantors.SetRange("Guarantor Type", LoanGuarantors."Guarantor Type"::Guarantor);
        LoanGuarantors.SetRange("Self Guarantee", false);
        if LoanGuarantors.FindFirst() then begin
            //Create Loans For Guarantors and post the whole amount to the loan
            repeat
                AttachGuarantor := true;

                //Check if savings account is valid
                GuarantorBosaAccNo := LoanGuarantors."Savings Account No./Member No.";

                if GuarantorBosaAcc.Get(GuarantorBosaAccNo) then begin
                    if GuarantorMemAcc.Get(GuarantorBosaAcc."Member No.") then begin
                        if (GuarantorMemAcc.Status = GuarantorMemAcc.Status::Deceased) or
                        (GuarantorMemAcc.Status = GuarantorMemAcc.Status::Closed) or
                        (GuarantorMemAcc.Subflag = GuarantorMemAcc.Subflag::Withdrawal) or
                        (GuarantorMemAcc.Subflag = GuarantorMemAcc.Subflag::"Pending Withdrawal") then
                            AttachGuarantor := false;
                    end;
                end else begin
                    if GuarantorMemAcc.Get(LoanGuarantors."Member No") then begin
                        if (GuarantorMemAcc.Status = GuarantorMemAcc.Status::Deceased) or
                        (GuarantorMemAcc.Status = GuarantorMemAcc.Status::Closed) or
                        (GuarantorMemAcc.Subflag = GuarantorMemAcc.Subflag::Withdrawal) or
                        (GuarantorMemAcc.Subflag = GuarantorMemAcc.Subflag::"Pending Withdrawal") then
                            AttachGuarantor := false;

                        GuarantorBosaAcc.Reset();
                        GuarantorBosaAcc.SetRange("Member No.", GuarantorMemAcc."No.");
                        GuarantorBosaAcc.SetRange("Product Category", GuarantorBosaAcc."Product Category"::"BOSA Deposits");
                        if GuarantorBosaAcc.FindFirst() then begin
                            GuarantorBosaAccNo := GuarantorBosaAcc."No.";
                        end;

                        LoanGuarantors."Savings Account No./Member No." := GuarantorBosaAccNo;
                        LoanGuarantors.Modify();
                    end;
                end;

                if LoanGuarantors."Amount Guaranteed" <= 0 then
                    AttachGuarantor := false;

                if AttachGuarantor then begin
                    Counter += 1;
                    AmountToTransaferToGuarantor := 0;
                    // if Rec."Source Unit" = Rec."Source Unit"::FOSA then begin
                    //     PrincipleToTransaferToGuarantor := PrShare;
                    //     InterestToTransaferToGuarantor := IntShare;
                    // end else begin
                    PrincipleToTransaferToGuarantor := round((LoanGuarantors."Amount Guaranteed" / TotalGuaranteedAmount) * (PrincipleToGuarantors), 0.01);//Incase no balance calculated
                    InterestToTransaferToGuarantor := round((LoanGuarantors."Amount Guaranteed" / TotalGuaranteedAmount) * (InterestToGuarantors), 0.01);
                    // end;

                    AmountToTransaferToGuarantor := PrincipleToTransaferToGuarantor + InterestToTransaferToGuarantor;
                    // To handle out of balance by 0.01
                    if Counter = AvailableGuarantorsCount then begin
                        if Rec."Source Unit" = Rec."Source Unit"::FOSA then begin
                            PrincipleToTransaferToGuarantor := PrShare + PrModRemainder;
                            InterestToTransaferToGuarantor := IntShare + IntModRemainder;
                        end else begin
                            PrincipleToTransaferToGuarantor := PrincipleRemainder;
                            InterestToTransaferToGuarantor := InterestRemainder;
                        end;
                        AmountToTransaferToGuarantor := PrincipleToTransaferToGuarantor + InterestToTransaferToGuarantor;
                    end;

                    if Counter <> AvailableGuarantorsCount then begin
                        // if Rec."Source Unit" <> Rec."Source Unit"::FOSA then begin
                        AmountToTransaferToGuarantor := Round(AmountToTransaferToGuarantor, 0.01);
                        PrincipleToTransaferToGuarantor := Round(PrincipleToTransaferToGuarantor, 0.01);
                        InterestToTransaferToGuarantor := Round(InterestToTransaferToGuarantor, 0.01);
                        // end;
                    end;

                    if (PrincipleToTransaferToGuarantor > 0) or (InterestToTransaferToGuarantor > 0) then
                        InsertRecoveryLines(GuarantorBosaAccNo, Rec."No.", AmountToTransaferToGuarantor, '', 0,
                        LoanRecoveryLines."Recovery Type"::"Guarantor Attachment", PrincipleToTransaferToGuarantor, InterestToTransaferToGuarantor);

                    PrincipleRemainder -= PrincipleToTransaferToGuarantor;
                    InterestRemainder -= InterestToTransaferToGuarantor;
                end;
            until LoanGuarantors.Next() = 0;
        end;
    end;


    local procedure ServiceGuarantorLoans()
    var
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

        OriginalRecoveryLines: Record "Loan Recovery Lines";
        LoanBalances: Decimal;
    begin
        LoanReappotionmentLines.Reset();
        LoanReappotionmentLines.SetRange("Header No.", Rec."No.");
        if LoanReappotionmentLines.FindFirst() then LoanReappotionmentLines.DeleteAll();

        OriginalRecoveryLines.Reset();
        OriginalRecoveryLines.SetRange("Header No.", "Detach Recovery No");
        OriginalRecoveryLines.SetRange("Recovery Type", OriginalRecoveryLines."Recovery Type"::"Guarantor Attachment");
        if OriginalRecoveryLines.Find('-') then begin
            repeat
                if GuarantorLoan.Get(OriginalRecoveryLines."Loan No.") then begin
                    GetLoanBalances(OriginalRecoveryLines."Loan No.", OutInt, OutBal, TotalBal);
                    LoanBalances += TotalBal;
                end;
                LoanGuarantors.Reset();
                LoanGuarantors.SetRange("Loan No", Rec."Loan No.");
                LoanGuarantors.SetRange("Member No", OriginalRecoveryLines."Member No.");
                if LoanGuarantors.FindFirst() then begin
                    AvailableGuarantorsCount += 1;
                    TotalGuaranteedAmount += LoanGuarantors."Amount Guaranteed";
                end;
            until OriginalRecoveryLines.Next() = 0;
        end;

        if "Amount To Use" >= LoanBalances then
            Error('Kindly consider doing a reversal');
        OutInt := 0;
        OutBal := 0;
        TotalBal := 0;

        Counter := 0;
        AmouuntTrasfered := 0;

        OriginalRecoveryLines.Reset();
        OriginalRecoveryLines.SetRange("Header No.", "Detach Recovery No");
        OriginalRecoveryLines.SetRange("Recovery Type", OriginalRecoveryLines."Recovery Type"::"Guarantor Attachment");
        if OriginalRecoveryLines.Find('-') then begin
            repeat
                LoanGuarantors.Reset();
                LoanGuarantors.SetRange("Loan No", Rec."Loan No.");
                LoanGuarantors.SetRange("Member No", OriginalRecoveryLines."Member No.");
                if LoanGuarantors.FindFirst() then begin
                    //Create Loans For Guarantors and post the whole amount to the loan
                    Counter += 1;
                    AmountToTransaferToGuarantor := 0;
                    AmountToTransaferToGuarantor := (LoanGuarantors."Amount Guaranteed" / TotalGuaranteedAmount) * ("Amount To Use");
                    AmountToTransaferToGuarantor := Round(AmountToTransaferToGuarantor, 0.01, '=');

                    if (Counter = AvailableGuarantorsCount) then begin
                        AmountToTransaferToGuarantor := "Amount To Use" - AmouuntTrasfered;
                    end;

                    AmouuntTrasfered += AmountToTransaferToGuarantor;

                    if BOSAAccount.Get(LoanGuarantors."Savings Account No./Member No.") then begin
                        LoanRecoveryLines.Reset();
                        LoanRecoveryLines.SetRange("Account No.", LoanGuarantors."Savings Account No./Member No.");
                        LoanRecoveryLines.SetRange("Header No.", Rec."Detach Recovery No");
                        if LoanRecoveryLines.FindFirst() then begin
                            CreditLedgerEntry.Reset();
                            CreditLedgerEntry.SetFilter("Document No.", '<>%1', LoanRecoveryLines."Header No.");
                            CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::"Interest Due");
                            CreditLedgerEntry.SetRange("Loan No", LoanRecoveryLines."Loan No.");
                            CreditLedgerEntry.SetRange(Reversed, false);
                            if CreditLedgerEntry.FindFirst() then begin
                                CreditLedgerEntry.CalcSums(Amount);
                                InterestDues := CreditLedgerEntry.Amount;
                                InterestDues := Abs(InterestDues);
                            end;

                            if AmountToTransaferToGuarantor > LoanRecoveryLines."Recovery Amount" + InterestDues then
                                AmountToTransaferToGuarantor := LoanRecoveryLines."Recovery Amount" + InterestDues;

                            //Get Loan Balance and determini if money will go to FOSA
                            TotalBal := 0;
                            MoneyToFOSA := 0;
                            if GuarantorLoan.Get(LoanRecoveryLines."Loan No.") then begin
                                GetLoanBalances(LoanRecoveryLines."Loan No.", OutInt, OutBal, TotalBal);
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
                            LoanReappotionmentLines."Guarantor Member No." := BOSAAccount."Member No.";
                            LoanReappotionmentLines."BOSA Account No." := LoanGuarantors."Savings Account No./Member No.";
                            LoanReappotionmentLines."Guarantor Loan No." := LoanRecoveryLines."Loan No.";
                            LoanReappotionmentLines."Guarantor Member No." := BOSAAccount."Member No.";
                            LoanReappotionmentLines."Guarantor Name" := BOSAAccount.Name;
                            LoanReappotionmentLines."Loan Balance" := TotalBal;
                            LoanReappotionmentLines."Money To FOSA" := MoneyToFOSA;
                            LoanReappotionmentLines."Interest Portion" := InterestPortion;
                            LoanReappotionmentLines."Principle Portion" := PrinciplePortion;
                            LoanReappotionmentLines."Innitial Attachment Amount" := LoanRecoveryLines."Recovery Amount";
                            LoanReappotionmentLines.Insert(true);
                        end;
                    end;

                end;
            until OriginalRecoveryLines.Next() = 0;
        end;
    end;

    procedure InsertRecoveryLines(AccountNo: Code[30]; HeaderNo: Code[30]; RecoveryAmount: Decimal; AttachedLoanNumber: Code[30]; AttachedLoanBalance: Decimal;
    RecoveryType: Option "Guarantor Attachment","Account Recovery","Guaranto Loan Payment"; PrincipleAmt: Decimal; InterestAmt: Decimal)
    begin
        LoanRecoveryLines.Init();
        LoanRecoveryLines."Account No." := AccountNo;
        LoanRecoveryLines."Header No." := HeaderNo;
        LoanRecoveryLines.Validate("Account No.");
        LoanRecoveryLines."Recovery Type" := RecoveryType;
        LoanRecoveryLines."Recovery Amount" := RecoveryAmount;
        LoanRecoveryLines."Attached Loan Number" := AttachedLoanNumber;
        LoanRecoveryLines."Attached Loan Balance" := AttachedLoanBalance;
        LoanRecoveryLines."Principle Amount" := PrincipleAmt;
        LoanRecoveryLines."Interest Amount" := InterestAmt;
        LoanRecoveryLines.Insert(true);
    end;

    procedure PrefillGuarantorAttachmentsDetails()
    Var
        LoanRecoveryHeader: Record "Loan Recovery Header";
        LoanRecoveryLines: Record "Loan Recovery Lines";
        CurrentLoan: Record Loans;
        PreviousLoans: Record Loans;
        ThisGuarantorAttachments: Decimal;
        AllGuarantorAttachments: Decimal;
        TotalPerHeader: Decimal;
    begin
        ThisGuarantorAttachments := 0;
        AllGuarantorAttachments := 0;
        LoanRecoveryHeader.Reset();
        LoanRecoveryHeader.SetRange("Member No.", "Member No.");
        LoanRecoveryHeader.SetRange("Header Reversed", false);
        LoanRecoveryHeader.SetRange("Recovery Type", LoanRecoveryHeader."Recovery Type"::"Recovery and Attachment");
        LoanRecoveryHeader.SetRange(Action, LoanRecoveryHeader.Action::Recovered);
        if LoanRecoveryHeader.FindFirst() then begin
            repeat
                if LoanRecoveryHeader."Loan No." = '' then Message('WARNING!\Recovery header %1 does not have a loan number', LoanRecoveryHeader."No.");
                if "Loan No." = '' then Error('WARNING!\This recovery header does not have a loan number');

                if not PreviousLoans.Get(LoanRecoveryHeader."Loan No.") then Message('WARNING!\Loan number %1 in header %2 does not exist');
                if not CurrentLoan.Get("Loan No.") then Message('WARNING!\Loan number %1 in header %2 does not exist');

                PreviousLoans.CalcFields("Recovery Product");
                CurrentLoan.CalcFields("Recovery Product");

                if CurrentLoan."Recovery Product" = PreviousLoans."Recovery Product" then begin
                    TotalPerHeader := 0;
                    LoanRecoveryLines.Reset();
                    LoanRecoveryLines.SetRange("Header No.", LoanRecoveryHeader."No.");
                    LoanRecoveryLines.SetRange("Recovery Type", LoanRecoveryLines."Recovery Type"::"Guarantor Attachment");
                    if LoanRecoveryLines.FindFirst() then begin
                        repeat
                            TotalPerHeader += LoanRecoveryLines."Recovery Amount";
                        until LoanRecoveryLines.Next() = 0;
                    end;
                    AllGuarantorAttachments += TotalPerHeader;
                    if LoanRecoveryHeader."Loan No." = "Loan No." then begin
                        ThisGuarantorAttachments += TotalPerHeader;
                    end;
                end;
            until LoanRecoveryHeader.Next() = 0;
        end;

        "Amount Attached" := ThisGuarantorAttachments;
        "Total Amount Attached" := AllGuarantorAttachments;
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

    procedure InsertReversalLines(LoanRecoveryHeader: Record "Loan Recovery Header")
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
        SavingsLedgerEntry: Record "Savings Ledger Entry";

        ReversalLines: Record "Loan Reversal Lines";
        InnitialAttachmentHeader: Record "Loan Recovery Header";
        InitialRecoveryLines: Record "Loan Recovery Lines";
        ReappotionmentHeaders: Record "Loan Recovery Header";
        ReappotionmentLines: Record "Loan Reapotionment Lines";

        HeaderNo: Code[30];
        DefMno: Code[30];
        DefLoanNo: Code[30];
        RefundType: Option "Deposits Refund","Guarantor Refund";
        IntAttachedAmt: Decimal;
        PrAttachedAmt: Decimal;
        GuarantorMno: Code[30];
        GuarantorLnNo: code[30];
        GuarIntBal: Decimal;
        GuarPrBal: Decimal;
        IntAccrued: Decimal;
        IntPaidGuar: Decimal;
        PrPaidGuar: Decimal;
        IntReapp: Decimal;
        PrReapp: Decimal;
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
        if InitialRecoveryLines.FindFirst() then begin
            repeat

                IntAttachedAmt := 0;
                PrAttachedAmt := 0;
                GuarantorMno := '';
                GuarantorLnNo := '';
                GuarIntBal := 0;
                GuarPrBal := 0;
                IntAccrued := 0;
                IntReapp := 0;
                PrReapp := 0;
                IntPaidGuar := 0;
                PrPaidGuar := 0;
                AllInterestsPaid := 0;
                FOSAReapp := 0;
                IntToDefLn := 0;
                PrToDefLn := 0;
                TotalToDefLn := 0;
                AllInterestsDues := 0;
                AllPrinciplesPaid := 0;

                RefundType := RefundType::"Guarantor Refund";
                if InitialRecoveryLines."Recovery Type" = InitialRecoveryLines."Recovery Type"::"Deposits Recovery" then
                    RefundType := RefundType::"Deposits Refund";

                IntAttachedAmt := InitialRecoveryLines."Interest Amount";
                PrAttachedAmt := InitialRecoveryLines."Principle Amount";
                GuarantorMno := InitialRecoveryLines."Member No.";
                GuarantorLnNo := InitialRecoveryLines."Loan No.";

                GetLoanBalances(GuarantorLnNo, GuarIntBal, GuarPrBal, TotalBal);

                if GuarantorLnNo = 'LN000225' then begin
                    Message('JKS');
                end;

                CreditLedgerEntry.Reset();
                CreditLedgerEntry.SetFilter("Document No.", '<>%1', InitialRecoveryLines."Header No.");
                CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::"Interest Due");
                CreditLedgerEntry.SetRange("Loan No", InitialRecoveryLines."Loan No.");
                CreditLedgerEntry.SetRange(Reversed, false);
                if CreditLedgerEntry.FindFirst() then begin
                    CreditLedgerEntry.CalcSums(Amount);
                    IntAccrued := CreditLedgerEntry.Amount;
                    IntAccrued := Abs(IntAccrued);
                end;

                CreditLedgerEntry.Reset();
                CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::"Interest Paid");
                CreditLedgerEntry.SetRange("Loan No", InitialRecoveryLines."Loan No.");
                CreditLedgerEntry.SetRange(Reversed, false);
                if CreditLedgerEntry.FindFirst() then begin
                    CreditLedgerEntry.CalcSums(Amount);
                    AllInterestsPaid := CreditLedgerEntry.Amount;
                    AllInterestsPaid := Abs(AllInterestsPaid);
                end;

                CreditLedgerEntry.Reset();
                CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::"Interest Due");
                CreditLedgerEntry.SetRange("Loan No", InitialRecoveryLines."Loan No.");
                CreditLedgerEntry.SetRange(Reversed, false);
                if CreditLedgerEntry.FindFirst() then begin
                    CreditLedgerEntry.CalcSums(Amount);
                    AllInterestsDues := CreditLedgerEntry.Amount;
                    AllInterestsDues := Abs(AllInterestsDues);
                end;

                CreditLedgerEntry.Reset();
                CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."Transaction Type"::Repayment);
                CreditLedgerEntry.SetRange("Loan No", InitialRecoveryLines."Loan No.");
                CreditLedgerEntry.SetRange(Reversed, false);
                if CreditLedgerEntry.FindFirst() then begin
                    CreditLedgerEntry.CalcSums(Amount);
                    AllPrinciplesPaid := CreditLedgerEntry.Amount;
                    AllPrinciplesPaid := Abs(AllPrinciplesPaid);
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
                                    IntReapp += ReappotionmentLines."Interest Portion";
                                    PrReapp += ReappotionmentLines."Principle Portion";
                                    FOSAReapp += ReappotionmentLines."Money To FOSA";
                                end;
                            until ReappotionmentLines.Next() = 0;
                        end;
                    until ReappotionmentHeaders.Next() = 0;
                end;

                IntPaidGuar := AllInterestsPaid - IntReapp;

                PrPaidGuar := AllPrinciplesPaid - PrReapp;

                IntToDefLn := AllInterestsDues - IntReapp;

                //Reappotionments must have cleared the interest
                if FOSAReapp > 0 then begin
                    // PrPaidGuar -= FOSAReapp - IntPaidGuar;
                    PrPaidGuar := PrPaidGuar - FOSAReapp - IntPaidGuar;
                    IntPaidGuar := 0;
                    IntToDefLn := 0;
                end;

                if (IntToDefLn = 0) and (GuarIntBal > 0) then begin
                    IntToDefLn := GuarIntBal;
                end;

                PrToDefLn := PrPaidGuar + GuarPrBal;

                TotalToDefLn := IntToDefLn + PrToDefLn;

                FOSARefund := PrPaidGuar + IntPaidGuar;

                if InitialRecoveryLines."Recovery Type" = InitialRecoveryLines."Recovery Type"::"Deposits Recovery" then begin
                    IntToDefLn := IntAttachedAmt;
                    PrToDefLn := PrAttachedAmt;
                    TotalToDefLn := IntToDefLn + PrToDefLn;
                end;

                InsertLoanReversalLines(HeaderNo, DefMno, DefLoanNo, RefundType, IntAttachedAmt, PrAttachedAmt, GuarantorMno, GuarantorLnNo, GuarIntBal, GuarPrBal,
                                        IntAccrued, IntPaidGuar, PrPaidGuar, IntReapp, PrReapp, FOSAReapp, FOSARefund, IntToDefLn, PrToDefLn, TotalToDefLn);
            until InitialRecoveryLines.Next() = 0;
        end;
    end;


    procedure InsertLoanReversalLines(HeaderNo: Code[30]; DefMno: Code[30]; DefLoanNo: Code[30]; RefundType: Option "Deposits Refund","Guarantor Refund";
    IntAttachedAmt: Decimal; PrAttachedAmt: Decimal; GuarantorMno: Code[30]; GuarantorLnNo: code[30]; GuarIntBal: Decimal; GuarPrBal: Decimal;
    IntAccrued: Decimal; IntPaidGuar: Decimal; PrPaidGuar: Decimal; IntReapp: Decimal; PrReapp: Decimal; FOSAReapp: Decimal; FOSARefund: Decimal;
    IntToDefLn: Decimal; PrToDefLn: Decimal; TotalToDefLn: Decimal)
    var
        ReversalLines: Record "Loan Reversal Lines";
    begin
        ReversalLines.Init();
        ReversalLines."Header No." := HeaderNo;
        ReversalLines."Defaulter Member No." := DefMno;
        ReversalLines."Defaulter Loan No" := DefLoanNo;
        ReversalLines."Refund Type" := RefundType;
        ReversalLines."Interest Attached Amount" := IntAttachedAmt;
        ReversalLines."Principle Attached Amount" := PrAttachedAmt;
        ReversalLines."Guarantor Member No." := GuarantorMno;
        ReversalLines."Guarantor Loan No" := GuarantorLnNo;
        ReversalLines."Guarantor Interest Balance" := GuarIntBal;
        ReversalLines."Guarantor Principal Balance" := GuarPrBal;
        ReversalLines."Interests Accrued" := IntAccrued;
        ReversalLines."Interest Paid By Guarantor" := IntPaidGuar;
        ReversalLines."Principle Paid By Guarantor" := PrPaidGuar;
        ReversalLines."Interest Reappotionments" := IntReapp;
        ReversalLines."Principle Reappotionments" := PrReapp;
        ReversalLines."FOSA Reappotionments" := FOSAReapp;
        ReversalLines."FOSA Refund" := FOSARefund;
        ReversalLines."Total Int To Defaulter" := IntToDefLn;
        ReversalLines."Total Pr To Defaulter" := PrToDefLn;
        ReversalLines."Total Loan To Defaulter" := TotalToDefLn;
        ReversalLines.Insert(true);
    end;

    procedure CheckIfMemebrIsADefaluter(Members: Record Members): Boolean
    begin
        Loans.Reset();
        Loans.SetRange("Member No.", Members."No.");
        Loans.SetFilter("Loans Category-SASRA", '<>%1', Loans."Loans Category-SASRA"::Perfoming);
        if Loans.FindFirst() then
            exit(true)
        else
            exit(false);
    end;

    procedure CheckIfLoanIsADefaluted(VarLoans: Record Loans): Boolean
    begin
        VarLoans.CalcFields("Loans Category-SASRA");
        if VarLoans."Loans Category-SASRA" = VarLoans."Loans Category-SASRA"::Perfoming then
            exit(false)
        else
            exit(true);
    end;

    procedure GetMaxAmountToUseOnReappotionment(): Decimal
    var
        AttachmentLines: Record "Loan Recovery Lines";
        TotalAttachedAmount: Decimal;
        InterestBalances: Decimal;
        OutInt: Decimal;
        ReappotionmentLinez: Record "Loan Reapotionment Lines";
        ReappotionHeader: Record "Loan Recovery Header";
        TotalReappotioned: Decimal;
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        if "Recovery Type" = "Recovery Type"::Reappotionment then begin
            AttachmentLines.Reset();
            AttachmentLines.SetRange("Header No.", Rec."Detach Recovery No");
            AttachmentLines.SetRange("Recovery Type", AttachmentLines."Recovery Type"::"Guarantor Attachment");
            if AttachmentLines.Find('-') then begin
                AttachmentLines.CalcSums("Recovery Amount");
                TotalAttachedAmount := AttachmentLines."Recovery Amount";

                repeat
                    GetIntBalance(AttachmentLines."Loan No.", OutInt);
                    InterestBalances += OutInt;
                until AttachmentLines.Next() = 0;

            end;

            ReappotionHeader.Reset();
            ReappotionHeader.SetRange("Member No.", Rec."Member No.");
            ReappotionHeader.SetRange(Action, ReappotionHeader.Action::Reappotioned);
            ReappotionHeader.SetRange("Header Reversed", false);
            ReappotionHeader.SetRange(Nullified, false);
            ReappotionHeader.SetRange("Detach Recovery No", Rec."Detach Recovery No");
            if ReappotionHeader.Find('-') then begin
                repeat
                    CreditLedgerEntry.Reset();
                    CreditLedgerEntry.SetRange("Document No.", ReappotionHeader."No.");
                    CreditLedgerEntry.SetRange(Reversed, false);
                    if CreditLedgerEntry.FindFirst() then begin
                        ReappotionmentLinez.Reset();
                        ReappotionmentLinez.SetRange("Header No.", ReappotionHeader."No.");
                        if ReappotionmentLinez.Find('-') then begin
                            ReappotionmentLinez.CalcSums("Appotionment Amount");
                            TotalReappotioned += ReappotionmentLinez."Appotionment Amount";
                        end;
                    end;
                until ReappotionHeader.Next() = 0;
            end;
            exit((TotalAttachedAmount + InterestBalances) - TotalReappotioned);
        end;
    end;

    var
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
        LoanRecoveryLines: Record "Loan Recovery Lines";
        LoanReappotionmentLines: Record "Loan Reapotionment Lines";
        SubDepartments: Enum "Sub Module";
        GlobalFunctions: Codeunit "Global Functions";
        InterestToGuarantors: Decimal;
        PrincipleToGuarantors: Decimal;
        DepartMent: Enum "Responsibility Center Enum";
        RecoveryHeader: Record "Loan Recovery Header";

}
