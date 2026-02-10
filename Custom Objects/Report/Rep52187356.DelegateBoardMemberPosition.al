report 52187356 "Delegate/Board Member Position"
{
    ApplicationArea = All;
    Caption = 'Delegate/Board Member Position';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/DelegateBoard Member Position.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(DelegateOfficials; "Delegate Officials")
        {
            RequestfilterFields = "Member Number", Retired, "Board Member";

            column(Member_Number; "Member Number")
            {
            }
            column(Delegate_Official_Name; "Delegate Official Name")
            {
            }
            column(Delegate_Official_Position; "Position")
            {
            }
            column(ID_No_; "ID No.")
            {
            }
            column(Board_Member; "Board Member")
            {
            }
            column(Service_Period; "Service Period")
            {
            }
            column(Appointment_Date; "Appointment Date")
            {
            }
            // column(Expiry_Date;"Expiry Date")
            // {
            // }
            column(Electoral_Zone; "Electoral Zone")
            {
            }
            column(Electoral_Zone_Name; "Electoral Zone Name")
            {
            }
            column(Retire_Date; "Retire Date")
            {
            }
            // column(Retired;Retired)
            // {
            // }
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
        Days: Integer;
        Age: Integer;
        AgeBracket: Text;
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ElectroralZones: Record "Electoral Zones";
}
