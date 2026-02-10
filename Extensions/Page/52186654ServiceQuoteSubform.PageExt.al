#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186654 pageextension52186654 extends "Service Quote Subform"
{
    layout
    {
        modify("Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Group Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Code")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
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
        modify("Description 2")
        {
            ApplicationArea = Basic;
        }
        modify("Repair Status Code")
        {
            ApplicationArea = Basic;
        }
        modify("Service Shelf No.")
        {
            ApplicationArea = Basic;
        }
        modify(Warranty)
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Starting Date (Parts)")
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Ending Date (Parts)")
        {
            ApplicationArea = Basic;
        }
        modify("Warranty % (Parts)")
        {
            ApplicationArea = Basic;
        }
        modify("Warranty % (Labor)")
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Starting Date (Labor)")
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Ending Date (Labor)")
        {
            ApplicationArea = Basic;
        }
        modify("Contract No.")
        {
            ApplicationArea = Basic;
        }
        modify("Fault Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Service Price Group Code")
        {
            ApplicationArea = Basic;
        }
        modify("Adjustment Type")
        {
            ApplicationArea = Basic;
        }
        modify("Base Amount to Adjust")
        {
            ApplicationArea = Basic;
        }
        modify("Fault Area Code")
        {
            ApplicationArea = Basic;
        }
        modify("Symptom Code")
        {
            ApplicationArea = Basic;
        }
        modify("Fault Code")
        {
            ApplicationArea = Basic;
        }
        modify("Resolution Code")
        {
            ApplicationArea = Basic;
        }
        modify(Priority)
        {
            ApplicationArea = Basic;
        }
        modify("Response Time (Hours)")
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
        modify("Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Loaner No.")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Time")
        {
            ApplicationArea = Basic;
        }
        modify("Finishing Date")
        {
            ApplicationArea = Basic;
        }
        modify("Finishing Time")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Previous Services")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Line No."(Control 4)".


        //Unsupported feature: Code Modification on ""Service Item No."(Control 6).OnLookup".

        //trigger "(Control 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ServOrderMgt.LookupServItemNo(Rec);
        IF xRec.GET("Document Type","Document No.","Line No.") THEN;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ServOrderMgt.LookupServItemNo(Rec);
        IF xRec.GET("Document Type","Document No.","Line No.") THEN;
        InfopaneEnable("Service Item No." <> '');
        */
        //end;


        //Unsupported feature: Code Insertion on ""Service Item No."(Control 6)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        InfopaneEnable("Service Item No." <> '');
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Group Code"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Description 2"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Repair Status Code"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Shelf No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Warranty(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Starting Date (Parts)"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Ending Date (Parts)"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty % (Parts)"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty % (Labor)"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Starting Date (Labor)"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Ending Date (Labor)"(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Reason Code"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Price Group Code"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjustment Type"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Base Amount to Adjust"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Area Code"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Symptom Code"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Code"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resolution Code"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Time (Hours)"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Date"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Time"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor No."(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Item No."(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Loaner No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Time"(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finishing Date"(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finishing Time"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Previous Services"(Control 74)".

    }
    actions
    {
        modify("Resource &Allocations")
        {
            ApplicationArea = Basic;
        }
        modify("Service &Item Worksheet")
        {
            ApplicationArea = Basic;
        }
        modify(Troubleshooting)
        {
            ApplicationArea = Basic;
        }
        modify("&Fault/Resol. Codes Relations")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Faults)
        {
            ApplicationArea = Basic;
        }
        modify(Resolutions)
        {
            ApplicationArea = Basic;
        }
        modify(Internal)
        {
            ApplicationArea = Basic;
        }
        modify(Accessories)
        {
            ApplicationArea = Basic;
        }
        modify("Lent Loaners")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item &Log")
        {
            ApplicationArea = Basic;
        }
        modify("&Receive Loaner")
        {
            ApplicationArea = Basic;
        }
        modify("Create Service &Item")
        {
            ApplicationArea = Basic;
        }
        modify("Get St&d. Service Codes")
        {
            ApplicationArea = Basic;
        }
        modify(ServiceLines)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource &Allocations"(Action 1903867004)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service &Item Worksheet"(Action 1900545504)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Troubleshooting(Action 1902479904)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Fault/Resol. Codes Relations"(Action 1900978604)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1907528404)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Faults(Action 1901652704)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Resolutions(Action 1902759304)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Internal(Action 1900207104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Accessories(Action 1903099904)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lent Loaners"(Action 1901742304)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item &Log"(Action 1901991404)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Receive Loaner"(Action 1902759704)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Service &Item"(Action 1900295704)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get St&d. Service Codes"(Action 1902740204)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ServiceLines(Action 1901652204)".

    }

    var

        IPServItemEnable: Boolean;

        IPServItemButtonEnable: Boolean;

        IPServItemCommentPBEnable: Boolean;

        IPCompListEnable: Boolean;

        IPCompListTextboxEnable: Boolean;

        IPTroubleshootingEnable: Boolean;

        IPTroubleshootingTextboxEnable: Boolean;

        IPSkilledResEnable: Boolean;

        IPSkilledResTextboxEnable: Boolean;

        IPBarChartEnable: Boolean;

    local procedure InfopaneEnable(Value: Boolean)
    begin
        IPServItemEnable := Value;
        IPServItemButtonEnable := Value;
        IPServItemCommentPBEnable := Value;
        IPCompListEnable := Value;
        IPCompListTextboxEnable := Value;
        IPTroubleshootingEnable := Value;
        IPTroubleshootingTextboxEnable := Value;
        IPSkilledResEnable := Value;
        IPSkilledResTextboxEnable := Value;
        IPBarChartEnable := Value;
    end;
}
