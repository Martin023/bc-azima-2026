table 52185827 "Loan Guarantors Sub"
{
    DrilldownPageid = "Loan Guarantors substition Ln";

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Loans."Loan No.";
        }
        field(2; "Member No"; Code[20])
        {
            Editable = false;
            NotBlank = false;

            trigger OnValidate()
            begin

                GHeader.Reset;
                GHeader.SetRange(GHeader."No.", "No.");
                if GHeader.Find('-') then begin
                    if LoanApp.Get(GHeader."Loan No.") then begin
                        //Check status - sasra
                        LoanApp.CalcFields("Loans Category-SASRA");
                        if LoanApp."Loans Category-SASRA".AsInteger() > GenSetUp."Allowed Loan Categories".AsInteger() then
                            Message(Text012, LoanApp."Loans Category-SASRA");
                    end;
                end;

                if CreditAccounts.Get("Member No") then begin
                    "Loan No" := Lno;
                    "Member No" := CreditAccounts."No.";
                    Name := CreditAccounts.Name;
                    "ID No." := CreditAccounts."ID No.";
                    "Staff/Payroll No." := CreditAccounts."Payroll/Staff No.";
                end;
            end;
        }
        field(3; Name; Text[200])
        {
            Editable = false;
        }
        field(4; "Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(5; Shares; Decimal)
        {
            Editable = false;
        }
        field(6; "No Of Loans Guaranteed"; Integer)
        {
            Editable = false;
        }
        field(7; Substituted; Boolean)
        {

            trigger OnValidate()
            var
                SaVingAc: Record "Savings Accounts";
                GuarDeps: Decimal;
                PercentageGur: Decimal;
                CountNo: Integer;
                Gusub: Record "Loan Guarantors Sub";
                SubstitutePresent: Boolean;
                GCou: Integer;
                LGc: Integer;
            begin
                "Amount Guaranteed" := 0;

                if Substituted = true then begin
                    if Rec."Guarantor Type" = Rec."Guarantor Type"::Guarantor then begin
                        Rec."Amount Guaranteed" := 0;
                        Gusub.Reset();
                        Gusub.SetRange("Member Substituted", Rec."Savings Account No.");
                        Gusub.SetRange(inserted, true);
                        if not Gusub.Find('-') then
                            Error('kindly add Member substitute');
                    end;
                    if Rec."Guarantor Type" = Rec."Guarantor Type"::Collateral then begin
                        Rec."Amount Guaranteed" := 0;
                        Gusub.Reset();
                        Gusub.SetRange("Collateral Reg. No.", Rec."Member Substituted");
                        Gusub.SetRange(inserted, true);
                        if not Gusub.Find('-') then
                            Error('kindly add Collateral to substitute');
                    end;

                end
                else begin
                    SaVingAc.Reset();
                    SaVingAc.SetRange("No.", Rec."Savings Account No.");
                    SaVingAc.SetRange("Product Category", SaVingAc."Product Category"::"BOSA Deposits");
                    if SaVingAc.FindFirst() then begin
                        SaVingAc.CalcFields(Balance);
                        GuarDeps := SaVingAc.Balance;
                    end;
                    TotaAmtGUR := 0;
                    LoanGua.Reset;
                    LoanGua.SetRange("Loan No", "Loan No");
                    // LoanGua.SetRange("Guarantor Type", LoanGua."guarantor type"::Guarantor);
                    if LoanGua.Find('-') then begin
                        CountNo := LoanGua.Count;
                        LoanGua.CalcSums("Amount Guaranteed");
                        TotaAmtGUR := LoanGua."Amount Guaranteed";
                    end;
                    if ProductFactory.Get(Loans."Loan Product Type") then
                        if CountNo < ProductFactory."Minimum Guarantors" then
                            GuarantorMax := true;
                    if (Loans."Approved Amount" > ProductFactory."Max Amt on Guarantors") and (CountNo < (ProductFactory."Minimum Guarantors on Max Amt")) then
                        GuarantorMax := true;
                    if TotaAmtGUR <> 0 then begin
                        PercentageGur := Round((((GuarDeps / TotaAmtGUR) * 100)), 0.01, '=');
                    end;
                    Rec."Amount Guaranteed" := Round(((Loans."Requested Amount" * PercentageGur / 100)), 0.01, '=');
                end;
            end;
        }
        field(8; Date; Date)
        {
        }
        field(9; "Shares Recovery"; Boolean)
        {
        }
        field(10; "New Upload"; Boolean)
        {
        }
        field(11; "Amount Guaranteed"; Decimal)
        {
        }
        field(12; "Staff/Payroll No."; Code[20])
        {
        }
        field(14; "Self Guarantee"; Boolean)
        {
        }
        field(15; "ID No."; Code[50])
        {
        }
        field(16; "Outstanding Balance"; Decimal)
        {
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Transaction Type" = FILTER(Loan | Repayment),
                                                                  "Loan No" = FIELD("Loan No")));
            FieldClass = FlowField;
        }
        field(17; "Member Guaranteed"; Code[50])
        {
        }
        field(18; "Group Account No."; Code[50])
        {
        }
        field(19; "Loan Product Type"; Code[20])
        {
        }
        field(20; "No."; Code[20])
        {
        }
        field(21; "Line No."; Code[10])
        {
        }
        field(25; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(22; "Savings Account No."; Code[20])
        {
            TableRelation = IF ("Guarantor Type" = CONST(Guarantor)) "Savings Accounts"."No." WHERE("Product Category" = CONST("BOSA Deposits"), Status = FILTER(Active | Dormant))
            // TableRelation = IF ("Guarantor Type" = CONST(Guarantor)) "Savings Accounts"."No." WHERE("Can Guarantee Loan" = const(true), "Product Type" = CONST('1'), Status = FILTER(Active | Dormant))//added product type and statuS
            // TableRelation = IF ("Guarantor Type" = CONST(Guarantor)) "Savings Accounts"."No." WHERE(Status = const(Active))// for my own testing purpos


            ELSE
            IF ("Guarantor Type" = CONST(Collateral)) Members."No." where(Status = filter(Active))
            ELSE
            IF ("Guarantor Type" = FILTER(Lien)) "Savings Accounts"."No." WHERE("Lien Placed" = FILTER(<> 0));
            trigger OnValidate()
            var
                Membersrec: Record Members;
                SaVingAc: Record "Savings Accounts";
                Employer: Record Customer;
                LoanGar: Record "Loan Guarantors Sub";
                IncomingGs: Record "Loan Guarantors Sub";
                GuarDeps: Decimal;
                PercentageGur: Decimal;
                CountNo: Integer;
                MemberCode: code[30];
                NoofMajor: Integer;
                NoofMiner: Integer;
                TheLoans: Record Loans;
                MajorLoans: Integer;
                MinorLoans: Integer;
                maxamountguarantee: Decimal;
            begin
                GenSetUp.Get;

                "Self Guarantee" := false;
                SelfGuaranteedA := 0;
                Date := Today;
                if "Guarantor Type" <> Rec."Guarantor Type"::Collateral then begin
                    //Check redudant incoming GS
                    IncomingGs.Reset();
                    IncomingGs.SetRange("Savings Account No.", Rec."Savings Account No.");
                    IncomingGs.SetRange("Loan No", Rec."Loan No");
                    IncomingGs.SetFilter("Entry No", '<>%1', Rec."Entry No");
                    if IncomingGs.Find('-') then begin
                        CountNo := IncomingGs.Count;
                        Message(Format(CountNo));
                        if CountNo > 0 then
                            Error('Member already exist');
                    end;



                    //Set Member Guarantee..REVIEW
                    LoanGar.Reset();
                    LoanGar.SetRange(LoanGar."Loan No", rec."Loan No");
                    LoanGar.SetRange(LoanGar."Savings Account No.", Rec."Savings Account No.");
                    if LoanGar.Find('-') then
                        Error('Member already exist!')
                    else
                        Rec.inserted := true;
                    if LoansR.Get("Loan No") then
                        "Member Guaranteed" := LoansR."Member No.";
                    SaVingAc.Reset();
                    SaVingAc.SetRange("No.", Rec."Savings Account No.");
                    if SaVingAc.FindFirst() then begin
                        Membersrec.Reset();
                        Membersrec.SetRange("No.", SaVingAc."Member No.");
                        if Membersrec.Find('-') then begin
                            if (Membersrec.Subflag <> Membersrec.Subflag::Rejoined) and (Membersrec.Subflag <> Membersrec.Subflag::"First time") and (Membersrec.Subflag <> Membersrec.Subflag::"Partial withdrawn") then
                                Error('The member %1 with status  %2 is not allowed to Guarantee', Membersrec.Name, Membersrec.Subflag);
                        end;
                        if Employer.Get(SaVingAc."Employer Code") then begin
                            if Employer."Internal Staff Employer" = true then begin
                                Error(Employer."Employer Code" + ' are not allowed to guarantee');
                            end;
                        end;
                    end;
                    SaVingAc.Reset();
                    SaVingAc.SetRange(SaVingAc."No.", Rec."Savings Account No.");
                    if SaVingAc.FindFirst() then begin
                        SaVingAc.CalcFields(SaVingAc.Balance);
                        if SaVingAc.Balance <= 0 then begin
                            Error('Member %1 has no deposits', Savingac.Name);
                        end;
                    end;
                    //Amount Guarantee
                    MemberCode := '';
                    SaVingAc.Reset();
                    SaVingAc.SetRange("No.", Rec."Savings Account No.");
                    SaVingAc.SetRange("Product Category", SaVingAc."Product Category"::"BOSA Deposits");
                    if SaVingAc.FindFirst() then begin
                        SaVingAc.CalcFields(Balance);
                        GuarDeps := SaVingAc.Balance;
                        // "Amount Guaranteed" := GuarDeps;
                        MemberCode := SaVingAc."Member No.";
                    end;
                    TotaAmtGUR := 0;
                    LoanGua.Reset;
                    LoanGua.SetRange("Loan No", "Loan No");
                    LoanGua.SetRange(LoanGua."Member No", MemberCode);
                    if LoanGua.Find('-') then begin
                        CountNo := LoanGua.Count;
                        LoanGua.CalcSums("Amount Guaranteed");
                        TotaAmtGUR := LoanGua."Amount Guaranteed";
                    end;
                    if ProductFactory.Get(Loans."Loan Product Type") then
                        if CountNo < ProductFactory."Minimum Guarantors" then
                            GuarantorMax := true;
                    if (Loans."Approved Amount" > ProductFactory."Max Amt on Guarantors") and (CountNo < (ProductFactory."Minimum Guarantors on Max Amt")) then
                        GuarantorMax := true;
                    if TotaAmtGUR <> 0 then begin
                        PercentageGur := Round((((GuarDeps / TotaAmtGUR) * 100)), 0.01, '=');
                        Rec."Amount Guaranteed" := Round(((Loans."Requested Amount" - TotaAmtGUR)), 0.01, '=');
                    end;
                    // Rec."Amount Guaranteed" := Round(((Loans."Requested Amount" * PercentageGur / 100)), 0.01, '=');

                    //AmountGuarantee
                    Image.Reset;
                    Image.SetRange(Image."ID Number", SavingsAccounts."ID No.");
                    if Image.Find('-') then begin
                        Image.CalcFields(Image.Signature);
                        //Signature:=Image.Signature;
                    end;
                    //Evaluate guarantor basic info
                    if SavingsAccounts.Get("Savings Account No.") then begin
                        if (SavingsAccounts.Status <> SavingsAccounts.Status::Active) and (SavingsAccounts.Status <> SavingsAccounts.Status::Dormant) then
                            Error(Txt0001, SavingsAccounts."No.");
                        // Error('', SavingsAccounts."No.");
                        SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");//Cust."Outstanding Balance",Cust."Current Deposit");
                        Name := SavingsAccounts.Name;
                        "Staff/Payroll No." := SavingsAccounts."Payroll/Staff No.";
                        //"Loan Balance":=Cust."Outstanding Balance";
                        Shares := SavingsAccounts."Balance (LCY)";
                        "ID No." := SavingsAccounts."ID No.";
                        "Member No" := SavingsAccounts."Member No.";


                        //Check if short long term loan and exclude FOSA shares in guarantorship
                        if Loans.Get("Loan No") then begin
                            Loans.CalcFields("Loan Span");
                            if (Loans."Loan Span" = Loans."Loan Span"::"Major") and (CreditAccounts."Loan Security Inclination" = CreditAccounts."Loan Security Inclination"::"Short Term Loan Security") then
                                Error('This security account is not meant for major loans');
                        end;
                    end;

                    LoansG := 0;
                    LoanGuarantors.Reset;
                    LoanGuarantors.SetRange(LoanGuarantors."Account No.", "Member No");
                    if LoanGuarantors.Find('-') then begin
                        repeat
                            if Loans.Get(LoanGuarantors."Loan No") then begin
                                Loans.CalcFields(Loans."Outstanding Balance");
                                if Loans."Outstanding Balance" > 0 then begin
                                    LoansG := LoansG + 1;
                                    //Evaluate Available Shares
                                    TotalGuaranteed += (LoanGuarantors.PercentageGur / 100) * Loans."Outstanding Balance";
                                    //END-Evaluate Available Shares

                                    if LoanGuarantors."Self Guarantee" = true then begin
                                        if LoansR.Get("Loan No") then begin
                                            if LoansR."Member No." <> "Savings Account No." then
                                                Message('Member has guaranteed self therefore can not guarantee another member.')
                                            else
                                                SelfGuaranteedA := SelfGuaranteedA + Loans."Outstanding Balance";
                                        end;
                                    end;
                                end;
                            end;
                        until LoanGuarantors.Next = 0;

                    end;
                    //changed
                    "No Of Loans Guaranteed" := LoansG;
                    MajorLoans := 0;
                    MinorLoans := 0;
                    //Unposted Loans
                    LoanGuar.Reset;
                    LoanGuar.SetRange("Savings Account No./Member No.", Rec."Savings Account No.");
                    if LoanGuar.Find('-') then begin
                        repeat
                            if TheLoans.Get(LoanGuar."Loan No") then begin
                                TheLoans.CalcFields("Loan Span");
                                if TheLoans.Posted = false then
                                    if TheLoans."Requested Amount" > 0 then
                                        if TheLoans.Status <> TheLoans.Status::Rejected then begin
                                            if TheLoans."Loan Span" = TheLoans."Loan Span"::Major then
                                                MajorLoans += 1;
                                            if TheLoans."Loan Span" = TheLoans."Loan Span"::Minor then
                                                MinorLoans += 1;
                                        end;
                            end;
                        until LoanGuar.Next = 0;
                    end;
                    NoofMiner := 0;
                    NoofMajor := 0;
                    //Posted Loans
                    LoanGuar.Reset;
                    LoanGuar.SetRange("Savings Account No./Member No.", Rec."Savings Account No.");
                    LoanGuar.SetFilter("Outstanding Balance", '>0');
                    if LoanGuar.Find('-') then begin
                        repeat
                            if TheLoans.Get(LoanGuar."Loan No") then begin
                                TheLoans.CalcFields("Loan Span");
                                if TheLoans."Loan Span" = TheLoans."Loan Span"::Major then
                                    NoofMajor += 1;
                                if TheLoans."Loan Span" = TheLoans."Loan Span"::Minor then
                                    NoofMiner += 1;
                                //MESSAGE('Loans gua %1 Counter %2 Loan No. %3',TotalGuaranteed,"No Of Loans Guaranteed",LoanGuar."Loan No");
                            end;
                        until LoanGuar.Next = 0;
                    end;
                    GenSetUp.Get;
                    if LoanApp.Get(Rec."Loan No") then begin
                        //to do: policy
                        maxamountguarantee := GenSetUp."Maximum Amount to Guarantee";
                        LoanGua.CalcFields(LoanGua."Total Guaranteed");
                        Totalguarantee := "Amount Guaranteed" + LoanGua."Total Guaranteed";
                        if Totalguarantee > maxamountguarantee then begin
                            Error('The total loans  guaranteed have reached the maximum allowable limit of KES ' + Format(GenSetUp."Maximum Amount to Guarantee") + '.');
                        end;
                        // LoanApp.CalcFields("Loan Span");

                        // if LoanApp."Loan Span" = LoanApp."Loan Span"::Major then begin
                        //     if LoanApp."Source Unit" <> LoanApp."Source Unit"::FOSA then begin
                        //         if NoofMajor + MajorLoans > GenSetUp."Max Major Loans To Guarantee" then begin
                        //             Error('No of major Loan will exceed %1, the current major Loans guaranteed is %2.', GenSetUp."Max Major Loans To Guarantee", NoofMajor);
                        //         end;
                        //     end;
                        // end else
                        //     if LoanApp."Loan Span" = LoanApp."Loan Span"::Minor then begin
                        //         if LoanApp."Source Unit" <> LoanApp."Source Unit"::FOSA then begin
                        //             if NoofMiner + MinorLoans > GenSetUp."Max Minor Loans To Guarantee" then begin
                        //                 Error('No of Minor Loan will exceed %1, the current Minor Loans guaranteed is %2.', GenSetUp."Max Minor Loans To Guarantee", NoofMiner);
                        //             end;
                        //         end;
                        //     end;
                    end;

                    "Member Guaranteed" := LoansR."Member No.";
                    GHeader.Reset;
                    GHeader.SetRange(GHeader."No.", "No.");
                    if GHeader.Find('-') then begin
                        Rec."Loan No" := GHeader."Loan No.";
                        "Member Guaranteed" := CopyStr(GHeader."Loan Account No.", 5);
                    end;
                end;
                GHeader.Reset;
                GHeader.SetRange(GHeader."No.", "No.");
                if GHeader.Find('-') then begin
                    Rec."Loan No" := GHeader."Loan No.";
                end;
                //Check If Self Guarantee
            end;
        }
        field(23; "SMS Sent"; Boolean)
        {
        }
        field(24; "Member Substituted"; Code[20])
        {
            //TableRelation = "Savings Accounts" WHERE("Can Guarantee Loan" = FILTER(true));
            TableRelation = IF ("Guarantor Type" = CONST(Guarantor)) "Loan Guarantors and Security"."Savings Account No./Member No." where("Loan No" = field("Loan No"), "Guarantor Type" = filter(Guarantor))

            ELSE
            IF ("Guarantor Type" = CONST(Collateral)) "Loan Guarantors and Security"."Collateral Reg. No." where("Loan No" = field("Loan No"), "Guarantor Type" = filter(Collateral))
            ELSE
            IF ("Guarantor Type" = FILTER(Lien)) "Loan Guarantors and Security"."Savings Account No./Member No." where("Loan No" = field("Loan No"), "Guarantor Type" = filter(Lien));
            trigger OnValidate()
            var
                IncomingGs: Record "Loan Guarantors Sub";
                LoanG: Record "Loan Guarantors and Security";
                Found2: Boolean;
                GsubLines: Record "Loan Guarantors Sub";
                TotaDeps: Decimal;
                Gdepos: Decimal;

            begin

                GsubLines.Reset();
                GsubLines.SetRange(GsubLines."Loan No", Rec."Loan No");
                GsubLines.SetRange(GsubLines."No.", Rec."No.");
                GsubLines.SetRange(GsubLines."Savings Account No.", Rec."Member Substituted");
                if GsubLines.Find('-') then
                    Gdepos := GsubLines.Shares;
                if Rec."Savings Account No." = Rec."Member Substituted" then
                    Error('you cannot do self Substitution');
                if "Guarantor Type" = "Guarantor Type"::Collateral then begin
                    if Rec."Collateral Reg. No." = "Member Substituted" then
                        Error('you cannot substitute the same collateral');
                end;
                GsubLines.Reset();
                GsubLines.SetRange(GsubLines."Loan No", Rec."Loan No");
                GsubLines.SetRange(GsubLines."No.", Rec."No.");
                GsubLines.SetRange(GsubLines."Member Substituted", Rec."Member Substituted");
                if GsubLines.Find('-') then begin
                    repeat
                        SavingsAccounts.Reset();
                        SavingsAccounts.SetRange("No.", GsubLines."Savings Account No.");
                        if SavingsAccounts.FindFirst() then begin
                            SavingsAccounts.CalcFields(Balance);
                            TotaDeps := TotaDeps + SavingsAccounts.Balance;
                        end;
                    until GsubLines.Next() = 0;
                end;
                // if TotaDeps < Gdepos then
                //     // Message('Kindly add more Guarantors');
                // GenSetUp.Get();
                // GHeader.Reset;
                // GHeader.SetRange(GHeader."No.", "No.");
                // if GHeader.Find('-') then begin
                //     LoanApp.Reset;
                //     LoanApp.SetRange("Loan No.", GHeader."Loan No.");
                //     if LoanApp.Find('-') then begin
                //         //Check status - sasra
                //         LoanApp.CalcFields("Loans Category-SASRA");
                //         if LoanApp."Loans Category-SASRA".AsInteger() >= GenSetUp."Allowed Loan Categories".AsInteger() then
                //             Message(Text012, LoanApp."Loans Category-SASRA");
                //     end;
                // end;
                GsubLines.Reset();
                GsubLines.SetRange(GsubLines."Loan No", Rec."Loan No");
                GsubLines.SetRange(GsubLines."No.", Rec."No.");
                GsubLines.SetRange(GsubLines."Guarantor Type", GsubLines."Guarantor Type"::Guarantor);
                GsubLines.SetRange(GsubLines."Savings Account No.", Rec."Member Substituted");
                if GsubLines.Find('-') then begin
                    GsubLines."Amount Guaranteed" := 0;
                    GsubLines."Proportion Guaranteed" := 0;
                    GsubLines.PercentageGur := 0;
                    GsubLines.Substituted := true;
                    GsubLines.Modify();
                end;
                GsubLines.Reset();
                GsubLines.SetRange(GsubLines."Loan No", Rec."Loan No");
                GsubLines.SetRange(GsubLines."No.", Rec."No.");
                GsubLines.SetRange(GsubLines."Guarantor Type", GsubLines."Guarantor Type"::Collateral);
                GsubLines.SetRange(GsubLines."Collateral Reg. No.", Rec."Member Substituted");
                if GsubLines.Find('-') then begin
                    GsubLines.Substituted := true;
                    GsubLines."Amount Guaranteed" := 0;
                    GsubLines."Proportion Guaranteed" := 0;
                    GsubLines.PercentageGur := 0;
                    GsubLines.Modify();
                end;
            end;
        }
        field(26; "Guarantor Type"; Enum "Loan Guarantor Types Enum")
        {
            // OptionCaption = 'Guarantor,Collateral,Lien';
            // OptionMembers = Guarantor,Collateral,Lien;

            trigger OnValidate()
            begin
                if LoansR.Get("Loan No") then begin
                    "Member Guaranteed" := LoansR."Member No.";
                end;
            end;
        }
        field(28; "Collateral Reg. No."; Code[20])
        {
            TableRelation = "Securities Register"."No." WHERE("Account No." = field("Savings Account No."), Status = CONST(Approved));
            trigger OnValidate()
            var
                Text004: Label 'This collateral has been used for loan no. %1 and has a outstanding balance of %2';
                SecReg: Record "Securities Register";
                ColAmount: Decimal;
                IncomingGs: Record "Loan Guarantors Sub";
                ColAllocaAmount: Decimal;
            begin
                if "Guarantor Type" = "Guarantor Type"::Collateral then begin
                    IncomingGs.Reset();
                    IncomingGs.SetRange("Loan No", Rec."Loan No");
                    IncomingGs.SetRange(IncomingGs."Collateral Reg. No.", Rec."Collateral Reg. No.");
                    if IncomingGs.FindFirst() then
                        Error('Collateral  already exist');
                    SecReg.Reset;
                    //SecReg.SetRange("Account No.", "Member Guaranteed");
                    SecReg.SetRange("No.", "Collateral Reg. No.");
                    if SecReg.FindFirst() then begin
                        "Amount Guaranteed" := SecReg."Collateral Limit";
                        "Collateral Value" := SecReg."Market Value";
                        Rec.Name := SecReg."Collateral Name";
                        "Member No" := SecReg."Account No.";
                    end;
                    LoanGuar.Reset;
                    LoanGuar.SetFilter("Outstanding Balance", '>0');
                    LoanGuar.SetRange(LoanGuar."Collateral Reg. No.", rec."Collateral Reg. No.");
                    if LoanGuar.Find('-') then begin
                        LoanGuar.CalcSums("Amount Guaranteed");
                        ColAllocaAmount := LoanGuar."Amount Guaranteed";
                        SecReg.Reset;
                        SecReg.SetRange("No.", LoanGuar."Collateral Reg. No.");
                        if SecReg.FindFirst() then begin
                            ColAmount := SecReg."Market Value";
                        end;
                        if ColAllocaAmount > ColAmount then
                            Error('you cannot exceed the collateral Limit');
                    end;
                end;
            end;
        }
        field(29; "Collateral Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "inserted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Proportion Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; PercentageGur; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = '% Guaranteed';
        }
        field(33; "Total Amount Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Guaranteed';
        }
    }

    keys
    {
        key(Key1; "No.", "Savings Account No.", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        MemberLoaningDetails: JsonObject;
        TheLoanProduct: Record "Product Factory";
        TheLoan: record Loans;
        TheMember: record Members;

        MajorLoansCount: JsonToken;
        MinorLoansCount: JsonToken;
        MaxMajorLoansCount: JsonToken;
        MaxMinorLoansCount: JsonToken;
        IncomingGs: Record "Loan Guarantors Sub";

        GlobalFunctions: Codeunit "Global Functions";
    begin
        if "Guarantor Type" <> Rec."Guarantor Type"::Collateral then begin
            //Check redudant incoming GS
            IncomingGs.Reset();
            IncomingGs.SetRange("Savings Account No.", Rec."Savings Account No.");
            IncomingGs.SetRange("Loan No", Rec."Loan No");
            IncomingGs.SetFilter("Entry No", '<>%1', Rec."Entry No");
            if IncomingGs.Find('-') then
                // if IncomingGs.Count > 0 then
                Error('Member already exist');
        end;


        // Major - Minor loans validation
        TheLoan.Get(Rec."Loan No");

        TheLoanProduct.Reset;
        TheLoanProduct.SetRange("Product ID", TheLoan."Loan Product Type");

        if TheLoanProduct.FindFirst then begin
            MemberLoaningDetails := GlobalFunctions.GetMemberMajorMinorLoansCount(Rec."Member No");

            MemberLoaningDetails.Get('major_loans_count', MajorLoansCount);
            MemberLoaningDetails.Get('minor_loans_count', MinorLoansCount);
            MemberLoaningDetails.Get('max_major_loans_count', MaxMajorLoansCount);
            MemberLoaningDetails.Get('max_minor_loans_count', MaxMinorLoansCount);

            TheMember.Get(Rec."Member No");

            if TheLoanProduct."Loan Span" = TheLoanProduct."Loan Span"::Major then begin
                if MajorLoansCount.AsValue.AsInteger >= MaxMajorLoansCount.AsValue.AsInteger then begin
                    Error('Guarantor %1 cannot exceed the maximum major loans count of %2. Current count is %3',
                    TheMember.Name,
                    MaxMajorLoansCount.AsValue.AsInteger,
                    MajorLoansCount.AsValue.AsInteger
                    );
                end;
            end;

            if TheLoanProduct."Loan Span" = TheLoanProduct."Loan Span"::Minor then begin
                if MinorLoansCount.AsValue.AsInteger >= MaxMinorLoansCount.AsValue.AsInteger then begin
                    Error('Guarantor %1 cannot exceed the maximum minor loans count of %2. Current count is %3',
                    TheMember.Name,
                    MaxMinorLoansCount.AsValue.AsInteger,
                    MinorLoansCount.AsValue.AsInteger
                    );
                end;
            end;
        end;
    end;

    trigger OnModify()
    var
        MemberLoaningDetails: JsonObject;
        TheLoanProduct: Record "Product Factory";
        TheLoan: record Loans;
        TheMember: record Members;

        MajorLoansCount: JsonToken;
        MinorLoansCount: JsonToken;
        MaxMajorLoansCount: JsonToken;
        MaxMinorLoansCount: JsonToken;
        IncomingGs: Record "Loan Guarantors Sub";
        GlobalFunctions: Codeunit "Global Functions";
    begin
        // Major - Minor loans validation
        if "Guarantor Type" <> Rec."Guarantor Type"::Collateral then begin
            //Check redudant incoming GS
            IncomingGs.Reset();
            IncomingGs.SetRange("Savings Account No.", Rec."Savings Account No.");
            IncomingGs.SetRange("Loan No", Rec."Loan No");
            IncomingGs.SetFilter("Entry No", '<>%1', Rec."Entry No");
            if IncomingGs.Find('-') then
                // if IncomingGs.Count > 0 then
                Error('Member already exist');
        end;
        TheLoan.Get(Rec."Loan No");

        TheLoanProduct.Reset;
        TheLoanProduct.SetRange("Product ID", TheLoan."Loan Product Type");

        if TheLoanProduct.FindFirst then begin
            MemberLoaningDetails := GlobalFunctions.GetMemberMajorMinorLoansCount(Rec."Member No");

            MemberLoaningDetails.Get('major_loans_count', MajorLoansCount);
            MemberLoaningDetails.Get('minor_loans_count', MinorLoansCount);
            MemberLoaningDetails.Get('max_major_loans_count', MaxMajorLoansCount);
            MemberLoaningDetails.Get('max_minor_loans_count', MaxMinorLoansCount);

            TheMember.Get(Rec."Member No");

            if TheLoanProduct."Loan Span" = TheLoanProduct."Loan Span"::Major then begin
                if MajorLoansCount.AsValue.AsInteger >= MaxMajorLoansCount.AsValue.AsInteger then begin
                    Error('Guarantor %1 cannot exceed the maximum major loans count of %2. Current count is %3',
                    TheMember.Name,
                    MaxMajorLoansCount.AsValue.AsInteger,
                    MajorLoansCount.AsValue.AsInteger
                    );
                end;
            end;

            if TheLoanProduct."Loan Span" = TheLoanProduct."Loan Span"::Minor then begin
                if MinorLoansCount.AsValue.AsInteger >= MaxMinorLoansCount.AsValue.AsInteger then begin
                    Error('Guarantor %1 cannot exceed the maximum minor loans count of %2. Current count is %3',
                    TheMember.Name,
                    MaxMinorLoansCount.AsValue.AsInteger,
                    MinorLoansCount.AsValue.AsInteger
                    );
                end;
            end;
        end;
    end;

    var
        CreditAccounts: Record "Credit Accounts";
        GHeader: Record "Guarantors Substitution";
        Lno: Code[50];
        SavingsAccounts: Record "Savings Accounts";
        LoanGuarantors: Record "Loan Guarantors and Security";
        Loans: Record Loans;
        LoansR: Record Loans;
        LoansG: Integer;
        GenSetUp: Record "General Set-Up";
        SelfGuaranteedA: Decimal;
        StatusPermissions: Record "Credit Ledger Entry";
        Employer: Record Customer;
        LoanProduct: Record "Loan Charges";
        TotalGuaranteed: Decimal;
        BalanceRemaining: Decimal;
        ProductFactory: Record "Product Factory";
        TotaAmtGUR: Decimal;
        GuarantorMax: Boolean;
        Image: Record "Image Data";
        LoanGuar: Record "Loan Guarantors and Security";
        TotG: Decimal;
        Txt0001: Label 'Member No. %1 is not an Active Member or Dormant Member and therefore cannot be a guarantor';
        LoanGua: Record "Loan Guarantors and Security";
        LoanApp: Record Loans;
        Text012: Label 'The loan you are substituting guaranto is in default, Status: %1';
        Totalguarantee: Decimal;
}