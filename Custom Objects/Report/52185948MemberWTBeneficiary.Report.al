#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185948 "Member W/T Beneficiary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Member WT Beneficiary.rdl';

    dataset
    {
        //dataitem(52185700;"52185700")
        dataitem(Members; "Members")
        {
            RequestFilterFields = "No.", Status, "Employer Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(Member_No; Members."No.")
            {
            }
            column(Member_Name; Members.Name)
            {
            }
            column(Member_ID; Members."Primary Identification")
            {
            }
            column(Member_Phone; Members."Phone No.")
            {
            }
            column(Member_PF; Members."Payroll/Staff No.")
            {
            }
            column(Member_EmployerName; Members."Employer Name")
            {
            }
            column(Member_EmployerCode; Members."Employer Code")
            {
            }
            column(Member_Status; Members.Status)
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
                NextKin.Reset;
                NextKin.SetRange("Record ID", Members."No.");
                NextKin.SetRange("Is a Beneficiary", NextKin."Is a Beneficiary");
                //NextKin.SETRANGE(Beneficiary,TRUE);
                if NextKin.Find('-') then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
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
        NextKin: Record "Next of KIN";
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
