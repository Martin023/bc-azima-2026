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

                if SmSAlertHeader.Get("SMS Alerts Lines"."Header No") then
                    NoticeDate := SmSAlertHeader."Posted At";
                if GuarMember.get("Member No") then begin
                    GuarantorName := GuarMember.Name;
                    GuarWorkNo := GuarMember."Payroll/Staff No.";
                    GuarEmpcode := GuarMember."Employer Code";
                end
                else
                    CurrReport.Skip();

                if DefaultedLoan.Get("Loan No") then begin
                    DefaultedLoan.CalcFields("Outstanding Balance");
                    if Defaulter.Get(DefaultedLoan."Member No.") then begin
                        DefaulterName := Defaulter.Name;
                        DefaulterEmpcode := Defaulter."Employer Code";
                        DefaulterWkno := Defaulter."Payroll/Staff No.";

                        SavAcc.Reset();
                        SavAcc.Setloadfields("Product Category", "Member No.", Balance);
                        SavAcc.SetRange("Member No.", Defaulter."No.");
                        SavAcc.SetAutoCalcFields(Balance);
                        if not SavAcc.IsEmpty() then
                            AmountRecoverable := SavAcc.Balance
                        else
                            AmountRecoverable := 0;
                    end;
                    Defaultedamount := DefaultedLoan."Outstanding Balance";
                    LoanType := DefaultedLoan."Loan Product Type Name";
                end;


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

}
