report 52185453 "Unit Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Unit Report.rdl';
    Caption = 'Office Spaces Report';
    dataset
    {
        dataitem(Unit; Unit)
        {
            RequestFilterFields = "Unit Status";
            Column(Property_No_; "Property No.")
            {
            }
            column(Property_Name; "Property Name")
            {
            }
            column(Floor_Code; "Floor Code")
            {
            }
            column(Unit_Code; "Unit Code")
            {
            }
            column(Unit_Type; "Unit Type")
            {
            }
            column(Unit_Type_Name; "Unit Type Name")
            {
            }
            column(Unit_Status; "Unit Status")
            {
            }
            column(Area_Square_ft; "Area Square ft")
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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text[250];
        CompanyTelephone: Text[250];
        CommunicationOnline: Text[250];
}
