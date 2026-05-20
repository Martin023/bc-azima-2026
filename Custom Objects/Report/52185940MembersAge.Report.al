#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185940 "Members Age"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Members Age.rdl';

    dataset
    {
        //dataitem(52185700;52185700)
        dataitem(Members; "Members")
        {
            RequestFilterFields = "No.", Status,Age, "Date of Birth";
            column(ReportForNavId_1; 1)
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(IdNo_Members; Members."Primary Identification")
            {
            }
            column(Gender_Members; Members.Gender)
            {
            }
            column(DOB_Members; Members."Date of Birth")
            {
            }
            column(Age; Age)
            {
            }
            column(AgeGroup; AgeBracket)
            {
            }
            column(Employer_Code; Members."Employer Code")
            {
            }
            column(Employer_Name; EmployerName)
            {
            }
            column(Joining_Date; Members."Registration Date")
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
                Age := 0;
                Days := 0;
                AgeBracket := '';
                EmployerName := '';
                if Members."Date of Birth" <> 0D then begin
                    Days := Today - Members."Date of Birth";
                    Age := ROUND((Days / 365.2364), 1, '<') //Denis takes into Account Leap Year
                end
                else
                    Age := 0;

                //Group Age
                if Age <> 0 then begin
                    if Age < 18 then AgeBracket := 'Below 18';
                    if (Age >= 18) and (Age <= 30) then AgeBracket := '18-30';
                    if (Age > 30) and (Age <= 40) then AgeBracket := '31-40';
                    if (Age > 40) and (Age <= 50) then AgeBracket := '41-50';
                    if (Age > 50) and (Age <= 60) then AgeBracket := '51-60';
                    if (Age > 60) then AgeBracket := 'Over 60';

                end
                else
                    AgeBracket := 'No D.O.B';

                if Customer.Get(Members."Employer Code") then
                    EmployerName := Customer.Name
            end;

            // trigger OnPreDataItem()
            // begin
            //     CompanyInformation.Get;
            //     CompanyInformation.CalcFields(Picture);
            // end;
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
        Days: Integer;
        Age: Integer;
        AgeBracket: Text;
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
