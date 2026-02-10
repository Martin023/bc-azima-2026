#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186193 pageextension52186193 extends Workflow 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Category)
        {
            ApplicationArea = Basic;
        }
        modify(Enabled)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Category(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Enabled(Control 2)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "WorkflowSubpage(Control 7)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "WorkflowResponses(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control11(Control 11)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control10(Control 10)".

    }
    actions
    {
        modify(ImportWorkflow)
        {
            ApplicationArea = Basic;
        }
        modify(ExportWorkflow)
        {
            ApplicationArea = Basic;
        }
        modify(WorkflowStepInstances)
        {
            ApplicationArea = Basic;
        }
        modify(ArchivedWorkflowStepInstances)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (RunPageMode) on "ArchivedWorkflowStepInstances(Action 15)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ImportWorkflow(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExportWorkflow(Action 17)".

        modify(Flow)
        {
            Visible = false;
        }
        modify(WebhookClientLink)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "WorkflowStepInstances(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ArchivedWorkflowStepInstances(Action 15)".

    }

    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF OpenNew THEN
          CLEAR(Rec);

        CurrPage.WorkflowResponses.PAGE.UpdateData;

        IF NOT TemplateValueSet THEN BEGIN
          TemplateValueSet := TRUE;
          SETRANGE(Template,Template);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsNotTemplate := NOT Template;

        WorkflowStepInstance.SETRANGE("Workflow Code",Code);
        InstancesExist := NOT WorkflowStepInstance.ISEMPTY;

        WorkflowStepInstanceArchive.SETRANGE("Workflow Code",Code);
        ArchiveExists := NOT WorkflowStepInstanceArchive.ISEMPTY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IsNotTemplate := NOT Template;
        #3..7
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsNotTemplate := NOT Template;
        InstancesExist := FALSE;
        ArchiveExists := FALSE;

        IF OpenView OR ApplicationAreaMgmtFacade.IsBasicOnlyEnabled THEN
          CurrPage.EDITABLE := FALSE;

        // Load webhook subscription link when page opens
        WorkflowWebhookSubscription.SETRANGE(Enabled,TRUE);
        WorkflowWebhookSubscription.SETRANGE("WF Definition Id",Code);
        HasWebhookClientLink := WorkflowWebhookSubscription.FINDFIRST;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        IF OpenView THEN
          CurrPage.EDITABLE := FALSE;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetOpenNew(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetOpenView(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
