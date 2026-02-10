table 52185824 "Membership Closure"
{
    // DrillDownPageID = "Open Closure List";
    // LookupPageID = "Open Closure List";

    DrillDownPageID = "Posted Membership Closure List";
    //52186365;
    LookUpPageID = "Posted Membership Closure List";

    fields
    {
        field(1; "No."; Code[10])
        {
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Members;

            trigger OnValidate()
            begin
                "Staff No." := '';
                "TSC Clearance" := 0;
                if not Members.Get("Member No.") then Error(ErrMemberNotFound, "Member No.");

                GetLoanBalances();
                ClearClosureLines();
                Validate("Close Account", "Close Account"::All);
                ValidateExistingMembershipClosureCount();
                ValidateGuarantor();
                ValidateWithDrawalNotice();
                //Alert MemberwithdrawalNotice
                "Member Name" := Members.Name;
                "Primary Identification Type" := Members."Primary Identification Type";
                "Primary Identification No." := Members."Primary Identification";
                "Staff No." := Members."Payroll/Staff No.";
                "Application Date" := Today;

                if rec."Closure Type" = "Closure Type"::"Withdrawal - Normal" then
                    Validate("Loans Option", "Loans Option"::All)
                else
                    "Loans Option" := "Loans Option"::" ";

                if rec."% of Refunds" > 0 then
                    Rec.validate("% of Refunds");

                //******DAN Said close account is always all******//
                // if "Closure Type" = "Closure Type"::"Withdrawal - Normal" then
                //     Validate("Close Account", "Close Account"::All)
                // else
                //     Validate("Close Account", "Close Account"::Specific);

                ValidateOverPaidLoans();
                UpdateClosureCharges();

                //GlobalFunctions.AssignDigitCustodianTask(Rec."No.", Rec."Member No.", "Sub Module"::"Member Closure");
            end;
        }
        field(3; "Member Name"; Text[50])
        {
        }
        field(4; "Closing Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Closing Date" < Today then
                    Error(Err0004);
            end;
        }
        field(5; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending,Approved,Rejected,Cancelled';
            OptionMembers = Open,Pending,Approved,Rejected,"Cancelled";
            trigger OnValidate()
            var
                GlobalFunc: Codeunit "Global Functions";/*  */
                WithNotice: record "Member withdrawal Notice";
            begin
                case Status of
                    Status::Approved:
                        begin
                            GlobalFunc.CommentsManagement(Rec."No.");
                            "Date Approved" := Today;
                            "Approved By" := UserId;

                            WithNotice.Reset();
                            WithNotice.SetRange("No.", Rec."Notice Number");
                            if WithNotice.FindFirst() then begin
                                WithNotice.Status := WithNotice.Status::Approved;
                                WithNotice.Modify(true);
                            end;
                        end;
                    Status::Rejected:
                        begin
                            GlobalFunc.CommentsManagement(Rec."No.");
                        end;
                    Status::"Cancelled":
                        begin
                            GlobalFunc.CommentsManagement(Rec."No.");
                            WithNotice.Reset();
                            WithNotice.SetRange("No.", Rec."Notice Number");
                            if WithNotice.FindFirst() then begin
                                WithNotice.Status := WithNotice.Status::Cancelled;
                                WithNotice.Modify(true);
                            end;
                        end;
                end;

            end;
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Total Loan"; Decimal)
        {
        }
        field(8; "Total Interest"; Decimal)
        {
        }
        field(9; "Member Savings"; Decimal)
        {
        }
        field(10; "No. Series"; Code[10])
        {
        }
        field(11; "Closure Type"; Option)
        {
            OptionMembers = " ","Withdrawal - Normal","Withdrawal - 1st Partial","Withdrawal - 2nd Partial";
            Editable = false;
            trigger OnValidate()
            begin
                ValidateSelectedClosureType();
                "CheckIf2ndClosureIsValid"();
                "CheckIf1stClosureIsValid"();
            end;
        }
        field(12; "Application Date"; Date)
        {
        }
        field(13; "Deposit Refundable"; Decimal)
        {
        }
        field(14; Remarks; Text[50])
        {
        }
        field(15; "Close Account"; Option)
        {
            OptionCaption = ' ,All,Specific';
            OptionMembers = " ",All,Specific;
            ValuesAllowed = " ", All;
            Editable = false;
            trigger OnValidate()
            begin
                ClearClosureLines();

                "Member Savings" := 0;
                TotalSaving := 0;
                GenSetup.Get;


                if "Close Account" <> "Close Account"::" " then begin
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Member No.");
                    SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
                    // if "Closure Type" = "Closure Type"::"Withdrawal - 1st Partial" then
                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                    if SavingsAccounts.Find('-') then begin
                        repeat
                            //if SavingsAccounts."Loan Disbursement Account" = false then begin
                            if ProductFactory.Get(SavingsAccounts."Product Type") then begin
                                // if ProductFactory."Product Class Type" = ProductFactory."Product Class Type"::Savings then begin
                                //     if ProductFactory."Product Category" <> ProductFactory."Product Category"::"Share Capital" then begin
                                //         if ProductFactory."Product Category" <> ProductFactory."product category"::"Entrance Fee" then begin
                                //             if ProductFactory."Product Category" <> ProductFactory."Product Category"::"Benevolent (BBF)" then begin
                                if not ProductFactory."Exclude From Closure" then begin
                                    AccLine.Init;
                                    AccLine."No." := "No.";
                                    AccLine."Account No." := SavingsAccounts."No.";
                                    AccLine.Name := SavingsAccounts.Name;
                                    AccLine."Product Type" := SavingsAccounts."Product Type";
                                    AccLine.Balance := SavingsAccounts."Balance (LCY)";
                                    if "Close Account" = "Close Account"::All then
                                        AccLine.Close := true;
                                    AccLine.Blocked := SavingsAccounts.Blocked;
                                    AccLine."Member No." := SavingsAccounts."Member No.";
                                    AccLine.Insert;
                                    //AccountClosureFee := GetTransactionCharge(ProductFactory."Closure Fee");
                                    TotalSaving := TotalSaving + (SavingsAccounts."Balance (LCY)");
                                end;
                            end;
                        //         end;
                        //     end;
                        // end;
                        // end;
                        //end;
                        until SavingsAccounts.Next = 0;
                    end;

                    "Member Savings" := TotalSaving/* - "Premature Charges"*/;
                    if "Close Account" = "Close Account"::Specific then begin
                        "Member Savings" := 0;
                        "Deposit Refundable" := 0;
                        "Partial Deposit Refundable" := 0;
                        "Premature Charges" := 0;
                        "WithDrawal Charge" := 0;
                    end;
                    //CurrPage.UPDATE;
                end else begin

                    "Member Savings" := 0;
                    "Deposit Refundable" := 0;
                    "Partial Deposit Refundable" := 0;
                    "Premature Charges" := 0;
                    "WithDrawal Charge" := 0;

                end;

                UpdateDepositRefundable();

                /*  if ("Member Savings" - ("Total Loan" + "Total Interest" + "Premature Charges" + GenSetup."Withdrawal Fee" + "TSC Clearance")) < 0 then
                     "Deposit Refundable" := 0
                 else
                     "Deposit Refundable" := "Member Savings" - ("Total Loan" + "Total Interest" + GenSetup."Withdrawal Fee" + "Premature Charges" + "TSC Clearance");
  */
                // "Partial Deposit Refundable" := "Deposit Refundable";
                "Benevolent Fund" := BBF;
                //"WithDrawal Charge" := "Deposit Refundable" * 0.01;
                //"Partial Deposit Refundable" := "Deposit Refundable" * 0.5;

            end;
        }
        field(16; "Loans Option"; Option)
        {
            OptionCaption = ' ,Short Term,Long Term,All';
            OptionMembers = " ","Short Term","Long Term",All;
            Editable = false;

            trigger OnValidate()
            begin
                GenSetup.Get;

                // if "Closure Type" = "Closure Type"::"Withdrawal - 1st Partial" then begin
                //     "Loans Option" := "Loans Option"::All;
                //     // "Close Account" := "Close Account"::Specific; Dan
                // end;

                if ("Member Savings" - ("Total Loan" + "Total Interest")) < 0 then
                    "Deposit Refundable" := 0
                else
                    "Deposit Refundable" := "Member Savings" - ("Total Loan" + "Total Interest" + "TSC Clearance" + "Closure Charges"/*+ "Premature Charges"*/);
                //"WithDrawal Charge" := "Deposit Refundable" * 0.01;
                //"Partial Deposit Refundable" := "Deposit Refundable" * 0.5;
                if "Closure Type" = "Closure Type"::"Withdrawal - 1st Partial" then
                    Validate("Partial Deposit Refundable");

            end;
        }
        field(17; "Entered By"; Code[30])
        {
        }

        field(18; Transaction; Option)
        {
            OptionCaption = 'Member Withdrawal';
            OptionMembers = "Member Withdrawal";
        }
        field(19; "Primary Identification No."; Code[20])
        {
            Editable = false;
        }
        field(20; "Benevolent Fund"; Decimal)
        {
        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = false;
        }
        field(23; "Notice Number"; Code[20])
        {
            TableRelation = "Member withdrawal Notice"."No." where(Status = const(Approved), "Notice Finalized" = const(false));
            Editable = false;
            trigger OnValidate()
            var
                MemberwithdrawalNotice: Record "Member withdrawal Notice";
            begin
                MemberwithdrawalNotice.Reset();
                MemberwithdrawalNotice.SetRange("No.", "Notice Number");
                MemberwithdrawalNotice.SetRange(Status, MemberwithdrawalNotice.Status::Approved);
                if MemberwithdrawalNotice.FindFirst() then begin
                    Validate("Member No.", MemberwithdrawalNotice."Member No.");
                    Validate("Closure Type", MemberwithdrawalNotice."Notice Type");
                    Validate("% of Refunds", MemberwithdrawalNotice.Percentage);
                    Validate("TSC Clearance", MemberwithdrawalNotice."Employer Liability");
                    validate("Loans Option", rec."Loans Option"::All);
                    if rec."Closure Type" <> rec."Closure Type"::"Withdrawal - Normal" then
                        validate("Partial Deposit Refundable", MemberwithdrawalNotice."Amount To Refund");
                    rec.validate("Early Withdrawal", MemberwithdrawalNotice."Early Withdrawal");
                    UpdateClosureCharges();
                    UpdateDepositRefundable();
                end
                else
                    Error('The record is not Approved');

            end;
        }
        field(24; "Maturity Date"; Date)
        {
        }
        field(25; "Premature Charges"; Decimal)
        {
            Editable = false;
        }
        field(26; "WithDrawal Charge"; Decimal)
        {
        }
        field(27; "% of Refunds"; Decimal)
        {
            Editable = false;
            MinValue = 0;
            MaxValue = 100;
            trigger OnValidate()
            var
                ErrRefunds: Label 'The maximum % of refunds cannot exceed %1';
                ErrApplicationType: Label 'This option is only applicable to partial Withdrawal!';
                IsPartialWithDrawal: Boolean;
            begin

                IsPartialWithDrawal := ("Closure Type" = "Closure Type"::"Withdrawal - 1st Partial")
                or ("Closure Type" = "Closure Type"::"Withdrawal - 2nd Partial");

                if ("Closure Type" = "Closure Type"::"Withdrawal - 1st Partial") then begin
                    GenSetup.Get();
                    GenSetup.TestField("Max 1st Partial Withdrawal %");
                    if "% of Refunds" > GenSetup."Max 1st Partial Withdrawal %" then
                        Error(ErrRefunds, GenSetup."Max 1st Partial Withdrawal %");
                end;

                // if IsPartialWithDrawal then
                //     "Partial Deposit Refundable" := Round(("Deposit Refundable" * 0.01 * "% of Refunds"), 0.01, '<')
                // else
                //     "Partial Deposit Refundable" := Rec."Deposit Refundable";
            end;
        }
        field(28; "Partial Deposit Refundable"; Decimal)
        {

            Editable = false;
            trigger OnValidate()
            begin
                /*if "Closure Type" <> "Closure Type"::"Withdrawal - 1st Partial" then
                    Error('This is only application to partial Withdrawal');
                if "Deposit Refundable" > 0 then
                    "% of Refunds" := "Partial Deposit Refundable" / "Deposit Refundable" * 100 else
                    "% of Refunds" := 0;
                if "% of Refunds" > 50 then begin
                    if not Confirm('this amount would exceed 50 % , do you wish to continue?') then Error('Process Terminated');
                end;
                if "Partial Deposit Refundable" > "Deposit Refundable" then Error('Partial Withdrawal should not exceed %1', "Deposit Refundable");
               */
            end;
        }
        field(29; "Staff No."; Code[15])
        {
            Editable = false;
        }
        field(30; "Early Withdrawal"; Boolean)
        {
            trigger OnValidate()
            begin
                if rec."Early Withdrawal" then begin
                    UpdateClosureCharges();
                    UpdateDepositRefundable();
                end;
            end;
        }
        field(31; "TSC Clearance"; Decimal)
        {
            Caption = 'Other Liability';
            trigger OnValidate()
            var
                TSCClearance: Label 'TSC Clearance applies to normal & 2nd partial withdrawal only';
            begin
                //if xRec."TSC Clearance" <> Rec."TSC Clearance" then begin
                // if "Closure Type" in ["Closure Type"::"Withdrawal - 1st Partial", Rec."Closure Type"::" "] then
                //     Error(TSCClearance); 
                //******Dan Commented*******
                UpdateDepositRefundable();
                //end;

            end;
        }
        field(32; "TSC Clearance Account"; Code[20])
        {
            Caption = 'Other Liability Account';
            TableRelation = Customer."No." where("Account Type" = CONST(Employer));
        }
        field(33; "Fosa Loans"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Bosa Loans"; Decimal)
        {
            Editable = false;
        }
        field(35; "Business Loans"; Decimal)
        {
            Editable = false;
        }
        field(36; "HR Loans"; Decimal)
        {
            Editable = false;
        }
        field(37; "Primary Identification Type"; Enum "Identification Type")
        {
            Editable = false;
        }
        field(38; "Closure Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
            // trigger OnValidate()
            // var
            //     RespCenter: text[50];
            // begin
            //     if Rec."Send/Forward to" <> '' then begin
            //         RespCenter := Rec."Send/Forward to";
            //         if RespCenter.Contains('FOSA') then
            //             if not RespCenter.Contains('300') then
            //                 error('You can only forward to FOSA HQ-(FOSA300)');
            //     end;
            // end;
        }

        field(40; "Originating Department"; Code[50])
        {
            Editable = false;
        }
        field(41; "Current Department"; Code[50])
        {
            Editable = false;
            TableRelation = "Responsibility CenterBR";
        }
        field(42; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Date Approved"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "closure time"; time)
        {

        }
        field(77; "SLA"; Duration)
        {
            Editable = false;
        }
        field(78; "Employer Code"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Employer Code" where("No." = field("Member No.")));
            Editable = false;
        }
        field(79; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No.")));
        }
        field(80; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No.")));
        }
        field(81; "Reason for withdrawal"; Text[250])
        {
            TableRelation = "Withdrawal Reason".Description;
            FieldClass = FlowField;
            CalcFormula = lookup("Member withdrawal Notice"."Reason for withdrawal" where("No." = field("Notice Number")));
        }
        field(82; Digit; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("User Tasks".Digit where("Record ID" = field("No.")));
        }
        field(83; "Previous Department"; Code[50])
        {
            Editable = false;
        }
        field(84; "Checked By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(85; "Date Time Checked"; DateTime)
        {
            Editable = false;
        }
        field(86; Updated; Boolean)
        {
            Editable = false;
        }
        field(87; "Updated DateTime"; DateTime)
        {
            Editable = false;
        }
        field(88; "Amount to refund"; Date)
        {
            Editable = false;
        }
        field(89; "SMS Charge"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = CONST("SMS Charge"));
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

    trigger OnDelete()
    begin
        if Status <> Status::Open then
            Error(Txt0000);
    end;

    trigger OnInsert()

    begin
        if "Closure Type" = Rec."Closure Type"::"Withdrawal - Normal" then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Normal Closure Nos.");
            NoSeriesMgt.InitSeries(NoSetup."Normal Closure Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        if ("Closure Type" = Rec."Closure Type"::"Withdrawal - 1st Partial") or ("Closure Type" = Rec."Closure Type"::"Withdrawal - 2nd Partial") then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Pertial Closure Nos.");
            NoSeriesMgt.InitSeries(NoSetup."Pertial Closure Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        //"Date Entered":=TODAY;
        "Entered By" := UserId;
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst then begin
            UserSetup.TestField("Global Dimension 1 Code");
            UserSetup.TestField("Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            UserSetup.TestField("Responsibility Centre");
            "Originating Department" := UserSetup."Responsibility Centre";
            "Current Department" := UserSetup."Responsibility Centre";
            CFPage.InsertTracker("No.", "Originating Department", true, UserId, CurrentDateTime);
        end else
            Error('User must exist in user setup table');
        "Closing Date" := Today;
        "Loans Option" := "Loans Option"::All;

        // if Rec."Member No." <> '' then
        //     GlobalFunctions.AssignDigitCustodianTask(Rec."No.", Rec."Member No.", "Sub Module"::"Member Closure");
    end;

    var
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        NoSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Members: Record Members;
        AccLine: Record "Account Closure Line";
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        TotalSaving: Decimal;
        GenSetup: Record "General Set-Up";
        LoanTotal: Decimal;
        IntTotal: Decimal;
        Loans: Record Loans;
        LoansG: Decimal;
        LoanGuarantors: Record "Loan Guarantors and Security";
        Txt0000: Label 'You cannot delete when status is not open';
        BBF: Decimal;
        AccountClosureFee: Decimal;
        Amount: array[2] of Integer;
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
        Err001: Label 'This member has guranteed loan No %1';
        MemberwithdrawalNotice: Record "Member withdrawal Notice";
        ErrMemberNotFound: Label 'Member %1, has not been found!';
        Txt0001: Label 'Member notice for withdrwal will be on %1';
        Txt0002: Label 'This member has not placed any notice for withdrawal';
        Err0002: Label 'Loan No. %1 has been overpaid by %2 , Kindly reconcile so that you can continue';
        Err0003: Label 'Loan No. %1 interest has been overpaid by %2 , Kindly reconcile so that you can continue';
        Err0004: Label 'Date cannot be infuture ';
        Membershipclosure: Record "Membership closure";
        Err0005: Label 'Application for this member already Exist';
        NextofKIN: Record "Next of KIN";
        Err0006: Label 'Member does not have next of kin details';
        Counts: Integer;
        Err0007: Label 'Closure Type varies from Noitice Placed';
        AccountClosureLine: Record "Account Closure Line";
        MembersII: Record Members;
        RetereeDepError: Label 'Total Loan Balance exceeds Deposits';
        Err0008: Label 'Closure Type Normal withdrawal already exits for this member';
        UserSetup: Record "User Setup";
        GlobalFunctions: Codeunit "Global Functions";

    procedure UpdateClosureCharges(): Decimal;
    var
        GeneralSetUp: Record "General Set-Up";
        TransactionCharge: Decimal;
    begin
        GeneralSetUp.Get();
        "Closure Charges" := 0;
        if "Early Withdrawal" then begin
            GeneralSetUp.TestField(GeneralSetUp."Early Withdrawal Fee");
            TransactionCharge := GetTransactionCharge(GeneralSetUp."Early Withdrawal Fee", (rec."Member Savings" - ("Total Loan" + "Total Interest" + "TSC Clearance")));
            "Closure Charges" := TransactionCharge;
        end
        else
            "Closure Charges" := 0;
        //     "Closure Charges" := GeneralSetUp."Withdrawal Fee" + (GeneralSetUp."Withdrawal Fee" * 0.01 * GeneralSetUp."Excise Duty (%)");

        // if "Closure Type" in ["Closure Type"::"Withdrawal - 1st Partial",
        // "Closure Type"::"Withdrawal - 2nd Partial"] then begin

        // end;

    end;

    procedure GetPrematureCharge() TCharges: Decimal
    var
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        ChargeAmount: Decimal;
        GeneralSetUp: Record "General Set-Up";
    begin
        //*********************Premature Withdrawal
        GeneralSetUp.Get;
        TCharges := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("Member No.", "Member No.");
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
        if SavingsAccounts.Find('-') then begin
            SavingsAccounts.CalcFields("Balance (LCY)");
        end;
        MemberwithdrawalNotice.Reset;
        MemberwithdrawalNotice.SetRange(MemberwithdrawalNotice."Member No.", "Member No.");
        MemberwithdrawalNotice.SetRange(MemberwithdrawalNotice.Status, MemberwithdrawalNotice.Status::Approved);
        if MemberwithdrawalNotice.Find('+') then begin
            if MemberwithdrawalNotice."Maturity Date" > "Closing Date" then begin
                TransactionTypes.Reset;
                TransactionTypes.SetRange(TransactionTypes.Type, TransactionTypes.Type::"Member Withdrawal");
                TransactionTypes.SetRange(Code, GeneralSetUp."Withdrawal Notice Penalty");
                if TransactionTypes.Find('-') then begin

                    //Charges
                    //TCharges:=0;
                    //MESSAGE('%1',TransactionTypes.Code);
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransactionTypes.Code);
                    if TransactionCharges.Find('-') then begin
                        repeat
                            //MESSAGE('i');
                            ChargeAmount := 0;
                            if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                                ChargeAmount := (SavingsAccounts."Balance (LCY)" * TransactionCharges."Percentage of Amount") * 0.01
                            else
                                ChargeAmount := TransactionCharges."Charge Amount";

                            if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                if TariffDetails.Find('-') then begin
                                    repeat
                                        if (SavingsAccounts."Balance (LCY)" >= TariffDetails."Lower Limit") and (SavingsAccounts."Balance (LCY)" <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                ChargeAmount := SavingsAccounts."Balance (LCY)" * TariffDetails.Percentage * 0.01;
                                            end else begin
                                                ChargeAmount := TariffDetails."Charge Amount"
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;
                            /*
                            LineNo:=LineNo+10000;
                            AcctType:=AcctType::Savings;
                            TransType:=TransType::" ";

                            JournalPosting.PostJournal(Jtemplate,JBatch,LineNo,AcctType,"No.",
                            TransactionCharges.Description+ClosureAccounts."No.",ChargeAmount,SavingsAccounts."No.","Closing Date",BalAccType,
                            TransactionCharges."G/L Account",'',Dim1,Dim2,TransType,'','','',0,'',0);
                            */

                            //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                            if TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty" then begin
                                //Excise Duty

                                /*LineNo:=LineNo+10000;
                                AcctType:=AcctType::Savings;
                                TransType:=TransType::" ";

                                JournalPosting.PostJournal(Jtemplate,JBatch,LineNo,AcctType,"No.",
                                Txt0001+ClosureAccounts."No.",(ChargeAmount*GeneralSetUp."Excise Duty (%)")*0.01,SavingsAccounts."No.","Closing Date",BalAccType,
                                GeneralSetUp."Excise Duty G/L",'',Dim1,Dim2,TransType,'','','',0,'',0);*/

                                TCharges := (ChargeAmount * GeneralSetUp."Excise Duty (%)" * 0.01) + ChargeAmount + TCharges;

                            end;

                        until TransactionCharges.Next = 0;
                    end;
                end;

            end;
        end else begin
            //Charges

            TransactionTypes.Reset;
            TransactionTypes.SetRange(TransactionTypes.Type, TransactionTypes.Type::"Member Withdrawal");
            TransactionTypes.SetRange(Code, GeneralSetUp."Withdrawal Notice Penalty");
            if TransactionTypes.Find('-') then begin



            end;
            TCharges := 0;
            TransactionCharges.Reset;
            TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransactionTypes.Code);

            if TransactionCharges.Find('-') then begin
                repeat

                    ChargeAmount := 0;
                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                        ChargeAmount := (SavingsAccounts."Balance (LCY)" * TransactionCharges."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := TransactionCharges."Charge Amount";

                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                        if TariffDetails.Find('-') then begin
                            repeat
                                if (SavingsAccounts."Balance (LCY)" >= TariffDetails."Lower Limit") and (SavingsAccounts."Balance (LCY)" <= TariffDetails."Upper Limit") then begin
                                    if TariffDetails."Use Percentage" = true then begin
                                        ChargeAmount := SavingsAccounts."Balance (LCY)" * TariffDetails.Percentage * 0.01;
                                    end else begin
                                        ChargeAmount := TariffDetails."Charge Amount"
                                    end;
                                end;
                            until TariffDetails.Next = 0;
                        end;
                    end;

                    /*LineNo:=LineNo+10000;
                    AcctType:=AcctType::Savings;
                    TransType:=TransType::" ";

                    JournalPosting.PostJournal(Jtemplate,JBatch,LineNo,AcctType,"No.",
                    TransactionCharges.Description+ClosureAccounts."No.",ChargeAmount,SavingsAccounts."No.","Closing Date",BalAccType,
                    TransactionCharges."G/L Account",'',Dim1,Dim2,TransType,'','','',0,'',0);*/


                    //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                    if TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty" then begin
                        //Excise Duty

                        /*LineNo:=LineNo+10000;
                        AcctType:=AcctType::Savings;
                        TransType:=TransType::" ";

                        JournalPosting.PostJournal(Jtemplate,JBatch,LineNo,AcctType,"No.",
                        Txt0001+ClosureAccounts."No.",(ChargeAmount*GeneralSetUp."Excise Duty (%)")*0.01,SavingsAccounts."No.","Closing Date",BalAccType,
                        GeneralSetUp."Excise Duty G/L",'',Dim1,Dim2,TransType,'','','',0,'',0);*/

                        TCharges := TCharges + ChargeAmount + (ChargeAmount * GeneralSetUp."Excise Duty (%)" * 0.01);
                    end;
                until TransactionCharges.Next = 0;
            end;
        end;
        //^^
        // "Partial Deposit Refundable" := "Deposit Refundable" * 0.5;
        // if "Closure Type" = "Closure Type"::"Withdrawal - 1st Partial" then
        //   Validate("Partial Deposit Refundable");

    end;

    procedure ValidateGuarantor()
    begin

        if ("Closure Type" = "Closure Type"::"Withdrawal - Normal") or ("Closure Type" = "Closure Type"::"Withdrawal - 1st Partial") then begin
            SavingsAccounts.Reset;
            SavingsAccounts.SetRange("Member No.", "Member No.");
            SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
            if SavingsAccounts.Find('-') then begin
                LoanGuarantorsandSecurity.Reset;
                LoanGuarantorsandSecurity.SetRange("Savings Account No./Member No.", SavingsAccounts."No.");
                LoanGuarantorsandSecurity.SetRange(Substituted, false);
                LoanGuarantorsandSecurity.SetRange("Self Guarantee", false);
                if LoanGuarantorsandSecurity.Find('-') then begin
                    repeat
                        if LoanGuarantorsandSecurity."Member Guaranteed" <> LoanGuarantorsandSecurity."Member No" then begin
                            if Loans.Get(LoanGuarantorsandSecurity."Loan No") then begin
                                Loans.CalcFields("Outstanding Balance");
                                if Loans."Outstanding Balance" > 0 then
                                    Error(Err001, LoanGuarantorsandSecurity."Loan No");
                            end;
                        end;
                    until LoanGuarantorsandSecurity.Next = 0;
                end;

            end;
        end;
    end;


    procedure ValidateExistingMembershipClosureCount()
    begin
        Counts := 0;
        Membershipclosure.Reset;
        Membershipclosure.SetRange("Member No.", "Member No.");
        Membershipclosure.SetRange(Posted, false);
        Membershipclosure.SetFilter("No.", '<>%1', Rec."No.");
        Membershipclosure.SetFilter(Status, '<>%1&<>%2', Membershipclosure.Status::Rejected, Membershipclosure.Status::Cancelled);
        Counts := Membershipclosure.Count;

        if Counts > 0 then
            Error(Err0005);
    end;

    procedure GetLoanBalances()
    var
        LoanProduct: Record "Product Factory";
        LoansProcess: Codeunit "Loans Process";
    begin

        "Bosa Loans" := 0;
        "Fosa Loans" := 0;
        "Business Loans" := 0;
        "HR Loans" := 0;
        "Total Loan" := 0;
        "Total Interest" := 0;
        Loans.Reset;
        Loans.SetRange("Member No.", "Member No.");
        Loans.SetAutoCalcFields("Total Loan Balance", "Outstanding Balance", "Outstanding Interest", "Daily Interest");
        Loans.SetFilter("Total Loan Balance", '>0');
        if Loans.FindSet then
            repeat
                Loans.calcFields("Total Loan Balance", "Outstanding Balance", "Outstanding Interest", "Daily Interest");
                case Loans."Source Unit" of
                    Loans."Source Unit"::BOSA:
                        begin
                            "Bosa Loans" += Loans."Total Loan Balance";
                            "Total Loan" += Loans."Outstanding Balance";
                            "Total Interest" += Loans."Outstanding Interest" + Loans."Daily Interest";
                        end;
                    Loans."Source Unit"::FOSA:
                        begin
                            "Fosa Loans" += Loans."Total Loan Balance";
                            "Total Loan" += Loans."Outstanding Balance";
                            "Total Interest" += Loans."Outstanding Interest" + Loans."Daily Interest";
                        end;
                    Loans."Source Unit"::"BUSINESS LOANS":
                        begin
                            "Business Loans" += Loans."Total Loan Balance";
                            "Total Loan" += Loans."Outstanding Balance";
                            "Total Interest" += Loans."Outstanding Interest" + Loans."Daily Interest";
                        end;
                    Loans."Source Unit"::"HR LOANS":
                        begin
                            "HR Loans" += Loans."Total Loan Balance";
                            "Total Loan" += Loans."Outstanding Balance";
                            "Total Interest" += Loans."Outstanding Interest" + Loans."Daily Interest";
                        end;
                    else begin
                        "Total Loan" += Loans."Outstanding Balance";
                        "Total Interest" += Loans."Outstanding Interest" + Loans."Daily Interest";
                    end;

                end;
            until Loans.Next() = 0;
    end;

    procedure ValidateWithDrawalNotice()
    begin
        case "Closure Type" of
            "Closure Type"::"Withdrawal - Normal":
                begin

                    MemberwithdrawalNotice.Reset;
                    MemberwithdrawalNotice.SetRange("Member No.", "Member No.");
                    MemberwithdrawalNotice.SetRange("No.", "Notice Number");
                    MemberwithdrawalNotice.SetRange(Status, MemberwithdrawalNotice.Status::Approved);
                    if MemberwithdrawalNotice.Find('+') then begin
                        if MemberwithdrawalNotice."Maturity Date" > Today then
                            Message(Txt0001, MemberwithdrawalNotice."Maturity Date");
                        "Maturity Date" := MemberwithdrawalNotice."Maturity Date";
                        //"Notice Number" := MemberwithdrawalNotice."No.";
                        "Early Withdrawal" := MemberwithdrawalNotice."Early Withdrawal";
                    end else
                        Message(Txt0002);

                end;
        end;
    end;

    procedure ClearClosureLines()
    begin
        AccountClosureLine.Reset;
        AccountClosureLine.SetRange("No.", Rec."No.");
        if AccountClosureLine.Find('-') then begin
            AccountClosureLine.DeleteAll;
        end;
    end;

    procedure ValidateOverPaidLoans()
    begin
        Loans.Reset;
        Loans.SetRange("Member No.", "Member No.");
        Loans.SetFilter("Outstanding Balance", '<0');
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields("Outstanding Balance");
                Error(Err0002, Loans."Loan No.", Loans."Outstanding Balance");
            until Loans.Next = 0;
        end;

        Loans.Reset;
        Loans.SetRange("Member No.", "Member No.");
        Loans.SetFilter("Outstanding Interest", '<0');
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields("Outstanding Interest");
                Error(Err0003, Loans."Loan No.", Loans."Outstanding Interest");
            until Loans.Next = 0;
        end;

    end;

    procedure ValidateSelectedClosureType()
    var
        MemberLoanBalance: Decimal;
        MemberDeposits: Decimal;
        MembClosureExists: Label 'An unprocessed membership closure %1 exists for the member, please rectify before proceeding!';
    begin
        Membershipclosure.Reset;
        Membershipclosure.SetRange("Member No.", "Member No.");
        Membershipclosure.SetRange(Membershipclosure."Closure Type", "Closure Type");
        Membershipclosure.setfilter(Membershipclosure."No.", '<>%1', Rec."No.");
        Membershipclosure.SetRange(Posted, false);
        Membershipclosure.SetFilter(Status, '%1|%2|%3', Membershipclosure.Status::Open,
        Membershipclosure.Status::Pending, Membershipclosure.Status::Approved);
        if Membershipclosure.FindLast() then
            Error(MembClosureExists, Membershipclosure."No.");

        GenSetup.Get;

        LoanGuarantors.Reset;
        LoanGuarantors.SetRange("Member No", Rec."Member No.");
        LoanGuarantors.SetRange(Substituted, false);
        LoanGuarantors.SetRange("Self Guarantee", false);
        LoanGuarantors.SetFilter("Outstanding Balance", '>0');
        if LoanGuarantors.FindFirst then begin
            if LoanGuarantors."Member Guaranteed" <> LoanGuarantors."Member No" then
                Message(Err001, LoanGuarantors."Loan No");
        end;

        //check if Loans are more than Deposits
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Member No.");
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
        if SavingsAccounts.Find('-') then begin
            SavingsAccounts.CalcFields("Balance (LCY)");
            MemberDeposits := SavingsAccounts."Balance (LCY)";
        end;

        Loans.Reset;
        Loans.SetRange("Member No.", Rec."Member No.");
        Loans.SetFilter("Total Loan Balance", '>%1', 0);
        if Loans.FindSet() then
            repeat
                Loans.CalcFields("Total Loan Balance");
                MemberLoanBalance += Loans."Total Loan Balance";
            until Loans.Next() = 0;

        if MemberLoanBalance > MemberDeposits then
            Error(RetereeDepError);

        //check if Unllocated account has a balance
        ClearUnAllocatedFunds();

        MemberwithdrawalNotice.Reset;
        MemberwithdrawalNotice.SetRange("Member No.", Rec."Member No.");
        MemberwithdrawalNotice.SetRange("No.", "Notice Number");
        MemberwithdrawalNotice.SetRange(MemberwithdrawalNotice.Status, MemberwithdrawalNotice.Status::Approved);
        if MemberwithdrawalNotice.Find('-') then
            if Rec."Closure Type" <> MemberwithdrawalNotice."Notice Type" then
                Error(Err0007);

        "Loans Option" := "Loans Option"::All;
        "Close Account" := "Close Account"::All;
        if "Closure Type" = "Closure Type"::"Withdrawal - 1st Partial" then begin
            "Loans Option" := "Loans Option"::All;
            // "Close Account" := "Close Account"::Specific; Dan said hakuna kitu kama hii
        end;

        Validate("Loans Option");
        Validate("Close Account");

    end;

    procedure ClearUnAllocatedFunds()
    begin
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("Member No.", Members."No.");
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Unallocated Fund");
        if SavingsAccounts.Find('-') then begin
            SavingsAccounts.CalcFields("Balance (LCY)");
            if SavingsAccounts."Balance (LCY)" > 0 then
                Error('Kindly clear the balance of %1 in Unllocated account', SavingsAccounts."Balance (LCY)");
        end;
    end;

    procedure "Has1stPartial"(): Boolean
    var
        MembershipClosure: Record "Membership Closure";
    begin
        MembershipClosure.Reset();
        MembershipClosure.SetRange("Closure Type", MembershipClosure."Closure Type"::"Withdrawal - 1st Partial");
        MembershipClosure.SetRange("Member No.", "Member No.");
        MembershipClosure.setfilter(Status, '<>%1', MembershipClosure.Status::Cancelled);
        MembershipClosure.SetRange(Posted, true);
        exit(MembershipClosure.FindLast());
    end;

    procedure "CheckIf2ndClosureIsValid"()
    var
        MembershipClosure: Record "Membership Closure";
        ErrPartial: Label 'There is no any Withdrawal 1st partial record that exists in the System, process the 1st Partial before proceeding to 2nd Partial!';
    begin
        if Rec."Closure Type" = Rec."Closure Type"::"Withdrawal - 2nd Partial" then
            if not "Has1stPartial" then
                Error(ErrPartial);
    end;

    procedure "CheckIf1stClosureIsValid"()
    var
        Err_Partial: Label 'An existing posted 1st partial membership closure no %1 already exists in the system!';
    begin
        if Rec."Closure Type" = Rec."Closure Type"::"Withdrawal - 1st Partial" then
            if "Has1stPartial" then
                Error(Err_Partial, MembershipClosure."No.");
    end;

    [Scope('OnPrem')]
    procedure LoanOpt()
    begin
        GenSetup.Get;

        if "Closure Type" = "Closure Type"::"Withdrawal - 1st Partial" then begin
            LoansG := 0;
            LoanGuarantors.Reset;
            LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No.");
            if LoanGuarantors.Find('-') then begin

                repeat
                    if Loans.Get(LoanGuarantors."Loan No") then begin
                        Loans.CalcFields(Loans."Outstanding Balance", "Total Loan Balance");
                        if Loans."Total Loan Balance" > 0 then begin
                            LoansG += 1;
                        end;
                    end;
                until LoanGuarantors.Next = 0;

                /*IF LoansG>0 THEN
                   ERROR('Member is Guaranteeing %1 Active Loans',LoansG);*/
            end;

            //VALIDATE("Close Account");
            IntTotal := 0;
            LoanTotal := 0;

            Loans.Reset;
            Loans.SetRange(Loans."Member No.", "Member No.");
            Loans.SetRange(Loans.Posted, true);
            Loans.SetFilter(Loans."Total Loan Balance", '>0');
            if Loans.Find('-') then begin
                repeat
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", "Total Loan Balance");
                    IntTotal := IntTotal + Loans."Outstanding Interest";
                    LoanTotal := LoanTotal + Loans."Outstanding Balance";
                until Loans.Next = 0;
            end;
            "Total Loan" := LoanTotal;
            "Total Interest" := IntTotal;
        end else begin
            if ("Member Savings" - (LoanTotal + IntTotal)) < 0 then
                "Deposit Refundable" := 0
            else
                "Deposit Refundable" := "Member Savings" - (LoanTotal + IntTotal + "Closure Charges"/* + "Premature Charges"*/);
            //"WithDrawal Charge" := "Deposit Refundable" * 0.01;
        end;
        // IF "Total Loan"+"Total Interest">0 THEN ERROR('The member should settle the loans totalling %1 first',("Total Interest"+"Total Loan"));

    end;

    procedure GetTransactionCharge(TransactionCode: Code[20]; TotalAmount: Decimal): Decimal
    var
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
    begin
        GenSetup.Get();
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransactionCode);
        if TransactionCharges.Find('-') then begin
            repeat
                ChargeAmount := 0;
                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::Normal) or
                (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::"Stamp Duty") then begin

                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                        ChargeAmount := (TotalAmount * TransactionCharges."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := TransactionCharges."Charge Amount";

                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                        if TariffDetails.Find('-') then begin
                            repeat
                                if (TotalAmount >= TariffDetails."Lower Limit") and (TotalAmount <= TariffDetails."Upper Limit") then begin
                                    if TariffDetails."Use Percentage" = true then begin
                                        ChargeAmount := TotalAmount * TariffDetails.Percentage * 0.01;
                                    end else begin
                                        ChargeAmount := TariffDetails."Charge Amount";
                                    end;
                                end;
                            until TariffDetails.Next = 0;
                        end;
                    end;


                    TChargeAmount := TChargeAmount + ChargeAmount;

                    if TransactionCharges."Recover Excise Duty" then
                        TChargeAmount := TChargeAmount + (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                end;
            until TransactionCharges.Next = 0;
        end;
        exit(TChargeAmount);
    end;

    procedure MarkNoticeAsFinalized()
    var
        MemberwithdrawalNotice: Record "Member withdrawal Notice";
    begin
        MemberwithdrawalNotice.Reset();
        MemberwithdrawalNotice.SetRange("No.", "Notice Number");
        if MemberwithdrawalNotice.FindFirst() then begin

            if Rec.Posted then begin
                Rec.Status := Rec.Status::Approved;
                Rec.Modify;
            end;

            MemberwithdrawalNotice.Status := MemberwithdrawalNotice.Status::Approved;
            MemberwithdrawalNotice."Notice Finalized" := true;
            MemberwithdrawalNotice."DateTime Finalized" := CurrentDateTime;
            MemberwithdrawalNotice."Finalized By" := UserId;
            MemberwithdrawalNotice.Modify(true);
        end;
    end;

    procedure UpdateDepositRefundable()
    var
        AccClosureLn: Record "Account Closure Line";
        Sav: Record "Savings Accounts";
        AccountClosureFee: Decimal;
        ProductFactory: Record "Product Factory";
        TotalSaving: Decimal;
    begin
        //rec.TestField("Closure Charges");
        "Deposit Refundable" := 0;
        AccClosureLn.Reset();
        AccClosureLn.SetRange("No.", Rec."No.");
        AccClosureLn.SetRange(Close, true);
        if AccClosureLn.FindSet() then
            repeat
                Sav.Get(AccClosureLn."Account No.");
                Sav.CalcFields("Balance (LCY)");
                ProductFactory.Get(Sav."Product Type");
                // AccountClosureFee := GetTransactionCharge(ProductFactory."Closure Fee");
                TotalSaving := TotalSaving + (Sav."Balance (LCY)" - AccountClosureFee);
            until AccClosureLn.Next() = 0;

        "Member Savings" := TotalSaving;
        if ("Member Savings" - ("Total Loan" + "Closure Charges" + "Total Interest"/* + "Premature Charges"*/ + "TSC Clearance")) < 0 then
            "Deposit Refundable" := 0
        else
            "Deposit Refundable" := "Member Savings" - ("Total Loan" + "Closure Charges" + "Total Interest" + /*GenSetup."Withdrawal Fee" + "Premature Charges"*/ +"TSC Clearance");

        // if rec."Closure Type" <> rec."Closure Type"::"Withdrawal - Normal" then
        //     rec.Validate("Notice Number")
        // else
        //     "Partial Deposit Refundable" := 0;
        //if Rec."Closure Type" = Rec.C

    end;



    procedure UpdateTotalLoanBalancesOld()
    begin
        /*if "Loans Option" = "Loans Option"::"Long Term" then begin
            LoansG := 0;
            LoanGuarantors.Reset;
            LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No.");
            if LoanGuarantors.Find('-') then begin

                repeat
                    if Loans.Get(LoanGuarantors."Loan No") then begin
                        Loans.CalcFields(Loans."Outstanding Balance", "Total Loan Balance");
                        if Loans."Total Loan Balance" > 0 then begin
                            LoansG += 1;
                        end;
                    end;
                until LoanGuarantors.Next = 0;
                /*
                IF LoansG>0 THEN
                   ERROR('Member is Guaranteeing %1 Active Loans',LoansG);*/
        /*end;
                IntTotal := 0;
                LoanTotal := 0;

                Loans.Reset;
                Loans.SetRange(Loans."Member No.", "Member No.");
                Loans.SetRange(Loans.Posted, true);
                Loans.SetFilter(Loans."Total Loan Balance", '>0');
                Loans.SetRange(Loans."Loan Span", Loans."Loan Span"::"Major");
                if Loans.Find('-') then begin
                    repeat
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", "Total Loan Balance");
                        IntTotal := IntTotal + Loans."Outstanding Interest";
                        LoanTotal := LoanTotal + Loans."Outstanding Balance";
                    until Loans.Next = 0;
                end;
                "Total Loan" := LoanTotal;
                "Total Interest" := IntTotal;
            end else
                if "Loans Option" = "Loans Option"::"Short Term" then begin
                    LoansG := 0;
                    LoanGuarantors.Reset;
                    LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No.");
                    if LoanGuarantors.Find('-') then begin

                        repeat
                            if Loans.Get(LoanGuarantors."Loan No") then begin
                                Loans.CalcFields(Loans."Outstanding Balance", "Total Loan Balance");
                                if Loans."Outstanding Balance" > 0 then begin
                                    LoansG += 1;
                                end;
                            end;
                        until LoanGuarantors.Next = 0;

                        /*IF LoansG>0 THEN
                           ERROR('Member is Guaranteeing %1 Active Loans',LoansG);*/
        /*end;

                    //VALIDATE("Close Account");
                    IntTotal := 0;
                    LoanTotal := 0;

                    Loans.Reset;
                    Loans.SetRange(Loans."Member No.", "Member No.");
                    Loans.SetRange(Loans.Posted, true);
                    Loans.SetRange(Loans."Loan Span", Loans."Loan Span"::"minor");
                    Loans.SetFilter(Loans."Total Loan Balance", '>0');
                    if Loans.Find('-') then begin
                        repeat
                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", "Total Loan Balance");
                            IntTotal := IntTotal + Loans."Outstanding Interest";
                            LoanTotal := LoanTotal + Loans."Outstanding Balance";
                        until Loans.Next = 0;
                    end;


                    "Total Loan" := LoanTotal;
                    "Total Interest" := IntTotal;

                end else
                    if "Loans Option" = "Loans Option"::All then begin
                        LoansG := 0;
                        LoanGuarantors.Reset;
                        LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No.");
                        if LoanGuarantors.Find('-') then begin

                            repeat
                                if Loans.Get(LoanGuarantors."Loan No") then begin
                                    Loans.CalcFields(Loans."Outstanding Balance", "Total Loan Balance");
                                    if Loans."Total Loan Balance" > 0 then begin
                                        LoansG += 1;
                                    end;
                                end;
                            until LoanGuarantors.Next = 0;

                            /*IF LoansG>0 THEN
                               ERROR('Member is Guaranteeing %1 Active Loans',LoansG);*/
        /*              end;

                      //VALIDATE("Close Account");
                      IntTotal := 0;
                      LoanTotal := 0;

                      Loans.Reset;
                      Loans.SetRange(Loans."Member No.", "Member No.");
                      Loans.SetRange(Loans.Posted, true);
                      Loans.SetFilter(Loans."Total Loan Balance", '>0');
                      if Loans.Find('-') then begin
                          repeat
                              Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", "Total Loan Balance");
                              IntTotal := IntTotal + Loans."Outstanding Interest";
                              LoanTotal := LoanTotal + Loans."Outstanding Balance";
                          until Loans.Next = 0;
                      end;
                      "Total Loan" := LoanTotal;
                      "Total Interest" := IntTotal;
                  end else begin
                      "Total Loan" := 0;
                      "Total Interest" := 0;
                  end;*/

    end;

}

