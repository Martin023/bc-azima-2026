#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186416 pageextension52186416 extends "Integration Synch. Error List"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Date/Time")
        {
            ApplicationArea = Basic;
        }
        modify(Message)
        {
            ApplicationArea = Basic;
        }
        modify("Exception Detail")
        {
            ApplicationArea = Basic;
        }
        modify(Source)
        {
            ApplicationArea = Basic;
        }
        modify(Destination)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date/Time"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Message(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exception Detail"(Control 9)".


        //Unsupported feature: Code Insertion (VariableCollection) on "Source(Control 16).OnDrillDown".

        //trigger (Variable: OpenRecordID)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Source(Control 16).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CRMSynchHelper.ShowPage("Source Record ID");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        OpenRecordID := "Source Record ID";
        ShowPage(OpenRecordID);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Source(Control 16)".



        //Unsupported feature: Code Insertion (VariableCollection) on "Destination(Control 18).OnDrillDown".

        //trigger (Variable: OpenRecordID)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Destination(Control 18).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CRMSynchHelper.ShowPage("Destination Record ID");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        OpenRecordID := "Destination Record ID";
        ShowPage(OpenRecordID);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Destination(Control 18)".

    }
    actions
    {
        modify(Delete7days)
        {
            ApplicationArea = Basic;
        }
        modify(Delete0days)
        {
            ApplicationArea = Basic;
        }
        modify(ActionGroupDataIntegration)
        {

            //Unsupported feature: Property Modification (Name) on "ActionGroupDataIntegration(Action 17)".

            Caption = 'Dynamics CRM';
        }
        modify(DataIntegrationSynchronizeNow)
        {

            //Unsupported feature: Property Modification (Name) on "DataIntegrationSynchronizeNow(Action 15)".

            Caption = 'Synchronize Now';
            ToolTip = 'Send or get updated data to or from Microsoft Dynamics CRM.';
            ApplicationArea = Basic;
        }
        modify(Coupling)
        {
            ToolTip = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.';
        }
        modify(ManageCRMCoupling)
        {
            ToolTip = 'Create or modify the coupling to a Microsoft Dynamics CRM entity.';
            ApplicationArea = Basic;
        }
        modify(DeleteCRMCoupling)
        {
            ToolTip = 'Delete the coupling to a Microsoft Dynamics CRM entity.';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Delete7days(Action 11)".


        //Unsupported feature: Property Deletion (Enabled) on "Delete7days(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Delete0days(Action 10)".


        //Unsupported feature: Property Deletion (Enabled) on "Delete0days(Action 10)".


        //Unsupported feature: Property Deletion (Visible) on "ActionGroupDataIntegration(Action 17)".



        //Unsupported feature: Code Insertion (VariableCollection) on "CRMSynchronizeNow(Action 15).OnAction".

        //trigger (Variable: CRMIntegrationManagement)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "DataIntegrationSynchronizeNow(Action 15).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ISEMPTY THEN
          EXIT;

        GetRecordID(LocalRecordID);
        ForceSynchronizeDataIntegration(LocalRecordID,SynchronizeHandled);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetRecordID(LocalRecordID);
        CRMIntegrationManagement.UpdateOneNow(LocalRecordID);
        */
        //end;

        //Unsupported feature: Property Deletion (Visible) on "DataIntegrationSynchronizeNow(Action 15)".


        //Unsupported feature: Property Deletion (Enabled) on "DataIntegrationSynchronizeNow(Action 15)".


        //Unsupported feature: Property Deletion (Visible) on "Coupling(Action 14)".



        //Unsupported feature: Code Modification on "ManageCRMCoupling(Action 13).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ISEMPTY THEN
          EXIT;

        GetRecordID(LocalRecordID);
        CRMIntegrationManagement.DefineCoupling(LocalRecordID);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetRecordID(LocalRecordID);
        CRMIntegrationManagement.CreateOrUpdateCoupling(LocalRecordID);
        */
        //end;

        //Unsupported feature: Property Deletion (Visible) on "ManageCRMCoupling(Action 13)".


        //Unsupported feature: Property Deletion (Enabled) on "ManageCRMCoupling(Action 13)".



        //Unsupported feature: Code Modification on "DeleteCRMCoupling(Action 12).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ISEMPTY THEN
          EXIT;

        GetRecordID(LocalRecordID);
        CRMCouplingManagement.RemoveCoupling(LocalRecordID);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetRecordID(LocalRecordID);
        CRMCouplingManagement.RemoveCoupling(LocalRecordID);
        */
        //end;

        //Unsupported feature: Property Deletion (Visible) on "DeleteCRMCoupling(Action 12)".


        //Unsupported feature: Property Deletion (Enabled) on "DeleteCRMCoupling(Action 12)".

    }

    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";

    var
    //OpenRecordID: RecordID;

    var
        OpenRecordID: RecordID;

    var
        ReferenceRecordRef: RecordRef;

    var
        UnableToFindPageForRecordErr: label 'Unable to find page for record %1.', Comment = '%1 ID of the record';


    //Unsupported feature: Code Insertion (VariableCollection) on "OnAfterGetRecord".

    //trigger (Variable: ReferenceRecordRef)()
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
    RecID := "Source Record ID";
    OpenSourcePageTxt := GetPageLink(RecID);

    RecID := "Destination Record ID";
    OpenDestinationPageTxt := GetPageLink(RecID);

    HasRecords := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ReferenceRecordRef.GET("Source Record ID") THEN
      OpenSourcePageTxt := OpenPageTok
    ELSE
      OpenSourcePageTxt := '';

    IF ReferenceRecordRef.GET("Destination Record ID") THEN
      OpenDestinationPageTxt := OpenPageTok
    ELSE
      OpenDestinationPageTxt := '';
    */
    //end;

    local procedure ShowPage(RecordID: RecordID)
    var
        TableMetadata: Record "Table Metadata";
        PageManagement: Codeunit "Page Management";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        CrmId: Guid;
        CrmIdFormattet: Text;
    begin
        if RecordID.TableNo = 0 then
            exit;
        if not TableMetadata.Get(RecordID.TableNo) then
            exit;

        if not TableMetadata.DataIsExternal then begin
            PageManagement.PageRun(RecordID);
            exit;
        end;

        if TableMetadata.TableType = TableMetadata.Tabletype::CRM then begin
            CrmIdFormattet := Format(RecordID);
            CrmIdFormattet := CopyStr(CrmIdFormattet, StrPos(CrmIdFormattet, ':') + 1);
            Evaluate(CrmId, CrmIdFormattet);
            Hyperlink(CRMIntegrationManagement.GetCRMEntityUrlFromCRMID(RecordID.TableNo, CrmId));
            exit;
        end;

        Error(StrSubstNo(UnableToFindPageForRecordErr, Format(RecordID, 0, 1)));
    end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
