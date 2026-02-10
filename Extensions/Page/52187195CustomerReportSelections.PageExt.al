#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187195 pageextension52187195 extends "Customer Report Selections"
{
    layout
    {
        modify(Usage2)
        {
            OptionCaption = 'Quote,Confirmation Order,Invoice,Credit Memo,Customer Statement';
            ApplicationArea = Basic;
        }
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
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Name) on ""Custom Report Description"(Control 7)".

        // }
        modify(SendToEmail)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (FreezeColumnID) on "Group(Control 2)".


        //Unsupported feature: Code Modification on "Usage2(Control 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CASE Usage2 OF
          Usage2::Quote:
            Usage := Usage::"S.Quote";
        #4..8
            Usage := Usage::"S.Cr.Memo";
          Usage2::"Customer Statement":
            Usage := Usage::"C.Statement";
          Usage2::"Job Quote":
            Usage := Usage::JQ;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // Map from the page option to the table option
        #1..11
        END;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Usage2(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReportID(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReportCaption(Control 5)".



        //Unsupported feature: Code Insertion (VariableCollection) on "CustomReportDescription(Control 7).OnDrillDown".

        //trigger (Variable: CustomReportLayout)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Custom Report Description"(Control 7).OnDrillDown".

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
        // modify("Custom Report Description")
        // {
        //     Visible = false;
        // }
        // modify("Custom Report Description")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (Lookup) on ""Custom Report Description"(Control 7)".


        //Unsupported feature: Property Deletion (DrillDown) on ""Custom Report Description"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Custom Report Description"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SendToEmail(Control 8)".

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

    var
        CustomReportSelection: Record "Custom Report Selection";


    //Unsupported feature: Property Modification (OptionString) on "Usage2(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //Usage2 : Quote,"Confirmation Order",Invoice,"Credit Memo","Customer Statement","Job Quote";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Usage2 : Quote,"Confirmation Order",Invoice,"Credit Memo","Customer Statement";
    //Variable type has not been exported.


    //Unsupported feature: Code Insertion (VariableCollection) on "OnAfterGetRecord".

    //trigger (Variable: CustomReportSelection)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    MapTableUsageValueToPageValue;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.UPDATE(FALSE);

    // Map from the table option to the page option
    CASE Usage OF
      CustomReportSelection.Usage::"S.Quote":
        Usage2 := Usage::"S.Quote";
      CustomReportSelection.Usage::"S.Order":
        Usage2 := Usage::"S.Order";
      CustomReportSelection.Usage::"S.Invoice":
        Usage2 := Usage::"S.Invoice";
      CustomReportSelection.Usage::"S.Cr.Memo":
        Usage2 := Usage::"S.Cr.Memo";
      CustomReportSelection.Usage::"C.Statement":
        Usage2 := Usage2::"Customer Statement";
    END;
    */
    //end;

    //Unsupported feature: Property Deletion (DelayedInsert).


    //Unsupported feature: Property Deletion (DataCaptionFields).

}
