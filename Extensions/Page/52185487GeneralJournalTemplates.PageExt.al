#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185487 pageextension52185487 extends "General Journal Templates" 
{
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify(Recurring)
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("No. Series")
        {
            ApplicationArea = Basic;
        }
        modify("Posting No. Series")
        {
            ApplicationArea = Basic;
        }
        modify("Source Code")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Force Doc. Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Copy VAT Setup to Jnl. Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Allow VAT Difference")
        {
            ApplicationArea = Basic;
        }
        modify("Page ID")
        {
            ApplicationArea = Basic;
        }
        modify("Page Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Test Report ID")
        {
            ApplicationArea = Basic;
        }
        modify("Test Report Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Report ID")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Report Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Force Posting Report")
        {
            ApplicationArea = Basic;
        }
        modify("Cust. Receipt Report ID")
        {
            ApplicationArea = Basic;
        }
        modify("Cust. Receipt Report Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Receipt Report ID")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Receipt Report Caption")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Recurring(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account Type"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account No."(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. Series"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting No. Series"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Force Doc. Balance"(Control 31)".


        //Unsupported feature: Code Modification on ""Copy VAT Setup to Jnl. Lines"(Control 43).OnValidate".

        //trigger  Lines"(Control 43)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Copy VAT Setup to Jnl. Lines" <> xRec."Copy VAT Setup to Jnl. Lines" THEN
              IF NOT ConfirmManagement.ConfirmProcess(
                   STRSUBSTNO(Text001,FIELDCAPTION("Copy VAT Setup to Jnl. Lines")),TRUE)
              THEN
                ERROR(Text002);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Copy VAT Setup to Jnl. Lines" <> xRec."Copy VAT Setup to Jnl. Lines" THEN
              IF NOT CONFIRM(Text001,TRUE,FIELDCAPTION("Copy VAT Setup to Jnl. Lines")) THEN
                ERROR(Text002);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy VAT Setup to Jnl. Lines"(Control 43)".

        modify("Increment Batch Name")
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on ""Allow VAT Difference"(Control 45).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Allow VAT Difference" <> xRec."Allow VAT Difference" THEN
              IF NOT ConfirmManagement.ConfirmProcess(
                   STRSUBSTNO(Text001,FIELDCAPTION("Allow VAT Difference")),TRUE)
              THEN
                ERROR(Text002);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Allow VAT Difference" <> xRec."Allow VAT Difference" THEN
              IF NOT CONFIRM(Text001,TRUE,FIELDCAPTION("Allow VAT Difference")) THEN
                ERROR(Text002);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow VAT Difference"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Page ID"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Page Caption"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report ID"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report Caption"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Report ID"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Report Caption"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Force Posting Report"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust. Receipt Report ID"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust. Receipt Report Caption"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Receipt Report ID"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Receipt Report Caption"(Control 53)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Batches)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Batches(Action 39)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
