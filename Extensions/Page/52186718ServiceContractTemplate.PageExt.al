#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186718 pageextension52186718 extends "Service Contract Template"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Contract Group Code")
        {
            ApplicationArea = Basic;
        }
        modify("Service Order Type")
        {
            ApplicationArea = Basic;
        }
        modify("Default Service Period")
        {
            ApplicationArea = Basic;
        }
        modify("Price Update Period")
        {
            ApplicationArea = Basic;
        }
        modify("Default Response Time (Hours)")
        {
            ApplicationArea = Basic;
        }
        modify("Max. Labor Unit Price")
        {
            ApplicationArea = Basic;
        }
        modify("Serv. Contract Acc. Gr. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Invoice Period")
        {
            ApplicationArea = Basic;
        }
        modify("Price Inv. Increase Code")
        {
            ApplicationArea = Basic;
        }
        modify(Prepaid)
        {
            ApplicationArea = Basic;
        }
        modify("Allow Unbalanced Amounts")
        {
            ApplicationArea = Basic;
        }
        modify("Combine Invoices")
        {
            ApplicationArea = Basic;
        }
        modify("Automatic Credit Memos")
        {
            ApplicationArea = Basic;
        }
        modify("Contract Lines on Invoice")
        {
            ApplicationArea = Basic;
        }
        modify("Invoice after Service")
        {
            ApplicationArea = Basic;
            Enabled = "Invoice after ServiceEnable";
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract Group Code"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Order Type"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Default Service Period"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Price Update Period"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Default Response Time (Hours)"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. Labor Unit Price"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serv. Contract Acc. Gr. Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Period"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Price Inv. Increase Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Prepaid(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Unbalanced Amounts"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Combine Invoices"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Automatic Credit Memos"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract Lines on Invoice"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice after Service"(Control 42)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Service Dis&counts")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Dis&counts"(Action 52)".

        addafter(Dimensions)
        {
            separator(Action17)
            {
                Caption = '';
            }
        }
    }

    var

        "Invoice after ServiceEnable": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InvoiceAfterServiceEnable := TRUE;
    PrepaidEnable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Invoice after ServiceEnable" := TRUE;
    PrepaidEnable := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "ActivateFields(PROCEDURE 2)".

    //procedure ActivateFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PrepaidEnable := (NOT "Invoice after Service" OR Prepaid);
    InvoiceAfterServiceEnable := (NOT Prepaid OR "Invoice after Service");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    PrepaidEnable := (NOT "Invoice after Service" OR Prepaid);
    "Invoice after ServiceEnable" := (NOT Prepaid OR "Invoice after Service");
    */
    //end;
}
