report 52187369 "Mileage Per Driver Report"
{
    ApplicationArea = All;
    Caption = 'Mileage Per Driver Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Mileage Per Driver Report.rdl';
    dataset
    {
        dataitem(VehicleMovement; "Vehicle Movement")
        {
            column(No; "No.")
            {
            }
            column(TotalDistance; "Total Distance")
            {
            }
            column(VehicleRegNo; "Vehicle Reg No.")
            {
            }
            column(OutwardDistance; "Outward Distance")
            {
            }
            column(ReturnDistance; "Return Distance")
            {
            }
            column(DriverStaffNo; "Driver Staff No.")
            {
            }
            dataitem(Motor_Vehicle_Request; "Motor Vehicle Request")
            {
                column(MovementNo; "No.")
                {
                }
                dataitem("Company Vehicles"; "Company Vehicles")
                {
                    column(RegistrationNo; "Registration No.")
                    {
                    }

                }

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
}
