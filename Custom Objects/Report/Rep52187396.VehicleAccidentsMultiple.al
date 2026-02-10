report 52187396 "Vehicle Accidents - Multiple"
{
    ApplicationArea = All;
    Caption = 'Vehicle Accidents - Multiple';
    //UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Vehicle Accidents - Multiple.rdl';
    dataset
    {

        dataitem(HROSAccident; "HR OSAccident")
        {
            RequestFilterFields = "Accident No.", "Type of Accident", "Accident Date", "Accident Location", "Accident Time", "Driver No.", "Driver Staff No.", "MNS Driver Name", "MNS Driver ID No.", "MNS Driver Phone No.", "MNS Vehicle No.", "MNS Vehicle Make", "Extent of damages", "MNS Vehicle Inusrance", "Registration No.";
            column(AccidentNo; "Accident No.")
            {
            }
            column(AccidentDate; "Accident Date")
            {
            }
            column(AccidentLocation; "Accident Location")
            {
            }
            column(AccidentTime; "Accident Time")
            {
            }
            column(DriverNo; "Driver No.")
            {
            }
            column(DriverStaffNo; "Driver Staff No.")
            {
            }
            column(MNSDriverName; "MNS Driver Name")
            {
            }
            column(MNSDriverIDNo; "MNS Driver ID No.")
            {
            }
            column(MNSDriverPhoneNo; "MNS Driver Phone No.")
            {
            }
            column(MNSVehicleNo; "MNS Vehicle No.")
            {
            }
            column(MNSVehicleMake; "MNS Vehicle Make")
            {
            }
            column(Extentofdamages; "Extent of damages")
            {
            }
            column(MNSVehicleInusrance; "SACCO Vehicle Insurance")
            {
            }
            column(RegistrationNo; "Registration No.")
            {
            }
            column(TypeofAccident; "Type of Accident")
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

            dataitem(OtherPartyLines; "Accident Lines Table")
            {
                //DataItemLinkReference = "HR OSAccident";
                DataItemLink = "Accident No." = FIELD("Accident No.");
                column(LinesAccidentNo; "Accident No.")
                {
                }
                column(Driver_Name; "Driver Name")
                {
                }
                Column(Driver_IDNo; "Driver ID No.")
                {
                }
                column(Driver_PhoneNo; "Phone No.")
                {
                }
                column(Vehicle_No; "Vehicle No.")
                {
                }
                column(Vehicle_Make; "Vehicle Make")
                {
                }
                column(Vehicle_Insurance; "Vehicle Insurance")
                {
                }
                trigger OnPreDataItem()
                begin
                    CompanyInformation.Get;
                    CompanyInformation.CalcFields(Picture);
                end;

                trigger OnAfterGetRecord()
                begin
                    Driver_Name := '';
                    Driver_IDNo := '';
                    Driver_PhoneNo := '';
                    Vehicle_No := '';
                    Vehicle_Make := '';
                    Vehicle_Insurance := 0;

                    OtherPartyLines.Reset;
                    OtherPartyLines.SetRange("Accident No.", "Accident No.");
                    if OtherPartyLines.find('-') then
                        repeat
                            Driver_Name := OtherPartyLines."Driver Name";
                            Driver_IDNo := OtherPartyLines."Driver ID No.";
                            Driver_PhoneNo := OtherPartyLines."Phone No.";
                            Vehicle_No := OtherPartyLines."Vehicle No.";
                            Vehicle_Make := OtherPartyLines."Vehicle Make";
                            Vehicle_Insurance := OtherPartyLines."Vehicle Insurance";
                        until OtherPartyLines.next = 0;

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


    Var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Driver_Name: Text;
        Driver_IDNo: Text;
        Driver_PhoneNo: Code[50];
        Vehicle_No: Code[50];
        Vehicle_Make: Text;
        Vehicle_Insurance: Option;
}
