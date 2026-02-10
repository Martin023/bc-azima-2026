#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185725 "Actual Repayment Schedule"
{
    Caption = ' Repayment Schedule';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Actual Repayment Schedule.rdl';

    dataset
    {
        dataitem(Loans; Loans)
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
            column(Member_No; "Member No.")
            {
            }
            column(Loan_No; "Loan No.")
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
            column(Approved_Amount; "Approved Amount")
            {

            }
            dataitem("Ideal Repayment Schedule"; "Ideal Repayment Schedule")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = sorting("Loan No.", "Member No.", "Repayment Date");


                column(Monthly_Repayment; ROUND("Monthly Repayment"))
                {
                }
                column(Repayment_Date; Format("Repayment Date", 0, 4))
                {
                }
                column(Principal_Repayment; ROUND("Principal Repayment"))
                {
                }
                column(Monthly_Interest; ROUND("Monthly Interest"))
                {
                }
                column(LoanBalance; ROUND(IdealLoanBalance))
                {
                }
                column(Repayment_Code; "Repayment Code")
                {
                }
                column(Monthly_Repayment_10; ROUND("Monthly Repayment"))
                {
                }
                column(Principal_Repayment_10; ROUND("Principal Repayment"))
                {
                }
                column(Monthly_Interest_10; ROUND("Monthly Interest"))
                {
                }


                column(Actual_Loan_Bal; "Actual Loan Bal")
                {

                }
                column(Actual_Pr_Repayment; "Actual Pr Repayment")
                {

                }
                column(Actual_Int_Repayment; "Actual Int Repayment")
                {

                }
                column(Actual_Repayment; "Actual Repayment")
                {

                }

                trigger OnAfterGetRecord()
                begin

                end;
            }

            trigger OnAfterGetRecord()
            var
                LoansProcess: Codeunit "Loans Process";
            begin
                LoansProcess.GenerateActualSchedule(Loans);
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
        //columns 
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];

        IdealLoanBalance: Decimal;

        //Other Variables
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        LastPaymentDate: Date;
        LastPaymentLoanBalance: Decimal;
}
