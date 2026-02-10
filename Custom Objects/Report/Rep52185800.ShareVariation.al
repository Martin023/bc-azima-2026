report 52185800 "Share Variation"
{
    ApplicationArea = All;
    Caption = 'Share Variation';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Share Variation Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Variation; "Product Variations")
        {
            DataItemTableView = where("Variation Type" = filter(Savings));
            RequestFilterFields = "No.", "Variation Type", Posted;
            column(No; Variation."No.")
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(Member_Name; "Member Name")
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
            column(Reference; Reference)
            {

            }
            column(Member_ID_No_; "Member ID No.")
            {

            }
            column(Remarks; "Variation Action")
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
            column(Effective_Date; "Effective Month")
            {

            }
            column(posted; posted)
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
                //Amount_On := 0;
                //Amount_Off := 0;
                Variance := 0;

                //Variation.Reset();
                //Variation.Get("No.");
                //if variation.FindSet() then begin
                Variance := "Amount On" - "Amount Off";
                //end;

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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: Record Members;
}
