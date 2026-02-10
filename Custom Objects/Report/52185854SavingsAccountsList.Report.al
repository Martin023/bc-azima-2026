#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185854 "Savings Accounts List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Savings Accounts List.rdl';

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            RequestFilterFields = "Current Address", "Registration Date", Status, "Account Category", "Product Type";
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
            column(Status_SavingsAccounts; "Savings Accounts".Status)
            {
            }
            column(DateofBirth_SavingsAccounts; "Savings Accounts"."Date of Birth")
            {
            }
            column(AccountCategory_SavingsAccounts; "Savings Accounts"."Account Category")
            {
            }
            column(ProductType_SavingsAccounts; "Savings Accounts"."Product Type")
            {
            }
            column(MemberNo_SavingsAccounts; "Savings Accounts"."Member No.")
            {
            }
            column(ProductName_SavingsAccounts; "Savings Accounts"."Product Name")
            {
            }
            column(CreatedBy_SavingsAccounts; "Savings Accounts"."Created By")
            {
            }
            column(RegistrationDate_SavingsAccounts; "Savings Accounts"."Registration Date")
            {
            }
            column(ProductDescription; ProductDescription)
            {
            }
            column(SavingsAccountNo_SavingsAccounts; "Savings Accounts"."Savings Account No.")
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
            dataitem(User; User)
            {
                DataItemLink = "User Name" = field("Created By");
                column(ReportForNavId_15; 15)
                {
                }
                column(FullName_User; User."Full Name")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if "Savings Accounts"."Registration Date" = 0D then CurrReport.Skip;
                ProductFactory.Get("Savings Accounts"."Product Type");
                ProductDescription := ProductFactory."Product Description";
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
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := CompanyInformation."Phone No.";
        CommunicationOnline := CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ProductFactory: Record "Product Factory";
        ProductDescription: Text;
}
