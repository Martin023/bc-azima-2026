#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185562 pageextension52185562 extends "Acc. Sched. KPI Web Srv. Setup" 
{

    //Unsupported feature: Property Modification (PageType) on ""Acc. Sched. KPI Web Srv. Setup"(Page 195)".

    layout
    {
        modify(Period)
        {
            ApplicationArea = Basic;
        }
        modify("View By")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Budget Name")
        {
            ApplicationArea = Basic;
        }
        modify("Forecasted Values Start")
        {
            ApplicationArea = Basic;
        }
        modify("Web Service Name")
        {
            ApplicationArea = Basic;
        }
        modify(Published)
        {
            ApplicationArea = Basic;
        }
        modify(GetLastClosedAccDate)
        {
            ApplicationArea = Basic;
        }
        modify(GetLastBudgetChangedDate)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""View By"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Budget Name"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Forecasted Values Start"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Web Service Name"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Published(Control 13)".

        modify("Data Last Updated")
        {
            Visible = false;
        }
        modify("Data Time To Live (hours)")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "GetLastClosedAccDate(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetLastBudgetChangedDate(Control 17)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control4(Control 4)".

    }
    actions
    {
        modify(PublishWebService)
        {
            ApplicationArea = Basic;
        }
        modify(DeleteWebService)
        {
            ApplicationArea = Basic;
        }
        modify(KPIData)
        {
            ApplicationArea = Basic;
        }
        modify(WebServices)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PublishWebService(Action 8)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "PublishWebService(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DeleteWebService(Action 9)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "DeleteWebService(Action 9)".

        modify(RefreshBufferData)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "KPIData(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WebServices(Action 11)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
