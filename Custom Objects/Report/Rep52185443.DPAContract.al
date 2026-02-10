report 52185443 "DPA Contract"
{
    ApplicationArea = All;
    Caption = 'DPA Contract';
    //UsageCategory = ReportsAndAnalysis;
    // DefaultLayout = RDLC;
    // RDLCLayout = './bc-kenpipe-2024/Layout/DPA Contract.rdl';
    DefaultLayout = Word;
    WordLayout = './bc-kenpipe-2024/Layout/DPA Contract.docx';
    dataset
    {
        dataitem(Contracts; Contracts)
        {
            RequestFilterFields = "Contract No";
            column(ContractNo; "Contract No")
            {
            }
            column(ContractorNo; "Contractor No")
            {
            }
            column(ContractorType; "Contractor Type")
            {
            }
            column(ContractorName; "Contractor Name")
            {
            }
            column(ContractType; "Contract Type")
            {
            }
            column(Contractor_Description; "Contractor Description")
            {
            }
            column(Date_of_Excecution; "Date of Excecution")
            {
            }
            column(PartytotheContract; "Party to the Contract")
            {
            }
            column(PostOfficeAddress; Address)
            {
            }
            column(Physical_Address; "Physical Address")
            {
            }
            column(Chairman; CompanyInformation.Chairman)
            {
            }
            Column(CEO; CompanyInformation.CEO)
            {
            }
            column(Secretary; CompanyInformation.Secretary)
            {
            }
            column(Treasurer; CompanyInformation.Treasurer)
            {
            }
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
    var
        CompanyInformation: Record "Company Information";

}
