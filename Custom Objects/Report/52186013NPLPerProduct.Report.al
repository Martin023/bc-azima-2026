#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186013 "NPL Per Product"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/NPL Per Product.rdl';

    dataset
    {

        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Loan No.", "Member No.", "Employer Code", "Loan Product Type", "Disbursement Date", "Loans Category-SASRA", "Global Dimension 1 Code", "Global Dimension 2 Code", "Source Unit", Installments;
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
            column(Loan_Product_Type; "Loan Product Type")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }
            column(Source_Unit; "Source Unit")
            {

            }
            column(OutInt; OutInt)
            {

            }
            column(OutBal; OutBal)
            {

            }
            column(TotalBal; TotalBal)
            {

            }
            trigger OnPreDataItem()
            begin
                intProgressTotal := COUNT;

                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;

            trigger OnAfterGetRecord()
            begin
                RecoveryHeader.GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);

                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                end;

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
        //Colums
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];

        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;

        //Other Variable
        //Other Variable
        Members: Record Members;
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        RecoveryHeader: Record "Loan Recovery Header";
        CreditLedgerEntry: Record "Credit Ledger Entry";

        //progress
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;

}
