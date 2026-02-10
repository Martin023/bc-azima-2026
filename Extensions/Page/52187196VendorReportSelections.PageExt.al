#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187196 pageextension52187196 extends "Vendor Report Selections" 
{
    layout
    {
        // modify(Usage2)
        // {
        //     ApplicationArea = Basic;
        // }
        modify(ReportID)
        {
            ApplicationArea = Basic;
        }
        modify(ReportCaption)
        {
            ApplicationArea = Basic;
        }
        // modify("Custom Report Description")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Custom Report Description"(Control 6)".

        //     ApplicationArea = Basic;
        // }
        modify(SendToEmail)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (FreezeColumnID) on "Group(Control 2)".

        modify(Usage2)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Usage2(Control 8)".


        //Unsupported feature: Property Deletion (OptionCaptionML) on "Usage2(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReportID(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReportCaption(Control 4)".


        //Unsupported feature: Code Insertion (VariableCollection) on "CustomReportDescription(Control 6).OnDrillDown".

        //trigger (Variable: CustomReportLayout)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Custom Report Description"(Control 6).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            LookupCustomReportDescription;
            CurrPage.UPDATE(TRUE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CustomReportLayout.SETCURRENTKEY("Report ID","Company Name",Type);
            CustomReportLayout.SETRANGE("Report ID","Report ID");
            CustomReportLayout.SETFILTER("Company Name",'%1|%2','',COMPANYNAME);
            CustomReportLayouts.SETTABLEVIEW(CustomReportLayout);
            IF CustomReportLayouts.RUNMODAL = ACTION::OK THEN BEGIN
              CustomReportLayouts.GETRECORD(CustomReportLayout);
              "Custom Report Layout ID" := CustomReportLayout.ID;
              MODIFY;
              CALCFIELDS("Custom Report Description");
            END;
            */
        //end;
        
        modify("Custom Report Description")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (Lookup) on ""Custom Report Description"(Control 6)".


        //Unsupported feature: Property Deletion (DrillDown) on ""Custom Report Description"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Custom Report Description"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SendToEmail(Control 7)".

        modify("Use for Email Body")
        {
            Visible = false;
        }
        modify("Email Body Layout Code")
        {
            Visible = false;
        }
        modify("Email Body Layout Description")
        {
            Visible = false;
        }
    }

    var
        CustomReportLayout: Record "Custom Report Layout";
        CustomReportLayouts: Page "Custom Report Layouts";


    //Unsupported feature: Property Modification (OptionString) on "Usage2(Variable 1001)".

    //var
        //>>>> ORIGINAL VALUE:
        //Usage2 : "Purchase Order","Vendor Remittance","Vendor Remittance - Posted Entries","Posted Return Shipment";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Usage2 : "Vendor Remittance";
        //Variable type has not been exported.


    //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //begin
        /*
        // Map from the table option to the page option
        CASE Usage2 OF
          Usage::"V.Remittance":
            Usage2 := Usage2::"Vendor Remittance";
        END;
        */
    //end;


    //Unsupported feature: Code Insertion on "OnInsertRecord".

    //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    //begin
        /*
        // Map from the page option to the table option
        CASE Usage2 OF
          Usage2::"Vendor Remittance":
            Usage := Usage::"V.Remittance";
        END;
        */
    //end;


    //Unsupported feature: Code Insertion on "OnModifyRecord".

    //trigger OnModifyRecord(): Boolean
    //begin
        /*
        // Map from the page option to the table option
        CASE Usage2 OF
          Usage2::"Vendor Remittance":
            Usage := Usage::"V.Remittance";
        END;
        */
    //end;

    //Unsupported feature: Property Deletion (DelayedInsert).


    //Unsupported feature: Property Deletion (DataCaptionFields).

}
