report 52187014 "Office Keys Movement"
{
    ApplicationArea = All;
    Caption = 'Office Keys Movement';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Office Keys Movement.rdl';
    dataset
    {
        dataitem(KeyDetails; "Office Keys List")
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {
            }
            column(KeyDepartment; Department)
            {
            }
            column(Key_Category; "Key Category")
            {
            }
            column(Other_Key_Category; "Other Key Category")
            {
            }
            column(Office_Store_Room_Name; "Office/Store/Room Name")
            {
            }
            column(KeyRoomFloor; Floor)
            {
            }
            column(NumberofKeys; "Key Number")
            {
            }
            column(Key_Status; "Key Status")
            {
            }
            column(Floor; Floor)
            {
            }
            dataitem(OfficeKeys; "Key Request Table")
            {
                //RequestFilterFields = "Key Status";
                DataItemLinkReference = KeyDetails;
                DataItemLink = "Key No." = FIELD("No.");
                column(Name; "Name")
                {
                }
                column(No; "No.")
                {
                }
                column(NoSeries; "No. Series")
                {
                }
                column(PurposeofKeyRequest; "Purpose of Request")
                {
                }
                column(StaffNumber; "Staff Number")
                {
                }
                column(StaffName; "Name")
                {
                }
                column(Key_Request_Date; "Date of Request")
                {
                }
                column(Key_Request_Status; "Key Status")
                {

                }
                column(Returned; Returned)
                {

                }
                column(Date_Returned; "Date Returned")
                {
                }
                column(Received; Received)
                {

                }
                column(Date_Received; "Date Received")
                {
                }
                column(Dispatched; Dispatched)
                {
                }
                column(Date_of_Issue; "Date of Issue")
                {
                }
                column(Dispatched_By; "Dispatched By")
                {

                }
                column(Key_Dispatch_Date; "Date of Issue")
                {

                }
                column(Key_No_; "Key No.")
                {

                }
                column(Key_Room_Name; "Key Room Name")
                {
                }
                column(Department; "Department Name")
                {
                }
                column(Closed; Closed)
                {
                }
                column(Date_Closed; "Date Closed")
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
