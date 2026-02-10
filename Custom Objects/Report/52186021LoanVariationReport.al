report 52186029 "Loan Variation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Variation Report.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Variation; "Product Variations")
        {
            DataItemTableView = where("Variation Type" = filter(Loan));
            RequestFilterFields = "No.", "Variation Type", posted;
            column(No; Variation."No.")
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(Reference; Reference)
            {

            }
            column(Remarks; "Variation Action")
            {

            }
            column(Employer_Code; "Employer Code")
            {

            }
            column(Payroll_No; "Payroll No")
            {

            }
            column(Amount_On; "Amount On")
            {

            }
            column(Amount_Off; "Amount Off")
            {

            }
            column(Product_Type; "Product Type")
            {

            }
            column(Product_Name; "Product Name")
            {

            }
            column(Variance; Variance)
            {

            }
            column(Member_ID_No_; "Member ID No.")
            {

            }
            column(Effective_Date; "Effective Month")
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

            trigger OnAfterGetRecord()
            begin
                //     Amount_On := 0;
                //     Amount_Off := 0;
                Variance := 0;

                Variance := "Amount On" - "Amount Off";


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
    end;



    var
        myInt: Integer;

        Variance: decimal;
        Amount_On: Decimal;
        Amount_Off: Decimal;
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        MemberId: Code[30];
        CommunicationOnline: Text;
        Members: Record Members;

}