#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185617 "Accounts Application Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Accounts Application Register.rdl';

    dataset
    {
        dataitem(MemberApplication; "Member Application")
        {
            RequestFilterFields = "No.", "Application Date", "Employer Code", Status, "Group Account No.", "Responsibility Center";
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
            column(No_MemberApplication; MemberApplication."No.")
            {
            }
            column(Name_MemberApplication; MemberApplication.Name)
            {
            }
            column(GlobalDimension1Code_MemberApplication; MemberApplication."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_MemberApplication; MemberApplication."Global Dimension 2 Code")
            {
            }
            column(RegistrationDate_MemberApplication; MemberApplication."Application Date")
            {
            }
            column(EmployerCode_MemberApplication; MemberApplication."Employer Code")
            {
            }
            column(Nationality_MemberApplication; MemberApplication.County)
            {
            }
            column(PayrollStaffNo_MemberApplication; MemberApplication."Payroll/Staff No.")
            {
            }
            column(PhoneNo_MemberApplication; MemberApplication."Phone No.")
            {
            }
            column(IDNumber_MemberApplication; MemberApplication."Primary Identification")
            {
            }

            column(GroupAccountNo_MemberApplication; MemberApplication."Group Account No.")
            {
            }
            column(SalespersonCode_MemberApplication; MemberApplication."Recruited By")
            {
            }
            column(CreatedBy_MemberApplication; MemberApplication."Created By")
            {
            }

            column(Status_MemberApplication; MemberApplication.Status)
            {
            }
            column(SCount; SNo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
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
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
}
