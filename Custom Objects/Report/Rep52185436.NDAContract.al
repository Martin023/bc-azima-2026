report 52185436 "NDA Contract"
{
    ApplicationArea = All;
    Caption = 'NDA Contract';
    //UsageCategory = Documents;
    // DefaultLayout = RDLC;
    // RDLCLayout = './bc-kenpipe-2024/Layout/NDA Contract.rdl';
    DefaultLayout = Word;
    WordLayout = './bc-kenpipe-2024/Layout/NDA Contract.docx';
    dataset
    {
        dataitem(Contracts; Contracts)
        {
            RequestFilterFields = "Contract No";
            column(ContractorNo; "Contractor No")
            {
            }
            column(ContractorType; "Contractor Type")
            {
            }
            column(NatureOfService; "Nature Of Service")
            {
            }
            column(PartytotheContract; "Party to the Contract")
            {
            }
            column(Date_of_Excecution; "Date of Excecution")
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
            column(Company_Number; "Company Number")
            {
            }
            column(Place_of_Business; "Place of Business")
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
    Var
        CompanyInformation: Record "Company Information";
}
