table 52185674 "prSalary Advance"
{
    DataCaptionFields = "Requisition No.", "Employee Names";

    fields
    {
        field(1; "Requisition No."; Code[20])
        {
        }
        field(5; "Application Date"; Date)
        {
        }
        field(10; "Loan Types"; Option)
        {
            OptionCaption = ' ,Salary Advance,Mortgage,Car Loan';
            OptionMembers = " ","Salary Advance",Mortgage,"Car Loan";

            trigger OnValidate()
            begin
                /*
           IF "Requisition No."='' THEN BEGIN

             IF "Loan Types"="Loan Types"::"Salary Advance" THEN BEGIN
               prSetup.GET;
               prSetup.TESTFIELD("Salary Advance Nos.");
               NoSeriesMgt.InitSeries(prSetup."Salary Advance Nos.",xRec."No. Series",0D,"Requisition No.","No. Series");

             END ELSE IF "Loan Types"="Loan Types"::Mortgage THEN BEGIN
               prSetup.GET;
               prSetup.TESTFIELD("Mortgage Nos.");
               NoSeriesMgt.InitSeries(prSetup."Mortgage Nos.",xRec."No. Series",0D,"Requisition No.","No. Series");

             END ELSE IF "Loan Types"="Loan Types"::"Car Loan" THEN BEGIN
               prSetup.GET;
               prSetup.TESTFIELD(prSetup."Car Loan Nos.");
               NoSeriesMgt.InitSeries(prSetup."Car Loan Nos.",xRec."No. Series",0D,"Requisition No.","No. Series");
             END;

           END ELSE  BEGIN
             IF "Loan Types"="Loan Types"::"Salary Advance" THEN BEGIN
               prSetup.GET;
               prSetup.TESTFIELD("Salary Advance Nos.");
               NoSeriesMgt.InitSeries(prSetup."Salary Advance Nos.",xRec."No. Series",0D,"Requisition No.","No. Series");

             END ELSE IF "Loan Types"="Loan Types"::Mortgage THEN BEGIN
               prSetup.GET;
               prSetup.TESTFIELD("Mortgage Nos.");
               NoSeriesMgt.InitSeries(prSetup."Mortgage Nos.",xRec."No. Series",0D,"Requisition No.","No. Series");

             END ELSE IF "Loan Types"="Loan Types"::"Car Loan" THEN BEGIN
               prSetup.GET;
               prSetup.TESTFIELD(prSetup."Car Loan Nos.");
               NoSeriesMgt.InitSeries(prSetup."Car Loan Nos.",xRec."No. Series",0D,"Requisition No.","No. Series");

             END;
           MODIFY;
           END;

           IF "Loan Types"="Loan Types"::"Salary Advance" THEN
           "Repayment Period":=12;
              */

            end;
        }
        field(15; "Employee No"; Code[20])
        {
        }
        field(20; "Employee Names"; Text[100])
        {
        }
        field(25; "ID No."; Code[10])
        {
        }
        field(30; Designation; Text[100])
        {
        }
        field(35; "Advance Amount Requested"; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin
                if "Amount Approved" > "Advance Amount Requested" then
                    Error('AMount Approved cannot be more than Amount Requested')
            end;
        }
        field(40; "Reasons for Advance Amount"; Text[30])
        {
        }
        field(45; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(50; Eligible; Boolean)
        {
        }
        field(55; "No. Series"; Code[20])
        {
        }
        field(56; "Repayment Period"; Decimal)
        {
            MinValue = 1;

            trigger OnValidate()
            begin
                "Instalments Amount" := ("Expected Repayment Amount" / "Repayment Period");
            end;
        }
        field(57; "Instalments Amount"; Decimal)
        {
            Editable = false;
        }
        field(58; "Interest Rate"; Integer)
        {
            MinValue = 1;

            trigger OnValidate()
            begin
                "Expected Repayment Amount" := ("Interest Rate" / 100 * "Advance Amount Requested") + "Advance Amount Requested";
                "Instalments Amount" := ("Expected Repayment Amount" / "Repayment Period");
            end;
        }
        field(59; "Expected Repayment Amount"; Decimal)
        {
            Editable = false;
        }
        field(60; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center B".Code;
        }
        field(61; County; Code[10])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(62; Department; Code[10])
        {
            TableRelation = "Responsibility Center B".Code WHERE("Global Dimension 2 Code" = CONST(''));
        }
        field(63; "Basic Salary"; Decimal)
        {
            //Editable = false;
        }
        field(64; "1/3/ of Basic Salary"; Decimal)
        {
            Editable = false;
        }
        field(65; "Net Pay"; Decimal)
        {
        }
        field(66; "Contract type"; Option)
        {
            OptionCaption = 'Permanent&Pensionable,Contract,Casual,Secondment,Temporary,Graduate trainee,Intern';
            OptionMembers = "Permanent&Pensionable",Contract,Casual,Secondment,"Temporary","Graduate trainee",Intern;
        }
        field(67; "Months Salary"; Option)
        {
            OptionMembers = " ","1 month","2 Months";

            trigger OnValidate()
            begin

                prSalary.Reset;
                prSalary.SetRange(prSalary."Employee Code", "Employee No");
                if prSalary.Find('-') then begin
                    if "Months Salary" = "Months Salary"::"1 month" then begin
                        "Advance Amount Requested" := prSalary."Basic Pay";
                        "Instalments Amount" := "Advance Amount Requested" / "Repayment Period";
                    end
                    else
                        if "Months Salary" = "Months Salary"::"2 Months" then begin
                            "Advance Amount Requested" := (prSalary."Basic Pay" * 2);
                            "Instalments Amount" := "Advance Amount Requested" / "Repayment Period"
                        end
                        else
                            if "Months Salary" = "Months Salary"::" " then begin
                                "Advance Amount Requested" := 0;
                                "Instalments Amount" := "Advance Amount Requested" / "Repayment Period"
                            end
                end
            end;
        }
        field(68; "Loan Type"; Code[20])
        {
            TableRelation = "Staff Loan Types".Code;

            trigger OnValidate()
            var
                HRLoanTypes: Record "Staff Loan Types";
            begin
                if HRLoanTypes.Get("Loan Type") then begin
                    "Loan Description" := HRLoanTypes."Product Description";
                    "Interest Rate" := HRLoanTypes."Interest rate";
                    "No of Instalments" := HRLoanTypes."No of Installment";
                    "Repayment Frequency" := HRLoanTypes."Repayment Frequency";
                    "Grace Period - Principle (M)" := HRLoanTypes."Grace Period - Principle (M)";
                    "Grace Period - Interest (M)" := HRLoanTypes."Grace Period - Interest (M)";
                    "Payroll Code" := HRLoanTypes."Payroll Code";
                    "Repayment Method" := HRLoanTypes."Repayment Method";
                    HREmp.Reset;
                    HREmp.SetRange(HREmp."No.", "Employee No");
                    //if HREmp.Find('-') then begin
                    //EmpDate := CalcDate(HRLoanTypes."Min Application Period", HREmp."Date Of Join");
                    //if EmpDate > Today then begin
                    //IF (TODAY-HREmp."Date Of Joining the Company")<=HRLoanTypes."Min Application Period" THEN BEGIN
                    //Error('You have not reached the minimum %1 years to take this loan', HRLoanTypes."Min Application Period");
                    //end;
                    //end
                end;

                objLoanApps.Reset;
                objLoanApps.SetRange(objLoanApps."Employee No", "Employee No");
                objLoanApps.SetRange(objLoanApps."Loan Type", "Loan Type");
                objLoanApps.SetRange(objLoanApps.Posted, false);
                if objLoanApps.Find('-') then begin
                    repeat
                        if objLoanApps.Status <> objLoanApps.Status::Rejected then begin
                            if objLoanApps."Loan No." <> "Loan No." then
                                Error('You already have an existing %1 application: - %2', objLoanApps."Loan Description", objLoanApps."Loan No.");
                        end;
                    until objLoanApps.Next = 0;

                end;

                if "Loan Type" = 'HR001' then begin

                end
            end;
        }
        field(69; "Loan Description"; Text[100])
        {
        }
        field(70; "No of Instalments"; Decimal)
        {
        }
        field(71; "Repayment Frequency"; Option)
        {
            OptionMembers = Daily,Weekly,Monthly,Quaterly,Yearly;
        }
        field(72; "Grace Period - Principle (M)"; Integer)
        {

            trigger OnValidate()
            begin

                //"No of Instalments":="Installment Including Grace"-"Grace Period - Principle (M)"
            end;
        }
        field(73; "Grace Period - Interest (M)"; Integer)
        {
        }
        field(74; "Repayment Method"; Option)
        {
            OptionMembers = "Reducing Balance",Amortised,"Straight line",Constants;
        }
        field(75; "Payroll Code"; Code[10])
        {
        }
        field(76; Posted; Boolean)
        {
        }
        field(77; "Loan No."; Code[50])
        {
        }
        field(78; "Amount Approved"; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin
                //"Undisbursed Amount":="Amount Approved"-"Amount Disbursed";
                if "Amount Approved" > "Advance Amount Requested" then
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
                InterestRate := "Interest Rate";
                LoanAmount := "Amount Approved";
                RepayPeriod := "No of Instalments";
                LBalance := "Amount Approved";

                //+++++++++++++++++++++++++If Amortization++++++++++++++++++++++++++

                if "Repayment Method" = "Repayment Method"::Amortised then begin
                    //IF "Loan Product Type"='DEFAULTER' THEN BEGIN
                    //LPrincipal:=ROUND(LoanAmount/RepayPeriod,1,'>');
                    //Repayment:=LPrincipal;
                    //END ELSE BEGIN
                    TestField("Interest Rate");
                    TestField("No of Instalments");
                    TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 0.05, '>');
                    linterest := Round(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                    lPrincipal := TotalMRepay - linterest;
                    Repayment := TotalMRepay;//lPrincipal+linterest;
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

                if "Repayment Method" = "Repayment Method"::Constants then begin
                    TestField("No of Instalments");
                    lPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                    linterest := 0;//ROUND((InterestRate/100/12)*LoanAmount,1,'>');
                                   //Repayment:=lPrincipal+linterest;
                                   //"Adjust Repayment":=LPrincipal+LInterest;
                    "Loan Principal Repayment" := lPrincipal;
                    "Loan Interest Repayment" := linterest;
                    Repayment := "Loan Principal Repayment" + "Loan Interest Repayment";

                end;


                //Repayments for reducing balance method
                if "Repayment Method" = "Repayment Method"::"Reducing Balance" then begin
                    TestField("Interest Rate");
                    TestField("No of Instalments");
                    lPrincipal := LoanAmount / RepayPeriod;
                    linterest := (InterestRate / 12 / 100) * LBalance;
                    Repayment := lPrincipal + linterest;
                    "Total Loan Repayment Amount" := Repayment * "No of Instalments";
                    //"Adjust Repayment":=LPrincipal+LInterest;
                    "Loan Principal Repayment" := lPrincipal;
                    "Loan Interest Repayment" := linterest;
                end;
            end;
        }
        field(79; "Loan Principal Repayment"; Decimal)
        {
        }
        field(80; "Loan Interest Repayment"; Decimal)
        {
        }
        field(81; "User ID"; Code[50])
        {
        }
        field(82; Account; Code[20])
        {
        }
        field(84; "Amount Paid"; Decimal)
        {
            TableRelation = "PR Period Transactions".Amount WHERE("Loan Number" = FIELD("Loan No."));
        }
        field(85; Balance; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("Requisition No.")));
            FieldClass = FlowField;
        }
        field(86; Picture; BLOB)
        {
        }
        field(87; "Supervisor Email"; Text[50])
        {
        }
        field(88; Supervisor; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(89; Repayment; Decimal)
        {
            Editable = false;
        }
        field(90; "Total Loan Repayment Amount"; Decimal)
        {
            Editable = false;
        }
        field(91; "Loan Disbursement Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Loan Disbursement Date" > Today then
                    Error('Disbursement date cannot be in the future');
            end;
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

    trigger OnInsert()
    begin

        if "Loan No." = '' then begin
            prSetup.Get;
            prSetup.TestField("Salary Advance Nos.");
            "Loan No." := NoSeriesMgt.GetNextNo(prSetup."Salary Advance Nos.");
            // NoSeriesMgt.InitSeries(prSetup."Salary Advance Nos.", xRec."No. Series", 0D, "Loan No.", "No. Series");
        end;


        /*
        //Get applicant details from Hr Employees
        HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID",USERID);
        IF HREmp.FIND('-') THEN BEGIN
        "Employee No":=HREmp."No.";
        "Employee Names":=HREmp."First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";
        "ID No.":=HREmp."ID Number";
        Designation:=HREmp."Job Title";
        "Application Date":=TODAY;
        END ELSE BEGIN
        ERROR(Txt001)
        END;
        
          prSalary.RESET;
          prSalary.SETRANGE(prSalary."Employee Code","Employee No") ;
        
          IF prSalary.FIND('-')   THEN
          BEGIN
             "Basic Salary":=prSalary."Basic Pay";
        
        
          END;
            */







        //---------GENERATE NEW NUMBER FOR THE DOCUMENT-----------------------------------
        if "Loan No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Loan Application Nos.");
            "Loan No." := NoSeriesMgt.GetNextNo(HRSetup."Loan Application Nos.");
            // NoSeriesMgt.InitSeries(HRSetup."Loan Application Nos.", xRec."No. Series", 0D, "Loan No.", "No. Series");
        end;
        //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE LEAVE APPLICATION TABLE
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            "Employee No" := HREmp."No.";

            //---------------------------------------------------------------------
            HREmp.Get(HREmp."No.");
            HREmp.CalcFields(HREmp.Picture);
            //Picture:=HREmp.Picture;
            "User ID" := UserId;
        end else begin
            Error('User id' + ' ' + '[' + UserId + ']' + ' has not been assigned to any employee. Please consult the HR officer for assistance')
        end;
        //GET LOAN APPROVER DETAILS FROM USER SETUP TABLE COPY THEM TO THE LOAN APPLICATION TABLE
        UserSetup.Reset;
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Approver ID");
            //Supervisor:=UserSetup."Approver ID";
            UserSetup.Reset;
            //IF UserSetup.GET(Supervisor) THEN
            //"Supervisor Email":=UserSetup."E-Mail";
        end;

        //POPULATE FIELDS
        "Application Date" := Today;
        //"Request Date":=TODAY;
        if HREmp.Get("Employee No") then begin
            "Employee Names" := HREmp."Full Name";//HREmp."First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";
            Department := HREmp."Global Dimension 1 Code";
            County := HREmp."Global Dimension 2 Code";
            "Responsibility Center" := HREmp."Responsibility Center";
            Account := HREmp."No.";//HREmp."Sacco Staff No";

            /*
           Vend.RESET;
           Vend.SETRANGE(Vend."Staff No",Account);
           Vend.SETRANGE(Vend."Account Type",'SAVINGS');
           IF Vend.FIND('-') THEN BEGIN
            "Account No.":=Vend."No.";
           END*/
            /*IF member.GET(Account) THEN BEGIN
            "Account No.":=member."FOSA Account";
            END*/
        end;


        prperiodtrans.Reset;
        prperiodtrans.SetRange(prperiodtrans."Employee Code", "Employee No");
        prperiodtrans.SetRange(prperiodtrans."Transaction Code", 'NPAY');
        if prperiodtrans.Find('-') then begin
            prPayPeriod.Reset;
            prPayPeriod.SetRange(prPayPeriod."Date Opened", prperiodtrans."Payroll Period");
            prPayPeriod.SetRange(prPayPeriod.Closed, true);
            if prPayPeriod.Find('+') then
                "Basic Salary" := prperiodtrans.Amount;
            "1/3/ of Basic Salary" := (1 / 3 * "Basic Salary")
        end

    end;

    var
        HREmp: Record "HR Employees";
        Txt001: Label 'User must be Setup as an employee first. Consult the HR Officer so as to be setup as an employee';
        prSetup: Record "HR Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        prSalary: Record "PR Salary Card";
        EmpDate: Date;
        objLoanApps: Record "prSalary Advance";
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
        HRSetup: Record "HR Setup";
        UserSetup: Record "User Setup";
        prperiodtrans: Record "PR Period Transactions";
        prPayPeriod: Record "PR Payroll Periods";

    // [Scope('OnPrem')]
    procedure AssistEdit(): Boolean
    begin

        prSetup.Get;
        prSetup.TestField("Salary Advance Nos.");
        if Rec."No. Series" = '' then
            Rec."No. Series" := prSetup."Salary Advance Nos.";

        if Rec."No. Series" <> '' then begin
            Rec."Requisition No." := NoSeriesMgt.GetNextNo(
                Rec."No. Series",
                WorkDate(),
                true
            );
            exit(true);
        end;
        
        // if NoSeriesMgt.SelectSeries(prSetup."Salary Advance Nos.", xRec."No. Series", "No. Series") then begin
        //     NoSeriesMgt.SetSeries("Requisition No.");
        //     exit(true);
        // end;
    end;
}

