report 52185909 "Membership TAT Report"
{
    ApplicationArea = All;
    Caption = 'Membership TAT Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Membership TAT Report.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "Registration Date", "No.";
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Status; Status)
            {
            }
            column(Subflag; Subflag)
            {
            }
            column(RegistrationDate; "Registration Date")
            {
            }
            column(Registration_Time; "Registration Time")
            {
            }
            column(Rejoinig_Date; "Rejoinig Date")
            {
            }
            column(Rejoining_Time; "Rejoining Time")
            {
            }
            column(DateofBirth; "Date of Birth")
            {
            }
            column(EMail; "E-Mail")
            {
            }
            column(RecruitedBy; "Recruited By")
            {
            }
            column(RecruitedByName; "Recruited By Name")
            {
            }
            column(RecruitedbyType; "Recruited by Type")
            {
            }
            column(MemberClass; "Member Class")
            {
            }
            column(Salutation; Salutation)
            {
            }
            column(MaritalStatus; "Marital Status")
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
            column(Delegates_Zone; "Delegates Zone")
            {
            }
            column(WokedOnANonWorkingPeriod; WokedOnANonWorkingPeriod)
            {
            }
            column(Duration; Duration)
            {
            }
            column(SLADuration; SLADuration)
            {
            }
            column(TimeVariance; TimeVariance)
            {
            }
            column(ApplicationDate; ApplicationDate)
            {

            }
            column(ApplicationTime; ApplicationTime)
            {

            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                SLADuration := 0;
                Duration := 0;
                TimeVariance := 0;

                //SLA
                SLA.Reset();
                SLA.SetRange("Origination Type", SLA."Origination Type"::"New Registration");
                if SLA.FindFirst() then begin
                    SLADuration := SLA.SLA;
                end;

                //TAT
                begin
                    MemberApplications.Reset();
                    MemberApplications.SetRange("Primary Identification", Members."Primary Identification");
                    MemberApplications.SetRange("Type of Application", MemberApplications."Type of Application"::"New Registration");
                    if MemberApplications.FindFirst() then begin
                        ApplicationDate := MemberApplications."Application Date";
                        ApplicationTime := MemberApplications."Application Time";
                        repeat
                            if MemberApplications."Type of Application" = MemberApplications."Type of Application"::"New Registration" then begin
                                Globalfunctions.HoursBetweenPeriods(MemberApplications."Application Date", MemberApplications."Application Time", Members."Registration Date", members."Registration Time", Duration, WokedOnANonWorkingPeriod);
                            end
                        until MemberApplications.next = 0;
                        Globalfunctions.HoursBetweenPeriods(MemberApplications."Application Date", MemberApplications."Application Time", Members."Registration Date", members."Registration Time", Duration, WokedOnANonWorkingPeriod);
                    end;
                end;

                //Vatiance
                TimeVariance := SLADuration - Duration;
            end;
        }
        // Globalfunctions.HoursBetweenPeriods("Application Date", "Application Time", Members."Registration Date", members."Registration Time", Duration, WokedOnANonWorkingPeriod);

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
        Globalfunctions: Codeunit "Global Functions";
        Duration: duration;

        WokedOnANonWorkingPeriod: Boolean;
        MemberApplications: record "Member Application";
        SLA: Record "Defined SLA";

        SLADuration: Duration;

        TimeVariance: Duration;

        ApplicationDate: date;

        ApplicationTime: Time;

}
