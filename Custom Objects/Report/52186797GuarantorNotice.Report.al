#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186797 "Guarantor Notice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Guarantor Notice.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("SMS Alerts Lines"; "SMS Alerts Lines")
        {
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyName; CompanyName)
            {

            }
            column(BuldingName; BuldingName)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CompanyEmail; CompanyEmail)
            {
            }
            column(PrintingDate; PrintingDate)
            {

            }
            column(PrintingTime; PrintingTime)
            {

            }
            column(PrintedBy; PrintedBy)
            {

            }
            column(GuarantorName; GuarantorName)
            {
            }
            column(NoticeDate; NoticeDate)
            {
            }
            column(GuarWorkNo; GuarWorkNo)
            {
            }
            column(Member_No; "Member No")
            {
            }
            column(GuarEmpcode; GuarEmpcode)
            {
            }
            column(LoanType; LoanType)
            {
            }
            column(DefaulterName; DefaulterName)
            {
            }
            column(DefaulterEmpcode; DefaulterEmpcode)
            {
            }
            column(DefaulterWkno; DefaulterWkno)
            {
            }
            column(Defaultedamount; Defaultedamount)
            {
            }
            column(AmountRecoverable; AmountRecoverable)
            {
            }
            column(AmtToGuarantor; AmtToGuarantor)
            {
            }
            column(DefaultedDate; DefaultedDate)
            {
            }
            trigger OnAfterGetRecord()
            begin
                GuarantorName := '';
                // NoticeDate := 0D;
                GuarWorkNo := '';
                DefaulterName := '';
                DefaulterEmpcode := '';
                LoanType := '';
                GuarEmpcode := '';
                DefaulterWkno := '';
                Defaultedamount := 0;
                AmountRecoverable := 0;

                if SmSAlertHeader.Get("SMS Alerts Lines"."Header No") then begin
                    NoticeDate := SmSAlertHeader."Posted At";
                    if GuarMember.get("Member No") then begin
                        GuarantorName := GuarMember.Name;
                        GuarWorkNo := GuarMember."Payroll/Staff No.";
                        GuarEmpcode := GuarMember."Employer Code";
                    end
                    else
                        CurrReport.Skip();

                    if DefaultedLoan.Get("SMS Alerts Lines"."Loan No") then begin
                        DefaultedLoan.CalcFields("Outstanding Balance", "Total Balance", "Installments In Arrears");
                        Defaultedamount := DefaultedLoan."Total Balance" + threemonthsint(DefaultedLoan);
                        LoanType := DefaultedLoan."Loan Product Type Name";
                        if DefaultedLoan."Installments In Arrears" > 0 then
                            DefaultedDate := CalcDate('<-' + Format(DefaultedLoan."Installments In Arrears") + 'M>', Today)
                        else
                            DefaultedDate := Today;

                        if Defaulter.Get(DefaultedLoan."Member No.") then begin
                            DefaulterName := Defaulter.Name;
                            DefaulterEmpcode := Defaulter."Employer Code";
                            DefaulterWkno := Defaulter."Payroll/Staff No.";

                            SavAcc.Reset();
                            SavAcc.Setloadfields("Product Category", "Member No.", Balance);
                            SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
                            SavAcc.SetRange("Member No.", Defaulter."No.");
                            SavAcc.SetAutoCalcFields(Balance);
                            if SavAcc.FindFirst() then
                                DepositBal := SavAcc.Balance
                            else
                                DepositBal := 0;                            //

                            // if AmountRecoverable > 0 then begin
                            ExistingLoans.Reset();
                            ExistingLoans.SetLoadFields("Member No.", "Total Balance");
                            ExistingLoans.SetRange("Member No.", Defaulter."No.");
                            ExistingLoans.SetAutoCalcFields("Total Balance");
                            if ExistingLoans.FindSet() then begin
                                repeat
                                    TotExistingLoan += ExistingLoans."Total Balance";
                                until ExistingLoans.next() = 0;
                            end;

                            if TotExistingLoan > 0 then
                                AmountRecoverable := round(((DefaultedLoan."Total Balance" / TotExistingLoan) * DepositBal), 1, '<')
                            Else
                                AmountRecoverable := DepositBal;

                            if SmSAlertHeader."Equal Guarantor Disribution" then begin
                                LoanGuar.Reset();
                                LoanGuar.SetRange("Loan No", DefaultedLoan."Loan No.");
                                LoanGuar.SetRange("Self Guarantee", false);
                                LoanGuar.SetRange(Substituted, false);
                                if LoanGuar.FindSet() then
                                    NoOfGuars := LoanGuar.Count()
                                else
                                    NoOfGuars := 0;
                                if NoOfGuars > 0 then
                                    AmtToGuarantor := Round(((Defaultedamount - AmountRecoverable) / NoOfGuars), 1, '>')
                                else
                                    AmtToGuarantor := 0;
                            end
                            else begin
                                LoanGuar.Reset();
                                LoanGuar.SetRange("Loan No", DefaultedLoan."Loan No.");
                                LoanGuar.SetRange(Substituted, false);
                                LoanGuar.SetRange("Member No", "SMS Alerts Lines"."Member No");
                                if LoanGuar.FindFirst() then
                                    AmtToGuarantor := LoanGuar."Amount Guaranteed";
                            end;

                        end;

                    end;
                end
                else
                    CurrReport.Skip();

            end;


        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {

            }
        }

        actions
        {
        }
    }

    labels
    {
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyName := CompanyInformation.Name;
        BuldingName := CompanyInformation."Building Name";
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
        CompanyEmail := CompanyInformation."E-Mail";
        PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
        PrintingTime := Format(Time);
        PrintedBy := GlobalFunctions.FormatUserName(UserId);
    end;

    var
        //General Columns
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];
        GuarantorName: text;
        GuarMember: Record Members;
        SmSAlertHeader: record "SMS Alerts Header";
        NoticeDate: Datetime;
        Defaulter: Record Members;
        DefaulterName: Text[100];
        DefaultedLoan: record Loans;
        GuarWorkNo: Text;
        GuarEmpcode: Code[20];
        DefaulterEmpcode: Code[20];
        LoanType: code[20];
        DefaulterWkno: Code[20];
        Defaultedamount: Decimal;
        AmountRecoverable: Decimal;
        SavAcc: record "Savings Accounts";
        ExistingLoans: Record Loans;
        TotExistingLoan: Decimal;
        DepositBal: Decimal;
        AmtToGuarantor: Decimal;
        LoanGuar: record "Loan Guarantors and Security";
        NoOfGuars: Integer;
        DefaultedDate: Date;

    procedure threemonthsint(LoanII: record Loans): Decimal
    begin
        LoanII.CalcFields("Outstanding Balance");
        exit(round((LoanII."Outstanding Balance" * ((LoanII.Interest / 12) * 0.01)) * 3, 1, '>'));
    end;

}
