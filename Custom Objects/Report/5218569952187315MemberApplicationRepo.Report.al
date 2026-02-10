report 52187315 MembAppReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/MembAppReport.rdl';
    Caption = 'MembAppReport';


    dataset
    {
        dataitem(DataItemName; "Member Application")
        {
            column(No; "No.")
            {

            }
            column(Application_Date; "Application Date")
            {

            }
            column(Name; "Name")
            {

            }
            column(Primary_Identification; "Primary Identification")
            {

            }
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {

            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


    var
        myInt: Integer;
}