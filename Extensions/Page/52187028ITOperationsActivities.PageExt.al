#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187028 pageextension52187028 extends "IT Operations Activities" 
{
    layout
    {
        modify("Job Queue Entries Until Today")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Job Queue Entries Until Today"(Control 6)".


            //Unsupported feature: Property Modification (Name) on ""Job Queue Entries Until Today"(Control 6)".

        }
        modify("User Posting Period")
        {
            ApplicationArea = Basic;
        }
        modify("No. Series Period")
        {
            ApplicationArea = Basic;
        }
       

        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Queue Entries Until Today"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User Posting Period"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. Series Period"(Control 10)".

        modify("Data Integration")
        {
            Visible = false;
        }
        modify("CDS Integration Errors")
        {
            Visible = false;
        }
        modify("Coupled Data Synch Errors")
        {
            Visible = false;
        }
        // modify("My User Tasks")
        // {
        //     Visible = false;
        // }
        // modify("UserTaskManagement.GetMyPendingUserTasksCount")
        // {
        //     Visible = false;
        // }
        modify("Data Privacy")
        {
            Visible = false;
        }
        modify(UnclassifiedFields)
        {
            Visible = false;
        }
    }
    actions
    {
        // modify("Administration(Control 1).""Edit Job Queue Entry Card""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Administration(Control 1).""Edit User Setup""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Administration(Control 1).""Edit Migration Overview""")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Administration(Control 1)."Edit Job Queue Entry Card"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Administration(Control 1)."Edit User Setup"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Administration(Control 1)."Edit Migration Overview"(Action 14)".

    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RESET;
        IF NOT GET THEN BEGIN
          INIT;
          INSERT;
        END;

        DataClassificationMgt.ShowNotifications;

        DataSensitivity.SETRANGE("Company Name",COMPANYNAME);
        DataSensitivity.SETRANGE("Data Sensitivity",DataSensitivity."Data Sensitivity"::Unclassified);
        UnclassifiedFields := DataSensitivity.COUNT;

        SETFILTER("Date Filter2",'<=%1',CREATEDATETIME(TODAY,0T));
        SETFILTER("Date Filter3",'>%1',CREATEDATETIME(TODAY,0T));
        SETFILTER("User ID Filter",USERID);

        ShowIntelligentCloud := NOT PermissionManager.SoftwareAsAService;
        IntegrationSynchJobErrors.SetDataIntegrationUIElementsVisible(ShowDataIntegrationCues);
        ShowD365SIntegrationCues := CRMConnectionSetup.IsEnabled;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        SETFILTER("Date Filter2",'<=%1',CREATEDATETIME(TODAY,0T));
        SETFILTER("Date Filter3",'>%1',CREATEDATETIME(TODAY,0T));
        */
    //end;

    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
