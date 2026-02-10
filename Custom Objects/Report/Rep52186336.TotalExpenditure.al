report 52186336 "Total Expenditure"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Total Ependiture Report.rdl';
    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "No.";
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(BudgetedAmount; "Budgeted Amount")
            {
            }
            Column(Last_Direct_Cost; "Last Direct Cost")
            {

            }
            column(Inventory; Inventory)

            {

            }
            column(Purchases__Qty__; "Purchases (Qty.)")
            {

            }
            column(Purchases__LCY_; "Purchases (LCY)")
            {

            }
            column(Sales__Qty__; "Sales (Qty.)")
            {

            }
            column(Sales__LCY_; "Sales (LCY)")
            {

            }
            column(Positive_Adjmt___Qty__; "Positive Adjmt. (Qty.)")
            {

            }
            column(Positive_Adjmt___LCY_; "Positive Adjmt. (LCY)")
            {

            }
            column(Negative_Adjmt___Qty__; "Negative Adjmt. (Qty.)")
            {

            }
            column(Negative_Adjmt___LCY_; "Negative Adjmt. (LCY)")
            {

            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
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
            column(Total_Amount; "Total Amount")
            {

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                "Total Amount" := (Item."Purchases (LCY)" + Item."Positive Adjmt. (LCY)") - (Item."Sales (LCY)" + Item."Negative Adjmt. (LCY)");
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

        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        "Total Amount": decimal;
}
