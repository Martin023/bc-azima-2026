table 52185739 "Loan Guarantors and Security"
{
    DrillDownPageID = "Loan Guarantors and Security";
    LookupPageID = "Loan Guarantors and Security";

    fields
    {
        field(1; "Loan No"; Code[50])
        {
            NotBlank = true;
            TableRelation = Loans."Loan No.";
        }
        field(2; "Savings Account No./Member No."; Code[20])
        {
            TableRelation =
            IF ("Guarantor Type" = CONST(Guarantor), "Loan Groups" = FILTER(Normal)) "Savings Accounts"."No." WHERE("Product Category" = filter("Business Deposits" | "BOSA Deposits"))
            ELSE
            IF ("Guarantor Type" = CONST(Guarantor), "Loan Groups" = FILTER("Group Loan")) "Savings Accounts"."No." WHERE("Product Category" = filter("Business Deposits"), "Group Account No" = FIELD("Group Account Nos"))
            else
            IF ("Guarantor Type" = CONST(Collateral)) Members."No." where(Status = filter(Active))
            ELSE
            IF ("Guarantor Type" = FILTER(Lien)) "Savings Accounts"."No." WHERE("Lien Placed" = FILTER(<> 0))
            ELSE
            IF ("Guarantor Type" = FILTER("Fixed Deposit")) "Fixed Deposit Contract"."No." WHERE("Fixed Deposit Status" = FILTER(Active));

            trigger OnValidate()
            var
                SalaryLines: Record "Salary Lines";
                SaVingAc: Record "Savings Accounts";
                GuarnotrFa: Record "Guarantor Failure Reasons";
                Membersrec: Record Members;
                Lons: Record Loans;
                LoanGua: Record "Loan Guarantors and Security";
                TotaAmtGUR: Decimal;
                Majorloans: Integer;
                MinerLoans: Integer;
                Guarantor: Record "Loan Guarantors and Security";
                TotalGuarantors: Integer;
                AppliedAmount: Decimal;
                GlobalFunctions: Codeunit "Global Functions";
                LoanNo: Code[20];
                FixedDeposit: Record "Fixed Deposit Contract";
            begin

                GenSetUp.Get;
                "Self Guarantee" := false;
                SelfGuaranteedA := 0;
                Date := Today;
                if "Guarantor Type" = "Guarantor Type"::Lien then begin
                    SaVingAc.Reset();
                    SaVingAc.SetRange(SaVingAc."No.", Rec."Savings Account No./Member No.");
                    if SaVingAc.FindFirst() then begin
                        Rec."Amount Guaranteed" := SaVingAc."Lien Placed";
                    end;
                end;
                if "Guarantor Type" = "Guarantor Type"::"Fixed Deposit" then begin
                    FixedDeposit.Reset();
                    FixedDeposit.SetRange(FixedDeposit."No.", Rec."Savings Account No./Member No.");
                    if FixedDeposit.FindFirst() then begin
                        Rec."Amount Guaranteed" := FixedDeposit."Fixed Deposit Amount";
                    end;
                end;

                SaVingAc.Reset();
                SaVingAc.SetRange(SaVingAc."No.", Rec."Savings Account No./Member No.");
                if SaVingAc.FindFirst() then begin
                    SaVingAc.CalcFields(SaVingAc.Balance);
                    if SaVingAc.Balance <= 0 then begin
                        Error('Member ' + SaVingAc.Name + ' No. ' + SaVingAc."Member No." + ' has no deposits');
                    end;
                    //*************Kenpipe Bypass::Allow Members with attached defaulted loans to guarantee
                    // ProductFactory.Reset();
                    // ProductFactory.SetRange("Nature of Loan Type", ProductFactory."Nature of Loan Type"::Defaulter);
                    // if ProductFactory.FindFirst() then begin
                    //     Lons.Reset();
                    //     Lons.SetRange("Member No.", SaVingAc."Member No.");
                    //     Lons.SetFilter("Outstanding Balance", '>%1', 0);
                    //     Lons.SetRange("Loan Product Type", ProductFactory."Product ID");
                    //     if Lons.FindFirst() then
                    //         Error('Member ' + SaVingAc.Name + ' No. ' + Lons."Member No." + ' has an attached loan');
                    // end;
                    //*************Kenpipe Bypass::Allow Members with attached defaulted loans to guarantee
                    Membersrec.Reset();
                    Membersrec.SetRange("No.", SaVingAc."Member No.");
                    if Membersrec.Find('-') then begin
                        if (Membersrec.Subflag <> Membersrec.Subflag::Rejoined) and (Membersrec.Subflag <> Membersrec.Subflag::"First time") and (Membersrec.Subflag <> Membersrec.Subflag::"Partial withdrawn") then
                            Error('The member ' + Membersrec.Name + ' with subflag  %1 is not allowed to Guarantee', Membersrec.Subflag);
                        //check if defaulter
                        GlobalFunctions.FlagAccounts(Membersrec."No.");
                    end;
                end;



                // if LoanApp.Get(Rec."Loan No") then begin
                //     ProductFactory.Reset();
                //     ProductFactory.SetRange("Product ID", LoanApp."Loan Product Type");
                //     ProductFactory.SetRange("Source Unit", ProductFactory."Source Unit"::FOSA);
                //     if ProductFactory.FindFirst() then begin
                //         SaVingAc.Reset();
                //         SaVingAc.SetRange("No.", Rec."Savings Account No./Member No.");
                //         if SaVingAc.FindFirst() then begin
                //             SalaryLines.Reset();
                //             SalaryLines.SetRange("Member No.", SaVingAc."Member No.");
                //             SalaryLines.SetRange(Posted, true);
                //             SalaryLines.SetFilter("Posting Date", '%1..%2', CalcDate('-40D', Today), Today);
                //             if not SalaryLines.FindFirst() then begin
                //                 Error('Salary for member ' + SaVingAc.Name + ' - ' + SaVingAc."Member No." + ' has not been received for the last 40 days');
                //             end;
                //         end;
                //     end;
                // end;
                //***************RESTRICT GUARANTOR TYPE BASED ON LOAN SECURITY ***********************************************//
                if "Guarantor Type" = "Guarantor Type"::Guarantor then begin
                    if LoanApp.Get(Rec."Loan No") then begin
                        ProductFactory.Reset();
                        ProductFactory.SetRange("Product ID", LoanApp."Loan Product Type");
                        // ProductFactory.SetRange("Source Unit", ProductFactory."Source Unit"::BOSA);
                        if ProductFactory.FindFirst() then begin
                            if ProductFactory."Loan Security" = ProductFactory."Loan Security"::"Collateral Only" then begin

                                Error('The ' + ProductFactory."Product Description" + '  product requires only collateral as loan security.');
                            end;
                        end;
                    end;
                end;

                if "Guarantor Type" = "Guarantor Type"::Collateral then begin
                    if LoanApp.Get(Rec."Loan No") then begin
                        ProductFactory.Reset();
                        ProductFactory.SetRange("Product ID", LoanApp."Loan Product Type");
                        ProductFactory.SetRange("Source Unit", ProductFactory."Source Unit"::BOSA);
                        if ProductFactory.FindFirst() then begin
                            if ProductFactory."Loan Security" = ProductFactory."Loan Security"::"Guarantors Only" then begin
                                Error('The ' + ProductFactory."Product Description" + '  product requires only guarantor(s) as loan security.');
                            end;
                        end;
                    end;
                end;
                if "Guarantor Type" = "Guarantor Type"::"Fixed Deposit" then begin
                    if LoanApp.Get(Rec."Loan No") then begin
                        ProductFactory.Reset();
                        ProductFactory.SetRange("Product ID", LoanApp."Loan Product Type");
                        // ProductFactory.SetRange("Source Unit", ProductFactory."Source Unit"::BOSA);
                        if ProductFactory.FindFirst() then begin
                            if (ProductFactory."Loan Security" <> ProductFactory."Loan Security"::"Guarantors and Collateral") and (ProductFactory."Loan Security" <> ProductFactory."Loan Security"::"Fixed Deposit Only") then begin
                                Error('The ' + ProductFactory."Product Description" + '  product does not support Fixed deposits as loan security.');
                            end;
                        end;
                    end;
                end;
                //*************************RESTRICT GUARANTOR TYPE BASED ON LOAN SECURITY*******************************//

                //Set Member Guaranteed
                if LoansR.Get("Loan No") then begin
                    "Member Guaranteed" := LoansR."Member No.";
                    "Loanee Name" := LoansR."Member Name";

                end;

                if "Guarantor Type" = "Guarantor Type"::Guarantor then begin
                    SELFLOAN.Reset;
                    SELFLOAN.SetRange("Loan No.", "Loan No");
                    if SELFLOAN.Find('-') then begin
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange("Member No.", SELFLOAN."Member No.");
                        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                        if SavingsAccounts.Find('-') then begin
                            if SavingsAccounts."No." = "Savings Account No./Member No." then
                                "Self Guarantee" := true else
                                "Self Guarantee" := false;
                        end;
                    end;

                    //Evaluate guarantor basic info
                    if Cust.Get("Savings Account No./Member No.") then begin
                        if Members.Get(Cust."Member No.") then begin
                            if Members.Status <> Members.Status::Active then begin
                                Error('Member %2 No. %1 is not an Active Member', Members."No.", Members.Name);
                            end;
                        end;

                        if Employer.Get(Cust."Employer Code") then begin
                            if Employer."Internal Staff Employer" = true then begin
                                //Check if self guaranteed, allow
                                if Members.Get(Cust."Member No.") then begin
                                    if "Member Guaranteed" <> cust."Member No." then
                                        Error(cust."Employer Code" + ' are not allowed to guarantee');
                                    // Error(Text001);
                                end;
                            end;
                        end;
                        // if Employer.Get(Cust."Employer Code") then begin
                        //     if Employer."Internal Staff Employer" = true then begin
                        //         //Check if self guaranteed, allow
                        //         if LoansR.Get("Loan No") then begin
                        //             // if "Member Guaranteed" <> LoansR."Member No." then
                        //             if "Member Guaranteed" <> Rec."Member No" then
                        //                 Error(Text001);

                        //         end;

                        //     end;
                        // end;
                        Members.Get(Cust."Member No.");
                        Cust.CalcFields(Cust."Balance (LCY)");
                        Name := Cust.Name;
                        "Staff/Payroll No." := Cust."Payroll/Staff No.";
                        // "Loan Balance":=Cust."Balance (LCY)";
                        "Deposits/Shares" := Cust."Balance (LCY)";
                        // "Amount Guaranteed" := cust.GetAvailableBalance(cust."No.");
                        "ID No." := Members."Primary Identification";
                        "Member No" := Cust."Member No.";
                        Name := Cust.Name;
                        "Phone No." := Members."Phone No.";
                        //Check if self gauarantee
                        Loans.Reset;
                        Loans.SetRange(Loans."Member No.", Cust."Member No.");
                        Loans.SetRange(Loans."Self Guarantee", true);
                        Loans.SetFilter(Loans."Outstanding Balance", '>0');
                        if Loans.Find('-') then begin
                            Loans.CalcFields(Loans."Outstanding Balance");
                            if Loans."Outstanding Balance" >= GenSetUp."Self Guarantee %" * "Deposits/Shares" * 0.01 then begin
                                LoansTopup.Reset;
                                LoansTopup.SetRange("Loan Top Up", Loans."Loan No.");
                                if not LoansTopup.Find('-') then begin
                                    Error(Text002, Loans."Outstanding Balance", "Deposits/Shares");
                                end;
                            end
                            else
                                "Amount Guaranteed" := (GenSetUp."Self Guarantee %" * "Deposits/Shares" * 0.01) - Loans."Outstanding Balance";
                        end;
                    end;
                    LoanGuar.Reset;
                    LoanGuar.SetRange("Savings Account No./Member No.", "Savings Account No./Member No.");
                    LoanGuar.SetFilter("Outstanding Balance", '>0');
                    if LoanGuar.Find('-') then begin
                        LoanGuar.CalcSums("Amount Guaranteed");
                        TotalGuaranteed := LoanGuar."Amount Guaranteed";
                        "No Of Loans Guaranteed" := LoanGuar.Count;
                        //MESSAGE('Loans gua %1 Counter %2 Loan No. %3',TotalGuaranteed,"No Of Loans Guaranteed",LoanGuar."Loan No");
                    end;
                    "Available Shares" := "Deposits/Shares" - "Total Guaranteed";
                    //Check for Minor and Major Loans
                    "No Of Major Loans Guaranteed" := 0;
                    "No Of Minor Loans Guaranteed" := 0;
                    Majorloans := 0;
                    MinerLoans := 0;
                    //LoansOnpipe
                    LoanGuar.Reset;
                    LoanGuar.SetRange("Savings Account No./Member No.", "Savings Account No./Member No.");
                    if LoanGuar.Find('-') then begin
                        repeat
                            if TheLoans.Get(LoanGuar."Loan No") then begin
                                TheLoans.CalcFields("Loan Span");
                                if pfac.get(TheLoans."Loan Product Type") then begin
                                    if pfac."Source Unit" = pfac."Source Unit"::BOSA then begin
                                        if TheLoans.Status <> TheLoans.Status::Rejected then begin
                                            if TheLoans.Posted = false then begin
                                                if TheLoans."Loan Span" = TheLoans."Loan Span"::Major then
                                                    Majorloans += 1;
                                                if TheLoans."Loan Span" = TheLoans."Loan Span"::Minor then
                                                    MinerLoans += 1;
                                            end;
                                            //MESSAGE('Loans gua %1 Counter %2 Loan No. %3',TotalGuaranteed,"No Of Loans Guaranteed",LoanGuar."Loan No");
                                        end;
                                    end;
                                end;
                            end;
                        until LoanGuar.Next = 0;
                    end;

                    // //posted Loans
                    // LoanGuar.Reset;
                    // LoanGuar.SetRange("Savings Account No./Member No.", "Savings Account No./Member No.");
                    // LoanGuar.SetFilter("Outstanding Balance", '>0');
                    // if LoanGuar.Find('-') then begin
                    //     repeat
                    //         if TheLoans.Get(LoanGuar."Loan No") then begin
                    //             if pfac.get(TheLoans."Loan Product Type") then begin
                    //                 if pfac."Source Unit" = pfac."Source Unit"::BOSA then begin
                    //                     TheLoans.CalcFields("Loan Span");
                    //                     if TheLoans."Loan Span" = TheLoans."Loan Span"::Major then
                    //                         "No Of Major Loans Guaranteed" += 1;
                    //                     if TheLoans."Loan Span" = TheLoans."Loan Span"::Minor then
                    //                         "No Of Minor Loans Guaranteed" += 1;
                    //                     //MESSAGE('Loans gua %1 Counter %2 Loan No. %3',TotalGuaranteed,"No Of Loans Guaranteed",LoanGuar."Loan No");
                    //                 end;
                    //             end;
                    //         end;
                    //     until LoanGuar.Next = 0;
                    // end;
                    GenSetUp.Get;
                    if LoanApp.Get(Rec."Loan No") then begin
                        if FixedDeposit.get(rec."Savings Account No./Member No.") then begin
                            Members.Get(FixedDeposit."Member No.");
                            Name := Members.Name;
                            "Staff/Payroll No." := Members."Payroll/Staff No.";
                            // "Loan Balance":=Cust."Balance (LCY)";
                            "Deposits/Shares" := FixedDeposit."Fixed Deposit Amount";
                            // "Amount Guaranteed" := cust.GetAvailableBalance(cust."No.");
                            "ID No." := Members."Primary Identification";
                            "Member No" := Members."No.";
                            Name := Members.Name;
                            "Phone No." := Members."Phone No.";
                        end;

                        // maxamountguarantee := GenSetUp."Maximum Amount to Guarantee";
                        // Totalguarantee := "Amount Guaranteed" + "Total Guaranteed";
                        // if Totalguarantee > maxamountguarantee then begin
                        //     Error('The total loans  guaranteed have reached the maximum allowable limit of KES ' + Format(GenSetUp."Maximum Amount to Guarantee") + '.');
                        // end;

                        // LoanApp.CalcFields("Loan Span");
                        // if LoanApp."Loan Span" = LoanApp."Loan Span"::Major then begin
                        //     if LoanApp."Source Unit" <> LoanApp."Source Unit"::FOSA then begin
                        //         if "No Of Major Loans Guaranteed" + Majorloans > GenSetUp."Max Major Loans To Guarantee" then begin
                        //             Error('No of major Loan will exceed %1, the current major Loans guaranteed is %2.', GenSetUp."Max Major Loans To Guarantee", "No Of Major Loans Guaranteed");
                        //         end;
                        //     end;
                        // end else
                        //     if LoanApp."Loan Span" = LoanApp."Loan Span"::Minor then begin
                        //         if LoanApp."Source Unit" <> LoanApp."Source Unit"::FOSA then begin
                        //             if ("No Of Minor Loans Guaranteed" + MinerLoans) > GenSetUp."Max Minor Loans To Guarantee" then begin
                        //                 Error('No of Minor Loan will exceed %1, the current Minor Loans guaranteed is %2.', GenSetUp."Max Minor Loans To Guarantee", "No Of Minor Loans Guaranteed");
                        //             end;
                        //         end;
                        //     end;
                        // if (LoanApp."Source Unit" = LoanApp."Source Unit"::FOSA) and ("Self Guarantee" = true) then
                        //     Error('Self Guarantorship is not allowed on FOSA Loans.');
                    end
                end else
                    if "Guarantor Type" = "Guarantor Type"::Collateral then begin
                        if Members.Get("Savings Account No./Member No.") then begin

                            Name := Members.Name;
                            "Staff/Payroll No." := Members."Payroll/Staff No.";
                            "ID No." := Members."Primary Identification";
                            "Member No" := "Savings Account No./Member No.";
                            LoanGuar.Reset;
                            LoanGuar.SetRange("Member No", "Savings Account No./Member No.");
                            LoanGuar.SetFilter("Outstanding Balance", '>0');
                            if LoanGuar.Find('-') then begin
                                LoanGuar.CalcSums("Amount Guaranteed");
                                "No Of Loans Guaranteed" := LoanGuar.Count;
                            end;

                        end;
                    end else begin
                        if Cust.Get("Savings Account No./Member No.") then begin
                            if Cust.Status <> Cust.Status::Active then begin
                                Error('Member %2 No. %1 is not an Active Member', Cust."No.", Cust.Name);
                            end;
                            Cust.CalcFields(Cust."Balance (LCY)");
                            Name := Cust.Name;
                            "Staff/Payroll No." := Cust."Payroll/Staff No.";
                            // "Loan Balance":=Cust."Balance (LCY)";
                            "Deposits/Shares" := Cust."Balance (LCY)";
                            "Amount Guaranteed" := Cust."Lien Placed";
                            "ID No." := Cust."ID No.";
                            "Member No" := Cust."Member No.";
                            Name := Cust.Name;
                            Rec.CalcFields("Total Guaranteed");
                            "Total Guaranteed" := Round(Rec."Total Guaranteed", 0.01);
                            LoanGuar.Reset;
                            LoanGuar.SetRange("Member No", "Savings Account No./Member No.");
                            LoanGuar.SetFilter("Outstanding Balance", '>0');
                            if LoanGuar.Find('-') then begin
                                LoanGuar.CalcSums("Amount Guaranteed");
                                "No Of Loans Guaranteed" := LoanGuar.Count;
                                // "Total Guaranteed" := LoanGuar."Amount Guaranteed";
                            end;
                        end;
                    end;

                LoanGuarantors.Reset;
                LoanGuarantors.SetRange(LoanGuarantors."Loan No", "Loan No");
                if LoanGuarantors.Find('-') then begin
                    repeat
                        "Total Sum" := "Total Sum" + LoanGuarantors."Amount Guaranteed";
                    until LoanGuarantors.Next = 0;
                end;
                //Check Max garantors
                LoansG := 0;
                CalcFields("No Of Loans Guaranteed");
                // LoansG := "No Of Loans Guaranteed";
                Rec.CalcFields("Total Guaranteed");
                LoansG := Round("Total Guaranteed");//kenpipe policy
                //changed
                if "Guarantor Type" = "Guarantor Type"::Guarantor then begin
                    // if GenSetUp."Max Loans To Guarantee" > 0 then
                    if GenSetUp."Maximum Amount to Guarantee" > 0 then  //kenpipe policy
                        if LoansG >= GenSetUp."Maximum Amount to Guarantee" then begin
                            Error('Member ' + Rec."Savings Account No./Member No." +
      ' has reached the guarantorship limit of ' +
      Format(GenSetUp."Maximum Amount to Guarantee") +
      '. Current guaranteed amount: ' + Format(LoansG));

                            exit;
                        end;

                    // maxamountguarantee := GenSetUp."Maximum Amount to Guarantee";
                    // Totalguarantee := "Amount Guaranteed" + "Total Guaranteed";
                    // if Totalguarantee > maxamountguarantee then begin
                    //     Error('The total loans  guaranteed have reached the maximum allowable limit of KES ' + Format(GenSetUp."Maximum Amount to Guarantee") + '.');
                    // end;
                    //Check Max garantors - End
                end;

                // LoanApp.Reset;
                // LoanApp.SetLoadFields("Member No.", Posted);
                // LoanApp.SetRange("Member No.", "Member No");
                // LoanApp.SetRange(Posted, true);
                // LoanApp.SetAutoCalcFields("Outstanding Balance", "Loans Category-SASRA");
                // LoanApp.SetFilter("Outstanding Balance", '>%1', 0);
                // LoanApp.SetFilter("Loans Category-SASRA", '<>%1', LoanApp."Loans Category-SASRA"::Perfoming);
                // LoanApp.setfilter("Loan Product Type", '<>%1&<>%2', 'FGL', 'BGL');
                // if LoanApp.Find('-') then begin
                //     // repeat
                //     // LoansTopup.Reset;
                //     // LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
                //     // if not LoansTopup.Find('-') then begin
                //     Error(Err0003, "Member No", LoanApp."Loan No.");
                //     // end;

                //     // until LoanApp.Next = 0;
                // end;
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
        field(5; "Deposits/Shares"; Decimal)
        {
            Editable = false;
        }
        field(6; "No Of Loans Guaranteed"; Integer)
        {
            CalcFormula = Count("Loan Guarantors and Security" WHERE("Member No" = FIELD("Member No"),
                                                                      "Outstanding Balance" = FILTER(> 0),
                                                                      Substituted = FILTER(false)));
            Editable = false;
            FieldClass = FlowField;
        }

        field(7; Substituted; Boolean)
        {
            Editable = true;

            trigger OnValidate()
            begin
                Date := Today;
                if Rec."Self Guarantee" = true then
                    Error('You cannot substitute self-guarantee');
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

            trigger OnValidate()
            begin
                //Shares:=Shares*-1;
                //MESSAGE('SHARE %1',Shares);
                TotG := 0;
                if "Amount Guaranteed" > ("Deposits/Shares") then
                    // Error('You cannot guarantee more than your shares of %1', "Deposits/Shares");

                GenSetUp.Get;
                if LoanApp.Get(Rec."Loan No") then begin

                    maxamountguarantee := GenSetUp."Maximum Amount to Guarantee";
                    Rec.CalcFields("Total Guaranteed");
                    Totalguarantee := "Amount Guaranteed" + "Total Guaranteed";
                    if Totalguarantee > maxamountguarantee then begin
                        Error('The total loans  guaranteed have reached the maximum allowable limit of KES ' + Format(GenSetUp."Maximum Amount to Guarantee") + '.');
                    end;
                end;
                "Original Amount Guaranteed" := "Amount Guaranteed";
                "User Specified" := true;



                //CALCSUMS("Amount Guaranteed");
                BalanceRemaining := 0;

                TotG := TotG + "Amount Guaranteed";
                //MESSAGE('AmtGuar outside loop %1',TotG);
                //MESSAGE('Tot Guar %1',TotG);
                //CALCSUMS("Amount Guaranteed");
                if Loans.Get("Loan No") then begin
                    BalanceRemaining := Loans."Approved Amount" - TotG;//LoanGuar."Amount Guaranteed";

                    //MESSAGE('Balance not Guaranteed %1',BalanceRemaining);
                end;
                //"Percentage Guaranteed":=("Amount Guaranteed"/Loans."Approved Amount")*100;

                LoanGuarantors.Reset;
                LoanGuarantors.SetRange(LoanGuarantors."Loan No", "Loan No");
                if LoanGuarantors.Find('-') then begin
                    repeat
                        "Total Sum" := "Total Sum" + LoanGuarantors."Amount Guaranteed";
                    //LoanGuar.CALCSUMS(LoanGuar."Amount Guaranteed");
                    //MESSAGE('AmtGuar loop %1',TotG);

                    until LoanGuarantors.Next = 0;
                end;
            end;
        }
        field(12; "Staff/Payroll No."; Code[20])
        {

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."Payroll/Staff No.", "Staff/Payroll No.");
                Cust.SetRange(Cust."Loan Security Inclination", Cust."Loan Security Inclination"::"Long Term Loan Security");
                if Cust.Find('-') then begin
                    "Savings Account No./Member No." := Cust."No.";
                    Validate("Savings Account No./Member No.");
                end
                else begin
                    "Savings Account No./Member No." := '';
                    Error('Member deposits account not found.');
                end;
            end;
        }
        field(13; "Account No."; Code[20])
        {
            //TableRelation = "Securities Register"."No." WHERE ("Account No." = FIELD("Savings Account No./Member No."), Status = CONST(Approved));
        }
        field(14; "Self Guarantee"; Boolean)
        {
        }
        field(15; "ID No."; Code[50])
        {
            Editable = false;
        }
        field(16; "Outstanding Balance"; Decimal)
        {
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Loan No" = FIELD("Loan No"),
                                                                  "Transaction Type" = FILTER(Loan | Repayment)));
            FieldClass = FlowField;
        }
        field(17; "Member Guaranteed"; Code[50])
        {
        }
        field(18; "Percentage Guaranteed"; Decimal)
        {
        }
        field(19; "Total Guaranteed"; Decimal)
        {
            CalcFormula = Sum("Loan Guarantors and Security"."Amount Guaranteed"
                      WHERE("Member No" = FIELD("Member No"),
                            "Outstanding Balance" = FILTER(> 0),
                            "Amount Guaranteed" = FILTER(> 0),
                            Substituted = FILTER(false)));
            Editable = false;
            FieldClass = FlowField;
        }


        field(20; "Available Shares"; Decimal)
        {
        }
        field(21; Signature; BLOB)
        {
        }
        field(22; "Member No"; Code[20])
        {
        }
        field(23; "Loan Type"; Code[20])
        {
            CalcFormula = Lookup(Loans."Loan Product Type" WHERE("Loan No." = FIELD("Loan No")));
            FieldClass = FlowField;
        }
        field(230; "Loan Product Name"; Text[50])
        {
            CalcFormula = Lookup(Loans."Loan Product Type Name" WHERE("Loan No." = FIELD("Loan No")));
            FieldClass = FlowField;
        }
        field(24; "Guaranteed Balance"; Decimal)
        {
        }
        field(25; "Loanee Name"; Text[150])
        {
            Editable = false;
        }
        field(26; "Guarantor Type"; Option)
        {
            OptionCaption = 'Guarantor,Collateral,Lien,Fixed Deposit';
            OptionMembers = Guarantor,Collateral,Lien,"Fixed Deposit";

            trigger OnValidate()
            begin
                if LoansR.Get("Loan No") then begin
                    LoansR.TestField("Member No.");

                    "Member Guaranteed" := LoansR."Member No.";
                    "Loanee Name" := LoansR."Member Name";


                end;
            end;
        }
        field(27; "Collateral Reg. No."; Code[20])
        {
            TableRelation = "Securities Register"."No." WHERE("Account No." = FIELD("Savings Account No./Member No."), Status = CONST(Approved));

            trigger OnValidate()
            var
                ColAmount: Decimal;
                perfecion: Record "Securities Register";
            begin
                if "Guarantor Type" = "Guarantor Type"::Collateral then begin
                    LoanApp.Reset();
                    LoanApp.SetRange("Loan No.", Rec."Loan No");
                    LoanApp.SetRange("Source Unit", LoanApp."Source Unit"::"HR LOANS");
                    if LoanApp.FindFirst() then begin
                        perfecion.Reset();
                        perfecion.SetRange("Collateral Reg No.", Rec."Collateral Reg. No.");
                        perfecion.SetRange(perfecion."Collateral Perfected", true);
                        if not perfecion.FindFirst() then
                            Error('Collateral must be perfected');
                    end;
                    LoanGuar.Reset;
                    LoanGuar.SetFilter("Outstanding Balance", '>0');
                    LoanGuar.SetRange(LoanGuar."Collateral Reg. No.", rec."Collateral Reg. No.");
                    LoanGuar.SetFilter(LoanGuar."Loan No", '<>%1', Rec."Loan No");
                    if LoanGuar.Find('-') then begin
                        LoanGuar.CalcSums("Proportion Guaranteed");
                        SecReg.Reset;
                        SecReg.SetRange("No.", LoanGuar."Collateral Reg. No.");
                        if SecReg.FindFirst() then begin
                            ColAmount := SecReg."Collateral Value";
                        end;
                        if LoanGuar."Proportion Guaranteed" > ColAmount then
                            Error('You cannot exceed the collateral Limit of %1.', ColAmount);
                    end;
                end;
                SecReg.Reset;
                SecReg.SetRange("No.", "Collateral Reg. No.");
                if SecReg.Find('-') then begin
                    "Amount Guaranteed" := SecReg."Collateral Limit" - LoanGuar."Proportion Guaranteed";
                    "Collateral Value" := SecReg."Collateral Value";
                end;
            end;
        }
        field(28; "Collateral Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Securities Register"."Collateral Value" where("Account No." = field("Savings Account No./Member No.")));
        }
        field(280; "Collateral Name"; Text[300])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Securities Register"."Collateral Ref No." where("Account No." = field("Savings Account No./Member No.")));
        }
        field(29; "SMS Sent"; Boolean)
        {
        }
        field(30; "Total Sum"; Decimal)
        {
            CalcFormula = Sum("Loan Guarantors and Security"."Amount Guaranteed" WHERE("Loan No" = FIELD("Loan No")));
            FieldClass = FlowField;
        }
        field(31; "Member Substituted"; Code[20])
        {
            Enabled = false;
            TableRelation = "Savings Accounts"."No." WHERE("Product Category" = filter("BOSA Deposits"),
                                                            Balance = FILTER(> 0));
        }
        field(32; test; Integer)
        {
        }
        field(33; "Total Loan Balance"; Decimal)
        {
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Loan No" = FIELD("Loan No"),
                                                                  "Transaction Type" = FILTER("Interest Paid" | "Interest Due" | Repayment | Loan)));
            FieldClass = FlowField;
        }
        field(34; "Substituted By"; Text[50])
        {
        }
        field(35; "Date Substituted"; Date)
        {
        }
        field(36; Verified; Boolean)
        {
            Editable = false;
        }
        field(37; "No Of Major Loans Guaranteed"; Integer)
        {
            Editable = false;
        }
        field(38; "No Of Minor Loans Guaranteed"; Integer)
        {
            Editable = false;
        }
        field(39; "Deceased"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(40; Comments; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Proportion Guaranteed"; decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(42; "Phone No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "PercentageGur"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(44; "Guarantor Status"; Enum "Member Status")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(members.status WHERE("No." = FIELD("Member No")));
            Editable = false;

        }
        field(45; "Source Unit"; Option)
        {
            OptionCaption = ' ,FOSA,BOSA,BUSINESS LOANS,HR LOANS';
            OptionMembers = "",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Source Unit" where("Loan No." = field("Loan No")));
            Editable = false;
        }
        field(10024; "Loan Group"; Option)
        {
            OptionMembers = Normal,"Group Loan";
            OptionCaption = 'Normal,Group Loan';
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Loan Group" where("Product ID" = field("Loan Type")));
            Editable = false;
        }
        field(10025; "Loan Groups"; Option)
        {
            Caption = 'Loan Group';
            OptionMembers = Normal,"Group Loan";
            OptionCaption = 'Normal,Group Loan';
            FieldClass = Normal;
            Editable = true;
            trigger OnValidate()
            var
                mpfa: Record "Product Factory";
            begin
                if mpfa.Get(Rec."Loan No") then begin
                    if mpfa."Loan Group" <> mpfa."Loan Group"::"Group Loan" then
                        Error(('This is only applicable to group loans'));
                end;

            end;
        }

        field(57; "Group Account No"; Code[20])
        {
            Description = 'Group Account No.';
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Group Account No." where("No." = field("Member Guaranteed")));

        }
        field(58; "Group Account Nos"; Code[20])
        {
            Description = 'Group Account No.';
            FieldClass = Normal;

        }

        field(63; "Source Application"; Option)
        {
            OptionMembers = "BC",CRM,"Mwalimu Smart","Member Portal","Mbanking - APP","Mbanking - USSD";
            Editable = false;
        }
        field(64; "NumberOfGuarantors"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "User Specified"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(66; "Original Amount Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Loan No", "Savings Account No./Member No.", "Guarantor Type", "Collateral Reg. No.")
        {
            Clustered = true;
            SumIndexFields = "Deposits/Shares";
        }
    }

    fieldgroups
    {
    }
    //guarantor Apportionment

    //guarantor Apportionment
    trigger OnDelete()
    var
        Guarantor: Record "Loan Guarantors and Security";
        TotalGuarantors: Integer;
    begin
        if LoansR.Get("Loan No") then begin


        end;
        if LoanApp.Get("Loan No") then begin
            if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) or (LoanApp.Status = LoanApp.Status::Posted) then
                Error(Text003, LoanApp.Status);
            if LoanApp.Posted = true then
                Error(Text003, LoanApp.Status);
        end;
        //guarantors
    end;

    trigger OnInsert()
    var
        Guarantor: Record "Loan Guarantors and Security";
        TotalGuarantors: Integer;
        LoanNo: Code[20];
        RequestedAmount: Decimal;
    begin
        //guarantors



        if LoanApp.Get("Loan No") then begin
            UpdateLoanGroups();
            if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) or (LoanApp.Status = LoanApp.Status::Posted) then
                Error(Text003, LoanApp.Status);
            if LoanApp.Posted = true then
                Error(Text003, LoanApp.Status);
            ProductFactory.Get(LoanApp."Loan Product Type");
            if ProductFactory."Mortgage Loan" = true then Error(MortgageError);

        end;
        Date := Today;


    end;

    trigger OnModify()
    var
        Guarantor: Record "Loan Guarantors and Security";
        TotalGuarantors: Integer;
    begin
        //guarantors

        if LoanApp.Get("Loan No") then begin
            UpdateLoanGroups();
            if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) or (LoanApp.Status = LoanApp.Status::Posted) then
                Error(Text003, LoanApp.Status);
            if LoanApp.Posted = true then
                Error(Text003, LoanApp.Status);
        end;
        Date := Today;

    end;

    trigger OnRename()
    begin

        if LoanApp.Get("Loan No") then begin
            UpdateLoanGroups();
            if (LoanApp.Status = LoanApp.Status::Pending) or (LoanApp.Status = LoanApp.Status::Approved) or (LoanApp.Status = LoanApp.Status::Posted) then
                Error(Text003, LoanApp.Status);
            if LoanApp.Posted = true then
                Error(Text003, LoanApp.Status);

        end;

    end;

    local procedure UpdateLoanGroups()
    var
        loansrec: Record loans;
        Mem: Record Members;
        pfact: Record "Product Factory";
    begin
        if loansrec.Get((Rec."Loan No")) then begin

            pfact.Get((loansrec."Loan Product Type"));
            Rec."Loan Group" := pfact."Loan Group";
            Rec."Loan Groups" := pfact."Loan Group";
            if pfact."Loan Group" = pfact."Loan Group"::"Group Loan" then begin
                if Mem.Get(loansrec."Member No.") then begin
                    Rec."Group Account Nos" := Mem."Group Account No.";

                end;

            end;
        end;
    end;

    var
        Cust: Record "Savings Accounts";
        LoanGuarantors: Record "Loan Guarantors and Security";
        Loans: Record Loans;
        TheLoans: Record Loans;
        LoansR: Record Loans;
        LoansG: Decimal;
        GenSetUp: Record "General Set-Up";
        SelfGuaranteedA: Decimal;
        StatusPermissions: Record "Credit Ledger Entry";
        LoanProduct: Record "Loan Charges";
        TotalGuaranteed: Decimal;
        BalanceRemaining: Decimal;
        LoanGuar: Record "Loan Guarantors and Security";
        TotG: Decimal;
        Members: Record Members;
        SecReg: Record "Securities Register";
        Employer: Record Customer;
        Text001: Label 'Internal staff are not allowed to guarantee loans';
        Text002: Label 'This member has self guaranteed %1 and has a balance of %2';
        LoanApp: Record Loans;
        Text003: Label 'This Loan is already %1 and cannot modify';
        Text004: Label 'This collateral has been used for loan no. %1 and has a outstanding balance of %2';
        LoanGs: Record "Loan Guarantors and Security";
        SavingsAccounts: Record "Savings Accounts";
        SalaryLines: Record "Salary Lines";
        ProductFactory: Record "Product Factory";
        Err0001: Label 'Gurantor salary has not been processed for the past 2 Months';
        Err0003: Label 'This guarantor No %1 has loan No, %2 that is not performing';
        SELFLOAN: Record Loans;
        LoansTopup: Record "Loans Top up";
        SecuritiesRegister: Record "Securities Register";
        MortgageError: Label 'This product is a mortgage Loan and does not require guarantors';
        pfac: Record "Product Factory";
        AmountApplied: Decimal;
        AmountToBeGuaranteed: Decimal;
        RemainingAmount: Decimal;
        NumOfGuarantors: Integer;
        EqualShare: Decimal;
        AppliedAmount: Decimal;
        InUpdateAmountGuaranteed: Boolean;
        maxamountguarantee: Decimal;
        Totalguarantee: Decimal;

}

