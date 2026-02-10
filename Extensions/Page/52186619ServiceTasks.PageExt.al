#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186619 pageextension52186619 extends "Service Tasks" 
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
        modify(AllocationStatus)
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
        modify(RepairStatusFilter)
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
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Repair Status Code")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Code")
        {
            ApplicationArea = Basic;
        }
        modify("Cust.Name")
        {
            ApplicationArea = Basic;
        }
        modify("Service Shelf No.")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Group Code")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Warranty)
        {
            ApplicationArea = Basic;
        }
        modify("Contract No.")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Allocations")
        {
            ApplicationArea = Basic;
        }
        modify(Description2)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ResourceFilter(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ResourceGroupFilter(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RespDateFilter(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AllocationStatus(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DocFilter(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ServOrderFilter(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RepairStatusFilter(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Time"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Repair Status Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.Name"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Shelf No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Group Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Warranty(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Allocations"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description2(Control 31)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Show Document")
        {
            ApplicationArea = Basic;
        }
        modify("&Item Worksheet")
        {
            ApplicationArea = Basic;
        }
        modify("Service &Tasks")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item &Worksheet")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Show Document"(Action 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Item Worksheet"(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service &Tasks"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item &Worksheet"(Action 48)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetAllFilters(PROCEDURE 5)".


    //Unsupported feature: Property Deletion (Attributes) on "SetRepStatFilter(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: ApplicationManagement) (VariableCollection) on "SetRespDateFilter(PROCEDURE 6)".


    //Unsupported feature: Property Deletion (Attributes) on "SetRespDateFilter(PROCEDURE 6)".


    //Unsupported feature: Code Modification on "SetRespDateFilter(PROCEDURE 6)".

    //procedure SetRespDateFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        FILTERGROUP(2);
        TextManagement.MakeDateFilter(RespDateFilter);
        SETFILTER("Response Date",RespDateFilter);
        RespDateFilter := GETFILTER("Response Date");
        FILTERGROUP(0);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        FILTERGROUP(2);
        IF ApplicationManagement.MakeDateFilter(RespDateFilter) = 0 THEN;
        #3..5
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetDocFilter(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "SetDocFilterHeader(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "SetServOrderFilter(PROCEDURE 7)".


    //Unsupported feature: Property Deletion (Attributes) on "SetResourceFilter(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetResourceGroupFilter(PROCEDURE 9)".


    //Unsupported feature: Property Deletion (Attributes) on "SetAllocationFilter(PROCEDURE 3)".


    //Unsupported feature: Property Insertion (Name) on "TestFilter(PROCEDURE 10).ReturnValue".


    //Unsupported feature: Deletion (VariableCollection) on "SetRespDateFilter(PROCEDURE 6).TextManagement(Variable 1000)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
