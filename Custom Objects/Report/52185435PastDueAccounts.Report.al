#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185435 "Past Due Accounts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Past Due Accounts.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Member No.", "Employer Code", "Source Unit", "Loans Category-SASRA", "Days In Arrears", "Application Date", "Disbursement Date", "Loan Product Type";

            DataItemTableView = where(Posted = const(true));

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
            column(Loan_No_; "Loan No.")
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(Loan_Product_Type; "Loan Product Type")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }
            column(Percentage; Percentage)
            {

            }
            column(ApplicationDate; ApplicationDate)
            {

            }
            column(ApprovedAmount; ApprovedAmount)
            {

            }
            column(OutBal; OutBal)
            {

            }
            column(OutInt; OutInt)
            {

            }
            trigger OnAfterGetRecord()
            begin

                intProgressI += 1;

                IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                END;

                RecoveryHeader.GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);
                ApprovedAmount := Loans."Approved Amount";
                ApplicationDate := GlobalFunctions.FormatDate(Loans."Application Date");

                if GenerateOnRun then begin

                    DaysInArrears := LoansProcess.CalculateLoanArrears(Loans, AmountInArrearsSACCO, AmountInArrearsSASRA, AsAt, True);
                    if not RunLoan then CurrReport.Skip();

                    Loans."Loans Category-SASRA" := LoansProcess.LoanCategoryStage(DaysInArrears);
                    Counter := Counter + 1;

                    if not SASRACategory.Get(Loans."Loan No.") then begin
                        SASRACategory.INIT;
                        SASRACategory."Loan No." := Loans."Loan No.";
                        SASRACategory."Loans Category-SASRA" := Loans."Loans Category-SASRA";
                        SASRACategory."Loan Age" := LoanAge;
                        SASRACategory."Days In Arreas" := DaysInArrears;
                        SASRACategory."Amount In Arears SACCO" := AmountInArrearsSACCO;
                        SASRACategory."Amount In Arears SASRA" := AmountInArrearsSASRA;

                        SASRACategory.INSERT;
                    end else begin
                        SASRACategory."Loans Category-SASRA" := Loans."Loans Category-SASRA";
                        SASRACategory."Loan Age" := LoanAge;
                        SASRACategory."Days In Arreas" := DaysInArrears;
                        SASRACategory."Amount In Arears SACCO" := AmountInArrearsSACCO;
                        SASRACategory."Amount In Arears SASRA" := AmountInArrearsSASRA;
                        SASRACategory.Modify();
                    end;


                    if Loans."Moratorium Loan" = true then begin
                        Loans."Moratorium Loan" := false;
                    end;
                end else begin
                    Loans.CalcFields("Days In Arrears", "Loans Category-SASRA")
                end;

                if Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Perfoming then
                    Percentage := '1%';
                if Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Watch then
                    Percentage := '5%';
                if Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Substandard then
                    Percentage := '25%';
                if Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Doubtful then
                    Percentage := '50%';
                if Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Loss then
                    Percentage := '100%';
            end;

            trigger OnPreDataItem()
            begin
                intProgressTotal := COUNT;

                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;

            trigger OnPostDataItem()
            begin
                diaProgress.CLOSE;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                field(GenerateOnRun; GenerateOnRun)
                {
                    Caption = 'Genrate on Run';
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
        CompanyName := CompanyInformation.Name;
        BuldingName := CompanyInformation."Building Name";
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
        CompanyEmail := CompanyInformation."E-Mail";
        PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
        PrintingTime := Format(Time);
        PrintedBy := GlobalFunctions.FormatUserName(UserId);
    end;

    //Columns
    var
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];
        Percentage: Text;
        ApplicationDate: Text;
        ApprovedAmount: Decimal;
        TotalBal: Decimal;
        OutInt: Decimal;
        OutBal: Decimal;
        AmountInArrearsSASRA: Decimal;
        AmountInArrearsSACCO: Decimal;


        //Request Page Fields
        GenerateOnRun: Boolean;


        //Other Variables
        Members: Record Members;
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        RecoveryHeader: Record "Loan Recovery Header";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        LoansProcess: Codeunit "Loans Process";
        DaysInArrears: Integer;
        RunLoan: Boolean;
        Counter: Integer;
        SASRACategory: Record "SASRA Categorization";
        LoanAge: Integer;
        AsAt: Date;

        //Task Progress
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;

}
