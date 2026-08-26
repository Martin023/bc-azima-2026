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
            Caption = 'Account/Collateral No.';
            TableRelation =
            IF ("Guarantor Type" = CONST(Guarantor), "Loan Groups" = FILTER(Normal)) "Savings Accounts"."No." WHERE("Product Category" = filter("Business Deposits" | "BOSA Deposits"))
            ELSE
            IF ("Guarantor Type" = CONST(Guarantor), "Loan Groups" = FILTER("Group Loan")) "Savings Accounts"."No." WHERE("Product Category" = filter("Chama Investment Account"))
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
                EmployerII: record customer;
            begin

                GenSetUp.Get;
                "Self Guarantee" := false;
                SelfGuaranteedA := 0;
                Date := Today;
                if "Guarantor Type" = "Guarantor Type"::Lien then begin
                    SaVingAc.Reset();
                    SaVingAc.SetRange(SaVingAc."No.", Rec."Savings Account No./Member No.");
                    if SaVingAc.FindFirst() then begin
                        Rec."Amount Guaranteed" := SaVingAc."Lien Placed" - LoanAppraisal.GetTotalGuaranteedAmt(SavingsAccounts."Member No.");
                        rec."Deposits/Shares" := SaVingAc."Lien Placed";
                        "Original Amount Guaranteed" := "Amount Guaranteed";
                    end;
                end;
                if "Guarantor Type" = "Guarantor Type"::"Fixed Deposit" then begin
                    FixedDeposit.Reset();
                    FixedDeposit.SetRange(FixedDeposit."No.", Rec."Savings Account No./Member No.");
                    if FixedDeposit.FindFirst() then begin
                        Rec."Amount Guaranteed" := FixedDeposit."Fixed Deposit Amount" - LoanAppraisal.GetTotalGuaranteedAmt(SavingsAccounts."Member No.");
                        rec."Deposits/Shares" := FixedDeposit."Fixed Deposit Amount";
                        "Original Amount Guaranteed" := "Amount Guaranteed";
                    end;
                end;

                SaVingAc.Reset();
                SaVingAc.SetRange(SaVingAc."No.", Rec."Savings Account No./Member No.");
                if SaVingAc.FindFirst() then begin
                    SaVingAc.CalcFields(SaVingAc.Balance);
                    if SaVingAc.Balance <= 0 then begin
                        Error('Member ' + SaVingAc.Name + ' No. ' + SaVingAc."Member No." + ' has no deposits');
                    end;

                    Membersrec.Reset();
                    Membersrec.SetRange("No.", SaVingAc."Member No.");
                    if Membersrec.Find('-') then begin
                        if (Membersrec.Subflag <> Membersrec.Subflag::Rejoined) and (Membersrec.Subflag <> Membersrec.Subflag::"First time") and (Membersrec.Subflag <> Membersrec.Subflag::"Partial withdrawn") then
                            Error('The member ' + Membersrec.Name + ' with subflag  %1 is not allowed to Guarantee', Membersrec.Subflag);
                        //check if defaulter
                        // GlobalFunctions.FlagAccounts(Membersrec."No.");
                    end;

                end;
                //***************RESTRICT GUARANTOR TYPE BASED ON LOAN SECURITY ***********************************************//
                if "Guarantor Type" = "Guarantor Type"::Guarantor then begin
                    if LoanApp.Get(Rec."Loan No") then begin
                        ProductFactory.Reset();
                        ProductFactory.SetRange("Product ID", LoanApp."Loan Product Type");
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
                    if rec."Loan Groups" <> rec."Loan Groups"::"Group Loan" then begin
                        SELFLOAN.Reset;
                        SELFLOAN.SetRange("Loan No.", "Loan No");
                        if SELFLOAN.Find('-') then begin
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange("Member No.", SELFLOAN."Member No.");
                            SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                            if SavingsAccounts.Find('-') then begin
                                if (SavingsAccounts."No." = "Savings Account No./Member No.") then
                                    "Self Guarantee" := true;
                                if "Self Guarantee" then begin
                                    // "Self Guarantee" := true;
                                    "Available Shares" := LoanAppraisal.GetmaxSelfGuaranteeAmt(SavingsAccounts."No.", "Loan No") - LoanAppraisal.GetTotalGuaranteedAmt(SavingsAccounts."Member No.") + LoanAppraisal.GetTotalTopUpLoans("Loan No");
                                    "Amount Guaranteed" := LoanAppraisal.GetmaxSelfGuaranteeAmt(SavingsAccounts."No.", "Loan No") - LoanAppraisal.GetTotalGuaranteedAmt(SavingsAccounts."Member No.") + LoanAppraisal.GetTotalTopUpLoans("Loan No");
                                    "Original Amount Guaranteed" := "Amount Guaranteed";
                                    LoansR."Self Guarantee" := true;
                                end
                                else begin
                                    if (Membersrec."Member Class" = 'CLASSB') then begin
                                        if classBEmployer.get(Membersrec."Employer Code") then begin
                                            if not classBEmployer."Full deposit Guarantee" then begin
                                                "Self Guarantee" := false;
                                                "Available Shares" := LoanAppraisal.GetmaxSelfGuaranteeAmt("Savings Account No./Member No.", "Loan No") - LoanAppraisal.GetTotalGuaranteedAmt(rec."Member No");
                                                "Amount Guaranteed" := LoanAppraisal.GetmaxSelfGuaranteeAmt("Savings Account No./Member No.", "Loan No") - LoanAppraisal.GetTotalGuaranteedAmt(rec."Member No");
                                                "Original Amount Guaranteed" := "Amount Guaranteed";
                                            end
                                            else begin
                                                "Self Guarantee" := false;
                                                "Available Shares" := SavingsAccounts.GetAvailableBalance("Savings Account No./Member No.");
                                                "Amount Guaranteed" := "Available Shares";
                                                "Original Amount Guaranteed" := "Amount Guaranteed";
                                            end;
                                        end;
                                    end
                                    else begin
                                        "Self Guarantee" := false;
                                        "Available Shares" := SavingsAccounts.GetAvailableBalance("Savings Account No./Member No.");
                                        "Amount Guaranteed" := "Available Shares";
                                        "Original Amount Guaranteed" := "Amount Guaranteed";
                                    end;
                                end;
                            end;
                        end;
                    end
                    else begin
                        "Deposits/Shares" := SavingsAccounts.GetAvailableBalance("Savings Account No./Member No.");
                        "Available Shares" := SavingsAccounts.GetAvailableBalance("Savings Account No./Member No.");
                        "Amount Guaranteed" := "Available Shares";
                        "Original Amount Guaranteed" := "Amount Guaranteed";
                        Modify;
                    end;
                    //Evaluate guarantor basic info
                    if Cust.Get("Savings Account No./Member No.") then begin
                        if Members.Get(Cust."Member No.") then begin
                            if (Members.Status <> Members.Status::Active) and (Members.Status <> Members.Status::Dormant) then begin
                                Error('Member %2 No. %1 is not an Active  or Dormant member hence cannot be a guarantor', Members."No.", Members.Name);
                            end;
                        end;

                        if Employer.Get(Cust."Employer Code") then begin
                            if Employer."Internal Staff Employer" = true then begin
                                if Members.Get(Cust."Member No.") then begin
                                    // if "Member Guaranteed" <> cust."Member No." then
                                    //     Error('Employer %1 are not allowed to guarantee.', Cust."Employer Code");
                                    Message('The selected guarantor is a Staff member');
                                end;
                            end;
                        end;

                        Members.Get(Cust."Member No.");
                        Cust.CalcFields(Cust."Balance (LCY)");
                        Name := Cust.Name;
                        //"Staff/Payroll No." := Cust."Payroll/Staff No.";
                        "Deposits/Shares" := Cust.GetAvailableBalance(Cust."No.");
                        "ID No." := Members."Primary Identification";
                        "Member No" := Cust."Member No.";
                        Name := Cust.Name;
                        "Phone No." := Members."Phone No.";
                        //Check if self gauarantee
                    end;

                    GenSetUp.Get;
                    if LoanApp.Get(Rec."Loan No") then begin
                        if FixedDeposit.get(rec."Savings Account No./Member No.") then begin
                            Members.Get(FixedDeposit."Member No.");
                            Name := Members.Name;
                            // "Staff/Payroll No." := Members."Payroll/Staff No.";
                            // "Loan Balance":=Cust."Balance (LCY)";
                            "Deposits/Shares" := FixedDeposit."Fixed Deposit Amount";
                            // "Amount Guaranteed" := cust.GetAvailableBalance(cust."No.");
                            "ID No." := Members."Primary Identification";
                            "Member No" := Members."No.";
                            Name := Members.Name;
                            "Phone No." := Members."Phone No.";
                            "Available Shares" := FixedDeposit."Fixed Deposit Amount" - LoanAppraisal.GetTotalGuaranteedAmt(Members."No.");
                            "Amount Guaranteed" := FixedDeposit."Fixed Deposit Amount" - LoanAppraisal.GetTotalGuaranteedAmt(Members."No.");
                            "Original Amount Guaranteed" := "Amount Guaranteed";
                        end;


                    end
                end else
                    if "Guarantor Type" = "Guarantor Type"::Collateral then begin
                        if Members.Get("Savings Account No./Member No.") then begin
                            Name := Members.Name;
                            "Staff/Payroll No." := Members."Payroll/Staff No.";
                            "ID No." := Members."Primary Identification";
                            "Member No" := "Savings Account No./Member No.";
                            // "No Of Loans Guaranteed" := LoanAppraisal.GetNumberOfLoansGuaranteed("Savings Account No./Member No.", "Guarantor Type"::Collateral);
                        end;
                    end else begin
                        if Cust.Get("Savings Account No./Member No.") then begin
                            if (Cust.Status <> Cust.Status::Active) and (Cust.Status <> Cust.Status::Dormant) then begin
                                Error('Member %2 No. %1 is not an Active Member or Dormant Member and therefore cannot be a guarantor', Cust."No.", Cust.Name);
                            end;
                            Cust.CalcFields(Cust."Balance (LCY)");
                            Name := Cust.Name;
                            "Staff/Payroll No." := Cust."Payroll/Staff No.";
                            // "Loan Balance":=Cust."Balance (LCY)";
                            "Deposits/Shares" := Cust.GetAvailableBalance(Cust."No.");
                            "Amount Guaranteed" := Cust."Lien Placed";
                            "ID No." := Cust."ID No.";
                            "Member No" := Cust."Member No.";
                            Name := Cust.Name;
                            Rec.CalcFields("Total Guaranteed");
                            "Total Guaranteed" := Round(Rec."Total Guaranteed", 0.01);
                            // "No Of Loans Guaranteed" := LoanAppraisal.GetNumberOfLoansGuaranteed(rec."Savings Account No./Member No.", Rec."Guarantor Type");
                            // "Total Guaranteed" := LoanGuar."Amount Guaranteed";
                        end;
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
            Editable = false;

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
            Caption = 'Pledged Deposits';

            trigger OnValidate()
            begin
                //Shares:=Shares*-1;
                //MESSAGE('SHARE %1',Shares);
                TotG := 0;
                if "Amount Guaranteed" > ("Deposits/Shares") then
                    Error('You cannot guarantee more than your shares of %1', "Deposits/Shares");
                if "Amount Guaranteed" > "Available Shares" then Error('You cannot guarantee more than your available shares of %1', "Available Shares");
            end;
        }
        field(12; "Staff/Payroll No."; Code[20])
        {
            trigger OnValidate()
            begin
                // Cust.Reset;
                // Cust.SetRange(Cust."Payroll/Staff No.", "Staff/Payroll No.");
                // Cust.SetRange(Cust."Loan Security Inclination", Cust."Loan Security Inclination"::"Long Term Loan Security");
                // if Cust.Find('-') then begin
                //     "Savings Account No./Member No." := Cust."No.";
                //     Validate("Savings Account No./Member No.");
                // end
                // else begin
                //     "Savings Account No./Member No." := '';
                //     Error('Member deposits account not found.');
                // end;
                //     "Member Guaranteed" := '';
                //     "Loanee Name" := '';
                //     Name := '';
                //    /// "Staff/Payroll No." := '';
                //     "Deposits/Shares" := 0;
                //     "ID No." := '';
                //     "Member No" := '';
                //     Name := '';
                //     "Phone No." := '';
                //     "Savings Account No./Member No." := '';

                if (rec."Employer Code" <> '') and (rec."Staff/Payroll No." <> '') then begin
                    Members.Reset();
                    Members.SetRange(Members."Payroll/Staff No.", Rec."Staff/Payroll No.");
                    Members.SetRange(Members."Employer Code", Rec."Employer Code");
                    if Members.FindFirst() then begin
                        if rec."Guarantor Type" = rec."Guarantor Type"::Guarantor then begin
                            Cust.reset();
                            Cust.SetRange(Cust."Member No.", Members."No.");
                            Cust.setrange("Product Category", Cust."Product Category"::"BOSA Deposits");
                            if Cust.FindFirst() then begin
                                //Rec."Savings Account No./Member No." := Cust."No.";
                                //Rec.Modify(true);
                                Validate(Rec."Savings Account No./Member No.", Cust."No.");
                            end
                            else begin
                                //"Savings Account No./Member No." := '';
                                Error('Member deposits account not found.');
                            end;
                        end;
                        if rec."Guarantor Type" = rec."Guarantor Type"::Collateral then begin
                            validate(Rec."Savings Account No./Member No.", Members."No.")
                        end;

                    end
                    else
                        Message('Member deposits account not found for the specified employer code %1 and staff/payroll number %2', Rec."Employer Code", Rec."Staff/Payroll No.");

                end
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
        // field(18; "Percentage Guaranteed"; Decimal)
        // {
        // }
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
            Editable = false;
        }
        // field(21; Signature; BLOB)
        // {
        // }
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
        // field(24; "Guaranteed Balance"; Decimal)
        // {
        // }
        field(25; "Loanee Name"; Text[150])
        {
            Editable = false;
        }
        field(26; "Guarantor Type"; Enum "Loan Guarantor Types Enum")
        {

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
                GuaranteedAmt: Decimal;
                perfecion: Record "Securities Register";
            begin
                if "Guarantor Type" = "Guarantor Type"::Collateral then begin
                    GuaranteedAmt := 0;
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
                    LoanGuar.SetRange(Substituted, false);
                    if LoanGuar.Find('-') then begin
                        Error('This Collateral is being used in another loan %1 - %2', LoanGuar."Loan No", LoanGuar."Loan Product Name");
                    end;
                end
                else
                    Error('Collateral Registration Number is only applicable for collateral guarantors');
                SecReg.Reset;
                SecReg.SetRange("No.", "Collateral Reg. No.");
                if SecReg.Findfirst then begin
                    "Amount Guaranteed" := SecReg."Collateral Limit" - GuaranteedAmt;
                    "Available Shares" := SecReg."Collateral Limit" - GuaranteedAmt;
                end;
            end;
        }
        field(28; "Collateral Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Securities Register"."Forced Sale Value" where("Account No." = field("Savings Account No./Member No.")));
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
        // field(32; test; Integer)
        // {
        // }
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
        // field(41; "Proportion Guaranteed"; decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     Editable = false;
        // }
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
        field(45; "Source Unit"; Enum "Source Unit")
        {
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
            OptionMembers = "BC",CRM,"Member Portal","Mbanking - APP","Mbanking - USSD";
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
        field(67; "Employer Code"; Code[20])
        {
            Tablerelation = Customer."No." WHERE("Account Type" = const("Employer Code"));
            DataClassification = ToBeClassified;
        }
        field(59; Released; boolean)
        {
            Description = 'Released Guarantor';
            FieldClass = Normal;
            Editable = false;
            trigger OnValidate()
            begin
                // if rec.Released then rec.TestField(Substituted, false);
            end;
        }
        field(60; "Released By"; Code[20])
        {
            Description = 'Released By';
            FieldClass = Normal;
            Editable = false;
        }
        field(61; "Released Date"; Date)
        {
            Description = 'Released Date';
            FieldClass = Normal;
            Editable = false;
        }
        field(62; "Added Later"; Boolean)
        {
            FieldClass = Normal;
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
        TotalGuaranteed: Decimal;
        BalanceRemaining: Decimal;
        LoanGuar: Record "Loan Guarantors and Security";
        TotG: Decimal;
        Members: Record Members;
        SecReg: Record "Securities Register";
        Employer: Record Customer;
        Text002: Label 'This member has self guaranteed %1 and has a balance of %2';
        LoanApp: Record Loans;
        Text003: Label 'This Loan is already %1 and cannot modify';
        Text004: Label 'This collateral has been used for loan no. %1 and has a outstanding balance of %2';
        LoanGs: Record "Loan Guarantors and Security";
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        SELFLOAN: Record Loans;
        LoansTopup: Record "Loans Top up";
        SecuritiesRegister: Record "Securities Register";
        MortgageError: Label 'This product is a mortgage Loan and does not require guarantors';

        maxamountguarantee: Decimal;
        Totalguarantee: Decimal;
        LoanAppraisal: Codeunit "Loan Appraisal Codeunit";
        classBEmployer: record Customer;



}

