report 52186028 "Dormant Deposit Listing Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/ Dormant Deposit Listing Report.rdl';

    dataset
    {

        dataitem("Savings Accounts"; "Savings Accounts")
        {
            RequestFilterFields = Status, "Employer Code";
            DataItemTableView = where(Status = Filter(Dormant), "Product Type" = filter('DCS'));

            column(ReportForNavId_1; 1)
            {
            }
            column(No_SavingsAccounts; "Savings Accounts"."No.")
            {
            }
            column(Name_SavingsAccounts; "Savings Accounts".Name)
            {
            }
            column(PhoneNo_SavingsAccounts; "Savings Accounts"."Phone No.")
            {
            }
            column(GlobalDimension1Code_SavingsAccounts; "Savings Accounts"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_SavingsAccounts; "Savings Accounts"."Global Dimension 2 Code")
            {
            }
            column(Balance_SavingsAccounts; "Savings Accounts".Balance)
            {
            }
            column(Member_No_; "Savings Accounts"."Member No.")
            {
            }
            column(Product_Type; "Savings Accounts"."Product Type")
            {
            }
            column(Product_Name; "Savings Accounts"."Product Name")
            {
            }
            column(Status; "Savings Accounts".Status)
            {
            }
            column(Employer_Code; "Employer Code")
            {

            }
            column(Last_Transaction_Date; "Savings Accounts"."Last Transaction Date")
            {
            }
            column(BalanceLCY_SavingsAccounts; "Savings Accounts"."Balance (LCY)")
            {
            }
            column(PayrollStaffNo_SavingsAccounts; "Savings Accounts"."Payroll/Staff No.")
            {
            }
            column(IDNo_SavingsAccounts; "Savings Accounts"."ID No.")
            {
            }
            column(ATMTransactions_SavingsAccounts; "Savings Accounts"."ATM Transactions")
            {
            }
            column(ATMNo_SavingsAccounts; "Savings Accounts"."ATM No.")
            {
            }

            column(AccNo; "Savings Accounts".Balance)
            {
            }
            column(sno; SNo)
            {
            }
            column(Amount; Amount)
            {

            }
            column(Monthly_Contribution; "Monthly Contribution")
            {

            }
            column(ShowTotoDetail; ShowTotoDetail)
            {
            }

            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(NoOfDormancy; NoOfDormancy)
            {

            }
            column(FOSADeposits; FOSADeposits)
            {

            }
            column(BOSADeposits; BOSADeposits)
            {

            }
            column(realDormancy; realDormancy)
            {

            }
            column(MemStatus; MemStatus)
            {

            }
            column(SubStatus; SubStatus)
            {

            }


            trigger OnAfterGetRecord()
            var

            begin
                //"Savings Accounts".SetFilter("Date Filter", '..%1', AsAt);
                "Savings Accounts".CalcFields("Balance (LCY)", "Last Transaction Date");
                SNo += 1;
                FOSADeposits := 0;
                BOSADeposits := 0;
                NoOfDormancy := 0;
                realDormancy := 0;
                if "Savings Accounts"."Last Transaction Date" = 0D then "Savings Accounts"."Last Transaction Date" := Today;
                NoOfDormancy := AsAt - "Savings Accounts"."Last Transaction Date";
                BOSADeposits := "Savings Accounts"."Balance (LCY)";
                if Pfact.Get("Savings Accounts"."Product Type") then begin
                    realDormancy := AsAt - (CalcDate(Pfact."Dormancy Period", "Savings Accounts"."Last Transaction Date"));

                    if (CalcDate(Pfact."Dormancy Period", "Savings Accounts"."Last Transaction Date")) > AsAt then CurrReport.Skip();
                end;
                if NoOfDormancy <= 0 then CurrReport.Skip();
                if MemberFact.Get("Savings Accounts"."Member No.") then begin
                    MemberFact.CalcFields("FOSA Savings");
                    FOSADeposits := MemberFact."FOSA Savings";

                end;

                Members.Reset();
                Members.SetRange("No.", "Savings Accounts"."Member No.");
                if Members.FindFirst() then begin
                    MemStatus := Members.Status;
                    SubStatus := Members.Subflag;
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
                field(AsAt; AsAt)
                {

                }
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
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

        if AsAt = 0D then
            AsAt := today;
    end;

    var
        SNo: Integer;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ShowTotoDetail: Boolean;
        Pfact: Record "Product Factory";
        Amount: decimal;
        TotalAmount: decimal;
        Nosav: Code[30];
        AsAt: Date;
        NoOfDormancy: Integer;
        realDormancy: Integer;
        BOSADeposits: Decimal;
        FOSADeposits: Decimal;
        MemberFact: Record "Member FactBox";
        Members: Record Members;
        MemStatus: Enum "Member Status";
        SubStatus: Enum "Member Status Sub Flags";
}
