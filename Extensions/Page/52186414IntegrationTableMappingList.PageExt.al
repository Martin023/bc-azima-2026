#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186414 pageextension52186414 extends "Integration Table Mapping List"
{
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(TableCaptionValue)
        {
            ApplicationArea = Basic;
        }
        modify(TableFilterValue)
        {

            //Unsupported feature: Property Modification (Name) on "TableFilterValue(Control 12)".

            ApplicationArea = Basic;
        }
        modify(IntegrationTableCaptionValue)
        {
            ApplicationArea = Basic;
        }
        modify(IntegrationTableFilter)
        {
            ApplicationArea = Basic;
        }
        modify("Table Config Template Code")
        {
            ApplicationArea = Basic;
        }
        modify("Int. Tbl. Config Template Code")
        {
            ApplicationArea = Basic;
        }
        modify("Synch. Only Coupled Records")
        {
            ApplicationArea = Basic;
        }
        modify("Int. Tbl. Caption Prefix")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Int. Tbl. Caption Prefix"(Control 11)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TableCaptionValue(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TableFilterValue(Control 12)".

        modify(Direction)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "IntegrationTableCaptionValue(Control 8)".

        modify(IntegrationFieldCaption)
        {
            Visible = false;
        }
        modify(IntegrationFieldType)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "IntegrationTableFilter(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Table Config Template Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Int. Tbl. Config Template Code"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Synch. Only Coupled Records"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Int. Tbl. Caption Prefix"(Control 11)".

        modify("Synch. Modified On Filter")
        {
            Visible = false;
        }
    }
    actions
    {
        modify("View Integration Synch. Job Log")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""View Integration Synch. Job Log"(Action 10)".


            //Unsupported feature: Property Insertion (RunPageMode) on ""View Integration Synch. Job Log"(Action 10)".

        }
        modify(SynchronizeNow)
        {
            Caption = 'Synchronize Modified Records', Comment = 'Performs incremental synchronization of changes since last synchronization.';
            ApplicationArea = Basic;
            //Enabled = "Parent Name" = '';

            //Unsupported feature: Property Modification (PromotedCategory) on "SynchronizeNow(Action 6)".

        }
        modify(SynchronizeAll)
        {
            Caption = 'Run Full Synchronization', Comment = 'Performs a full synchronization of the mapping, clearing the incremental date filter.';
            ApplicationArea = Basic;
            //Enabled = "Parent Name" = '';
        }
        modify(FieldMapping)
        {
            Visible = false;
        }

        //Unsupported feature: Code Insertion (VariableCollection) on ""View Integration Synch. Job Log"(Action 10).OnAction".

        //trigger (Variable: IntegrationSynchJob)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""View Integration Synch. Job Log"(Action 10).OnAction".

        //trigger  Job Log"(Action 10)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowLog('');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IntegrationSynchJob.SETCURRENTKEY("Start Date/Time",ID);
        IntegrationSynchJob.ASCENDING := FALSE;
        IntegrationSynchJob.FILTERGROUP(2);
        IntegrationSynchJob.SETRANGE("Integration Table Mapping Name",Name);
        IntegrationSynchJob.FILTERGROUP(0);
        IntegrationSynchJob.FINDFIRST;
        PAGE.RUN(PAGE::"Integration Synch. Job List",IntegrationSynchJob);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""View Integration Synch. Job Log"(Action 10)".


        //Unsupported feature: Property Deletion (Enabled) on ""View Integration Synch. Job Log"(Action 10)".



        //Unsupported feature: Code Modification on "SynchronizeNow(Action 6).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ISEMPTY THEN
          EXIT;

        SynchronizeNow(FALSE);
        MESSAGE(SynchronizedModifiedCompletedMsg,IntegrationSynchJobList.CAPTION);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SynchronizeNow(FALSE);
        MESSAGE(SynchronizedModifiedCompletedMsg,IntegrationSynchJobList.CAPTION);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SynchronizeNow(Action 6)".



        //Unsupported feature: Code Modification on "SynchronizeAll(Action 14).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ISEMPTY THEN
          EXIT;

        IF NOT CONFIRM(StartFullSynchronizationQst) THEN
          EXIT;
        SynchronizeNow(TRUE);
        MESSAGE(FullSynchronizationCompletedMsg,IntegrationSynchJobList.CAPTION);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #4..7
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SynchronizeAll(Action 14)".


        //Unsupported feature: Property Deletion (Promoted) on "SynchronizeAll(Action 14)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "SynchronizeAll(Action 14)".

    }

    var
        IntegrationSynchJob: Record "Integration Synch. Job";


    //Unsupported feature: Property Modification (TextConstString) on "SynchronizedModifiedCompletedMsg(Variable 1006)".

    //var
    //>>>> ORIGINAL VALUE:
    //SynchronizedModifiedCompletedMsg : @@@=%1 caption from page 5338;ENU=Synchronized Modified Records completed.\See the %1 window for details.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SynchronizedModifiedCompletedMsg : @@@=%1 caption from page 5338;ENU=Synchronized Modifed Records completed.\See the %1 window for details.;
    //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IntegrationTableCaptionValue := ObjectTranslation.TranslateObject(ObjectTranslation."Object Type"::Table,"Integration Table ID");
    TableCaptionValue := ObjectTranslation.TranslateObject(ObjectTranslation."Object Type"::Table,"Table ID");
    IntegrationFieldCaptionValue := GetFieldCaption;
    IntegrationFieldTypeValue := GetFieldType;

    TableFilter := GetTableFilter;
    IntegrationTableFilter := GetIntegrationTableFilter;

    HasRecords := NOT ISEMPTY;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IntegrationTableCaptionValue := ObjectTranslation.TranslateObject(ObjectTranslation."Object Type"::Table,"Integration Table ID");
    TableCaptionValue := ObjectTranslation.TranslateObject(ObjectTranslation."Object Type"::Table,"Table ID");
    #5..7
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (SourceTableView).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
