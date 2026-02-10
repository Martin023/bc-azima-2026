report 52187013 "Staff Holding Keys"
{
    ApplicationArea = All;
    Caption = 'Staff Holding Keys';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Staff Holding Keys.rdl';
    dataset
    {
        dataitem(OfficeKeys; "Key Request Table")
        {
            RequestFilterFields = "Key Status";

            column(No; "No.")
            {
            }
            column(Date_of_Request; "Date of Request")
            {
            }
            column(Staff_Number; "Staff Number")
            {
            }
            column(StaffName; "Name")
            {
            }
            column(Department_Name; "Department Name")
            {
            }
            column(PurposeofKeyRequest; "Purpose of Request")
            {
            }
            column(Name_of_Room_Office; "Name of Room/Office")
            {
            }
            column(Received; Received)
            {
            }
            column(Returned; Returned)
            {
            }
            column(Date_Returned; "Date Returned")
            {
            }
            column(Date_Received; "Date Received")
            {
            }

            //Dispatch 
            column(Key_No_; "Key No.")
            {
            }
            column(Key_Room_Name; "Key Room Name")
            {
            }
            column(Dispatched; Dispatched)
            {
            }

            column(Key_Dispatch_Date; "Date of Issue")
            {
            }

            column(Closed; Closed)
            {
            }
            column(Date_Closed; "Date Closed")
            {
            }
            column(Status; Status)
            {
            }
            column(Key_Status; "Key Status")
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
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
