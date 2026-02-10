#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185503 "Victims on Incident List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Victims on Incident List.rdl';

    dataset
    {
        dataitem("HR OSIncident"; "HR OSIncident")
        {
            RequestFilterFields = "Incident No", "Type of Incident";
            column(ReportForNavId_1; 1)
            {
            }
            column(IncidentNo_OSIncident; "HR OSIncident"."Incident No")
            {
            }
            column(IncidentDesc_OSIncident; "HR OSIncident"."Incident Description")
            {
            }
            column(Address_OSIncident; "HR OSIncident".Address)
            {
            }
            column(DateofBirth_OSIncident; "HR OSIncident"."Date of Birth")
            {
            }
            column(JobTitle_OSIncident; "HR OSIncident"."Job Title")
            {
            }
            column(HomePhoneNo_OSIncident; "HR OSIncident"."Home Phone No.")
            {
            }
            column(Section_OSIncident; "HR OSIncident".Section)
            {
            }
            column(TypeofIncident_OSIncident; "HR OSIncident"."Type of Incident")
            {
            }
            column(LocationCode_OSIncident; "HR OSIncident"."Location Name")
            {
            }
            column(PartofBodyAffected_OSIncident; "HR OSIncident"."Part of Body Affected")
            {
            }
            column(DateofIncident_OSIncident; "HR OSIncident"."Date of Incident")
            {
            }
            column(Time_OSIncident; "HR OSIncident".Time)
            {
            }
            column(DateNotificationReceived_OSIncident; "HR OSIncident"."Date Notification Received")
            {
            }
            column(FirstWitnessName_OSIncident; "HR OSIncident"."First Witness Name")
            {
            }
            column(FirstWitnessAddress_OSIncident; "HR OSIncident"."First Witness Address")
            {
            }
            column(SecondWitnessName_OSIncident; "HR OSIncident"."Second Witness Name")
            {
            }
            column(SecondWitnessAddress_OSIncident; "HR OSIncident"."Second Witness Address")
            {
            }
            column(FirstAidGiven_OSIncident; "HR OSIncident"."First Aid Given")
            {
            }
            column(TakenHome_OSIncident; "HR OSIncident"."Taken Home")
            {
            }
            column(ReturntoWorkonsameday_OSIncident; "HR OSIncident"."Return to Work on same day")
            {
            }
            column(WentAbsent_OSIncident; "HR OSIncident"."Went Absent")
            {
            }
            column(TakentoHospital_OSIncident; "HR OSIncident"."Taken to Hospital")
            {
            }
            column(Admitted_OSIncident; "HR OSIncident".Admitted)
            {
            }
            column(NoSeries_OSIncident; "HR OSIncident"."No. Series")
            {
            }
            column(EmployeeNo_OSIncident; "HR OSIncident"."Employee No")
            {
            }
            dataitem("HR OSInjured Person"; "HR OSInjured Person")
            {
                DataItemLink = "Incident No" = field("Incident No");
                column(ReportForNavId_27; 27)
                {
                }
                column(EmployeeNo_OSInjuredPerson; "HR OSInjured Person"."Employee No")
                {
                }
                column(InjuredPerson_OSInjuredPerson; "HR OSInjured Person"."Injured Person")
                {
                }
                column(address; "HR OSInjured Person".Address)
                {
                }
                column(phone; "HR OSInjured Person"."Phone No")
                {
                }
                column(id; "HR OSInjured Person"."ID No")
                {
                }
                column(dob; "HR OSInjured Person"."Date Of Birth")
                {
                }
                column(mail; "HR OSInjured Person".Email)
                {
                }
            }
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
}
