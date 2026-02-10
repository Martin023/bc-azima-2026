#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186683 pageextension52186683 extends "Dispatch Board" 
{
    layout
    {
        modify(ResourceFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ResourceGroupFilter)
        {
            ApplicationArea = Basic;
        }
        modify(RespDateFilter)
        {
            ApplicationArea = Basic;
        }
        modify(AllocationFilter)
        {
            ApplicationArea = Basic;
        }
        modify(DocFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ServOrderFilter)
        {
            ApplicationArea = Basic;
        }
        modify(StatusFilter)
        {
            ApplicationArea = Basic;
        }
        modify(CustomFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ContractFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ZoneFilter)
        {
            ApplicationArea = Basic;
        }
        modify("Response Date")
        {
            ApplicationArea = Basic;
        }
        modify("Response Time")
        {
            ApplicationArea = Basic;
        }
        modify(Priority)
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Contract No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Zone Code")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Allocations")
        {
            ApplicationArea = Basic;
        }
        modify("Order Date")
        {
            ApplicationArea = Basic;
        }
        modify("Order Time")
        {
            ApplicationArea = Basic;
        }
        modify("Reallocation Needed")
        {
            ApplicationArea = Basic;
        }
        modify(Description2)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ResourceFilter(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ResourceGroupFilter(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RespDateFilter(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AllocationFilter(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DocFilter(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ServOrderFilter(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StatusFilter(Control 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CustomFilter(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ContractFilter(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ZoneFilter(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Time"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract No."(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Zone Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Allocations"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Time"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reallocation Needed"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description2(Control 92)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Show Document")
        {
            ApplicationArea = Basic;
        }
        modify("Resource &Allocations")
        {
            ApplicationArea = Basic;
        }
        modify("Demand Overview")
        {
            ApplicationArea = Basic;
        }
        modify("Print &Dispatch Board")
        {
            ApplicationArea = Basic;
        }
        modify("Print Service &Order")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Show Document"(Action 60)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""&Show Document"(Action 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource &Allocations"(Action 9)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Resource &Allocations"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Demand Overview"(Action 55)".


        //Unsupported feature: Property Deletion (Promoted) on ""Demand Overview"(Action 55)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Demand Overview"(Action 55)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Demand Overview"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Print &Dispatch Board"(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Print Service &Order"(Action 49)".

        addafter("Resource &Allocations")
        {
            separator(Action14)
            {
            }
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "SetAllFilters(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "SetDocFilter(PROCEDURE 7)".


    //Unsupported feature: Property Deletion (Attributes) on "SetDocFilter2(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "SetStatusFilter(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "SetRespDateFilter(PROCEDURE 9)".


    //Unsupported feature: Property Deletion (Attributes) on "SetServOrderFilter(PROCEDURE 10)".


    //Unsupported feature: Property Deletion (Attributes) on "SetCustFilter(PROCEDURE 11)".


    //Unsupported feature: Property Deletion (Attributes) on "SetZoneFilter(PROCEDURE 12)".


    //Unsupported feature: Property Deletion (Attributes) on "SetContractFilter(PROCEDURE 13)".


    //Unsupported feature: Property Deletion (Attributes) on "SetResourceFilter(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "SetResourceGroupFilter(PROCEDURE 6)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAllocFilter(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
