#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185630 "FOSA Savings Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Savings Register.rdl';

    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            DataItemTableView = where(Status = const(Active), "Product Type" = const('002'));
            //DataItemTableView = sorting("Member No.");
            RequestFilterFields = "No.", "Product Type", "Registration Date", "Global Dimension 1 Code", "Global Dimension 2 Code", "FD Maturity Date";
            column(ReportForNavId_1; 1)
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
            column(No_SavingsAccounts; SavingsAccounts."No.")
            {
            }
            column(Name_SavingsAccounts; SavingsAccounts.Name)
            {
            }
            column(GlobalDimension1Code_SavingsAccounts; SavingsAccounts."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_SavingsAccounts; SavingsAccounts."Global Dimension 2 Code")
            {
            }
            column(RegistrationDate_SavingsAccounts; SavingsAccounts."Registration Date")
            {
            }
            column(EmployerCode_SavingsAccounts; SavingsAccounts."Employer Code")
            {
            }
            column(ProductType_SavingsAccounts; SavingsAccounts."Product Type")
            {
            }
            column(ProductName_SavingsAccounts; SavingsAccounts."Product Name")
            {
            }
            column(MemberNo_SavingsAccounts; SavingsAccounts."Member No.")
            {
            }
            column(PayrollStaffNo_SavingsAccounts; SavingsAccounts."Payroll/Staff No.")
            {
            }
            column(PhoneNo_SavingsAccounts; SavingsAccounts."Phone No.")
            {
            }
            column(IDNumber_SavingsAccounts; SavingsAccounts."ID No.")
            {
            }
            column(BirthCertificateNo_SavingsAccounts; SavingsAccounts."Birth Certificate No.")
            {
            }
            column(SalespersonCode_SavingsAccounts; SavingsAccounts."Recruited By")
            {
            }
            column(CreatedBy_SavingsAccounts; SavingsAccounts."Created By")
            {
            }

            column(Status_SavingsAccounts; SavingsAccounts.Status)
            {
            }
            column(BalanceLCY_SavingsAccounts; SavingsAccounts."Balance (LCY)")
            {
            }
            column(SCount; SNo)
            {
            }
            column(MaturityDate; SavingsAccounts."FD Maturity Date")
            {
            }
            column(DateofBirth; SavingsAccounts."Date of Birth")
            {
            }
            column(MobilePhoneNo; SavingsAccounts."Mobile Phone No")
            {
            }
            column(ShowTotoDetail; ShowTotoDetail)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //SavingsAccounts.SETCURRENTKEY(SavingsAccounts."Member No.");
                SNo += 1;
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
                field(ShowTotoDetail; ShowTotoDetail)
                {
                    ApplicationArea = Basic;
                    Caption = 'ShowTotoDetail';
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
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        ShowTotoDetail: Boolean;
}
