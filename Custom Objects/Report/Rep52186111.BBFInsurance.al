namespace ALProject.ALProject;

report 52186111 "BBF Insurance"
{
    ApplicationArea = All;
    Caption = 'BBF Insurance';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SinkfundReportInformation; "Sinkfund Report Information")
        {
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
