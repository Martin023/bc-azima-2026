table 52187301 "Self Loan Application"
{

    fields
    {
        field(1; "Application Code"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Application Code" <> xRec."Application Code" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Self Service Loan Nos.");
                    "No series" := '';
                end;
            end;
        }
        field(2; "Loan Type"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID" WHERE("Product Class Type" = CONST(Loan),

                                                                  //Status = CONST(Active)}, 
                                                                  "Source Unit" = filter("HR LOANS"));



            trigger OnValidate()
            begin
                ProdFac.get("Loan Type");
                "Loan Product Type Name" := ProdFac."Product Description";
                Interest := ProdFac."Interest Rate (Min.)";
                "Interest Calculation Method" := ProdFac."Interest Calculation Method";
                Installments := ProdFac."Ordinary Default Intallments";
                "Repayment Frequency" := ProdFac."Repayment Frequency";
            end;
        }

        field(3; "Application Date"; Date)
        {
        }
        field(4; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;

            trigger OnValidate()
            begin

            end;
        }
        field(5; "Applicant Comments"; Text[250])
        {
        }
        field(6; "No series"; Code[30])
        {
        }


        field(7; Submitted; Boolean)
        {
        }
        field(8; "Submitted By"; Text[50])
        {
        }
        field(9; "Date Submitted"; Date)
        {
        }
        field(10; "Time Submitted"; Time)
        {
        }
        field(11; "Job Tittle"; Text[50])
        {
        }
        field(12; "Applicant User ID"; Code[50])
        {
        }
        field(13; "Applicant Staff No."; Code[20])
        {
            TableRelation = "HR Employees"."No.";
            trigger OnValidate()
            var
                SavingsAc: Record "Savings Accounts";
                AvailBal: Decimal;
            begin
                AvailBal := 0;
                Member.reset;
                Member.setrange("Payroll/Staff No.", rec."Applicant Staff No.");
                if Member.find('-') then begin
                    Rec."Member No." := member."No.";
                    rec."Global Dimension 1 Code" := Member."Global Dimension 1 Code";
                    rec."Global Dimension 2 Code" := Member."Global Dimension 2 Code";
                    rec."Responsibility Center" := Member."Responsibility Center";
                    Rec."Responsibility Center" := Member."Responsibility Center";
                    Rec."ID No" := Member."Primary Identification";
                    Rec."Application Date" := today;
                    Rec."Applicant User ID" := UserId;
                    Validate("Global Dimension 1 Code");
                    Validate("Global Dimension 2 Code");
                    Validate("Member No.");
                    SavingsAc.Reset();
                    SavingsAc.SetRange("Member No.", Member."No.");
                    SavingsAc.SetRange("Product Category", SavingsAc."Product Category"::"FOSA Account");
                    if SavingsAc.FindFirst() then begin
                        AvailBal := SavingsAc.GetAvailableBalance(SavingsAc."No.");
                        Rec."Member Deposits" := AvailBal;
                    end;
                end else
                    error('Member Not found.');
            end;

        }
        field(14; "Applicant Supervisor"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(15; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR".Code WHERE(Code = FILTER(<> ''));
        }

        field(16; "Employee Name"; Text[100])
        {
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                "Global Dimension 1 Name" := '';
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Global Dimension 1 Code");
                if DimValue.Find('-') then begin
                    "Global Dimension 1 Name" := DimValue.Name;
                end;
            end;
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                "Global Dimension 2 Name" := '';
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Global Dimension 2 Code");
                if DimValue.Find('-') then begin
                    "Global Dimension 2 Name" := DimValue.Name;
                end;
            end;
        }
        field(19; "Global Dimension 1 Name"; Text[60])
        {
            Editable = false;
        }
        field(20; "Global Dimension 2 Name"; Text[60])
        {
            Editable = false;
        }
        field(21; "Member No."; Code[20])
        {
            TableRelation = Members."No.";

            trigger OnValidate()
            begin
            end;
        }

        field(22; Interest; Decimal)
        {

            trigger OnValidate()
            begin
                TestField("Loan Type");
                if ProdFac.Get("Loan Type") then begin
                end;

                if "Requested Amount" > 0 then
                    Validate("Requested Amount");


                //compute expected end date based on application date
                if ProdFac.Get("Loan Type") then begin
                    if Format(ProdFac."Grace Period - Principle") <> '' then begin
                        IntstallMentPeriodText := Format(Installments) + 'M';
                        Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                        "Expected Date of Completion" := CalcDate(InstalmentPeriods, "Application Date");
                    end else begin
                        IntstallMentPeriodText := Format(Installments) + 'M';
                        Evaluate(InstalmentPeriods, IntstallMentPeriodText);
                        "Expected Date of Completion" := CalcDate(InstalmentPeriods, "Application Date");
                    end;
                end;

                ProdFac.Get("Loan Type");

                Interest := ProdFac."Interest Rate (Max.)";
            end;
        }
        field(23; "Member Name"; Text[100])
        {
        }

        field(24; Installments; Integer)
        {

            trigger OnValidate()
            var
                adj: Integer;
                RetirementDate: Date;
            begin
                //Control
                if ProdFac.Get("Loan Type") then begin
                    if ProdFac."Mortgage Loan" = true then begin
                        if "Member No." = '' then Error('Kindly Select Member applying for this loan');
                        GenSetup.Get();
                        if Mem.Get("Member No.") then begin
                            RetirementDate := CalcDate(Format(GenSetup."Max. Member Age"), Mem."Date of Birth");
                            if Mem."Employer Code" <> '99' then begin
                                // if Mem.Type <> Mem.Type::"From Other Sacco" then begin

                            end else begin
                                if Mem."Account Type" = Mem."Account Type"::"Single Member Account" then begin
                                    // ClientAge := HRDates.DetermineAge("Retirement/Expiry Date", TODAY);
                                    // ClientAgePart := COPYSTR(ClientAge, 1, 2);
                                    // ClientAgePart := COPYSTR(ClientAge, 1, 2);
                                    // EVALUATE(ClientAgeValue, ClientAgePart);
                                    RetirementDate := "Retirement/Expiry Date";
                                    adj := Round((((RetirementDate - "Application Date") / 365) * 12), 1, '<');
                                    if Installments > adj then
                                        Installments := adj
                                    else
                                        Installments := Installments;
                                end;
                            end;
                        end;

                        Validate(Interest);
                    end;
                end;

                if ProdFac.Get("Loan Type") then begin
                    if Installments > ProdFac."Ordinary Default Intallments" then
                        Error(Text006);
                end;

                if "Requested Amount" > 0 then
                    Validate("Requested Amount");

            end;
        }

        field(26; "Requested Amount"; Decimal)
        {
            trigger OnValidate()
            var
                Employerate: Decimal;
                Loanrec: Record Loans;
                AmountTaken: Decimal;
            begin

                ProdFac.Reset;
                ProdFac.SetRange("Product ID", Rec."Loan Type");
                if ProdFac.FindFirst then begin
                    //  IF "Picked Mobile Loan"=FALSE THEN BEGIN
                    if (ProdFac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::Normal) or (ProdFac."Nature of Loan Type" = ProdFac."Nature of Loan Type"::" ") then begin
                        if ("Requested Amount" > ProdFac."Maximum Loan Amount") or ("Requested Amount" < ProdFac."Minimum Loan Amount") then begin
                            Error(LoanAmountErr, ProdFac."Minimum Loan Amount", ProdFac."Maximum Loan Amount");
                            //  END;
                        end;
                    end;
                end;

                if Rec.Installments <= 0 then
                    Error(InstallmentsErr);

                if "Requested Amount" > "Requested Amount" then
                    Error(ApprovedAmtErr);
                ShareCapAcc.RESET;
                ShareCapAcc.SETRANGE(ShareCapAcc."Member No.", "Member No.");
                ShareCapAcc.SETRANGE(ShareCapAcc."Product Category", ShareCapAcc."Product Category"::"Share Capital");
                IF ShareCapAcc.FIND('-') THEN BEGIN
                    if SavProducts.Get(ShareCapAcc."Product Type") then begin
                        ShareCapAcc.CALCFIELDS(ShareCapAcc."Balance (LCY)");
                        IF ShareCapAcc."Balance (LCY)" < SavProducts."Minimum Balance" THEN
                            MESSAGE('Member no. %1 has share capital of %2 and minimum required share capital is %3.', "Member No.", ShareCapAcc."Balance (LCY)", SavProducts."Minimum Balance");
                    end;
                END ELSE
                    MESSAGE('Member does not  have share capital account.');

                //
                TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                InterestRate := Interest;
                LoanAmount := "Requested Amount";
                RepayPeriod := Installments;
                LBalance := "Requested Amount";

                if InterestRate <> 0 then begin
                    EmployerProducts.Reset();
                    EmployerProducts.SetRange("Product ID", Rec."Loan Type");
                    if EmployerProducts.FindFirst() then begin
                        Employerate := EmployerProducts.Interest;
                        if Employerate = 0 then
                            Employerate := InterestRate
                        else
                            Employerate := Employerate;
                    End;
                    if "Interest Calculation Method" = "Interest Calculation Method"::Amortised then begin
                        TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                        LInterest := Round(LBalance / 100 / 12 * InterestRate, 0.05, '>');

                        Repayment := TotalMRepay;
                        LPrincipal := TotalMRepay - LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                        "Repayment" := Round(TotalMRepay, 1, '>');
                    end;


                    if "Interest Calculation Method" = "Interest Calculation Method"::"Straight Line" then begin
                        TestField(Interest);
                        TestField(Installments);
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                        LInterest := Round((InterestRate / 12 / 100) * LoanAmount, 1, '>');
                        Repayment := round((LPrincipal + LInterest), 1, '>');
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                    end;

                    if "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Balance" then begin
                        TestField(Interest);
                        TestField(Installments);
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                        //LPrincipal:=LoanAmount/RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                        Repayment := round(LPrincipal, 1, '>');
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;

                    end;

                    if "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Flat" then begin
                        TestField(Interest);
                        TestField(Installments);
                        //TotalMRepay:=ROUND((InterestRate/12/100) / (1 - POWER((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount,1,'>');
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                        //AmortisedInt:=TotalMRepay*Installments-"Requested Amount";
                        LInterest := Round(((LoanAmount * Interest / 12 / 100) + (LPrincipal * Interest / 12 / 100)) / 2, 1, '>');
                        //LInterest:=AmortisedInt/Installments;
                        Repayment := Round((LPrincipal + LInterest), 1, '>');
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;

                    end;

                end else begin
                    LPrincipal := LoanAmount / RepayPeriod;
                    Repayment := ROUND(LPrincipal, 1, '>');
                end;
            end;
        }
        field(27; "Loan Product Type Name"; Text[80])
        {
        }
        field(28; "Interest Calculation Method"; Option)
        {
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Reducing Flat,Zero Interest';
            OptionMembers = Amortised,"Reducing Balance","Straight Line","Reducing Flat","Zero Interest";
        }
        field(29; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quarterly,Bi-Annual,Yearly';
            OptionMembers = Daily,Weekly,Monthly,Quarterly,"Bi-Annual",Yearly;
        }
        field(30; "Expected Date of Completion"; Date)
        {
        }

        field(31; "Retirement/Expiry Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Retirement/Expiry Date" <> 0D then
                    if "Retirement/Expiry Date" < Today then Error('This date cannot be less than today');
                Validate(Installments);
            end;
        }
        field(32; Repayment; Decimal)
        {

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec.Repayment);
                // if ("Recovery Mode" = "Recovery Mode"::Checkoff) or ("Loan Product Type" = '133') then
                //     CheckoffAdvice.LoanCheckoffAdvice(LoanRec, Repayment, xRec.Repayment);
            end;
        }
        field(33; "Loan Principle Repayment"; Decimal)
        {
        }
        field(34; "Loan Interest Repayment"; Decimal)
        {
        }
        field(35; "Purpose of Loan"; Code[200])
        {
            TableRelation = "Loan Purpose".Code;
            trigger OnValidate()
            var
                myInt: Integer;
                ProductSet: Record "Product Factory";
            begin
                if ProductSet.get(rec."Purpose of Loan") then begin
                    if rec."Purpose of Loan" <> ProductSet."Loan Purpose" then
                        Error('kindly select the correct loan purpose');
                end;
            end;
        }
        field(36; "Member Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Date Of Join"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(39004286; "Main Sector"; Code[20])
        {
            TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Main Sector"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Sub Sector Level1" := '';
                "Sub Sector Level1 Description" := '';
                "Sub Sector Level2" := '';
                "Sub Sector Level2 Description" := '';
                if SectoralClassification.Get(rec."Main Sector") then
                    "Main Sector Description" := SectoralClassification."Sector Description";
            end;
        }
        field(39004287; "Main Sector Description"; Text[100])
        {

            Editable = false;
        }
        field(39004288; "Sub Sector Level1"; Code[20])
        {
            TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Sub Sector Level 1"), "Parent Sector" = field("Main Sector"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Sub Sector Level2" := '';
                "Sub Sector Level2 Description" := '';
                SectoralClassification.Reset();
                if SectoralClassification.Get(rec."Sub Sector Level1") then
                    "Sub Sector Level1 Description" := SectoralClassification."Sector Description";
            end;
        }
        field(39004289; "Sub Sector Level1 Description"; Text[100])
        {
            Editable = false;
        }
        field(39004290; "Sub Sector Level2"; Code[20])
        {
            TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Sub Sector Level 2"), "Parent Sector" = field("Sub Sector Level1"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if SectoralClassification.Get(rec."Sub Sector Level2") then
                    "Sub Sector Level2 Description" := SectoralClassification."Sector Description";
            end;
        }
        field(39004291; "Sub Sector Level2 Description"; Text[100])
        {
            Editable = false;
        }
        field(1030; "Return To user"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(1032; "ID No"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Application Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Application Code", "Loan Type")
        {
        }
    }

    trigger OnDelete()
    begin
        //ERROR('Please edit document instead of deleting');
    end;

    trigger OnInsert()
    begin
        //No. Series
        if "Application Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Self Service Loan Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Self Service Loan Nos.", xRec."No series", 0D, "Application Code", "No series");
        end;

        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            HREmp.TestField(HREmp."Date Of Join");
            //Populate fields
            UserSetUp.Get(UserId);
            "Applicant Staff No." := HREmp."No.";
            Validate("Applicant Staff No.");
            "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            "Application Date" := Today;
            "Applicant User ID" := UserId;
            "Date Of Join" := HREmp."Date Of Join";
            "Retirement Date" := HREmp."Retirement date";
            "Job Tittle" := HREmp."Job Title";
            "Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
            "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
            "Responsibility Center" := UserSetUp."Responsibility Centre";
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmp: Record "HR Employees";

        ApprovalComments: Record "Approval Comment Line";

        intEntryNo: Integer;
        Member: Record Members;

        DimValue: Record "Dimension Value";
        LeaveAllowances: Record "Leave Allowances";
        prVitalSetup: Record "PR Vital Setup Info";
        PRSalCard: Record "PR Salary Card";
        UserSetUp: Record "User Setup";
        ProdFac: Record "Product Factory";
        SavProducts: Record "Product Factory";
        InstalmentPeriods: DateFormula;
        IntstallMentPeriodText: Text;
        GenSetup: Record "General Set-Up";
        SectoralClassification: Record "Sectoral Classification";
        Mem: Record Members;
        ClientAge: Text;
        HRDates: Codeunit "HR Dates 2";
        Text005: Label 'This Member age is less than the limit of %1';
        ClientAgeValue: Integer;
        ClientAgePart: Text;

        TotalMRepay: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Integer;
        EmployerProducts: Record "52187008 Employer Product Attr";
        LBalance: Decimal;
        Text006: Label 'You cannot exceed the maximum installments';
        ShareCapAcc: record "Savings Accounts";
        "InactiveErr:": Label 'This member account is not active';
        LoanAmountErr: Label 'Amount applied for this product is not within allowed margins Min %1 Max %2';
        InstallmentsErr: Label 'Number of installments must be greater than Zero.';
        DateErr: Label 'The date is invalid. It should not be in the past';
        DisbErr: Label 'The amount to disburse cannot be greater than or equal to approved amount';
        ApprovedAmtErr: Label 'The approved amount cannot be greater than requested amount';
        AmountToDisb: Label 'Amount to disburse cannot be greater than approved amount';
        Text002: Label 'Amount to disburse must be equal to amount approved';

    [Scope('OnPrem')]
    procedure GetApplicantSupervisor(EmpUserID: Code[50]) SupervisorID: Code[10]
    var
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        HREmp2: Record "HR Employees";
    begin
        SupervisorID := '';

        UserSetup.Reset;
        if UserSetup.Get(EmpUserID) then begin
            UserSetup.TestField(UserSetup."Approver ID");

            //Get supervisor e-mail
            UserSetup2.Reset;
            if UserSetup2.Get(UserSetup."Approver ID") then begin
                UserSetup2.TestField(UserSetup2."E-Mail");
                "Applicant Supervisor" := UserSetup."Approver ID";
            end;
        end;
    end;
}

