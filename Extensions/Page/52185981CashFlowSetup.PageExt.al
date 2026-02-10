#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185981 pageextension52185981 extends "Cash Flow Setup"
{
    layout
    {
        modify("Receivables CF Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Payables CF Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Order CF Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service CF Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Purch. Order CF Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("FA Budget CF Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("FA Disposal CF Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Cash Flow Forecast No. Series")
        {
            ApplicationArea = Basic;
        }
        modify("Automatic Update Frequency")
        {
            Visible = false;
        }
        modify(Accounts)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Receivables CF Account No."(Control 1001)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payables CF Account No."(Control 1003)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Order CF Account No."(Control 1005)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service CF Account No."(Control 1013)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. Order CF Account No."(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Budget CF Account No."(Control 1009)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Disposal CF Account No."(Control 1011)".

        modify("Job CF Account No.")
        {
            Visible = false;
        }
        modify("Tax CF Account No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Cash Flow Forecast No. Series"(Control 1015)".

        modify(Tax)
        {
            Visible = false;
        }
        modify("Taxable Period")
        {
            Visible = false;
        }
        modify("Tax Payment Window")
        {
            Visible = false;
        }
        modify("Tax Bal. Account Type")
        {
            Visible = false;
        }
        modify("Tax Bal. Account No.")
        {
            Visible = false;
        }
        // modify("Cortana Intelligence")
        // {
        //     Visible = false;
        // }
        modify("Period Type")
        {
            Visible = false;
        }
        modify("Historical Periods")
        {
            Visible = false;
        }
        modify(Horizon)
        {
            Visible = false;
        }
        modify("API URL")
        {
            Visible = false;
        }
        modify("API Key")
        {
            Visible = false;
        }
        modify("Time Series Model")
        {
            Visible = false;
        }
        modify("Variance %")
        {
            Visible = false;
        }
        modify(Enabled)
        {
            Visible = false;
        }
        modify("Total Proc. Time")
        {
            Visible = false;
        }
    }
    actions
    {
    //     modify(ActionContainer25)
    //     {
    //         Visible = false;
    //     }
    //     modify("Chart Options")
    //     {
    //         Visible = false;
    //     }
    //     modify("Open Cortana Intelligence Gallery")
    //     {
    //         Visible = false;
    //     }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
