#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185955 "NOK With Principle Mem ID No."
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/NOK With Principle Mem ID No..rdl';

    dataset
    {
        //dataitem(52185700;52185700)
        dataitem(Members; "Members")
        {
            DataItemTableView = where("Primary Identification" = filter(<> ''));
            column(ReportForNavId_1; 1)
            {
            }
            column(Member_No; Members."No.")
            {
            }
            column(Member_Name; Members.Name)
            {
            }
            column(Relationship; Relationship)
            {
            }
            column(Type; NOKType)
            {
            }
            column(NOKName; NOKName)
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
                NOK.Reset;
                NOK.SetRange("Record ID", Members."No.");
                NOK.SetRange(Identification, Members."Primary Identification");
                if NOK.Find('-') then begin
                    Relationship := NOK.Relationship;
                    NOKName := NOK.Name;
                end else
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
        NOK: Record "Next of KIN";
        Company: Record "Company Information";
        Relationship: Text;
        NOKType: Text;
        NOKName: Text;
        CompanyInformation: Record "Company Information";
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
