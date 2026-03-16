table 52186168 "HR Staff Loan Request"
{

    fields
    {
        field(1; "Loan No."; Code[50])
        {
        }
        field(2; "Loan Description"; Text[100])
        {
        }
        field(3; "Loan Type"; Code[50])
        {
            TableRelation = "HR Staff Loan Typess".Code;

            trigger OnValidate()
            begin
                if HRLoanTypes.Get("Loan Type") then begin
                    "Loan Description" := HRLoanTypes."Product Description";
                    Interest := HRLoanTypes."Interest rate";
                    "No of Instalments" := HRLoanTypes."No of Installment";
                    "Repayment Frequency" := HRLoanTypes."Repayment Frequency";
                    "Grace Period - Principle (M)" := HRLoanTypes."Grace Period - Principle (M)";
                    "Grace Period - Interest (M)" := HRLoanTypes."Grace Period - Interest (M)";
                    "Payroll Code" := HRLoanTypes."Payroll Code";
                    HREmp.Reset;
                    HREmp.SetRange(HREmp."No.", "Emp No.");
                    if HREmp.Find('-') then begin
                        EmpDate := CalcDate(HRLoanTypes."Min Application Period", HREmp."Date Of Join");
                        if EmpDate > Today then begin
                            //IF (TODAY-HREmp."Date Of Joining the Company")<=HRLoanTypes."Min Application Period" THEN BEG IN
                            Error('You have not reached the minimum %1 years to take this loan', HRLoanTypes."Min Application Period");
                        end;
                    end
                end;

                objLoanApps.Reset;
                objLoanApps.SetRange(objLoanApps."Emp No.", "Emp No.");
                objLoanApps.SetRange(objLoanApps."Loan Type", "Loan Type");
                objLoanApps.SetRange(objLoanApps.Posted, false);
                if objLoanApps.Find('-') then begin
                    repeat
                        if objLoanApps.Status <> objLoanApps.Status::Rejected then begin
                            if objLoanApps."Loan No." <> "Loan No." then
                                Error('You already have an existing %1 application: - %3', objLoanApps."Loan Description", objLoanApps."Loan No.");
                        end;
                    until objLoanApps.Next = 0;

                end;

                if "Loan Type" = 'HR001' then begin

                end
            end;
        }
        field(4; "Emp No."; Code[50])
        {
        }
        field(5; "Emp Name"; Text[200])
        {
        }
        field(6; "Request Date"; Date)
        {
        }
        field(7; "User ID"; Code[50])
        {
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility CenterBR".Code;
        }
        field(11; "Date Created"; Date)
        {
        }
        field(12; "Amount Requested"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Amount Approved" > "Amount Requested" then
                    Error('AMount Approved cannot be more than Amount Requested')
            end;
        }
        field(13; "Amount Approved"; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin
                "Undisbursed Amount" := "Amount Approved" - "Amount Disbursed";
                if "Amount Approved" > "Amount Requested" then
                    Error('Requested Amount cannot be less than the approved amount');

                "flat rate interest" := 0;
                "Flat Rate Principal" := 0;
                Repayment := 0;
                "Total Repayment" := 0;

                if "No of Instalments" <= 0 then
                    Error('Number of installments must be greater than Zero.');


                TotalMRepay := 0;
                lPrincipal := 0;
                linterest := 0;
                InterestRate := Interest;
                LoanAmount := "Amount Approved";
                RepayPeriod := "No of Instalments";
                LBalance := "Amount Approved";

                //+++++++++++++++++++++++++If Amortization++++++++++++++++++++++++++

                if "Repayment Method" = "Repayment Method"::Amortised then begin
                    //IF "Loan Product Type"='DEFAULTER' THEN BEGIN
                    //LPrincipal:=ROUND(LoanAmount/RepayPeriod,1,'>');
                    //Repayment:=LPrincipal;
                    //END ELSE BEGIN
                    TestField(Interest);
                    TestField("No of Instalments");
                    TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 0.05, '>');
                    linterest := Round(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                    lPrincipal := TotalMRepay - linterest;
                    Repayment := lPrincipal + linterest;
                    //"Adjust Repayment":=LPrincipal+LInterest;
                    "Loan Principal Repayment" := lPrincipal;
                    "Loan Interest Repayment" := linterest;
                    //END;
                end;

                if "Repayment Method" = "Repayment Method"::"Straight line" then begin
                    TestField("No of Instalments");
                    lPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                    linterest := Round((InterestRate / 100 / 12) * LoanAmount, 1, '>');
                    Repayment := lPrincipal + linterest;
                    //"Adjust Repayment":=LPrincipal+LInterest;
                    "Loan Principal Repayment" := lPrincipal;
                    "Loan Interest Repayment" := linterest;
                end;

                //Repayments for reducing balance method
                if "Repayment Method" = "Repayment Method"::"Reducing Balance" then begin
                    TestField(Interest);
                    TestField("No of Instalments");
                    lPrincipal := LoanAmount / RepayPeriod;
                    linterest := (InterestRate / 12 / 100) * LBalance;
                    Repayment := lPrincipal + linterest;
                    //"Adjust Repayment":=LPrincipal+LInterest;
                    "Loan Principal Repayment" := lPrincipal;
                    "Loan Interest Repayment" := linterest;
                end;
            end;
        }
        field(14; Interest; Decimal)
        {
        }
        field(15; "Total Amount Approved"; Decimal)
        {
            Description = 'Total Amount Approved inclusive of interest';
        }
        field(16; "Instalments Amount"; Decimal)
        {
        }
        field(17; "No of Instalments"; Decimal)
        {
        }
        field(18; "Amount Paid"; Decimal)
        {
            // TableRelation = "prStatutory Exemptions".Recurring WHERE (Field26 = FIELD ("Loan No."));
        }
        field(19; Balance; Decimal)
        {
        }
        field(20; Picture; BLOB)
        {
        }
        field(21; "Supervisor Email"; Text[50])
        {
        }
        field(22; Supervisor; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(23; "No series"; Code[30])
        {
        }
        field(24; Selected; Boolean)
        {
        }
        field(25; Status; Option)
        {
            Editable = true;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(26; "Number of Previous Attempts"; Text[200])
        {
        }
        field(27; "Job Tittle"; Text[50])
        {
        }
        field(28; "Repayment Frequency"; Option)
        {
            OptionMembers = Daily,Weekly,Monthly,Quaterly,Yearly;
        }
        field(29; "Loan Disbursement Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Loan Disbursement Date" > Today then
                    Error('Disbursement date cannot be in the future');
            end;
        }
        field(30; "Repayment Start Date"; Date)
        {
        }
        field(31; "Repayment Method"; Option)
        {
            OptionMembers = "Reducing Balance",Amortised,"Straight line",Constants;
        }
        field(32; "Batch No."; Code[10])
        {
            TableRelation = "HR Batches"."Batch No.";
        }
        field(33; "Account No."; Code[30])
        {
        }
        field(34; Posted; Boolean)
        {
        }
        field(35; "Amount Disbursed"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "Undisbursed Amount" := "Amount Approved" - "Amount Disbursed";
            end;
        }
        field(36; "Fully Disbursed"; Boolean)
        {
            Editable = false;
        }
        field(37; "Undisbursed Amount"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(38; "Amount to Disperse"; Decimal)
        {

            trigger OnValidate()
            begin
                if ("Amount Disbursed" + "Amount to Disperse") > "Amount Approved" then
                    Error('Amount to Disburse cannot be more than Undisbursed Amount');
                if "Loan Type" = '105' then begin
                    if "Amount Disbursed" = 0 then begin
                        if "Amount to Disperse" > "Amount Approved" * 0.1 then
                            Error('You can only disburse 10% or less of the approved amount during the first disbursement');
                    end
                end
            end;
        }
        field(39; "Car Reg No"; Code[20])
        {
        }
        field(40; "Log Book No"; Code[20])
        {
        }
        field(41; "Driving Licence No"; Code[20])
        {
        }
        field(42; "Grace Period - Principle (M)"; Integer)
        {

            trigger OnValidate()
            begin

                //"No of Instalments":="Installment Including Grace"-"Grace Period - Principle (M)"
            end;
        }
        field(43; "Grace Period - Interest (M)"; Integer)
        {
        }
        field(44; Repayment; Decimal)
        {
        }
        field(45; "Loan Principal Repayment"; Decimal)
        {
        }
        field(46; "Loan Interest Repayment"; Decimal)
        {
        }
        field(47; "Insurance Company"; Text[30])
        {
        }
        field(48; "Insurance No."; Code[10])
        {
        }
        field(49; "Instalment Period"; DateFormula)
        {
        }
        field(50; "New Car"; Boolean)
        {

            trigger OnValidate()
            begin
                CarLoan.Reset;
                CarLoan.SetRange(CarLoan."Loan type", "Loan Type");
                CarLoan.SetRange(CarLoan.New, "New Car");
                if CarLoan.Find('-') then begin
                    "No of Instalments" := CarLoan.Installments;
                end
            end;
        }
        field(51; "Customer No."; Code[30])
        {
        }
        field(52; "Interest Due"; Decimal)
        {
        }
        field(53; "Interest Paid"; Decimal)
        {
        }
        field(54; "Outstanding Interest"; Decimal)
        {
        }
        field(55; "Payroll Code"; Code[10])
        {
        }
        field(56; NetPay; Decimal)
        {
        }
        field(57; Plot; Boolean)
        {
        }
        field(58; Building; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Status <> Status::New then
            Error('This Loan has already been send for approval. You cannot Delete!');
    end;

    trigger OnInsert()
    begin
        //---------GENERATE NEW NUMBER FOR THE DOCUMENT-----------------------------------
        if "Loan No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Loan Application Nos.");
            "Loan No." := NoSeriesMgt.GetNextNo(HRSetup."Loan Application Nos.");
            // NoSeriesMgt.InitSeries(HRSetup."Loan Application Nos.", xRec."No series", 0D, "Loan No.", "No series");
        end;
        //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE LEAVE APPLICATION TABLE
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            "Emp No." := HREmp."No.";

            //---------------------------------------------------------------------
            HREmp.Get(HREmp."No.");
            HREmp.CalcFields(HREmp.Picture);
            Picture := HREmp.Picture;
            "User ID" := UserId;
        end else begin
            Error('User id' + ' ' + '[' + UserId + ']' + ' has not been assigned to any employee. Please consult the HR officer for assistance')
        end;
        //GET LOAN APPROVER DETAILS FROM USER SETUP TABLE COPY THEM TO THE LOAN APPLICATION TABLE
        UserSetup.Reset;
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Approver ID");
            Supervisor := UserSetup."Approver ID";
            UserSetup.Reset;
            if UserSetup.Get(Supervisor) then
                "Supervisor Email" := UserSetup."E-Mail";
        end;

        //POPULATE FIELDS
        "Date Created" := Today;
        "Request Date" := Today;
        if HREmp.Get("Emp No.") then begin
            "Emp Name" := HREmp."First Name";
            "Global Dimension 1 Code" := HREmp."Department Code";
            "Global Dimension 2 Code" := HREmp.Office;
            "Responsibility Center" := HREmp."Vehicle Registration Number";
            Account := HREmp."No.";
        end;
    end;

    trigger OnModify()
    begin
        /*objLoanApps.RESET;
        objLoanApps.SETRANGE(objLoanApps."Loan No.","Loan No.");
        IF objLoanApps.FIND('-') THEN BEGIN
        IF objLoanApps.Status<>objLoanApps.Status::New THEN
        ERROR('This Loan has already been send for approval. You cannot edit!');
        END*/

    end;

    var
        HRSetup: Record "HR Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        HREmp: Record "HR Employees";
        HRLoanTypes: Record "HR Staff Loan Typess";
        BaseCalendarChange: Record "Base Calendar Change";
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        // SMTP: Codeunit "SMTP Mail";
        "LineNo.": Integer;
        ApprovalComments: Record "Approval Comment Line";
        URL: Text[500];
        sDate: Record Date;
        Customized: Record "HR Leave Calendar Lines";
        HREmailParameters: Record "HR E-Mail Parameters";
        intEntryNo: Integer;
        Calendar: Record Date;
        empMonths: Integer;
        objLoanApps: Record "HR Staff Loan Request";
        Account: Code[20];
        member: Record "HR Succession Job Rotation";
        "flat rate interest": Integer;
        "Flat Rate Principal": Integer;
        Repayment: Decimal;
        "Total Repayment": Decimal;
        TotalMRepay: Decimal;
        lPrincipal: Decimal;
        linterest: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Decimal;
        LoanAmount: Decimal;
        LBalance: Decimal;
        Vend: Record Vendor;
        CarLoan: Record "HR Car Loan Setup";
        EmpDate: Date;
}

