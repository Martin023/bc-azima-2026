table 52185623 "PR Employee Transactions"
{
    DataCaptionFields = "Employee Code";

    fields
    {
        field(1; "Employee Code"; Code[30])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(2; "Transaction Code"; Code[30])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code" where(Suspended = Const(False));

            trigger OnValidate()
            begin

                CurrentYear := Date2DMY("Payroll Period", 3);

                Transcode.Reset;
                Transcode.SetRange(Transcode."Transaction Code", "Transaction Code");
                if Transcode.Find('-') then begin
                    "Transaction Name" := Transcode."Transaction Name";
                    Variated := Transcode.Variated;
                    Frequency := Transcode.Frequency;
                end;


                TotalAmount := 0;
                TotalAllowance := 0;


                SalCard.RESET;
                SalCard.SETRANGE(SalCard."Employee Code", "Employee Code");
                IF SalCard.FIND('-') THEN BEGIN
                    Transcode.RESET;
                    Transcode.RESET;
                    Transcode.SETRANGE(Transcode."Transaction Type", Transcode."Transaction Type"::Deduction);
                    BEGIN
                        REPEAT
                            EmployeeTrans.RESET;
                            EmployeeTrans.SETRANGE(EmployeeTrans."Employee Code", "Employee Code");
                            EmployeeTrans.SETRANGE(EmployeeTrans."Transaction Code", Transcode."Transaction Code");
                            //EmployeeTrans.SETRANGE(EmployeeTrans."Payroll Period", CurrPeriod);
                            IF EmployeeTrans.FIND('-') THEN
                                REPEAT
                                    TotalAmount += EmployeeTrans.Amount
                                UNTIL EmployeeTrans.NEXT = 0;


                        UNTIL Transcode.NEXT = 0;
                        TotalAmount += Amount
                    END;
                    //IF TotalAmount > 1 / 3 * SalCard."Basic Pay" then
                    //ERROR('Total deductions must not be more than 2/3 of basic pay %1', 1 / 3 * SalCard."Basic Pay");
                END;
                //END;
                //END;


                //..................  //1/3 RULE..................................................................

                /*   
                
                //Allowances based on job grades
                   HREmp.RESET;
                   HREmp.SETRANGE(HREmp."No.","Employee Code");
                   IF HREmp.FIND('-') THEN
                 BEGIN
                  PRAllowances.RESET;
                  PRAllowances.SETRANGE(PRAllowances."Transaction Code","Transaction Code");
                  PRAllowances.SETRANGE("Job Grade",HREmp.Grade);
                  IF PRAllowances.FIND('-') THEN
                    BEGIN
                      MESSAGE('HR IS %1, PR IS %2',HREmp.Grade,PRAllowances."Job Grade" );
                      Amount:=PRAllowances.Amount;
                    END
                 END;
                
                
                //Consume checkoff loan amounts from loans
                  Transcode.RESET;
                  Transcode.SETRANGE(Transcode."Transaction Code","Transaction Code");
                  Transcode.SETRANGE(Transcode."Based on Loans",TRUE);
                  IF Transcode.FIND('-') THEN
                  BEGIN
                  HREmp.RESET;
                  HREmp.SETRANGE(HREmp."No.","Employee Code");
                  IF HREmp.FIND('-') THEN
                      BEGIN
                      Members.RESET;
                      Members.SETRANGE(Members."Payroll/Staff No.",HREmp."No.");
                      IF Members.FIND('-') THEN
                
                          BEGIN
                          Loans.RESET;
                          Loans.SETRANGE(Loans."Member No.",Members."No.");
                          Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                         // Loans.SETRANGE(Loans."Loan Product Type",'902');
                          Loans.SETRANGE(Loans."Loan Product Type",Transcode."Loan Product Type");
                          Loans.SETCURRENTKEY("Disbursement Date");
                         // Loans.SETRANGE(Loans."Loan No.",'L204752');
                          //Loans.CALCFIELDS("Outstanding Balance");
                          IF Loans.FIND('+') THEN
                            MESSAGE(Loans."Loan No.",'%1',Loans."Outstanding Balance") ;
                
                
                            BEGIN
                              PayMethods.RESET;
                              PayMethods.SETRANGE(PayMethods."Loan No.",Loans."Loan No.");
                              PayMethods.SETRANGE(PayMethods."Payment Method",PayMethods."Payment Method"::Checkoff);
                              PayMethods.SETFILTER(Amount,'<>%1',0);
                              IF PayMethods.FIND('-') THEN
                                MESSAGE(FORMAT(PayMethods.Amount));
                              Amount:=PayMethods.Amount/Loans.Installments;
                              Balance:=PayMethods.Amount;
                              "Loan Number":=Loans."Loan No.";
                              "#of Repayments":=Loans.Installments;
                
                              END
                          END
                   END
                END
                */
                HREmp.reset();
                HrEmp.setrange("No.", rec."Employee Code");
                Hremp.setrange("Contract Type", 'CONTRACT');
                IF HrEmp.FindFirst() then begin
                    if rec."Transaction Code" = 'D048' then
                        Message('This Employee is on Contract');
                end


            end;
        }
        field(3; "Transaction Name"; Text[100])
        {
        }
        field(4; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                SalCard.reset();
                SalCard.setrange("Employee Code", rec."Employee Code");
                if SalCard.findset() then begin
                    Transcode.Reset;
                    Transcode.SetRange(Transcode."Transaction Code", "Transaction Code");
                    Transcode.SetRange(Transcode."Product Category", Transcode."Product Category"::"BOSA Deposits");
                    if Transcode.Find('-') then begin
                        Transcode.CalcFields("Product Min Cont.");
                        // if Amount > 2 / 3 * SalCard."Basic Pay" then begin
                        //     Error('Deduction Cannot be more than 2/3 of Basic Pay')
                        // end else
                        if Amount < Transcode."Product Min Cont." then
                            Amount := Transcode."Product Min Cont.";
                    end;



                    Transcode.Reset;
                    Transcode.SetRange(Transcode."Transaction Code", "Transaction Code");
                    Transcode.SetRange(Transcode."Product Category", Transcode."Product Category"::"Benevolent (BBF)");
                    if Transcode.Find('-') then begin
                        Transcode.CalcFields("Product Min Cont.");
                        // if Amount > 2 / 3 * SalCard."Basic Pay" then begin
                        //     Error('Deduction Cannot be more than 2/3 of Basic Pay')
                        // end else
                        if Amount < Transcode."Product Min Cont." then
                            Amount := Transcode."Product Min Cont.";
                    end;

                    // if (Transcode."Transaction Type" = Transcode."Transaction Type"::Income) or (Transcode."Transaction Type" = Transcode."Transaction Type"::Deduction) then begin
                    //     "Original Amount" := Amount;
                    // end;

                    Transcode.Reset;
                    Transcode.SetRange(Transcode."Transaction Code", "Transaction Code");
                    Transcode.SetRange("IsLeave Allowance", true);
                    if Transcode.Find('-') then begin

                        EmployeeTrans.Reset;
                        //EmployeeTrans.SetFilter(EmployeeTrans."Transaction Code", '=%1', 'E05');
                        EmployeeTrans.SetFilter(EmployeeTrans."Transaction Code", '=%1', 'E009');
                        EmployeeTrans.SetRange(EmployeeTrans."Period Year", "Period Year");
                        EmployeeTrans.SetFilter(EmployeeTrans."Employee Code", "Employee Code");
                        if EmployeeTrans.Find('+') then begin
                            Error('Transaction Type [ %1 ] has already been Paid to Staff no [ %2 ] on period [ %3 ]', "Transaction Name", "Employee Code", "Period Year");
                        end;
                    end;

                    if Ploan.Get("Loan Number") then begin
                        Ploan.CalcFields(Ploan."Outstanding Interest", Ploan."Outstanding Balance");
                        // if Amount > 2 / 3 * SalCard."Basic Pay" then begin
                        //     Error('Deduction Cannot be more than 2/3 of Basic Pay')
                        // end else
                        if Ploan."Outstanding Balance" > Amount then begin
                            if Ploan."Outstanding Interest" > Amount then begin

                                Amount := (Ploan."Outstanding Balance" * Ploan.Interest / 1200);
                                Message('The Amount entered is less than the outstanding interest of %1', Amount);
                                //MESSAGE('Interest %1',(Ploan."Outstanding Balance"*Ploan.Interest/1200));
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(5; Balance; Decimal)
        {

            trigger OnValidate()
            begin
                "#of Repayments" := 0;
                //IF (Balance > 0) AND ("#of Repayments" > 0) THEN
                //Amount:=Balance/"#of Repayments"
            end;
        }
        field(6; "Original Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if (Transcode."Transaction Type" = Transcode."Transaction Type"::Income) or (Transcode."Transaction Type" = Transcode."Transaction Type"::Deduction) then begin
                    Amount := "Original Amount";
                end;
            end;
        }
        field(7; "Period Month"; Integer)
        {
        }
        field(8; "Period Year"; Integer)
        {
        }
        field(9; "Payroll Period"; Date)
        {
            TableRelation = "PR Payroll Periods"."Date Opened";
        }
        field(10; "#of Repayments"; Integer)
        {

            trigger OnValidate()
            begin
                if (Balance > 0) and ("#of Repayments" > 0) then
                    Amount := Balance / "#of Repayments"
            end;
        }
        field(11; Membership; Code[20])
        {
            TableRelation = "prInstitutional Membership"."Institution No";
        }
        field(12; "Reference No"; Text[100])
        {
        }
        field(13; integera; Integer)
        {
        }
        field(14; "Employer Amount"; Decimal)
        {
        }
        field(15; "Employer Balance"; Decimal)
        {
        }
        field(16; "Stop for Next Period"; Boolean)
        {
        }
        field(17; "Amortized Loan Total Repay Amt"; Decimal)
        {
        }
        field(18; "Start Date"; Date)
        {
        }
        field(19; "End Date"; Date)
        {
        }
        field(25; "Interest Due"; Decimal)
        {
        }
        field(20; "Loan Number"; Code[20])
        {
            TableRelation = Loans."Loan No." WHERE("Staff No" = FIELD("Employee Code"));
            //"Employer Code" = FILTER('00'));

            trigger OnValidate()
            begin

                Loans.Reset;
                Loans.SetRange(Loans."Staff No", "Employee Code");
                Loans.SetRange(Loans."Loan No.", "Loan Number");
                if Loans.Find('-') then begin
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
                    // Amount:=Loan."Loan Principle Repayment";

                    Amount := Loans.Repayment;

                    Balance := Loans."Outstanding Balance";
                    "Original Amount" := Loans."Approved Amount";
                    "Start Date" := Loans."Repayment Start Date";
                    "End Date" := Loans."Expected Date of Completion";
                    "Loan Interest Rate" := Loans.Interest;
                    "Interest Due" := Loans."Outstanding Interest";

                    /*Transcode.RESET;
                    Transcode.SETRANGE(Transcode."Loan Product Type",Loans."Loan Product Type");
                    IF Transcode.FIND('-') THEN BEGIN
                      IF "Transaction Code" = '' THEN
                        "Transaction Code":=Transcode."Transaction Code";
                    END;*/
                end;

            end;
        }
        field(21; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(22; "No of Units"; Decimal)
        {

            trigger OnValidate()
            begin

                Transcode.Reset;
                Transcode.SetRange(Transcode."Transaction Code", 'E12');
                if Transcode.Find('-') then begin
                    SalCard.Reset;
                    SalCard.SetRange(SalCard."Employee Code", "Employee Code");
                    if SalCard.Find('-') then begin
                        Amount := Round(((SalCard."Basic Pay" / 173.33) * 2 * "No of Units"), 1, '>')
                    end;
                end;



                Transcode.Reset;
                Transcode.SetRange(Transcode."Transaction Code", 'E13');
                if Transcode.Find('-') then begin
                    SalCard.Reset;
                    SalCard.SetRange(SalCard."Employee Code", "Employee Code");
                    if SalCard.Find('-') then begin
                        Amount := Round(((SalCard."Basic Pay" / 173.33) * 1.5 * "No of Units"), 1, '>')
                    end;
                end;
            end;
        }
        field(23; Suspended; Boolean)
        {
        }
        field(24; "Entry No"; Integer)
        {
            AutoIncrement = false;
        }
        field(38; "IsCoop/LnRep"; Boolean)
        {
            CalcFormula = Lookup("PR Transaction Codes"."IsCoop/LnRep" WHERE("Transaction Code" = FIELD("Transaction Code")));
            Description = 'to be able to report the different coop contributions';
            FieldClass = FlowField;
        }
        field(39; EmployeePostingG; Code[20])
        {
            CalcFormula = Lookup("HR Employees"."Posting Group" WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(40; grants; Code[20])
        {
        }
        field(41; Stopped; Boolean)
        {
        }
        field(42; "Subledger Account"; Code[15])
        {
            TableRelation = IF ("Subledger Account" = CONST('VENDOR')) Vendor."No." WHERE(Blocked = FILTER(<> All),
                                                                                         "Vendor Posting Group" = CONST('OTHERS'))
            ELSE
            IF ("Subledger Account" = CONST('CUSTOMER')) Customer."No." WHERE(Blocked = FILTER(<> All))
            else
            IF ("Subledger Account" = CONST('CREDIT')) loans."Loan No."; // WHERE("Outstanding Balance" = FILTER(<>0));

        }
        field(43; Subledger; Option)
        {
            OptionCaption = ' ,Customer,Vendor,Credit';
            OptionMembers = " ",Customer,Vendor,Credit;
        }
        field(44; "Sacco loan"; Boolean)
        {
        }
        field(45; "Sacco share"; Boolean)
        {
        }
        field(47; "Loan Interest Rate"; Decimal)
        {
        }
        field(48; "Exempt from Interest"; Boolean)
        {

            trigger OnValidate()
            begin
                /*
                if not "Exempt from Interest" then
                begin
                    if Confirm('Disable Staff No [ %1 ] from paying Interest on this Transaction Code [ %2 - %3? ]',false
                                  ,"Employee Code","Transaction Code","Transaction Name") = true then
                    begin
                        "Exempt from Interest":=true;
                    end else
                    begin
                        error('Aborted');
                    end;
                end else
                begin
                    if Confirm('Enalbe Staff No [ %1 ] to pay Interest on this Transaction Code [ %2 - %3? ]',false
                                  ,"Employee Code","Transaction Code","Transaction Name") = true then
                    begin
                        "Exempt from Interest":=true;
                    end else
                    begin
                        error('Aborted');
                    end;
                
                end;
                 */

            end;
        }
        field(49; Grade; Code[20])
        {
            CalcFormula = Lookup("HR Employees".Grade WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(50; Variated; Boolean)
        {
        }
        field(51; "Salary Grade"; code[50])
        {
            TableRelation = "HR Employees"."Salary Grade";
        }
        field(52; Frequency; Option)
        {
            OptionMembers = "Fixed",Varied;
        }
        field(53; "Savings Account No."; Code[20])
        {
            TableRelation = "Savings Accounts"."No.";
        }
        
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period", "Reference No")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2; "Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended)
        {
        }
    }


    fieldgroups
    {
    }

    var
        CurrPeriod: Date;
        TotalAmount: Decimal;
        Transcode: Record "PR Transaction Codes";
        EmployeeTrans: Record "PR Employee Transactions";
        MonthName: Text[100];
        SalCard: Record "PR Salary Card";
        CurrentYr: Integer;
        objPeriod: Record "PR Payroll Periods";
        PRAllowances: Record "PR Employee Allowances";
        TotalAllowance: Decimal;
        HREmp: Record "HR Employees";
        Members: Record Members;
        Loans: Record Loans;
        Ploan: Record Loans;
        curLoanInt: Decimal;
        CurrentYear: Integer;
        Allowances: decimal;
        Deductions: decimal;



}

