report 52187015 "Mileage Per Driver"
{
    Caption = 'Mileage Per Driver';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Mileage Per Driver.rdl';

    dataset
    {
        dataitem(VehicleMovement; "Vehicle Movement")
        {
            column(DriverStaffNo; "Driver Staff No.")
            {
            }
            column(NameofDriver; "Name of Driver")
            {
            }
            column(No; "No.")
            {
            }
            column(TotalDistance; "Total Distance")
            {
            }
            column(VehicleRegNo; "Vehicle Reg No.")
            {
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
