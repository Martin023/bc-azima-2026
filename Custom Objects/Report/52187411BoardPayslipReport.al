report 52187411 "Board Payslip Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;

    RDLCLayout = './bc-kenpipe-2024/Layout/Board Payslip Report.rdl';

    dataset
    {
        dataitem("Board members"; "Board members")
        {
            RequestFilterFields = "Member No.", "No.";
            column(No_; "No.")
            {

            }
            column(Total_earnings; "Total earnings")
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(CommunicationOnline; CommunicationOnline)
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(CompanyTelephone; CompanyTelephone)
            {

            }
            column(Picture; CompanyInformation.Picture)
            {

            }
            column(CompanyName; CompanyName)
            {

            }
            dataitem("PR Board Transactions"; "PR Board Transactions")
            {
                DataItemLink = "No." = field("No.");
                column(No; "No.")
                {

                }
                column(Code; Code)
                {

                }
                column(Is_Deduction; "Is Deduction")
                {

                }
                column(Name; Name)
                {

                }
                column(Amount; Amount)
                {

                }

            }
            dataitem("Board Payroll Deductions"; "Board Payroll Deductions")
            {
                DataItemLink = "Document No" = field("No.");
                column(Document_No; "Document No")
                {

                }
                column(Deduction_Type; "Deduction Type")
                {

                }
                column(Related_No_; "Related No.")
                {

                }
                column(Amount_LCY; "Amount LCY")
                {

                }
            }


        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
        CompanyName := CompanyInformation.Name;

    end;

    var
        myInt: Integer;
        PRBoardTrans: Record "PR Board Transactions";
        BoardDeductions: Record "Board Payroll Deductions";
        SNo: Integer;
        CompanyInformation: Record "Company Information";
        CompanyName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}